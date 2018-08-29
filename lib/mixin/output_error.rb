# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Narou
  module Mixin
    module OutputError
      def output_error(stdout, exception)
        io = stdout.original_stream || stdout
        outputter = proc do
          io.puts "#{$@.shift}: #{exception.message} (#{exception.class})"
          $@.each do |b|
            io.puts "  from #{b}"
          end
        end
        # MEMO: report_on_exception は Ruby 2.4.0 から実装
        if Thread.respond_to?(:report_on_exception) && Thread.report_on_exception
          # report_on_exception が有効な場合は標準出力へのエラー表示はそっちに任せる。
          # silence を使うことで、標準出力には表示されないがログには記録される
          io.silence(&outputter)
        else
          outputter.call
        end
      end
    end
  end
end
