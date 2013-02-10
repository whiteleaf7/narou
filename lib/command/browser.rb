# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../localsetting"

module Command
  class Browser < CommandBase
    def initialize
      super("[options...]")
      @opt.separator <<-EOS

  ・指定した小説の掲載ページをブラウザで開きます。

  Example:
    narou browser n9669bk
    narou browser musyoku
      EOS
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      argv.each do |target|
        toc_url = Downloader.get_toc_url(target)
        unless toc_url
          puts "#{target} は存在しません"
          next
        end
        Helper.open_url_by_browser(toc_url)
      end
    end

    def oneline_help
      "小説の掲載ページをブラウザで開きます"
    end
  end
end
