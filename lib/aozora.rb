# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "memoist"
require "pathname"
require "active_support/core_ext/hash/deep_merge"
require_relative "narou"

module AozoraEpub3
  _ORG = {
    type: :org,
    name: "AozoraEpub3 (元祖)",
    exist: "template/OPS/css/vertical_font.css",
    dakuten: [:css, :font],
    css: {
      mode: :erb,
      src: "vertical_font.css",
      dst: "template/OPS/css_custom/vertical_font.css",
    },
    font: {
      mode: :copy,
      src: "DMincho.ttf",
      dst: "template/OPS/fonts/DMincho.ttf",
    },
  }
  _DEN = _ORG.deep_merge({  # hash#deep_merge <- active_support
    type: :den,
    name: "AozoraEpub3 (電書協)",
    exist: "template/item/style/font.css",
    css: {
      src: "denshokyo_font.css",
      dst: "template/item/style_custom/font.css",
    },
    font: { dst: "template/item/fonts/DMincho.ttf" },
  })
  AOZORAEPUB3_TYPE = [_ORG, _DEN]

  class << self
    extend Memoist

    def aozoraepub3_type
      aozoraepub3_type_with_path(Narou.aozoraepub3_path.dirname)
    end
    memoize :aozoraepub3_type

    # ファイル配置がオリジナルタイプか電書協タイプか判定する
    def aozoraepub3_type_with_path(aozora_path)
      AOZORAEPUB3_TYPE.find do |item|
        aozora_path.join(item[:exist]).exist?
      end
    end

  end
end
