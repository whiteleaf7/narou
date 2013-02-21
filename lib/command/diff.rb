# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "tempfile"
require "open3"
require_relative "../downloader"
require_relative "../database"
require_relative "../template"
require_relative "../globalsetting"
require_relative "../helper"

module Command
  class Diff < CommandBase
    def oneline_help
      "アップデートされた小説の変更点を表示します"
    end

    def initialize
      super("[<target>] [options ...]")
      @opt.separator <<-EOS

  ・指定した小説のアップデート前後の変更部分を setting コマンドで指定した difftool で表示します。
  ・引数を指定しなかった場合は直前に更新した小説の変更点を表示します。

  Example:
    narou diff          # 直前に更新した小説の変更点を表示
    narou diff 6
    narou diff 6 -n 2   # 最新から2番目の差分との比較
    narou diff 6 -2     # -n 2 の省略した記述方法
    narou diff 6 2013.02.21@01;39;46   # 差分を直接指定

    # 差分表示用プログラムの指定
    narou setting difftool="C:\\Program Files\\WinMerge\\WinMergeU.exe"

    # difftoolに渡す引数(指定しなければ単純に新旧ファイルを引数に呼び出す)
    # 特殊な変数 %NEW : DLした最新データの差分用ファイルパス
    #            %OLD : 古い方の差分用ファイルパス
    narou setting difftool.arg='-e -x -ub -dl "NEW" -dr "OLD" %NEW %OLD'

      EOS

      @options["number"] = 1
      @opt.on("-n NUM", "--number", "比較する差分を遡って指定する。最新のアップデートと直前のデータを比較するなら-n 1、2個前のアップデートなら-n 2。(デフォルトは-n 1)", Integer) do |number|
        @options["number"] = number if number > 1
      end
      @opt.on("--clean", "指定した小説の差分データを全て削除する") {
        @options["clean"] = true
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
      @difftool = GlobalSetting.get["global_setting"]["difftool"]
      unless @difftool
        warn "difftool が設定されていません。narou setting で difftool を設定して下さい"
        return
      end
      if argv.empty?
        latest = Database.instance.sort_by_last_update.first
        if latest
          exec_difftool(latest["id"])
        end
        return
      end
      target = argv.shift
      view_diff_version = argv.shift
      if view_diff_version
        if invalid_diff_version_string?(view_diff_version)
          warn "差分指定の書式が違います(正しい例:2013.02.21@01;39;46)"
          return
        end
        @options["view_diff_version"] = view_diff_version
      end
      id = Downloader.get_id_by_target(target)
      unless id
        warn "#{target} は存在しません"
        return
      end
      exec_difftool(id)
    end

    def invalid_diff_version_string?(str)
      !str =~ /^\d{4}\.\d{2}\.\d{2}@\d{2};\d{2};\d{2}$/
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
        warn e.message
        exit 1
      end
      puts res[0] unless res[0].empty?
      warn res[1] unless res[1].empty?
    end

    def create_difftool_command_string(left, right)
      diff_arg = GlobalSetting.get["global_setting"]["difftool.arg"]
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

    def create_temp_files(id)
      if @options["view_diff_version"]
        cache_root_dir = Downloader.get_cache_root_dir(id)
        if cache_root_dir
          cache_dir = File.join(cache_root_dir, @options["view_diff_version"])
          cache_dir = nil unless File.exists?(cache_dir)
        end
      else
        nth = @options["number"]
        cache_dir = Downloader.get_cache_list(id).sort_by { |v| File.basename(v) }.reverse[nth - 1]
      end
      unless cache_dir
        puts "差分データがありません"
        return nil
      end
      cache_list = Dir.glob("#{cache_dir}/*.yaml")
      if cache_list.length == 0
        puts "最新話のみでした"
        return nil
      end
      novel_dir = Downloader.get_novel_section_save_dir(Downloader.get_novel_data_dir_by_target(id))
      latest_novel_sections = []
      cache_sections = []
      cache_list.each do |path|
        latest_novel_sections << YAML.load_file(File.join(novel_dir, File.basename(path)))
        cache_sections << YAML.load_file(path)
      end
      sections = latest_novel_sections
      temp_new = Tempfile.open("new")
      temp_new.write(Template.get("diff.txt", binding))

      sections = cache_sections
      temp_old = Tempfile.open("old")
      temp_old.write(Template.get("diff.txt", binding))

      [temp_new, temp_old]
    end
  end
end
