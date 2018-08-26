# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

class HotentryManager
  attr_reader :hotentries

  def initialize
    inv = Inventory.load("local_setting")
    self.enable = inv["hotentry"]
    self.auto_mail = inv["hotentry.auto-mail"]
    self.hotentries = {}
  end

  def connect(downloader)
    return unless enable?
    downloader.on(:newarrival, &method(:store_entry))
  end

  def enable?
    enable
  end

  def auto_mail?
    auto_mail
  end

  private

  attr_accessor :enable, :auto_mail
  attr_writer :hotentries

  def store_entry(hash)
    entry = hotentries[hash[:id]] ||= []
    entry << hash[:subtitle_info]
  end
end
