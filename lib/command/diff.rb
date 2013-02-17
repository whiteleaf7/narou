# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "tempfile"
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
      super("[<target> ...]")
      @opt.separator <<-EOS

  ・指定した小説のアップデート前、後の変更部分を setting コマンドで指定した difftool で表示します。
  ・引数を指定しなかった場合は直近のアップデートの変更点を表示します。

  Example:
    narou diff     # 直近のアップデートの変更点を表示
    narou diff 6

    # 差分表示用プログラムの指定
    narou setting difftool="C:\\Program Files\\WinMerge\\WinMergeU.exe"

    # difftoolに渡す引数(指定しなければ単純に新旧ファイルを引数に呼び出すだけ)
    # 特殊な変数 $NEW : DLした最新データの差分用ファイルパス
    #            $OLD : 古い方の差分用ファイルパス
    narou setting difftool.arg='-e -x -ub -dl "NEW" -dr "OLD" $NEW $OLD'

      EOS

      @options["number"] = 1
      @opt.on("-n NUM", "比較する差分を遡って指定する。最新のアップデートと直前のデータを比較するなら-n 1、2個前のアップデートなら-n 2。(デフォルトは-n 1)", Integer) do |number|
        if number > 1
          @options["number"] = number
        end
      end
    end

    def execute(argv)
      super
      @difftool = GlobalSetting.get["global_setting"]["difftool"]
      if @difftool
        unless File.exists?(@difftool)
          warn "#{@difftool} が存在しません。narou setting で difftool を再設定して下さい"
          return
        end
      else
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
      argv.each do |target|
        id = Downloader.get_id_by_target(target)
        unless id
          warn "#{target} は存在しません"
          next
        end
        exec_difftool(id)
      end
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
      `#{diff_cmd}`
    end

    def create_difftool_command_string(left, right)
      diff_arg = GlobalSetting.get["global_setting"]["difftool.arg"]
      diff_cmd = %!"#{@difftool}" !
      if diff_arg
        diff_arg.gsub!("$NEW", left)
        diff_arg.gsub!("$OLD", right)
        diff_cmd += diff_arg
      else
        diff_cmd += %!#{left} #{right}!
      end
      diff_cmd
    end

    def create_temp_files(id)
      nth = @options["number"]
      cache_dir = Downloader.get_cache_list(id).sort_by { |v| File.basename(v) }.reverse[nth - 1]
      unless cache_dir
        puts "差分データがありません"
        return nil
      end
      cache_list = Dir.glob("#{cache_dir}/*.yaml")
      if cache_list.length == 0
        puts "差分データがありません"
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
      temp_new.write(Template.get("temp4diff.txt", binding))

      sections = cache_sections
      temp_old = Tempfile.open("old")
      temp_old.write(Template.get("temp4diff.txt", binding))

      [temp_new, temp_old]
    end
  end
end
