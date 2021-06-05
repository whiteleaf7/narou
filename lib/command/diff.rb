# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "tempfile"
require "open3"
require_relative "../downloader"
require_relative "../database"
require_relative "../template"
require_relative "../inventory"
require_relative "../helper"

module Command
  class Diff < CommandBase
    def self.oneline_help
      "更新された小説の差分を表示します"
    end

    def initialize
      super("[<target>] [options]")
      @opt.separator <<-EOS

  ・指定した小説の更新前後の変更点の差分を表示します。
  ・対象小説を指定しなかった場合は直前に更新した小説の差分を表示します。
  ・もし自分の好きな差分表示プログラムを使いたい場合、difftoolを設定して変更することが出来ます(下記参照)

  Examples:
    narou diff          # 直前に更新した小説の差分を表示
    narou diff 6
    narou diff 6 -n 2   # 最新から2番目の差分との比較
    narou diff 6 -2     # -n 2 の省略した記述方法
    narou diff 6 2013.02.21@01.39.46   # 差分を直接指定
    narou diff 6 -l     # 過去にどの話数の差分があるのかを確認

    # 自分の好きな差分表示プログラムを使う場合
    narou s difftool="C:\\Program Files\\WinMerge\\WinMergeU.exe"
    narou s difftool=colordiff      # コマンドラインツールを指定したり
    # Narou.rbオリジナルの差分表示に戻す場合は設定を削除する
    narou s difftool=

    # difftoolに渡す引数(指定しなければ単純に新旧ファイルを引数に呼び出す)
    # 特殊な変数 %NEW : 最新データの差分用ファイルパス
    #            %OLD : 古い方の差分用ファイルパス
    narou s difftool.arg='-e -x -ub -dl "OLD" -dr "NEW" %OLD %NEW'
    narou s difftool.arg="-u %OLD %NEW"

  Options:
      EOS

      @opt.on("-n NUM", "--number", "比較する差分を遡って指定する。最新のアップデートと直前のデータを比較するなら-n 1、2個前のアップデートなら-n 2。(デフォルトは-n 1)", Integer) { |number|
        @options["number"] = number if number > 1
      }
      @opt.on("-l", "--list", "指定した小説の差分一覧を表示する") {
        @options["list"] = true
      }
      @opt.on("-c", "--clean", "指定した小説の差分データを全て削除する") {
        @options["clean"] = true
      }
      @opt.on("--all-clean", "凍結済を除く全小説の差分データを削除する") {
        @options["all-clean"] = true
      }
      @opt.on("--no-tool", "外部差分ツールを使用しない") {
        @options["no-tool"] = true
      }
    end

    # 引数の中の -数字 オプション(-n 数字の省略形)を -n 数字 に変換する
    def short_number_option_parse(argv)
      argv.map! { |arg|
        if arg =~ /^-(\d+)$/
          ["-n", $1.to_s]
        else
          arg
        end
      }.flatten!
    end

    def execute(argv)
      disable_logging
      short_number_option_parse(argv)
      super
      @options["number"] ||= 1
      if argv.empty?
        latest = Database.instance.sort_by("last_update").first
        return unless latest
        id = latest["id"]
        @novel_data = latest
      else
        target = argv.shift
        @novel_data = Downloader.get_data_by_target(target) || {}
        id = @novel_data["id"]
      end
      unless id
        error "#{target} は存在しません"
        return
      end
      view_diff_version = argv.shift
      if view_diff_version
        if invalid_diff_version_string?(view_diff_version)
          error "差分指定の書式が違います(正しい例:2013.02.21@01.39.46)"
          return
        end
        @options["view_diff_version"] = view_diff_version
      end
      if @options["list"]
        display_diff_list(id)
        return
      end
      if @options["clean"]
        clean_diff(id)
        return
      end
      if @options["all-clean"]
        clean_all_diff
        return
      end
      @difftool = Inventory.load("global_setting", :global)["difftool"]
      if @difftool.! || @options["no-tool"]
        display_diff_on_oneself(id)
        return
      end
      exec_difftool(id)
    end

    def invalid_diff_version_string?(str)
      str !~ /^\d{4}\.\d{2}\.\d{2}@\d{2}[;.]\d{2}[;.]\d{2}$/
    end

    def version_string_to_time(string)
      ymd, hms = string.split("@")
      Helper.date_string_to_time("#{ymd} #{hms.tr(".", ":")}")
    end

    def clean_diff(id)
      cache_root_dir = Downloader.get_cache_root_dir(id)
      stream_io.print @novel_data["title"] + " の"
      unless File.exist?(cache_root_dir)
        stream_io.puts "差分はひとつもありません"
        return
      end
      FileUtils.remove_entry_secure(cache_root_dir)
      stream_io.puts "差分を削除しました"
    end

    def exec_difftool(id)
      temp_paths = create_temp_files(id) or return
      diff_cmd = create_difftool_command_string(*temp_paths.map { |temp|
        path = temp.path
        if Helper.os_windows?
          path = path.encode(Encoding::Windows_31J)
        end
        %!"#{path}"!
      })
      begin
        res = Helper::AsyncCommand.exec(diff_cmd)
      rescue Errno::ENOENT => e
        error e.message
        exit Narou::EXIT_ERROR_CODE
      ensure
        temp_paths.map(&:delete)
      end
      stream_io.puts res[0] unless res[0].empty?
      error res[1] unless res[1].empty?
    end

    def create_difftool_command_string(temp_old_path, temp_new_path)
      diff_arg = Inventory.load("global_setting", :global)["difftool.arg"]
      diff_cmd = %!"#{@difftool}" !
      if diff_arg
        diff_arg.gsub!("%OLD", temp_old_path)
        diff_arg.gsub!("%NEW", temp_new_path)
        diff_cmd += diff_arg
      else
        diff_cmd += [temp_old_path, temp_new_path].join(" ")
      end
      diff_cmd
    end

    def get_sorted_cache_list(id)
      list = Downloader.get_cache_list(id) or return nil
      list.sort_by { |v| File.basename(v) }.reverse
    end

    def create_temp_files(id)
      if @options["view_diff_version"]
        cache_root_dir = Downloader.get_cache_root_dir(id)
        if cache_root_dir
          cache_dir = File.join(cache_root_dir, @options["view_diff_version"])
          cache_dir = nil unless File.exist?(cache_dir)
        end
      else
        nth = @options["number"]
        list = get_sorted_cache_list(id)
        cache_dir = list ? list[nth - 1] : nil
      end
      unless cache_dir
        stream_io.puts "#{@novel_data["title"]} の差分データがありません"
        return nil
      end
      cache_section_list = Dir.glob("#{cache_dir}/*.yaml").sort_by { |path|
        File.basename(path, ".yaml").split(" ", 2)[0].to_i
      }
      if cache_section_list.length == 0
        stream_io.puts "#{@novel_data["title"]} は最新話のみのアップデートのようです"
        return nil
      end
      novel_dir = Downloader.get_novel_section_save_dir(Downloader.get_novel_data_dir_by_target(id))
      latest_novel_sections = []
      cache_sections = []
      cache_section_list.each do |path|
        match_latest_path = File.join(novel_dir, File.basename(path))
        latest_novel_sections << YAML.unsafe_load_file(match_latest_path) if File.exist?(match_latest_path)
        cache_sections << YAML.unsafe_load_file(path)
      end

      novel_info = Database.instance[id]
      temp_old = create_temp_by_sections("old", cache_sections, novel_info)
      temp_new = create_temp_by_sections("new", latest_novel_sections, novel_info)

      [temp_old, temp_new]
    end

    def create_temp_by_sections(temp_prefix, sections, novel_info)
      html = HTML.new
      html.strip_decoration_tag = true
      sections.each do |section|
        element = section["element"]
        data_type = element.delete("data_type") || "text"
        element.each do |text_type, elm_text|
          if data_type == "html"
            html.string = elm_text
            element[text_type] = html.to_aozora
          end
        end
      end
      temp = Tempfile.open([temp_prefix, ".txt"])
      temp.write(Template.get("diff.txt", binding, 1.0))
      temp.close
      temp
    end

    def get_diff_list(id)
      @novel_data ||= Database.instance.get_data("id", id)
      list = {
        id: id,
        title: @novel_data["title"],
        list: []
      }
      cache_list = get_sorted_cache_list(id)
      return list if cache_list.empty?
      cache_list.each.with_index(1) do |cache_path, i|
        objects = []
        version_string = File.basename(cache_path)
        data = {
          number: i,
          version_string: version_string,
          time: version_string_to_time(version_string),
          objects: objects
        }
        list[:list].push(data)
        cache_section_list = Dir.glob(File.join(cache_path, "*.yaml"))
        if cache_section_list.length > 0
          cache_section_list.map { |section_path|
            File.basename(section_path, ".yaml").split(" ", 2)
          }.sort_by { |v| v[0].to_i }.each { |index, subtitle|
            objects.push({ index: index, subtitle: subtitle })
          }
        end
      end
      list
    end

    def display_diff_list(id)
      list = get_diff_list(id)
      stream_io.print "#{list[:title]} の"
      if list[:list].empty?
        stream_io.puts "差分はひとつもありません"
        return
      end
      stream_io.puts "差分一覧"
      list[:list].each do |data|
        stream_io.puts "<bold><yellow>#{data[:version_string]}   -#{data[:number]}</yellow></bold>".termcolor
        data[:objects].each do |object|
          stream_io.puts "   第#{object[:index]}部分　#{object[:subtitle]}"
        end
        if data[:objects].empty?
          stream_io.puts "   (最新話のみのアップデート)"
        end
      end
    end

    def clean_all_diff
      Database.instance.each do |id, data|
        next if Narou.novel_frozen?(id)
        cache_root_dir = Downloader.get_cache_root_dir(id)
        next unless File.exist?(cache_root_dir)
        FileUtils.remove_entry_secure(cache_root_dir)
        stream_io.puts "#{data["title"]} の差分を削除しました"
      end
    end

    #
    # diff-lcs を使って自力で差分表示
    #
    def display_diff_on_oneself(id)
      require_relative "../diffviewer"
      temp_paths = create_temp_files(id) or return
      stream_io.puts "#{@novel_data["title"]} の差分を表示します"
      stream_io.puts DiffViewer.new(*temp_paths).result
    ensure
      temp_paths.map(&:delete) if temp_paths
    end
  end
end
