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
def image_with_fileset(request, gatewaywrapper):
    """Creates and returns an Image with associated Fileset."""
    gatewaywrapper.loginAsAuthor()
    update_service = gatewaywrapper.gateway.getUpdateService()
    image = ImageI()
    image.name = rstring(uuid())
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
    fileset = FilesetI()
    fileset.templatePrefix = rstring('')
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
    image.fileset = fileset
    image = update_service.saveAndReturnObject(image)
    return gatewaywrapper.gateway.getObject('Image', image.id.val)


class TestFileset(object):

    def assert_files(self, files):
        assert len(files) == 2
        for index, original_file in enumerate(files):
            assert original_file.name == 'filename_%d.ext' % index

    def testCountArchivedFiles(self, gatewaywrapper, image_with_fileset):
        assert image_with_fileset.countArchivedFiles() == 0

    def testCountFilesetFiles(self, gatewaywrapper, image_with_fileset):
        assert image_with_fileset.countFilesetFiles() == 2

    def testCountImportedImageFiles(self, gatewaywrapper, image_with_fileset):
        assert image_with_fileset.countImportedImageFiles() == 2

    def testGetImportedFilesInfo(self, gatewaywrapper, image_with_fileset):
        assert image_with_fileset.getImportedFilesInfo() == {
            'count': 2, 'size': 100
        }

    def testGetArchivedFiles(self, gatewaywrapper, image_with_fileset):
        self.assert_files(list(image_with_fileset.getArchivedFiles()))

    def testGetImportedImageFiles(self, gatewaywrapper, image_with_fileset):
        self.assert_files(list(image_with_fileset.getImportedImageFiles()))

    def testGetArchivedFilesInfo(self, gatewaywrapper, image_with_fileset):
        gw = gatewaywrapper.gateway
        files_info = gw.getArchivedFilesInfo([image_with_fileset.id])
        assert files_info == {'count': 0, 'size': 0}

    def testGetFilesetFilesInfo(self, gatewaywrapper, image_with_fileset):
        gw = gatewaywrapper.gateway
        files_info = gw.getFilesetFilesInfo([image_with_fileset.id])
        assert files_info == {'count': 2, 'size': 100}

    def testGetFileset(self, gatewaywrapper, image_with_fileset):
        assert image_with_fileset.getFileset() is not None
