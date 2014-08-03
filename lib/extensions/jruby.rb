# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

if Helper.os_windows?
  require "fileutils"

  module FileUtils
    # マルチバイト文字を含むパスを認識出来ないため
    def self.cp(src, dst, opt = nil)
      open(src, "rb") do |rp|
        open(dst, "wb") do |wp|
          wp.write(rp.read)
        end
      end
    end
  end

  class File
    # 何故かエンコーディングエラーが出るため
    def self.binwrite(path, data)
      open(path, "wb") do |fp|
        fp.write(data)
      end
    end

    # -Dfile.encoding=UTF-8 を指定するとなぜか File.mtime がマルチバイト文字を含むパスを認識出来ないため
    def self.mtime(path)
      java_path = java.nio.file.FileSystems.default.getPath(path)
      java_file_time = java.nio.file.Files.getLastModifiedTime(java_path)
      Time.parse(java_file_time.to_s).getlocal("+09:00")
    end
  end
end
