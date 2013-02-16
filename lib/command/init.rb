# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../globalsetting"
require_relative "../commandbase"

module Command
  class Init < CommandBase
    def oneline_help
      if Narou.already_init?
        "AozoraEpub3 の再設定を行います。"
      else
        "現在のフォルダを小説用に初期化します"
      end
    end

    def initialize
      super("")
      if Narou.already_init?
        initialize_already_init
      else
        initialize_init_yet
      end
    end

    def initialize_init_yet
      @opt.separator <<-EOS

  ・現在のフォルダを小説格納用フォルダとして初期化します。
  ・初期化されるまでは他のコマンドは使えません。

  Example:
    narou init
      EOS
    end

    def initialize_already_init
      @opt.separator <<-EOS

  ・AozoraEpub3 の再設定を行います。

  Example:
    narou init
      EOS
    end

    def execute(argv)
      super
      if Narou.already_init?
        init_aozoraepub3(true)
      else
        Narou.init
        puts "-" * 30
        init_aozoraepub3
        puts "初期化が完了しました"
      end
    end

    def init_aozoraepub3(force = false)
      global_setting = GlobalSetting.get["global_setting"]
      if !force && global_setting["aozoraepub3path"]
        return
      end
      puts "AozoraEpub3の設定を行います"
      puts "!!!WARNING!!!".center(70)
      puts "AozoraEpub3の構成ファイルを書き換えます。narouコマンド用に別途新規インストールしておくことをオススメします"
      aozora_path = ask_aozoraepub3_path
      unless aozora_path
        puts "AozoraEpub3の設定をスキップしました。あとで narou init で再度設定出来ます"
        return
      end
      rewrite_aozoraepub3_files(aozora_path)
      global_setting["aozoraepub3path"] = aozora_path
      GlobalSetting.get.save_settings("global_setting")
      puts "AozoraEpub3の設定を終了しました"
    end

    def rewrite_aozoraepub3_files(aozora_path)
      # chuki_tag.txt の書き換え
      custom_chuki_tag_path = File.join(Narou.get_preset_dir, "custom_chuki_tag.txt")
      chuki_tag_path = File.join(aozora_path, "chuki_tag.txt")
      custom_chuki_tag = File.read(custom_chuki_tag_path)
      chuki_tag = ""
      open(chuki_tag_path, "r:BOM|UTF-8") do |fp|
        chuki_tag = fp.read
      end
      if chuki_tag !~ /### Narou\.rb embedded custom chuki ###/
        chuki_tag << "\n" + custom_chuki_tag
        File.write(chuki_tag_path, chuki_tag)
        puts chuki_tag_path + " を書き換えました"
      end
      # ファイルコピー
      src = []; dst = []
      src << File.join(Narou.get_preset_dir, "vertical_font.css")
      dst << File.join(aozora_path, "template/OPS/css_custom/vertical_font.css")
      src << File.join(Narou.get_preset_dir, "DMincho.ttf")
      dst << File.join(aozora_path, "template/OPS/fonts/DMincho.ttf")
      src.count.times do |i|
        FileUtils.cp(src[i], dst[i])
        puts dst[i] + " を追加しました"
      end
    end

    def ask_aozoraepub3_path
      puts
      print "AozoraEpub3のあるフォルダを入力して下さい(未入力でスキップ):\n>"
      while input = STDIN.gets.rstrip
        path = File.expand_path(input)
        case
        when Narou.aozoraepub3_directory?(path)
          return path
          break
        when input == ""
          break
        else
          print "\n入力されたフォルダにAozoraEpub3がありません。もう一度入力して下さい:\n>"
        end
      end
      nil
    end
  end
end

if __FILE__ == $0
  Encoding.default_external = Encoding::UTF_8
  Command::Init.new.init_aozoraepub3(true)
end
