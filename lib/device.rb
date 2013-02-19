# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "helper"

module Device
  if Helper.os_windows?
    require_relative "device/library/windows"
    extend Device::Library::Windows
  end

  module Kindle
    VOLUME_NAME = "Kindle"
    DOCUMENTS_PATH = "documents"

    def self.connecting?
      !!get_documents_path
    end

    def self.get_documents_path
      if Helper.os_windows?
        dir = Device.get_device_root_dir(VOLUME_NAME)
        return File.join(dir, DOCUMENTS_PATH) if dir
      end
      nil
    end

    def self.copy_to_documents(src_file)
      documents_path = get_documents_path
      if documents_path
        dst_path = File.join(documents_path, File.basename(src_file))
        FileUtils.cp(src_file, dst_path)
        dst_path
      else
        nil
      end
    end
  end
end
