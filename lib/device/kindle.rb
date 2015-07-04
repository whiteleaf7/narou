# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"

module Device::Kindle
  PHYSICAL_SUPPORT = true
  VOLUME_NAME = "Kindle"
  DOCUMENTS_PATH_LIST = %w(documents Documents Books)
  EBOOK_FILE_EXT = ".mobi"
  NAME = "Kindle"
  DISPLAY_NAME = "Kindle"

  RELATED_VARIABLES = {
    "default.enable_half_indent_bracket" => true,
  }

  include Device::BackupBookmarkUtility

  def backup_bookmark
    documents_path = get_documents_path
    raise Device::DontConneting unless documents_path
    paths = Dir.glob(File.join(documents_path, "*.sdr/*.azw3{f,r}"))
    Helper.copy_files(paths, get_storage_path)
    paths.size
  end

  def restore_bookmark
    documents_path = get_documents_path
    raise Device::DontConneting unless documents_path
    paths = Dir.glob(File.join(get_storage_path, "*.sdr/*"))
    Helper.copy_files(paths, documents_path)
    paths.size
  end
end
