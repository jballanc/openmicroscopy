#!/usr/bin/env python
# -*- coding: utf-8 -*-

#
# Copyright (C) 2013 University of Dundee & Open Microscopy Environment.
# All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

"""
   gateway tests - Testing the gateway image wrapper

   pytest fixtures used as defined in conftest.py:
   - gatewaywrapper

"""

import pytest

from omero.model import ImageI, PixelsI, FilesetI, FilesetEntryI, \
    OriginalFileI, DimensionOrderI, PixelsTypeI
from omero.rtypes import rstring, rlong, rint, rtime
from uuid import uuid4


def uuid():
    return str(uuid4())


@pytest.fixture()
def fileset_with_images(request, gatewaywrapper):
    """Creates and returns a Fileset with associated Images."""
    gatewaywrapper.loginAsAuthor()
    update_service = gatewaywrapper.gateway.getUpdateService()
    fileset = FilesetI()
    fileset.templatePrefix = rstring('')
    for image_index in range(2):
        image = ImageI()
        image.name = rstring('%s_%d' % (uuid(), image_index))
        image.acquisitionDate = rtime(0)
        pixels = PixelsI()
        pixels.sha1 = rstring('')
        pixels.sizeX = rint(1)
        pixels.sizeY = rint(1)
        pixels.sizeZ = rint(1)
        pixels.sizeC = rint(1)
        pixels.sizeT = rint(1)
        pixels.dimensionOrder = DimensionOrderI(1L, False)  # XYZCT
        pixels.pixelsType = PixelsTypeI(1L, False)  # bit
        for index in range(2):
            fileset_entry = FilesetEntryI()
            fileset_entry.clientPath = rstring(
                '/client/path/filename_%d.ext' % index
            )
            original_file = OriginalFileI()
            original_file.name = rstring('filename_%d.ext' % index)
            original_file.path = rstring('/server/path/')
            original_file.size = rlong(50L)
            fileset_entry.originalFile = original_file
            fileset.addFilesetEntry(fileset_entry)
        image.addPixels(pixels)
        fileset.addImage(image)
    fileset = update_service.saveAndReturnObject(fileset)
    return gatewaywrapper.gateway.getObject('Fileset', fileset.id.val)


class TestFileset(object):

    def testCountArchivedFiles(self, gatewaywrapper, fileset_with_images):
        for image in fileset_with_images.copyImages():
            assert image.countArchivedFiles() == 0

    def testCountFilesetFiles(self, gatewaywrapper, fileset_with_images):
        for image in fileset_with_images.copyImages():
            assert image.countFilesetFiles() == 4

    def testCountImportedImageFiles(self, gatewaywrapper, fileset_with_images):
        for image in fileset_with_images.copyImages():
            assert image.countImportedImageFiles() == 4

    def testGetImportedFilesInfo(self, gatewaywrapper, fileset_with_images):
        for image in fileset_with_images.copyImages():
            assert image.getImportedFilesInfo() == {
                'count': 4, 'size': 200
            }

    def testGetArchivedFiles(self, gatewaywrapper, fileset_with_images):
        for image in fileset_with_images.copyImages():
            len(list(image.getArchivedFiles())) == 4

    def testGetImportedImageFiles(self, gatewaywrapper, fileset_with_images):
        for image in fileset_with_images.copyImages():
            len(list(image.getImportedImageFiles())) == 4

    def testGetArchivedFilesInfo(self, gatewaywrapper, fileset_with_images):
        gw = gatewaywrapper.gateway
        for image in fileset_with_images.copyImages():
            files_info = gw.getArchivedFilesInfo([image.id])
            assert files_info == {'count': 0, 'size': 0}

    def testGetFilesetFilesInfo(self, gatewaywrapper, fileset_with_images):
        gw = gatewaywrapper.gateway
        for image in fileset_with_images.copyImages():
            files_info = gw.getFilesetFilesInfo([image.id])
            assert files_info == {'count': 4, 'size': 200}

    def testGetFilesetFilesInfoMultiple(
            self, gatewaywrapper, fileset_with_images):
        gw = gatewaywrapper.gateway
        image_ids = [v.id for v in fileset_with_images.copyImages()]
        files_info = gw.getFilesetFilesInfo(image_ids)
        assert files_info == {'count': 4, 'size': 200}

    def testGetFileset(self, gatewaywrapper, fileset_with_images):
        for image in fileset_with_images.copyImages():
            assert image.getFileset() is not None
