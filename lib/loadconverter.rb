# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "converterbase"
require_relative "helper"

class Converter < ConverterBase; end

#
# 小説固有コンバーターのロード
#
# ファイル名は converter.rb 固定で、ConverterBase を継承した Converter クラスを定義すると、
# before_convert メソッド及び after_convert メソッドが呼ばれるようになる。
# このファイルを必ず用意する必要はない。
# デフォルトの動作は ConverterBase#before_convert 及び #after_convert に定義されている。
#
# 引数の io はファイル先頭に seek(rewind) してあることが保証される。
# また、返却する IO オブジェクトはファイル先頭に seek しておく必要はない。
# text_type は渡されるテキストがタイトルなのか、前書きなのか等の種別を判断する文字列が渡される。
# 渡される文字列と意味：
#  subtitle      節のタイトル
#  introduction  前書き
#  body          本文
#  postscript    後書き
#  textfile      テキストファイル形式で変換をしようとした場合
#
# @setting で setting.ini で設定した値が読み込める(ex. @setting.enable_num_to_kanji)
#
# ex.)
# class Converter < ConverterBase
#   # 共通変換処理の前に呼ばれる
#   def before_convert(io, text_type)
#     data = io.read
#     data.gsub!("\n\n", "\n")   # WEB小説に多い無駄な空改行を削除する
#     StringIO.new(data)         # 返り値はIOライクなオブジェクトを。StringIO推奨
#   end
#
#   # 共通変換処理の後に呼ばれる
#   def after_convert(io, text_type)
#     buffer = StringIO.new
#     io.each do |line|
#       ～何らかの処理～（共通変換処理で漢数字化されたものを特定部分だけアラビア数字に戻したり）
#       buffer.write ～～
#     end
#     buffer
#   end
# end
def load_converter(path)
  converter_path = File.join(path, "converter.rb")
  if File.exists?(converter_path)
    if Helper.os_windows?
      # TODO: RubyのバグでUTF-8なパスをrequireが見えてない。修正されたら消す
      load converter_path.encode(Encoding::Windows_31J)
    else
      load converter_path
    end
  end
  Converter
end
