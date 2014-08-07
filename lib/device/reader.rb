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

  def hook_change_settings(&original_func)
    @@__already_exec_change_settings ||= false
    return if @@__already_exec_change_settings
    force_change_settings_function({
      "force.enable_half_indent_bracket" => false,
    })
    @@__already_exec_change_settings = true
  end
end
