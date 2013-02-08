# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../template"

module Command
  class Init < CommandBase
    def initialize
      super("")
      @opt.separator <<-EOS

  ・現在のカレントディレクトリを小説格納用ディレクトリとして初期化します。
  ・初期化されるまでは他のコマンドは使えません。

  Example:
    narou init

  Options:
      EOS
    end

    def execute(argv)
      super
      return if Narou.already_init?
      Narou.init
    end

    def oneline_help
      "現在のカレントディレクトリを小説用に初期化します"
    end
  end
end
