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
        "AozoraEpub3 の再設定を行います"
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
        puts "初期化が完了しました！"
        puts "現在のフォルダ下で各種コマンドが使用出来るようになりました。"
        puts "まずは narou --help で簡単な説明を御覧ください。"
      end
    end

    def init_aozoraepub3(force = false)
      @global_setting = GlobalSetting.get["global_setting"]
      if !force && @global_setting["aozoraepub3dir"]
        return
      end
      puts "AozoraEpub3の設定を行います"
      puts "!!!WARNING!!!".center(70)
      puts "AozoraEpub3の構成ファイルを書き換えます。narouコマンド用に別途新規インストールしておくことをオススメします"
      aozora_path = ask_aozoraepub3_path
      unless aozora_path
        puts "設定をスキップしました。あとで narou init で再度設定出来ます"
        return
      end
      puts
      rewrite_aozoraepub3_files(aozora_path)
      @global_setting["aozoraepub3dir"] = aozora_path
      GlobalSetting.get.save_settings("global_setting")
      puts "AozoraEpub3の設定を終了しました"
    end

    def rewrite_aozoraepub3_files(aozora_path)
      # chuki_tag.txt の書き換え
      custom_chuki_tag_path = File.join(Narou.get_preset_dir, "custom_chuki_tag.txt")
      chuki_tag_path = File.join(aozora_path, "chuki_tag.txt")
      custom_chuki_tag = open(custom_chuki_tag_path, "r:BOM|UTF-8") { |fp| fp.read }
      chuki_tag = open(chuki_tag_path, "r:BOM|UTF-8") { |fp| fp.read }
      embedded_mark = "### Narou.rb embedded custom chuki ###"
      if chuki_tag =~ /#{embedded_mark}/
        chuki_tag.gsub!(/#{embedded_mark}.+#{embedded_mark}/m, custom_chuki_tag)
      else
        chuki_tag << "\n" + custom_chuki_tag
      end
      File.write(chuki_tag_path, chuki_tag)
      puts "(次のファイルを書き換えました)"
      puts chuki_tag_path
      puts
      # ファイルコピー
      src = ["AozoraEpub3.ini", "vertical_font.css", "DMincho.ttf"]
      dst = ["AozoraEpub3.ini", "template/OPS/css_custom/vertical_font.css", "template/OPS/fonts/DMincho.ttf"]
      puts "(次のファイルをコピーor上書きしました)"
      src.count.times do |i|
        src_full_path = File.join(Narou.get_preset_dir, src[i])
        dst_full_path = File.join(aozora_path, dst[i])
        FileUtils.install(src_full_path, dst_full_path)
        puts dst_full_path
      end
    end

    def ask_aozoraepub3_path
      puts
      print "AozoraEpub3のあるフォルダを入力して下さい\n(未入力でスキップ"
      if @global_setting["aozoraepub3dir"]
        print "、:keep で前回と同じ設定"
      end
      print "):\n>"
      while input = $stdin.gets.rstrip
        path = File.expand_path(input)
        case
        when input == ":keep"
          aozora_dir = @global_setting["aozoraepub3dir"]
          if aozora_dir && Narou.aozoraepub3_directory?(aozora_dir)
            return aozora_dir
          end
        when Narou.aozoraepub3_directory?(path)
          return path
        when input == ""
          break
        end
        print "\n入力されたフォルダにAozoraEpub3がありません。もう一度入力して下さい:\n>"
      end
      nil
    end
  end
end
