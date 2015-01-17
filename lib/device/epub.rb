# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

#
# multi-device で単純なEPUB変換をしたい場合用
#
module Device::Epub
  PHYSICAL_SUPPORT = false
  VOLUME_NAME = nil
  DOCUMENTS_PATH_LIST = nil
  EBOOK_FILE_EXT = ".epub"
  NAME = "EPUB"
  DISPLAY_NAME = "EPUB"

  RELATED_VARIABLES = {
    "force.enable_half_indent_bracket" => false,
  }
end
