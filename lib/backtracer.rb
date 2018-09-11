# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Narou
  module Backtracer
    module_function

    LOG_NAME = "trace_dump.txt"

    def capture(&block)
      raise "need a block" unless block
      rescue_level = $debug ? Exception : StandardError
      yield
    rescue SystemExit => e
      exit e.status
    rescue SyntaxError => e
      warn e
      exit Narou::EXIT_ERROR_CODE
    rescue rescue_level => e
      traces = build_traces(e)
      if $display_backtrace
        warn traces
      else
        warn traces.lines[0..2]
        warn ""
        warn "  エラーが発生したため終了しました。"
        warn "  詳細なエラーログは narou trace で表示出来ます。もしくは --backtrace オプションを付けて再度実行して下さい。"
      end
      save_log(traces)
      exit Narou::EXIT_ERROR_CODE
    end

    def argv=(argv)
      @argv = argv.map(&:dup)
    end

    def argv
      @argv || ARGV
    end

    def log_path
      if Narou.root_dir
        File.join(Narou.root_dir, LOG_NAME)
      else
        LOG_NAME
      end
    end

    def build_traces(exception)
      backtrace = exception.backtrace
      head = "#{backtrace.shift}: #{exception.message.encode(Encoding::UTF_8)} (#{exception.class})"
      buffer = StringIO.new
      buffer.puts head
      backtrace.each do |b|
        buffer.puts "  from #{b}"
      end
      buffer.string
    end

    def build_command
      "#{$0} #{argv.join(' ')}"
    end

    def save_log(traces)
      File.open(log_path, "w:UTF-8") do |fp|
        fp.puts "--- #{Time.now.strftime("%Y/%m/%d %H:%M:%S")} ---"
        fp.puts build_command
        fp.puts
        fp.puts traces
      end
    end
  end
end
