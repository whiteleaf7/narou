# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class Trace < CommandBase
    def self.oneline_help
      "エラーログを表示します"
    end

    def initialize
      super(" ")
      @opt.separator <<-MSG

  ・エラーが発生した際に保存されたバックトレースログを表示します。
  ・ログテキスト自体は #{Narou::Backtracer.log_path} に保存されています。
      MSG
    end

    def execute(argv)
      super
      return unless File.exist?(Narou::Backtracer.log_path)
      puts File.read(Narou::Backtracer.log_path)
    end
  end
end
