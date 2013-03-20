# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "helper"

class Device
  case Helper.determine_os
  when :windows
    require_relative "device/library/windows"
    extend Device::Library::Windows
  else
    require_relative "device/library/linux"
    extend Device::Library::Linux
  end

  require_relative "device/kindle"
  require_relative "device/kobo"

  attr_reader :name, :ebook_file_ext

  DEVICES = { "kindle" => Kindle, "kobo" => Kobo }

  class UnknownDevice < StandardError; end

  def self.exists?(device)
    DEVICES.include?(device.downcase)
  end

  def self.create(device_name)
    @@device_cache ||= {}
    name = device_name.downcase
    return @@device_cache[name] ||= new(name)
  end

  private_class_method :new

  def initialize(device_name)
    unless Device.exists?(device_name)
      raise UnknownDevice, "#{device_name} は存在しません"
    end
    @device = DEVICES[device_name.downcase]
    @name = device_name.capitalize
    @ebook_file_ext = @device::EBOOK_FILE_EXT
    create_device_check_methods
  end

  def connecting?
    !!get_documents_path
  end

  def get_documents_path
    if Device.respond_to?(:get_device_root_dir)
      dir = Device.get_device_root_dir(@device::VOLUME_NAME)
      return File.join(dir, @device::DOCUMENTS_PATH) if dir
    end
    nil
  end

  def ebook_file_old?(src_file)
    documents_path = get_documents_path
    if documents_path
      dst_path = File.join(documents_path, File.basename(src_file))
      if File.exists?(dst_path)
        return File.mtime(src_file) > File.mtime(dst_path)
      end
    end
    true
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
          raise capture.force_encoding(Encoding::Windows_31J).rstrip
        end
      else
        FileUtils.cp(src_file, dst_path)
      end
      dst_path
    else
      nil
    end
  rescue Exception => e
    puts
    error $@.shift + ": #{e.message} (#{e.class})"
    exit 1
  end

  private

  def create_device_check_methods
    DEVICES.keys.each do |name|
      instance_eval <<-EOS
        def #{name}?
          #{@name.downcase == name}
        end
      EOS
    end
  end
end
