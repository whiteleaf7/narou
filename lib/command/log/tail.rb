# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class Log < CommandBase
    # based on https://qiita.com/ymmtmdk/items/10cf80ec2fc7962ff9fc
    class Tail
      CHUNK_SIZE = 1024 * 16

      attr_accessor :path, :num, :stream_io

      def initialize(path, num)
        self.path = path
        self.num = num
        raise unless num.to_i > 0
      end

      def stream
        execute do |file|
          loop do
            stream_io.print file.read
            sleep 0.1
          end
        end
      end

      def display
        execute do |file|
          stream_io.puts file.read
        end
      end

      private

      def execute
        File.open(path, "r:UTF-8") do |file|
          offset = offset_of_nth_chr_from_tail(file, num, "\n")
          file.seek(file.size - offset)
          yield file
        end
      end

      def reverse_chunks(file, size)
        n = file.size / size
        n -= 1 if file.size == n * size
        len = file.size - n * size
        until n < 0
          file.seek(n * size)
          yield file.read(len)
          n -= 1
          len = size
        end
      end

      def offset_of_nth_chr_from_tail(file, count, target)
        offset = 0
        reverse_chunks(file, CHUNK_SIZE) do |chunk|
          chunk.size.times do |i|
            chr = chunk[chunk.size - i - 1]
            next unless chr == target || (offset == 0 && i == 0 && chr != target)
            count -= 1
            if count < 0
              offset += i
              return offset
            end
          end
          offset += chunk.size
        end
        offset
      end
    end
  end
end
