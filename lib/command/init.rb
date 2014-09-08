# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../inventory"
require_relative "../commandbase"

module Command
  class Init < CommandBase
    def self.oneline_help
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

  Examples:
    narou init
      EOS
    end

    def initialize_already_init
      @opt.separator <<-EOS

  ・AozoraEpub3 の再設定を行います。

  Examples:
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
        puts "まずは narou help で簡単な説明を御覧ください。"
      end
    end

    def init_aozoraepub3(force = false)
      @global_setting = Inventory.load("global_setting", :global)
      if !force && @global_setting["aozoraepub3dir"]
        return
      end
      puts "<bold><green>AozoraEpub3の設定を行います</green></bold>".termcolor
      unless @global_setting["aozoraepub3dir"]
        puts "<bold><red>#{"!!!WARNING!!!".center(70)}</red></bold>".termcolor
        puts "AozoraEpub3の構成ファイルを書き換えます。narouコマンド用に別途新規インストールしておくことをオススメします"
      end
      aozora_path = ask_aozoraepub3_path
      unless aozora_path
        puts "設定をスキップしました。あとで " + "<bold><yellow>narou init</yellow></bold>".termcolor + " で再度設定出来ます"
        return
      end
      puts
      rewrite_aozoraepub3_files(aozora_path)
      @global_setting["aozoraepub3dir"] = aozora_path
      @global_setting.save
      puts "<bold><green>AozoraEpub3の設定を終了しました</green></bold>".termcolor
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
      src.size.times do |i|
        src_full_path = File.join(Narou.get_preset_dir, src[i])
        dst_full_path = File.join(aozora_path, dst[i])
        FileUtils.install(src_full_path, dst_full_path)
        puts dst_full_path
      end
    end

    def ask_aozoraepub3_path
      puts
      print "<bold><green>AozoraEpub3のあるフォルダを入力して下さい:</green></bold>\n(未入力でスキップ".termcolor
      if @global_setting["aozoraepub3dir"]
        puts "、:keep で現在と同じ場所を指定)"
        print "(現在の場所:#{@global_setting["aozoraepub3dir"]}"
      end
      print ")\n>"
      while input = $stdin.gets.rstrip.gsub(/"/, "")
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
        print "\n<bold><green>入力されたフォルダにAozoraEpub3がありません。" \
              "もう一度入力して下さい:</green></bold>\n&gt;".termcolor
      end
      nil
    end
  end
end
