# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "narou"
require_relative "helper"

class Device
  case Helper.determine_os
  when :windows
    require_relative "device/library/windows"
    extend Device::Library::Windows
  when :cygwin
    require_relative "device/library/cygwin"
    extend Device::Library::Cygwin
  when :mac
    require_relative "device/library/mac"
    extend Device::Library::Mac
  else
    require_relative "device/library/linux"
    extend Device::Library::Linux
  end

  attr_reader :name, :ebook_file_ext, :display_name

  DEVICES = {}.tap do |h|
    [Narou.get_root_dir, File.dirname(__FILE__)].each do |dir|
      next unless dir   # narou init 前だと get_root_dir は nil
      Dir.glob(File.join(dir, "device", "*.rb")).each do |path|
        name = File.basename(path, ".rb")
        unless h[name]
          if Helper.os_windows?
            # パスにマルチバイト文字が使われる可能性があるのでrequireは使えない
            eval(File.read(path, encoding: Encoding::UTF_8), binding, path)
          else
            require path
          end
          h[name] = Device.const_get(name.capitalize)
        end
      end
    end
  end

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
      raise UnknownDevice, "#{device_name} という端末は存在しません"
    end
    @device_module = DEVICES[device_name.downcase]
    @name = @device_module::NAME
    @display_name = @device_module::DISPLAY_NAME
    @ebook_file_ext = @device_module::EBOOK_FILE_EXT
    create_device_check_methods
  end

  def connecting?
    !!get_documents_path
  end

  def find_documents_directory(device_root_dir)
    @device_module::DOCUMENTS_PATH_LIST.each do |documents_path|
      documents_directory = File.join(device_root_dir, documents_path)
      return documents_directory if File.directory?(documents_directory)
    end
    nil
  end

  def get_documents_path
    if Device.respond_to?(:get_device_root_dir)
      dir = Device.get_device_root_dir(@device_module::VOLUME_NAME)
      if dir
        return find_documents_directory(dir)
      end
    end
    nil
  end

  def ebook_file_old?(src_file)
    documents_path = get_documents_path
    if documents_path
      dst_path = File.join(documents_path, File.basename(src_file))
      if File.exist?(dst_path)
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
        begin
          # Rubyでコピーするのは遅いのでOSのコマンドを叩く
          cmd = "copy /B " + %!"#{src_file}" "#{dst_path}"!.gsub("/", "\\").encode(Encoding::Windows_31J)
          capture = `#{cmd}`
          unless $?.success?
            raise capture.force_encoding(Encoding::Windows_31J).rstrip
          end
        rescue StandardError
          # コマンドで送信出来ないものはRubyで直接コピーする
          FileUtils.cp(src_file, dst_path)
        end
      else
        status = system(%!cp "#{src_file}" "#{dst_path}"!)
        raise "コピーできませんでした" unless status
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

  def physical_support?
    @device_module::PHYSICAL_SUPPORT
  end

  def get_hook_module
    @device_module
  end

  def get_relative_variables
    if @device_module.const_defined?(:RELATED_VARIABLES)
      @device_module::RELATED_VARIABLES
    else
      {}
    end
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
