# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "pathname"

module Narou
  module MonkyPatches
    module PathnameGlob
      def glob(pattern, flags = 0, &block)
        Pathname.glob(self.join(pattern), flags, &block)
      end
    end
  end
end

unless Pathname.method_defined?(:glob)
  Pathname.prepend(Narou::MonkyPatches::PathnameGlob)
end
