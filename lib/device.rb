# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "helper"

class Device
  if Helper.os_windows?
    require_relative "device/library/windows"
    extend Device::Library::Windows
  end

  require_relative "device/kindle"
  require_relative "device/kobo"

  attr_reader :name, :ebook_file_ext

  DEVICES = { "kindle" => Kindle, "kobo" => Kobo }

  class SendFailure < StandardError; end

  def self.exists?(device)
    DEVICES.include?(device.downcase)
  end

  def initialize(device_name)
    unless Device.exists?(device_name)
      warn "#{device_name} は存在しません"
      exit 1
    end
    @device = DEVICES[device_name.downcase]
    @name = device_name.capitalize
    @ebook_file_ext = @device::EBOOK_FILE_EXT
  end

  def connecting?
    !!get_documents_path
  end

  def get_documents_path
    if Helper.os_windows?
      dir = Device.get_device_root_dir(@device::VOLUME_NAME)
      return File.join(dir, @device::DOCUMENTS_PATH) if dir
    end
    nil
  end

  def copy_to_documents(src_file)
    documents_path = get_documents_path
    if documents_path
      dst_path = File.join(documents_path, File.basename(src_file))
      case Helper.determine_os
      when :windows
        cmd = "copy /B " + %!"#{src_file}" "#{dst_path}"!.gsub("/", "\\").encode(Encoding::Windows_31J)
        capture = `#{cmd}`
        if $?.exitstatus > 0
          warn capture.force_encoding(Encoding::Windows_31J)
          exit 1
        end
      else
        begin
          FileUtils.cp(src_file, dst_path)
        rescue => e
          warn e.message
          exit 1
        end
      end
      dst_path
    else
      nil
    end
  end
end
