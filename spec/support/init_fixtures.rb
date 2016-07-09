# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

#
# テスト用にデータベース等を設定する
#

require "time"
require "narou"
require "database"

Narou::LOCAL_SETTING_DIR_NAME.replace(".test_dot_narou")
Narou::GLOBAL_SETTING_DIR_NAME.replace(".test_dot_narousetting")
Database::ARCHIVE_ROOT_DIR_PATH.replace(".test_novel_data/")

Narou.flush_cache

def install_fixtures
  root_dir = File.expand_path("../..", __dir__)
  local_dir = File.join(root_dir, ".test_dot_narou")
  _global_dir = File.join(root_dir, ".test_dot_narousetting")
  fixture_narou = File.expand_path("../fixtures/.test_dot_narou", __dir__)
  fixture_novel_data = File.expand_path("../fixtures/.test_novel_data", __dir__)
  novel_data_dir = File.join(root_dir, ".test_novel_data")

  if File.directory?(local_dir)
    version = Time.parse(File.read(File.join(local_dir, "fixture_version.txt")))
    fixture_version = Time.parse(File.read(File.join(fixture_narou, "fixture_version.txt")))
    return if version == fixture_version
    FileUtils.rm_r(local_dir, force: true)
    FileUtils.rm_r(novel_data_dir, force: true)
  end
  FileUtils.cp_r(fixture_narou, root_dir)
  FileUtils.cp_r(fixture_novel_data, root_dir)
  puts "== Copied fixtures version #{fixture_version}"
end

install_fixtures
