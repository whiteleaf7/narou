# -*- coding: utf-8 -*-

begin
  require "fiddle"

  module WinAPI
    include Fiddle
    Handle = RUBY_VERSION >= "2.0.0" ? Fiddle::Handle : DL::Handle
    Kernel32 = Handle.new("kernel32")

    def self.GetLogicalDriveStrings(buf_size, buffer)
      @@get_logical_drive_strings ||=
        Function.new(Kernel32["GetLogicalDriveStrings"], [TYPE_LONG, TYPE_VOIDP], TYPE_LONG)
      @@get_logical_drive_strings.call(buf_size, buffer)
    end

    def self.SetConsoleTextAttribute(cons_handle, attr)
      @@set_console_text_attribute ||=
        Function.new(Kernel32["SetConsoleTextAttribute"], [-TYPE_INT, -TYPE_INT], -TYPE_INT)
      @@set_console_text_attribute.call(cons_handle, attr)
    end

    def self.GetConsoleScreenBufferInfo(cons_handle, lp_buffer)
      @@get_console_screen_buffer_info ||=
        Function.new(Kernel32["GetConsoleScreenBufferInfo"], [TYPE_LONG, TYPE_VOIDP], TYPE_INT)
      @@get_console_screen_buffer_info.call(cons_handle, lp_buffer)
    end

    def self.GetStdHandle(handle_type)
      @@get_std_handle ||= Function.new(Kernel32["GetStdHandle"], [-TYPE_INT], -TYPE_INT)
      @@get_std_handle.call(handle_type)
    end

    def self.GetLastError
      @@get_last_error ||= Function.new(Kernel32["GetLastError"], [], -TYPE_INT)
      @@get_last_error.call
    end
  end
rescue LoadError
  # Fiddle がない環境用(http://www.artonx.org/data/asr/ の1.9.3とか)
  require "dl/import"

  class InvalidOS < StandardError; end

  module WinAPI
    extend DL::Importer
    begin
      dlload "kernel32"
      extern "long GetLogicalDriveStrings(long, void*)"
      extern "unsigned long SetConsoleTextAttribute(unsigned long, unsigned long)"
      extern "unsigned long GetConsoleScreenBufferInfo(unsigned long, void*)"
      extern "unsigned long GetStdHandle(unsigned long)"
      extern "long GetLastError()"
    rescue DL::DLError
      raise InvalidOS, "not Windows"
    end
  end
end
