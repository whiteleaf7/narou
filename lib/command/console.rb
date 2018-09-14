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
        @opt.separator <<~EOS

          ・開発時のみ有効になるコンソール。pry のインストール必須
        EOS
      end

      def execute(argv)
        $stdout = STDOUT
        super
        unless defined?(Pry)
          error "gem install pry をが必要です"
          exit Narou::EXIT_ERROR_CODE
        end
        TOPLEVEL_BINDING.pry
      end
    end
  end
end
