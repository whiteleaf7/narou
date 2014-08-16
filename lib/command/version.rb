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
      puts ::Version + " build " + ::CommitVersion
    end
  end
end
