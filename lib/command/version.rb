# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class Version < CommandBase
    def self.oneline_help
      "バージョンを表示します"
    end

    def execute(argv)
      puts self.class.create_version_string
    end

    def self.create_version_string
      cv_path = File.expand_path("commitversion", Narou.get_script_dir)
      commitversion = File.exist?(cv_path) ? File.read(cv_path) : `git describe --always`.strip + "(develop)"
      "#{::Version} build #{commitversion}"
    end
  end
end
