# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: 10年ごしの引きニートを辞めて外出したら自宅ごと異世界に転移してた
# 作者: 坂東太郎
# URL: http://ncode.syosetu.com/n7594ct/
#
# 詳細については http://bit.ly/1vTEH04 を参照して下さい
#
converter "n7594ct 10年ごしの引きニートを辞めて外出したら自宅ごと異世界に転移してた" do
  # 各種変換処理がされる「前」の生データに対しての変換処理を記述
  def before(io, text_type)
    if text_type == "subtitle"
      @bbs_mode = io.string.include?("掲示板回")
      super
    end
    if text_type == "body" && @bbs_mode
      @setting.enable_convert_num_to_kanji = false
    else
      super
    end
    io
  end

  # 各種変換処理がされた「後」のデータに対しての変換処理を記述
  def after(io, text_type)
    if text_type == "body" && @bbs_mode
      @setting.enable_convert_num_to_kanji = true
      @bbs_mode = false
    else
      super
    end

    io
  end
end
