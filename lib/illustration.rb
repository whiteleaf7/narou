# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open-uri"

#
# 挿絵管理
#
class Illustration
  ILLUST_DIR = "挿絵/"
  ILLUST_URL = "http://%s.mitemin.net/userpageimage/viewimage/icode/%s/"

  MIME = { "image/jpeg" => "jpg", "image/png" => "png", "image/gif" => "gif", "image/bmp" => "bmp" }

  class UnknownMIMEType < StandardError; end

  def initialize(setting, inspector)
    @setting = setting
    @inspector = inspector
  end

  #
  # 小説家になろうのイラストタグから挿絵データを取得する
  #
  def get(illust_tag)
    if illust_tag =~ /<(.+)\|(.+)>/
      id1, id2 = $1, $2
      illust_path = make_illust_path(id1, id2)
      unless illust_path
        # 挿絵画像をサイトからダウンロードして保存する
        open(make_url(id1, id2)) do |read_fp|
          read_fp.autoclose = true
          content_type = read_fp.meta["content-type"]
          ext = MIME[content_type] or raise UnknownMIMEType, content_type
          illust_path = make_illust_path(id1, id2, ext, false)
          illust_dir = File.dirname(illust_path)
          Dir.mkdir(illust_dir) unless File.exists?(illust_dir)
          open(illust_path, "wb") do |write_fp|
            write_fp.write(read_fp.read)
          end
          @inspector.info("挿絵「#{File.basename(illust_path)}」を保存しました。")
        end
      end
      chuki = make_illust_chuki(illust_path)
      chuki
    else
      # 有効なイラストタグではなかった
      @inspector.error("Illustration#get: #{illust_tag} は有効なイラストタグではありません。")
      nil
    end
  rescue UnknownMIMEType => e
    @inspector.error("Illustration#get: イラストタグ #{illust_tag} は対応した画像フォーマットではありません" + \
                     "(content-type: #{e.message})")
    nil
  rescue StandardError => e
    @inspector.error("Illustration#get: イラストタグ #{illust_tag} を処理中に例外が発生しました(#{e})")
    nil
  end

  def make_illust_chuki(illust_path)
    "［＃挿絵（#{ILLUST_DIR + File.basename(illust_path)}）入る］"
  end

  def make_illust_path(id1, id2, ext = "*", check = true)
    path = File.join(@setting.archive_path, ILLUST_DIR, "#{id1},#{id2}.#{ext}")
    if check
      Dir.glob(path)[0]
    else
      path
    end
  end

  def make_url(id1, id2)
    ILLUST_URL % [id2, id1]
  end
end
