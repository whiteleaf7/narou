module Narou
  module ServerHelper
    #
    # タグをHTMLで装飾する
    #
    def decorate_tags(tags)
      tags.sort.map do |tag|
        %!<span class="tag label label-#{Command::Tag.get_color(tag)}" data-tag="#{escape_html(tag)}">#{escape_html(tag)}</span>!
      end.join(" ")
    end

    #
    # タグをHTMLで装飾する(除外タグ指定用)
    #
    def decorate_exclusion_tags(tags)
      tags.sort.map do |tag|
        %!<span class="tag label label-#{Command::Tag.get_color(tag)}" data-exclusion-tag="#{escape_html(tag)}">^tag:#{escape_html(tag)}</span>!
      end.join(" ")
    end

    #
    # Rubyバージョンを構築
    #
    def build_ruby_version
      begin
        `"#{RbConfig.ruby}" -v`.strip
      rescue
        config = RbConfig::CONFIG
        "ruby #{RUBY_VERSION}p#{config["PATCHLEVEL"]} [#{RUBY_PLATFORM}]"
      end
    end

    #
    # 有効な novel ID だけの配列を生成する
    # ID が指定されなかったか、１件も存在しない場合は nil を返す
    #
    def select_valid_novel_ids(ids)
      return nil unless ids.kind_of?(Array)
      result = ids.select do |id|
        id =~ /^\d+$/
      end
      result.empty? ? nil : result
    end

    #
    # フォーム情報の真偽値データを実際のデータに変換
    #
    def convert_on_off_to_boolean(str)
      case str
      when "on"
        true
      when "off"
        false
      else
        nil
      end
    end

    #
    # nil true false を nil on off という文字列に変換
    #
    def convert_boolean_to_on_off(bool)
      case bool
      when TrueClass
        "on"
      when FalseClass
        "off"
      else
        "nil"
      end
    end

    #
    # HTMLエスケープヘルパー
    #
    def h(text)
      Rack::Utils.escape_html(text)
    end

    #
    # 与えられたデータが真偽値だった場合、設定画面用に「はい」「いいえ」に変換する
    # 真偽値ではなかった場合、そのまま返す
    #
    def value_to_msg(value)
      case value
      when TrueClass
        "はい"
      when FalseClass
        "いいえ"
      else
        value
      end
    end

    def notepad_text_path
      File.join(Narou.local_setting_dir, "notepad.txt")
    end

    def get_general_all_no_by_toc(id)
      toc = Downloader.new(id).load_toc_file
      return nil unless toc
      toc["subtitles"].size
    end
  end
end
