# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Device::Ibunko
  PHYSICAL_SUPPORT = false
  VOLUME_NAME = nil
  DOCUMENTS_PATH_LIST = nil
  EBOOK_FILE_EXT = ".zip"
  NAME = "iBunko"
  DISPLAY_NAME = "i文庫"

  #
  # i文庫用に設定を強制設定する
  #
  def hook_change_settings(&original_func)
    @@__already_exec_change_settings ||= false
    return if @@__already_exec_change_settings
    force_change_settings_function({
      "force.enable_half_indent_bracket" => false,
      "force.enable_dakuten_font" => false
    })
    @@__already_exec_change_settings = true
  end

  #
  # i文庫用にテキストと挿絵ファイルをzipアーカイブ化する
  #
  def hook_convert_txt_to_ebook_file(&original_func)
    return false if @options["no-zip"]
    require "zip"
    Zip.unicode_names = true
    dirpath = File.dirname(@converted_txt_path)
    translate_illust_chuki_to_img_tag
    zipfile_path = @converted_txt_path.sub(/.txt$/, @device.ebook_file_ext)
    File.delete(zipfile_path) if File.exists?(zipfile_path)
    Zip::File.open(zipfile_path, Zip::File::CREATE) do |zip|
      zip.add(File.basename(@converted_txt_path), @converted_txt_path)
      illust_dirpath = File.join(dirpath, Illustration::ILLUST_DIR)
      # 挿絵
      if File.exists?(illust_dirpath)
        Dir.glob(File.join(illust_dirpath, "*")) do |img_path|
          zip.add(File.join(Illustration::ILLUST_DIR, File.basename(img_path)), img_path)
        end
      end
      # 表紙画像
      cover_name = NovelConverter.get_cover_filename(dirpath)
      if cover_name
        zip.add(cover_name, File.join(dirpath, cover_name))
      end
    end
    puts File.basename(zipfile_path) + " を出力しました"
    puts "<bold><green>#{@device.display_name}用ファイルを出力しました</green></bold>".termcolor
    zipfile_path
  end

  #
  # 挿絵注記をimgタグに変換する
  #
  def translate_illust_chuki_to_img_tag
    data = File.read(@converted_txt_path, encoding: Encoding::UTF_8)
    data.gsub!(/［＃挿絵（(.+?)）入る］/, "<img src=\"\\1\">")
    File.write(@converted_txt_path, data)
  end
end
