# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "erb"
require_relative "narou"

class Template
  TEMPLATE_DIR = "template/"

  #
  # テンプレートを元にファイルを作成
  #
  # src_filename  読み込みたいテンプレートファイル名(.erb は省略する)
  # dest_filepath 保存先ファイルパス。ディレクトリならファイル名はsrcと同じ名前で保存する
  # _binding      変数とか設定したいスコープの binding 変数を渡す
  # overwrite     上書きするか
  #
  def self.write(src_filename, dest_filepath, _binding, overwrite = false)
    if File.directory?(dest_filepath)
      dest_filepath = File.join(dest_filepath, src_filename)
    end
    unless overwrite
      return if File.exists?(dest_filepath)
    end
    result = get(src_filename, _binding)
    File.write(dest_filepath, result)
  end

  #
  # テンプレートを元にデータを作成
  #
  def self.get(src_filename, _binding)
    src = File.read(File.join(Narou.get_script_dir, TEMPLATE_DIR, src_filename + ".erb"))
    result = ERB.new(src, nil, "-").result(_binding)
    result
  end
end
