# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#
# rubocop:disable Lint/AssignmentInCondition
# rubocop:disable UtilityFunction

require "etc"

class Device
  module Library
    module Linux
      username = Etc.getpwuid(Process.euid).name
      @@mount_roots = %w(/media /mnt)
      @@mount_roots << "/run/media/" + username # udisks2 による自動マウント(デフォルトの場所)
      @@mount_roots << "/media/" + username # udisks2 による自動マウント(Ubuntuの場合)
      def get_device_root_dir(volume_name)
        @@mount_roots.each do |mount_root|
          path = File.join(mount_root, volume_name)
          if File.directory?(path)
            return path
          end
        end
        nil
      end

      # 端末のデバイスファイル名と uhelper オプションの値を取得
      def device_mount_info(volume_name)
        device_root = get_device_root_dir(volume_name)
        raise Device::CantEject, "端末が接続されていません" unless device_root

        pattern = %r!^(/dev/[^ ]+) .* #{device_root} .*\Wuhelper=(\w+)!
        open("|mount") do |io|
          while line = io.gets
            if line =~ pattern
              return [$1, $2]
            end
          end
        end
        [nil, nil]
      end

      def ejectable?(volume_name)
        case device_mount_info(volume_name)[1]
        when "udisks", "udisks2"
          true
        else
          false
        end
      rescue Device::CantEject
        false
      end

      def eject(volume_name)
        device, uhelper = device_mount_info(volume_name)

        case uhelper
        when "udisks"
          commands = ["udisks --unmount #{device}",
                      "udisks --detach #{device.chop}"]
        when "udisks2"
          commands = ["udisksctl unmount -b #{device} --no-user-interaction",
                      "udisksctl power-off -b #{device.chop} --no-user-interaction"]
        else
          raise Device::CantEject, "udisks または udisks2 によって自動マウントされたデバイスではありません。"
        end

        commands.each do |command|
          status, _stdout, stderr = systemu(command)
          unless status.success?
            raise Device::CantEject, "#{command}: #{stderr.strip}"
          end
        end
      end
    end
  end
end
