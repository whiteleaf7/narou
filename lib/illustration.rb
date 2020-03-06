# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open-uri"

#
# 挿絵管理
#
class Illustration
  ILLUST_DIR = "挿絵/"
  NAROU_ILLUST_URL = "https://%s.mitemin.net/userpageimage/viewimage/icode/%s/"
  NAROU_ILLUST_TAG_PATTERN = /[ 　\t]*?<(i[0-9]+)\|([0-9]+)>\n?/m

  MIME = { "image/jpeg" => "jpg", "image/png" => "png", "image/gif" => "gif", "image/bmp" => "bmp" }

  class UnknownMIMEType < StandardError; end

  def initialize(setting, inspector)
    @setting = setting
    @inspector = inspector
  end

  def scanner(source, &block)
    source.gsub!(/［＃挿絵（(.+?)）入る］/) do |match|
      url = $1
      url = "https:#{url}" if url.start_with?("//")
      if url =~ URI::DEFAULT_PARSER.make_regexp
        path = download_image(url)
        path ? block.call(make_illust_chuki(path)) : ""
      else
        # URLでなければ、ローカルのパスが指定されたと判断してそのままの注記を使う
        block.call(match)
      end
    end
    source.gsub!(NAROU_ILLUST_TAG_PATTERN) do
      id1, id2 = $1, $2
      basename = "#{id1},#{id2}.*"
      url = NAROU_ILLUST_URL % [id2, id1]
      path = download_image(url, basename)
      path ? block.call(make_illust_chuki(path)) : ""
    end
    source
  end

  #
  # 画像のURLからデータを保存して、保存したファイルの絶対パスを返す
  #
  def download_image(url, basename = nil)
    basename = File.basename(basename ? basename : url, ".*")
    if path = search_image(basename)
      return path
    end

    url = transform_mitemin_url(url)
    URI.open(url, make_open_uri_options(allow_redirections: :safe)) do |fp|
      content_type = fp.meta["content-type"]
      ext = MIME[content_type] or raise UnknownMIMEType, content_type
      illust_abs_path = create_illust_path(basename) + "." + ext
      open(illust_abs_path, "wb") do |write_fp|
        write_fp.write(fp.read)
      end
      @inspector.info("挿絵「#{File.basename(illust_abs_path)}」を保存しました。")
      return illust_abs_path
    end
  rescue UnknownMIMEType => e
    @inspector.error("Illustration#download_image: #{url} は未対応の画像フォーマットです" +
                     "(content-type: #{e.message})")
    nil
  rescue StandardError => e
    @inspector.error("Illustration#download_image: #{url} を処理中に例外が発生しました(#{e})")
    nil
  end

  def search_image(basename)
    path = create_illust_path(basename) + ".*"
    Dir.glob(path)[0]
  end

  def transform_mitemin_url(url)
    uri = URI.parse(url)
    return url unless uri.host.end_with?(".mitemin.net")

    url.sub("viewimagebig", "viewimage")
  end

  def create_illust_path(basename)
    illust_abs_dir = File.join(@setting.archive_path, ILLUST_DIR)
    Dir.mkdir(illust_abs_dir) unless File.exist?(illust_abs_dir)
    File.join(illust_abs_dir, basename)
  end

  def make_illust_chuki(illust_path)
    rel_illust_path = to_rel(@setting.archive_path, illust_path)
    "［＃挿絵（#{rel_illust_path}）入る］"
  end

  #
  # 絶対パスから相対パスを作成
  # http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/36985
  #
  def to_rel(base, target)
    sep = /#{File::SEPARATOR}+/o
    base = base.split(sep)
    base.pop
    target = target.split(sep)
    while base.shift == target.shift
    end
    File.join([".."]*base.size+target)
  end
end
