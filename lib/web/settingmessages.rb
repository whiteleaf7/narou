# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Narou
  # WEB UI > 環境設定画面で表示する各項目の説明
  # ここになければ元々の説明が表示される
  SETTING_VARIABLES_WEBUI_MESSAGES = {
    "convert.multi-device" => "複数の端末用に同時に変換する。deviceよりも優先される。\nただのEPUBを出力したい場合はepubを指定",
    "device" => "変換、送信対象の端末",
    "difftool" => "Diffで使うツールのパスを指定する\n※WEB UIでは使われません",
    "update.sort-by" => "アップデートを指定した項目順で行う",
    "default.title_date_align" => "enable_add_date_to_title で付与する日付の位置",
    "force.title_date_align" => "enable_add_date_to_title で付与する日付の位置",
    "difftool.arg" => "difftoolで使う引数(指定しなければ単純に新旧ファイルを引数に呼び出す)\n" \
                      "特殊な変数\n" \
                      "<b>%NEW</b> : 最新データの差分用ファイルパス\n" \
                      "<b>%OLD</b> : 古い方の差分用ファイルパス",
    "no-color" => "コンソールのカラー表示を無効にする\n※要WEB UIサーバ再起動",
    "economy" => "容量節約に関する設定",
    "send.without-freeze" => "一括送信時に凍結された小説は対象外にする。（個別送信時は凍結済みでも送信可能）",
    "server-digest-auth.enable" => "WEBサーバでDigest認証を使用するかどうか\n" \
                                   "※digest-auth関連の設定を変更した場合WEB UIサーバの再起動が必要",
    "server-digest-auth.hashed-password" => "WEBサーバのDigest認証のパスワードを、Realmを\"narou.rb\"としてハッシュにしたもの。\n" \
                                            "https://tgws.plus/app/digest/ などで生成できる",
  }
end

