
require "open-uri"
require "openssl"

# open-uri で http → https へのリダイレクトを有効にする
require "open_uri_redirections"

# open-uri に渡すオプションを生成（必要に応じて extensions/*.rb でオーバーライドする）
def make_open_uri_options(add)
  add.merge(ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
end

#
# 安全なファイルの書き込み
#
# ファイルに直接上書きしないで、一旦別名で作成してからファイル名変更をすることで、
# ファイル書き込み中のPCクラッシュ等でデータが飛ばない様にする
#
require "securerandom"

def File.write(path, string, *options, mode: nil)
  return super if mode

  dirpath = File.dirname(path)
  temp_path = File.join(dirpath, SecureRandom.hex(15))
  if File.extname(path) == ".yaml" && File.basename(dirpath) != Downloader::SECTION_SAVE_DIR_NAME
    backup = "#{path}.backup"
  end

  res = super(temp_path, string, *options)
  if backup
    super(backup, string, *options)
  end
  File.rename(temp_path, path)
  res
end
