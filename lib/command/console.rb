# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

if $development
  module Command
    class Console < CommandBase
      def self.oneline_help
        "開発用コンソール"
      end

      def initialize
        super()
        @opt.separator <<~HELP

          ・開発時のみ有効になるコンソール。pry のインストール必須
        HELP
      end

      def execute(argv)
        $stdout = STDOUT
        super
        unless defined?(Pry)
          error "gem install pry をが必要です"
          exit Narou::EXIT_ERROR_CODE
        end
        Pry.start(TOPLEVEL_BINDING)
      end
    end
  end
end
