# -*- coding: utf-8 -*-
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

  def hook_change_settings(&original_func)
    @@__already_exec_change_settings ||= false
    return if @@__already_exec_change_settings
    force_change_settings_function({
      "force.enable_half_indent_bracket" => false,
    })
    @@__already_exec_change_settings = true
  end
end
