# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Device::Reader
  PHYSICAL_SUPPORT = true
  VOLUME_NAME = "READER"
  DOCUMENTS_PATH_LIST = ["Sony_Reader/media/books"]
  EBOOK_FILE_EXT = ".epub"
  NAME = "Reader"
  DISPLAY_NAME = "SonyReader"

  RELATED_VARIABLES = {
    "default.enable_half_indent_bracket" => false,
  }
end
