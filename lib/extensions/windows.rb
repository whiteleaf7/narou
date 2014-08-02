# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module WinAPI
  begin
    require "fiddle/import"
    extend Fiddle::Importer
  rescue LoadError
    # Fiddle がない環境用(http://www.artonx.org/data/asr/ の1.9.3とか)
    require "dl/import"
    extend DL::Importer
  end

  class InvalidOS < StandardError; end

  begin
    dlload "kernel32"
    extern "long GetLogicalDrives()"
    extern "unsigned long SetConsoleTextAttribute(unsigned long, unsigned long)"
    extern "unsigned long GetConsoleScreenBufferInfo(unsigned long, void*)"
    extern "unsigned long GetStdHandle(unsigned long)"
    extern "long GetLastError()"
  rescue DL::DLError
    raise InvalidOS, "not Windows"
  end
end
