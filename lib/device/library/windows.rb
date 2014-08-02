# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "win32ole"
require_relative "../../extensions/windows"

module Device::Library
  module Windows
    def get_device_root_dir(volume_name)
      @@FileSystemObject ||= WIN32OLE.new("Scripting.FileSystemObject")
      get_drives.each do |drive_letter|
        drive_info = @@FileSystemObject.GetDrive(drive_letter)
        vol = drive_info.VolumeName rescue ""
        if vol.downcase == volume_name.downcase
          return File.expand_path(drive_letter)
        end
      end
      nil
    end

    def get_drives
      result = []
      bits = WinAPI.GetLogicalDrives
      26.times do |i|
        if bits & (1 << i) != 0
          result << "#{(65 + i).chr}:\\"
        end
      end
      result
    end
  end
end
