
require "open-uri"

# open-uri で http → https へのリダイレクトを有効にする
require "open_uri_redirections"

# open-uri に渡すオプションを生成（必要に応じて extensions/*.rb でオーバーライドする）
def make_open_uri_options(add)
  add
end

#
# 安全なファイルの書き込み
#
# ファイルに直接上書きしないで、一旦別名で作成してからファイル名変更をすることで、
# ファイル書き込み中のPCクラッシュ等でデータが飛ばない様にする
#
require "securerandom"

def File.write(path, string, *options)
  dirname = File.dirname(path)
  temp_path = File.join(dirname, SecureRandom.hex(15))
  super(temp_path, string, *options)
  File.rename(temp_path, path)
end
