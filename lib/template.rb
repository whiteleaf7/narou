# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "erb"

class Template
  TEMPLATE_DIR = "./template/"

  #
  # テンプレートを元にファイルを作成
  #
  # src_filename  読み込みたいテンプレートファイル名(.erb は省略する)
  # dest_filepath 保存先ファイルパス。ディレクトリならファイル名はsrcと同じ名前で保存する
  # _binding      変数とか設定したいスコープの binding 変数を渡す
  #
  def self.write(src_filename, dest_filepath, _binding)
    result = get(src_filename, _binding)
    if File::ftype(dest_filepath) == "directory"
      dest_filepath = File.join(dest_filepath, src_filename)
    end
    open(dest_filepath, "w") do |fp|
      fp.write(result)
    end
  end

  #
  # テンプレートを元にデータを作成
  #
  def self.get(src_filename, _binding)
    result = ERB.new(File.read(TEMPLATE_DIR + src_filename + ".erb"), nil, "-").result(_binding)
    result
  end
end
