# -*- coding: utf-8 -*-
#
=begin
https://github.com/termtter/termtter/blob/master/lib/termtter/system_extensions/windows.rb

(The MIT License)

Copyright (c) 2008-2012 The Termtter Development Team

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
=end

alias :original_warn :warn
unless $debug
  def warn(*a); end
end

require "termcolor"

alias :warn :original_warn

if RUBY_PLATFORM =~ /mswin(?!ce)|mingw|bccwin/i   # without cygwin
  require_relative "extensions/windows"

  $hStdOut = WinAPI.GetStdHandle(0xFFFFFFF5)
  lpBuffer = ' ' * 22
  WinAPI.GetConsoleScreenBufferInfo($hStdOut, lpBuffer)
  $oldColor = lpBuffer.unpack('SSSSSssssSS')[4]

  $colorMap = {
    0 => 0x07|0x00|0x00|0x00, # black/white
    37 => 0x08|0x00|0x00|0x00, # white/intensity
    31 => 0x04|0x08|0x00|0x00, # red/red
    32 => 0x02|0x08|0x00|0x00, # green/green
    33 => 0x06|0x08|0x00|0x00, # yellow/yellow
    34 => 0x01|0x08|0x00|0x00, # blue/blue
    35 => 0x05|0x08|0x00|0x00, # magenta/purple
    36 => 0x03|0x08|0x00|0x00, # cyan/aqua
    39 => 0x07,                # default
    40 => 0x00|0x00|0xf0|0x00, # background:white
    41 => 0x07|0x00|0x40|0x00, # background:red
    42 => 0x07|0x00|0x20|0x00, # background:green
    43 => 0x07|0x00|0x60|0x00, # background:yellow
    44 => 0x07|0x00|0x10|0x00, # background:blue
    45 => 0x07|0x00|0x50|0x80, # background:magenta
    46 => 0x07|0x00|0x30|0x80, # background:cyan
    47 => 0x07|0x00|0x70|0x80, # background:gray
    49 => 0x70,                # default
    90 => 0x07|0x00|0x00|0x00, # erase/white
  }

  def write_color(str, console = STDOUT)
    str.gsub("\xef\xbd\x9e", "\xe3\x80\x9c").split(/(\e\[\d*[a-zA-Z])/).each do |token|
      case token
      when /\e\[(\d+)m/
        color = $1.to_i > 90 ? ($1.to_i % 60) : $1.to_i
        loop do
          error_code = WinAPI.SetConsoleTextAttribute $hStdOut, $colorMap[color].to_i
          if error_code == 0
            if WinAPI.GetLastError == 6
              $hStdOut = WinAPI.GetStdHandle(0xFFFFFFF5)
              redo
            end
          end
          break
        end
      when /\e\[\d*[a-zA-Z]/
        # do nothing
      else
        console.write token
      end
    end
    WinAPI.SetConsoleTextAttribute $hStdOut, $oldColor
  end
else
  def write_color(str, console = STDOUT)
    console.write str
  end
end
