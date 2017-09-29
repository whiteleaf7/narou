# -*- coding: utf-8 -*-

def write_color(str, console = STDOUT)
  console.write str
end

if RbConfig::CONFIG["host_os"] =~ /mswin(?!ce)|mingw|bccwin/i
  require_relative "extensions/windows"
  require_relative "extensions/windows_write_color" if $color_parser == "self"
end
