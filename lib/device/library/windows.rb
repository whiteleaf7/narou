# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fiddle"
require "win32ole"

module WinAPI
  include Fiddle
  class InvalidOS < StandardError; end
  Handle = RUBY_VERSION >= "2.0.0" ? Fiddle::Handle : DL::Handle

  def self.GetLogicalDriveStrings(buf_size, buffer)
    @@get_logical_drive_strings ||= Function.new(Handle.new("kernel32")["GetLogicalDriveStrings"],
                                                 [TYPE_LONG, TYPE_VOIDP], TYPE_LONG)
    @@get_logical_drive_strings.call(buf_size, buffer)
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
