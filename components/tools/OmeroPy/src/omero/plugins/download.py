#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
   download plugin

   Plugin read by omero.cli.Cli during initialization. The method(s)
   defined here will be added to the Cli class for later use.

   Copyright 2007 - 2014 Glencoe Software, Inc. All rights reserved.
   Use is subject to license terms supplied in LICENSE.txt

"""

import sys
import omero
import re
import os
from omero.cli import BaseControl, CLI
from omero.rtypes import unwrap

HELP = """Download the given file(s) with a specified ID

Examples:

    # Download OriginalFile 2 to local_file
    bin/omero download 2 --filename local_file
    # Download Original File 2 to the stdout
    bin/omero download 2 -

    # Download the OriginalFile linked to FileAnnotation 20
    # to a file named with the original file name
    bin/omero download FileAnnotation:20

    # Download all OriginalFiles linked to Images 5 and 6
    bin/omero download --object Image:5 Image:6
"""


class DownloadControl(BaseControl):

    def _configure(self, parser):
        # Allow single object for backwards compatibility
        parser.add_argument(
            "object", nargs="?",
            help="Object to download of form <object>:<id>. "
            "OriginalFile is assumed if <object>: is omitted.")
        # Allow optional filename for backwards compatibility
        parser.add_argument(
            "fname", nargs="?", default=None, metavar='filename',
            help="Local filename to be saved to. '-' for stdout")
        parser.add_argument(
            "-o", "--object", nargs="+", dest="objects", metavar="OBJECT",
            help="Objects to download of form <object>:<id>. "
            "OriginalFile is assumed if <object>: is omitted.")
        parser.add_argument(
            "-f", "--filename",
            help="Local filename to be saved to. '-' for stdout")
        parser.add_argument(
            "-d", "--directory",
            help="Directory to save files to.  Default is current directory.")
        parser.add_argument(
            "-c", "--clientpath",
            nargs="?", default=None, const=-1, type=int, metavar='LEVELS',
            help="Recreate client path to optional number of levels "
            "(only used for Image:...)")
        parser.add_argument(
            "--dryrun", action="store_true",
            help="Print files that would be downloaded"
        )
        parser.set_defaults(func=self.__call__)
        parser.add_login_arguments()

    def __call__(self, args):
        # Retrieve connection
        client = self.ctx.conn(args)
        objects = args.objects or []
        if args.object:
            objects.append(args.object)
        if not objects:
            self.ctx.die(601, 'Must specify at least one object')
        # if a file name is specified, we can only download a single object
        filename = args.filename or args.fname
        if filename and len(objects) > 1:
            self.ctx.die(603, 'Cannot specify filename for multiple objects')
        # remember what's been downloaded
        self.history = {
            'id': {},
            'name': {},
        }
        for obj in objects:
            self.process_file(obj, client, args)

    def process_file(self, obj, client, args):
        files = self.get_files(client.sf, obj)
        # if a file name is specified, we can only download a single file
        filename = args.filename or args.fname
        if filename and len(files) > 1:
            self.ctx.die(603, 'Cannot specify filename if input image has '
                         'more than 1 associated file, it has %s' % len(files))
        for entry in files:
            # entry is either a filesetentry or an originalfile
            orig_file = getattr(entry, 'originalFile', entry)
            orig_file_id = unwrap(orig_file.id)
            # Don't download same OriginalFile more than once
            if orig_file_id in self.history['id']:
                prev_obj = self.history['id'][orig_file_id]
                self.ctx.err('Object %s OriginalFile %s: WARNING: '
                             'already written for object %s, '
                             'skipping' % (obj, orig_file_id, prev_obj))
                continue
            self.history['id'][orig_file_id] = obj
            # filesetentry has a clientpath we may need
            clientpath = getattr(entry, 'clientPath', '')
            if clientpath:
                clientpath = unwrap(clientpath)
            # always remove drive information and file name
            clientpath = os.path.splitdrive(os.path.dirname(clientpath))[1]

            # calculate target directory
            target = args.directory or "."
            if args.clientpath:
                if args.clientpath > 0:
                    use = ''
                    for count in range(args.clientpath):
                        clientpath, tail = os.path.split(clientpath)
                        use = os.path.join(tail, use)
                    clientpath = use
                target = os.path.join(target, clientpath)

            target_file = filename or unwrap(orig_file.name)
            if target_file != "-":
                target_file = os.path.normpath(
                    os.path.join(target, target_file))

            # check if file would overwrite previously downloaded file
            if target_file in self.history['name']:
                prev_obj, prev_id = self.history['name'][target_file]
                self.ctx.err('Object %s OriginalFile %s: WARNING: '
                             'file "%s" written previously '
                             'for object %s (OriginalFile %s), '
                             'skipping' % (obj, orig_file_id, target_file,
                                           prev_obj, prev_id))
                continue
            self.history['name'][target_file] = (obj, orig_file_id)

            if args.dryrun:
                self.ctx.out('Object %s OriginalFile %s: Writing "%s"' % (
                    obj, orig_file_id,
                    "stdout" if target_file == "-" else target_file))
            else:
                # create output directory
                target_dir = os.path.dirname(target_file)
                if target_dir and target_file != "-" and \
                        not os.path.exists(target_dir):
                    os.makedirs(target_dir)
                # perform download
                self.download_file(client, orig_file, target_file)

    def download_file(self, client, orig_file, target_file):
        try:
            if target_file == "-":
                client.download(orig_file, filehandle=sys.stdout)
                sys.stdout.flush()
            else:
                client.download(orig_file, target_file)
        except omero.ValidationException, ve:
            # Possible, though unlikely after previous check
            self.ctx.die(67, "Unknown ValidationException: %s"
                         % ve.message)
        except omero.ResourceError, re:
            # ID exists in DB, but not on FS
            self.ctx.die(67, "ResourceError: %s" % re.message)

    def get_files(self, session, value):
        # returns a list of OriginalFile or FileSetEntry
        query = session.getQueryService()
        if ':' not in value:
            try:
                ofile = query.get("OriginalFile", long(value),
                                  {'omero.group': '-1'})
                return [ofile]
            except ValueError:
                self.ctx.die(601, 'Invalid OriginalFile ID input')
            except omero.ValidationException:
                self.ctx.die(601, 'No OriginalFile with input ID')

        # Assume input is of form OriginalFile:id
        file_id = self.parse_object_id("OriginalFile", value)
        if file_id:
            try:
                ofile = query.get("OriginalFile", file_id,
                                  {'omero.group': '-1'})
            except omero.ValidationException:
                self.ctx.die(601, 'No OriginalFile with input ID')
            return [ofile]

        # Assume input is of form FileAnnotation:id
        fa_id = self.parse_object_id("FileAnnotation", value)
        if fa_id:
            try:
                fa = query.get("FileAnnotation", fa_id, {'omero.group': '-1'})
            except omero.ValidationException:
                self.ctx.die(601, 'No FileAnnotation with input ID')
            return [fa.getFile()]

        # Assume input is of form Image:id
        image_id = self.parse_object_id("Image", value)
        params = omero.sys.ParametersI()
        if image_id:
            params.addLong('iid', image_id)
            sql = "select uf from Image i" \
                " left outer join i.fileset as fs" \
                " join fs.usedFiles as uf" \
                " join fetch uf.originalFile as f" \
                " where i.id = :iid"
            query_out = query.projection(sql, params, {'omero.group': '-1'})
            if not query_out:
                self.ctx.die(602, 'Input image has no associated Fileset')
            return [unwrap(fsentry)[0] for fsentry in query_out]

        self.ctx.die(601, 'Invalid object input')

    def parse_object_id(self, object_type, value):

        pattern = r'%s:(?P<id>\d+)' % object_type
        pattern = re.compile('^' + pattern + '$')
        m = pattern.match(value)
        if not m:
            return
        return long(m.group('id'))

try:
    register("download", DownloadControl, HELP)
except NameError:
    if __name__ == "__main__":
        cli = CLI()
        cli.register("download", DownloadControl, HELP)
        cli.invoke(sys.argv[1:])
