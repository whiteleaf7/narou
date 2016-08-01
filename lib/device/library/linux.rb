# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#
require "etc"

module Device::Library
  module Linux
    username = (Etc.getlogin || Etc.getpwuid.name)
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
  end
end
