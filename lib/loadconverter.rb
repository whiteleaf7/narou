#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "converterbase"
require_relative "helper"

BlankConverter = Class.new(ConverterBase) {}

$latest_converter = nil

def converter(_title, &block)
  $latest_converter = Class.new(ConverterBase, &block)
end

#
# 小説固有コンバーターのロード
#
# ファイル名は converter.rb 固定で、変換処理のフックを定義できる。
# 基本の変換処理の実行前にはbeforeメソッド、変換処理後にafterメソッドが呼ばれる。
# このファイルを必ず用意する必要はない。
# converter は ConverterBase を継承したクラスを生成するものである。
# converter "タイトル" {} は class CONVERTER < ConverterBase; end にほぼ等しい。
#
# デフォルトの動作は ConverterBase#before 及び ConverterBase#aftert に定義されている。
# super を呼ばなければ基本動作を抑制出来る。
#
# 引数の io は StringIO のオブジェクトであり、ファイル先頭に seek(rewind) してあることが保証される。
# また、返却する IO オブジェクトはファイル先頭に seek しておく必要はない。
# text_type は渡されるテキストがタイトルなのか、前書きなのか等の種別を判断する文字列が渡される。
# 渡される文字列と意味：
#  story         あらすじ
#  chapter       章のタイトル
#  subtitle      節のタイトル
#  introduction  前書き
#  body          本文
#  postscript    後書き
#  textfile      テキストファイル形式で変換をしようとした場合
#
# @setting で setting.ini で設定した値が読み込める(ex. @setting.enable_num_to_kanji)
#
# e.g.)
# converter "書籍のタイトル" do
#   # 共通変換処理の前に呼ばれる
#   def before(io, text_type)
#     io.string.gsub!("\n\n", "\n")   # WEB小説に多い無駄な空改行を削除する
#     io                              # 返り値もStringIOで
#   end
#
#   # 共通変換処理の後に呼ばれる
#   def after(io, text_type)
#     buffer = StringIO.new
#     io.each do |line|
#       ～何らかの処理～（共通変換処理で漢数字化されたものを特定部分だけアラビア数字に戻したり）
#       buffer.write ～～
#     end
#     buffer
#   end
# end
def load_converter(title, archive_path)
  converter_path = File.join(archive_path, "converter.rb")
  if File.exist?(converter_path)
    $latest_converter = nil
    eval(File.read(converter_path, mode: "r:BOM|UTF-8"), binding, converter_path)
  else
    return BlankConverter
  end

  conv = $latest_converter
  if conv
    conv
  else
    title_for_converter = (title =~ /.txt\z/ ? title : File.basename(archive_path))
    error "converter.rbは見つかりましたが、`converter'で登録されていないようです。" +
          "変換処理は converter \"#{title_for_converter.gsub('"', '\\"')}\" として登録する必要があります"
    BlankConverter
  end
end
