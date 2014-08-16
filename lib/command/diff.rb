# -*- coding: utf-8 -*-
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
      "アップデートされた小説の変更点を表示します"
    end

    def initialize
      super("[<target>] [options]")
      @opt.separator <<-EOS

  ・指定した小説のアップデート前後の変更部分を setting コマンドで指定した difftool で表示します。
  ・引数を指定しなかった場合は直前に更新した小説の変更点を表示します。

  Examples:
    narou diff          # 直前に更新した小説の変更点を表示
    narou diff 6
    narou diff 6 -n 2   # 最新から2番目の差分との比較
    narou diff 6 -2     # -n 2 の省略した記述方法
    narou diff 6 2013.02.21@01;39;46   # 差分を直接指定

    # 差分表示用プログラムの指定
    narou setting difftool="C:\\Program Files\\WinMerge\\WinMergeU.exe"
    narou s difftool=colordiff      # コマンドラインツールを指定したり

    # difftoolに渡す引数(指定しなければ単純に新旧ファイルを引数に呼び出す)
    # 特殊な変数 %NEW : DLした最新データの差分用ファイルパス
    #            %OLD : 古い方の差分用ファイルパス
    narou setting difftool.arg='-e -x -ub -dl "OLD" -dr "NEW" %OLD %NEW'
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
      short_number_option_parse(argv)
      super
      @options["number"] = 1
      if argv.empty?
        latest = Database.instance.sort_by_last_update.first
        return unless latest
        id = latest["id"]
      else
        target = argv.shift
        id = Downloader.get_id_by_target(target)
      end
      unless id
        error "#{target} は存在しません"
        return
      end
      view_diff_version = argv.shift
      if view_diff_version
        if invalid_diff_version_string?(view_diff_version)
          error "差分指定の書式が違います(正しい例:2013.02.21@01;39;46)"
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
      unless @difftool
        error "difftool が設定されていません。narou setting で difftool を設定して下さい"
        return
      end
      exec_difftool(id)
    end

    def invalid_diff_version_string?(str)
      str !~ /^\d{4}\.\d{2}\.\d{2}@\d{2};\d{2};\d{2}$/
    end

    def clean_diff(id)
      cache_root_dir = Downloader.get_cache_root_dir(id)
      print Database.instance.get_data("id", id)["title"] + " の"
      unless File.exists?(cache_root_dir)
        puts "差分はひとつもありません"
        return
      end
      FileUtils.remove_entry_secure(cache_root_dir)
      puts "差分を削除しました"
    end

    def exec_difftool(id)
      temp_paths = create_temp_files(id) or return
      diff_cmd = create_difftool_command_string(*temp_paths.map { |temp|
        path = temp.path
        if Helper.os_windows?
          path.encode!(Encoding::Windows_31J)
        end
        %!"#{path}"!
      })
      begin
        res = Open3.capture3(diff_cmd)
      rescue Errno::ENOENT => e
        error e.message
        exit 1
      ensure
        temp_paths.each { |tmp| tmp.delete }
      end
      puts res[0] unless res[0].empty?
      error res[1] unless res[1].empty?
    end

    def create_difftool_command_string(left, right)
      diff_arg = Inventory.load("global_setting", :global)["difftool.arg"]
      diff_cmd = %!"#{@difftool}" !
      if diff_arg
        diff_arg.gsub!("%NEW", left)
        diff_arg.gsub!("%OLD", right)
        diff_cmd += diff_arg
      else
        diff_cmd += [left, right].join(" ")
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
          cache_dir = nil unless File.exists?(cache_dir)
        end
      else
        nth = @options["number"]
        list = get_sorted_cache_list(id)
        cache_dir = list[nth - 1] if list
      end
      unless cache_dir
        puts "差分データがありません"
        return nil
      end
      cache_section_list = Dir.glob("#{cache_dir}/*.yaml").sort_by { |path|
        File.basename(path, ".yaml").split(" ", 2)[0].to_i
      }
      if cache_section_list.length == 0
        puts "最新話のみのアップデートのようです"
        return nil
      end
      novel_dir = Downloader.get_novel_section_save_dir(Downloader.get_novel_data_dir_by_target(id))
      latest_novel_sections = []
      cache_sections = []
      cache_section_list.each do |path|
        match_latest_path = File.join(novel_dir, File.basename(path))
        latest_novel_sections << YAML.load_file(match_latest_path) if File.exists?(match_latest_path)
        cache_sections << YAML.load_file(path)
      end

      novel_info = Database.instance[id]

      sections = latest_novel_sections
      temp_new = Tempfile.open(["new", ".txt"])
      temp_new.write(Template.get("diff.txt", binding))
      temp_new.close

      sections = cache_sections
      temp_old = Tempfile.open(["old", ".txt"])
      temp_old.write(Template.get("diff.txt", binding))
      temp_old.close

      [temp_new, temp_old]
    end

    def display_diff_list(id)
      cache_list = get_sorted_cache_list(id)
      print Database.instance.get_data("id", id)["title"] + " の"
      if cache_list.empty?
        puts "差分はひとつもありません"
        return
      end
      puts "差分一覧"
      cache_list.each.with_index(1) do |cache_path, i|
        puts ("<bold><yellow>" + File.basename(cache_path) + "   -#{i}</yellow></bold>").termcolor
        cache_section_list = Dir.glob(File.join(cache_path, "*.yaml"))
        if cache_section_list.length > 0
          cache_section_list.map { |section_path|
            File.basename(section_path, ".yaml").split(" ", 2)
          }.sort_by { |v| v[0].to_i }.each { |index, subtitle|
            puts "   第#{index}部分　#{subtitle}"
          }
        else
          puts "   (最新話のみのアップデート)"
        end
      end
    end

    def clean_all_diff
      Database.instance.each do |id, data|
        next if Narou.novel_frozen?(id)
        cache_root_dir = Downloader.get_cache_root_dir(id)
        next unless File.exists?(cache_root_dir)
        FileUtils.remove_entry_secure(cache_root_dir)
        puts "#{data["title"]} の差分を削除しました"
      end
    end
  end
end
