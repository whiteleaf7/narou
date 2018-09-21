# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Narou
  module Mixin
    module Locker
      def locked?(target)
        id = Downloader.get_id_by_target(target) or return false
        Inventory.load("lock").include?(id)
      end

      def lock(target)
        id = Downloader.get_id_by_target(target) or return
        locked_list = Inventory.load("lock")
        locked_list[id] = Time.now
        locked_list.save
      end

      def unlock(target)
        id = Downloader.get_id_by_target(target) or return
        locked_list = Inventory.load("lock")
        return unless locked_list.delete(id)
        locked_list.save
      end
    end
  end
end
