# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

Version = "1.0.0"

cv_path = File.expand_path(File.join(File.dirname(__FILE__), "../commitversion"))
if File.exists?(cv_path)
  CommitVersion = File.read(cv_path)
end
