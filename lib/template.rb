# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "erb"
require_relative "narou"

class Template
  TEMPLATE_DIR = "template/"
  OVERWRITE = true

  class LoadError < StandardError; end

  #
  # テンプレートを元にファイルを作成
  #
  # src_filename  読み込みたいテンプレートファイル名(.erb は省略する)
  # dest_filepath 保存先ファイルパス。ディレクトリならファイル名はsrcと同じ名前で保存する
  # _binding      変数とか設定したいスコープの binding 変数を渡す
  # overwrite     上書きするか
  #
  def self.write(src_filename, dest_filepath, _binding, binary_version, overwrite = false)
    if File.directory?(dest_filepath)
      dest_filepath = File.join(dest_filepath, src_filename)
    end
    unless overwrite
      return if File.exist?(dest_filepath)
    end
    result = get(src_filename, _binding, binary_version) or return nil
    if Helper.os_windows?
      File.write(dest_filepath, result)
    else
      File.binwrite(dest_filepath, result.lstrip)
    end
  end

  #
  # テンプレートを元にデータを作成
  #
  # テンプレートファイルの検索順位
  # 1. root_dir/template
  # 2. script_dir/template
  #
  def self.get(src_filename, _binding, binary_version)
    @@binary_version = binary_version
    @@src_filename = src_filename
    [Narou.root_dir, Narou.script_dir].each do |dir|
      path = File.join(dir, TEMPLATE_DIR, src_filename + ".erb")
      next unless File.exist?(path)
      src = Helper::CacheLoader.load(path)
      result = ERB.new(src, nil, "-").result(_binding)
      return result
    end
    raise LoadError, "テンプレートファイルが見つかりません。(#{src_filename}.erb)"
  end

  def self.invalid_templace_version?
    @@src_version != @@binary_version
  end

  #
  # 書かれているテンプレートがどのバージョンのテンプレートかを設定
  #
  # テンプレート内部で使われる変数の変更があった場合に binary_version が上がる
  # （変数の追加ではバージョンは上がらない。現在使われている変数の中身が変わった場合は上る）
  #
  def self.target_binary_version(version)
    @@src_version = version
    if invalid_templace_version?
      error "テンプレートのバージョンが異なるので意図しない動作をする可能性があります\n" +
            "(#{@@src_filename}.erb ver #{version.to_f} != #{@@binary_version.to_f})"
    end
  end
end
