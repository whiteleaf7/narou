# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Narou
  # WEB UI > 環境設定画面で表示する各項目の説明
  # ここになければ元々の説明が表示される
  SETTING_VARIABLES_WEBUI_MESSAGES = {
    "convert.multi-device" => "複数の端末用に同時に変換する。deviceよりも優先される。\n端末名をカンマ区切りで入力(" + Device::DEVICES.keys.join(", ") + ")\nただのEPUBを出力したい場合はepubを指定",
    "device" => "変換、送信対象の端末(" + Device::DEVICES.keys.join(", ") + ")",
    "difftool" => "Diffで使うツールのパスを指定する\n※WEB UIでは使われません"
  }
end

