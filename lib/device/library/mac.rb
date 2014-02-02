# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Device::Library
  module Mac
    def get_device_root_dir(volume_name)
      %w(/Volumes).each do |mount_root|
        path = File.join(mount_root, volume_name)
        if File.directory?(path)
          return path
        end
      end
      nil
    end
  end
end
