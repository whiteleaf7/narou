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
      super("[options]")
      if Narou.already_init?
        opt_message(<<-MSG)
  ・AozoraEpub3 の再設定を行います。
        MSG
      else
        opt_message(<<-MSG)
  ・現在のフォルダを小説格納用フォルダとして初期化します。
  ・初期化されるまでは他のコマンドは使えません。
        MSG
      end
      @opt.on("-p", "--path FOLDER", "指定したフォルダの AozoraEpub3 を利用する") { |dirname|
        # no check here since global_setting is not loaded yet
        @options["aozora_dirname"] = dirname
      }
      @opt.on("-l", "--line-height SIZE", "行の高さを変更する(単位em)。オススメは1.6〜1.8程度") do |line_height|
        begin
          @options["line_height"] = Helper.string_cast_to_type(line_height, :float)
        rescue Helper::InvalidVariableType => e
          error e.message
          exit Narou::EXIT_ERROR_CODE
        end
      end
    end

    def opt_message(description)
      @opt.separator <<-MSG

#{description}
  Examples:
    narou init
    narou init -p /opt/narou/aozora    # AozoraEpub3 のフォルダを直接指定
    narou init -p :keep                # 設定済みと同じ場所を指定(既に初期化済の場合)

    # 行の高さの調整
    narou init --line-height 1.8       # 行の高さを1.8emに設定(1.8文字分相当)
    # 行の高さなので、行間を1文字分あけたいという場合は 1+1 で 2 を指定する
    # (デフォルト 1.6)
    # 参考情報：Kindle Voyage で文字サイズ４番目の大きさの場合、
    #   1.6em : 1ページに15行
    #   1.8em : 1ページに13行
    # の表示行数になる

    # 入力を省略したい場合、-p と -l を両方指定してやる必要あり
    narou init -p /path/to/aozora -l 1.8

  Options:
      MSG
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
      if @options["aozora_dirname"]
        path = normalize_aozoraepub3_path(@options["aozora_dirname"])
        print "\n<bold><green>指定されたフォルダにAozoraEpub3がありません。</green></bold>\n".termcolor unless path
      end
      aozora_path = path || ask_aozoraepub3_path
      unless aozora_path
        puts "設定をスキップしました。あとで " + "<bold><yellow>narou init</yellow></bold>".termcolor + " で再度設定出来ます"
        return
      end
      line_height = @options["line_height"] || ask_line_height
      puts
      rewrite_aozoraepub3_files(aozora_path, line_height)
      @global_setting["aozoraepub3dir"] = aozora_path
      @global_setting["line-height"] = line_height
      @global_setting.save
      puts "<bold><green>AozoraEpub3の設定を終了しました</green></bold>".termcolor
    end

    def rewrite_aozoraepub3_files(aozora_path, line_height)
      # chuki_tag.txt の書き換え
      custom_chuki_tag_path = File.join(Narou.get_preset_dir, "custom_chuki_tag.txt")
      chuki_tag_path = File.join(aozora_path, "chuki_tag.txt")
      custom_chuki_tag = File.read(custom_chuki_tag_path, mode: "r:BOM|UTF-8")
      chuki_tag = File.read(chuki_tag_path, mode: "r:BOM|UTF-8")
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
      src = ["AozoraEpub3.ini", "vertical_font.css"]
      dst = ["AozoraEpub3.ini", "template/OPS/css_custom/vertical_font.css"]
      puts "(次のファイルをコピーor上書きしました)"
      src.size.times do |i|
        src_full_path = File.join(Narou.get_preset_dir, src[i])
        dst_full_path = File.join(aozora_path, dst[i])
        Helper.erb_copy(src_full_path, dst_full_path, binding)
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
      while (input = $stdin.gets)
        break if input.strip! == ""
        checked_input = normalize_aozoraepub3_path(input)
        return checked_input if checked_input
        print "\n<bold><green>入力されたフォルダにAozoraEpub3がありません。" \
              "もう一度入力して下さい:</green></bold>\n&gt;".termcolor
      end
      nil
    end

    def ask_line_height
      line_height = Narou.line_height
      puts
      puts(<<-MSG.termcolor)
<bold><green>行間の調整を行います。小説の行の高さを設定して下さい(単位 em):</green></bold>
1em = 1文字分の高さ
行の高さ＝1文字分の高さ＋行間の高さ
オススメは 1.6 〜 1.8 程度。1.6 で若干行間狭め。1.8 だと一般的な小説程度。2.0 くらいにするとかなりスカスカ
(未入力で #{line_height} を採用)
      MSG
      print ">"
      while (input = $stdin.gets)
        break if input.strip! == ""
        begin
          line_height = Helper.string_cast_to_type(input, :float)
          break
        rescue Helper::InvalidVariableType => e
          error e.message
          print "<bold><green>もう一度入力して下さい:</green></bold>\n&gt;".termcolor
        end
      end
      line_height
    end

    def normalize_aozoraepub3_path(input)
      if Helper.os_windows?
        input.force_encoding(Encoding::Windows_31J).encode!(Encoding::UTF_8)
      end
      input.delete!("\"")
      path = File.expand_path(input)
      if input == ":keep"
        aozora_dir = @global_setting["aozoraepub3dir"]
        if aozora_dir && Narou.aozoraepub3_directory?(aozora_dir)
          return aozora_dir
        end
      elsif Narou.aozoraepub3_directory?(path)
        return path
      end
      nil
    end
  end
end
