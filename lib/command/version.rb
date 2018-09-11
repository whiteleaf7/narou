# frozen_string_literal: true

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
      postfix = (Narou.commit_version ? "" : " (develop)")
      "#{Narou::VERSION}#{postfix}"
    end
  end
end
