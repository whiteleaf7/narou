# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#
# rubocop:disable Naming/MethodName
# rubocop:disable Naming/VariableName

class Device
  module Library
    module Windows
      def eject(volume_name)
        device_root = get_device_root_dir(volume_name)
        unless ejectVolume(device_root)
          raise Device::CantEject, "端末を取り外せませんでした"
        end
      end

      private

      FSCTL_LOCK_VOLUME = 0x00090018
      FSCTL_DISMOUNT_VOLUME = 0x00090020
      IOCTL_STORAGE_MEDIA_REMOVAL = 0x002d4804
      IOCTL_STORAGE_EJECT_MEDIA = 0x002d4808
      FILE_SHARE_READ = 0x00000001
      FILE_SHARE_WRITE = 0x00000002
      OPEN_EXISTING = 3
      INVALID_HANDLE_VALUE = -1
      GENERIC_READ = 0x80000000
      GENERIC_WRITE = 0x40000000
      DRIVE_REMOVABLE = 2
      DRIVE_CDROM = 5
      NULL = 0
      WIN_FALSE = 0
      LOCK_TIMEOUT = 3.0 # Seconds
      LOCK_RETRIES = 20

      def openVolume(cDriveLetter)
        szVolumeFormat = "\\\\.\\%s:"
        szRootFormat = "%s:\\"

        szRootName = szRootFormat % cDriveLetter

        uDriveType = WinAPI.GetDriveType(szRootName)
        case uDriveType
        when DRIVE_REMOVABLE
          dwAccessFlags = GENERIC_READ | GENERIC_WRITE
        when DRIVE_CDROM
          dwAccessFlags = GENERIC_READ
        else
          return INVALID_HANDLE_VALUE
        end

        szVolumeName = szVolumeFormat % cDriveLetter

        hVolume = WinAPI.CreateFile(
          szVolumeName,
          dwAccessFlags,
          FILE_SHARE_READ | FILE_SHARE_WRITE,
          NULL,
          OPEN_EXISTING,
          0,
          NULL
        )
        hVolume
      end

      def lockVolume(hVolume)
        dwSleepAmount = LOCK_TIMEOUT / LOCK_RETRIES
        dwBytesReturned = "    ".dup

        # Do this in a loop until a timeout period has expired
        LOCK_RETRIES.times do
          res = WinAPI.DeviceIoControl(
            hVolume,
            FSCTL_LOCK_VOLUME,
            NULL, 0,
            NULL, 0,
            dwBytesReturned,
            NULL
          )
          return true if res != 0
          sleep(dwSleepAmount)
        end
        raise Device::CantEject, "端末が使用中なため取り外せませんでした"
      end

      def dismountVolume(hVolume)
        dwBytesReturned = "    ".dup
        WinAPI.DeviceIoControl(
          hVolume,
          FSCTL_DISMOUNT_VOLUME,
          NULL, 0,
          NULL, 0,
          dwBytesReturned,
          NULL
        ) != 0
      end

      def preventRemovalOfVolume(hVolume, fPreventRemoval)
        dwBytesReturned = "    ".dup
        WinAPI.DeviceIoControl(
          hVolume,
          IOCTL_STORAGE_MEDIA_REMOVAL,
          [fPreventRemoval.to_s].pack("b"), 1,
          NULL, 0,
          dwBytesReturned,
          NULL
        ) != 0
      end

      def autoEjectVolume(hVolume)
        dwBytesReturned = "    ".dup
        WinAPI.DeviceIoControl(
          hVolume,
          IOCTL_STORAGE_EJECT_MEDIA,
          NULL, 0,
          NULL, 0,
          dwBytesReturned,
          NULL
        ) != 0
      end

      def ejectVolume(cDriveLetter)
        fRemoveSafely = false
        fAutoEject = false
        hVolume = INVALID_HANDLE_VALUE

        cDriveLetter = cDriveLetter[0]
        unless cDriveLetter
          raise Device::CantEject, "need a drive letter"
        end

        # Open the volume.
        hVolume = openVolume(cDriveLetter)
        if hVolume == INVALID_HANDLE_VALUE
          raise Device::CantEject, "Cannot eject. Drive type is incorrect."
        end

        # Lock and dismount the volume.
        if lockVolume(hVolume) && dismountVolume(hVolume)
          fRemoveSafely = true

          # Set prevent removal to false and eject the volume.
          if preventRemovalOfVolume(hVolume, WIN_FALSE) && autoEjectVolume(hVolume)
            fAutoEject = true
          end
        end

        if fAutoEject
          # puts "Media in Drive %s has been ejected safely." % cDriveLetter
        elsif fRemoveSafely
          # puts "Media in Drive %s can be safely removed." % cDriveLetter
        else
          return false
        end

        true
      ensure
        if hVolume != INVALID_HANDLE_VALUE
          # Close the volume so other processes can use the drive.
          WinAPI.CloseHandle(hVolume)
        end
      end
    end
  end
end
