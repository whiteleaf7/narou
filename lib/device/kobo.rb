# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Device::Kobo
  PHYSICAL_SUPPORT = true
  VOLUME_NAME = "KOBOeReader"
  DOCUMENTS_PATH_LIST = ["/"]
  EBOOK_FILE_EXT = ".kepub.epub"
  NAME = "Kobo"
  DISPLAY_NAME = "Kobo"

  RELATED_VARIABLES = {
    "default.enable_half_indent_bracket" => false,
  }
end
