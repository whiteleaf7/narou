# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

# rubocop:disable Style/VariableName

require "win32ole"
require_relative "../../extensions/windows"

class Device
  module Library
    module Windows
      def get_device_root_dir(volume_name)
        @@FileSystemObject ||= WIN32OLE.new("Scripting.FileSystemObject")
        drives.each do |drive_letter|
          drive_info = @@FileSystemObject.GetDrive(drive_letter)
          vol = drive_info.VolumeName rescue ""
          if vol.casecmp(volume_name) == 0
            return File.expand_path(drive_letter)
          end
        end
        nil
      end

      def drives
        result = []
        bits = WinAPI.GetLogicalDrives
        26.times do |i|
          if bits & (1 << i) != 0
            result << "#{(65 + i).chr}:\\"
          end
        end
        result
      end

      def eject(volume_name)
        device_root = get_device_root_dir(volume_name)
        status, _stdio, stderr = systemu(%!#{File.join(Narou.get_script_dir, "bin/eject.exe")} #{device_root}!)
        unless status.success?
          raise Device::CantEject, stderr.strip
        end
      end
    end
  end
end
