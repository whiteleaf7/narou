# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../localsetting"

module Command
  class Browser < CommandBase
    def initialize
      super("<target> [<target2> ...]")
      @opt.separator <<-EOS

  ・指定した小説の掲載ページをブラウザで開きます。

  Example:
    narou browser n9669bk
    narou browser musyoku

  Options:
      EOS

      @opt.on("-v", "--vote", "指定した小説の投票・感想を投稿するページを表示する") {
        @options["vote"] = true
      }
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      argv.each do |target|
        data = Downloader.get_data_by_target(target)
        unless data
          error "#{target} は存在しません"
          next
        end
        toc_url = data["toc_url"]
        if @options["vote"]
          # TODO: 最新話の場所をAPIで取得する
          data_dir = Downloader.get_novel_data_dir_by_target(data["id"])
          latest_index = YAML.load_file(File.join(data_dir, Downloader::TOC_FILE_NAME))["subtitles"].last["index"]
          open_url = "#{toc_url + latest_index}/#f_cr"
        else
          open_url = toc_url
        end
        Helper.open_url_by_browser(open_url)
        puts open_url
      end
    end

    def oneline_help
      "小説の掲載ページをブラウザで開きます"
    end
  end
end
