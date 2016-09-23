
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
  dirpath = File.dirname(path)
  backup = false
  temp_path =
    if File.extname(path) == ".yaml" && File.basename(dirpath) != Downloader::SECTION_SAVE_DIR_NAME
      backup = true
      "#{path}.backup"
    else
      File.join(dirpath, SecureRandom.hex(15))
    end

  super(temp_path, string, *options)

  if backup
    FileUtils.copy(temp_path, path)
  else
    File.rename(temp_path, path)
  end
end
