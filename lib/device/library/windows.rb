# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "win32ole"

class InvalidOS < StandardError; end

begin
  require "fiddle"

  module WinAPI
    include Fiddle
    Handle = RUBY_VERSION >= "2.0.0" ? Fiddle::Handle : DL::Handle

    def self.GetLogicalDriveStrings(buf_size, buffer)
      @@get_logical_drive_strings ||= Function.new(Handle.new("kernel32")["GetLogicalDriveStrings"],
      [TYPE_LONG, TYPE_VOIDP], TYPE_LONG)
      @@get_logical_drive_strings.call(buf_size, buffer)
    end
  end
rescue LoadError
  # Fiddle がない環境用(http://www.artonx.org/data/asr/ の1.9.3とか)
  require "dl/import"

  module WinAPI
    extend DL::Importer
    begin
      dlload "kernel32"
      extern "long GetLogicalDriveStrings(long, void*)"
    rescue DL::DLError
      raise InvalidOS, "not Windows"
    end
  end
end

module Device::Library
  module Windows
    def get_device_root_dir(volume_name)
      @@FileSystemObject ||= WIN32OLE.new("Scripting.FileSystemObject")
      drive_strings = " " * 1000
      result_len = WinAPI.GetLogicalDriveStrings(1000, drive_strings)
      drives = drive_strings[0, result_len].split("\0")
      drives.each do |drive_letter|
        drive_info = @@FileSystemObject.GetDrive(drive_letter)
        vol = drive_info.VolumeName rescue ""
        if vol == volume_name
          return File.expand_path(drive_letter)
        end
      end
      nil
    end
  end
end
