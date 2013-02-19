# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "Win32API"
require "win32ole"

module Device::Library
  module Windows
    def get_device_root_dir(volume_name)
      @@GetLogicalDriveStrings ||= Win32API.new("kernel32", "GetLogicalDriveStrings", "LP", "L")
      @@FileSystemObject ||= WIN32OLE.new("Scripting.FileSystemObject")
      drive_strings = " " * 1000
      result_len = @@GetLogicalDriveStrings.call(1000, drive_strings)
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
