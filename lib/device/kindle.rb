# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Device::Kindle
  PHYSICAL_SUPPORT = true
  VOLUME_NAME = "Kindle"
  DOCUMENTS_PATH_LIST = %w(documents Documents Books)
  EBOOK_FILE_EXT = ".mobi"
  NAME = "Kindle"
  DISPLAY_NAME = "Kindle"

  RELATED_VARIABLES = {
    "force.enable_half_indent_bracket" => true,
  }
end
