# frozen_string_literal: true

#
=begin
original source is
https://github.com/termtter/termtter/blob/master/lib/termtter/system_extensions/windows.rb

customed by whiteleaf

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

$hStdOut = WinAPI.GetStdHandle(0xFFFFFFF5)
lpBuffer = ' ' * 22
WinAPI.GetConsoleScreenBufferInfo($hStdOut, lpBuffer)
$oldColor = lpBuffer.unpack('SSSSSssssSS')[4]
$default_foreground = $oldColor & 0x0f
$default_background = $oldColor & 0xf0

$colorMap = {
   0 => 0x07|0x00|0x00|0x00, # black/white
   1 => 0x08               , # foreground_intensity
   4 => 0x8000             , # underline
   7 => 0x4000             , # reverse
  30 => 0x00|0x00|0x00|0x00, # black
  31 => 0x04|0x00|0x00|0x00, # red/red
  32 => 0x02|0x00|0x00|0x00, # green/green
  33 => 0x06|0x00|0x00|0x00, # yellow/yellow
  34 => 0x01|0x00|0x00|0x00, # blue/blue
  35 => 0x05|0x00|0x00|0x00, # magenta/purple
  36 => 0x03|0x00|0x00|0x00, # cyan/aqua
  37 => 0x07|0x00|0x00|0x00, # white/gray
  39 => $default_foreground, # default
  40 => 0x00|0x00|0x00|0x00, # background:black
  41 => 0x00|0x00|0x40|0x00, # background:red
  42 => 0x00|0x00|0x20|0x00, # background:green
  43 => 0x00|0x00|0x60|0x00, # background:yellow
  44 => 0x00|0x00|0x10|0x00, # background:blue
  45 => 0x00|0x00|0x50|0x00, # background:magenta
  46 => 0x00|0x00|0x30|0x00, # background:cyan
  47 => 0x00|0x00|0x70|0x00, # background:white
  49 => $default_background, # default
  90 => 0x07|0x00|0x00|0x00, # erase/white
}

def write_color(str, console = STDOUT)
  @decoration ||= 0
  @foreground ||= $default_foreground
  @background ||= $default_background
  @reverse ||= false
  str.gsub("\xef\xbd\x9e", "\xe3\x80\x9c").split(/(\e\[\d*[a-zA-Z])/).each do |token|
    case token
    when /\e\[(\d+)m/
      code = $1.to_i
      code = code > 90 ? (code % 60) : code
      case code
      when 0
        @decoration = 0
        @foreground = $default_foreground
        @background = $default_background
        @reverse = false
      when 1
        @decoration |= $colorMap[1]
      when 4
        @decoration |= $colorMap[4]
      when 7
        @reverse = true
      when 30..39
        @foreground = $colorMap[code].to_i
      when 40..49
        @background = $colorMap[code].to_i
      end
      foreground = @foreground
      background = @background
      if @reverse
        foreground <<= 4
        background >>= 4
        # reverse では intensity 情報も文字と背景で入れ替わるでの、
        # 下位4bitと上位4bitをスワップ
        @decoration = @decoration & 0xff00 | @decoration >> 4 & 0xf | (@decoration & 0xf) << 4
      end
      loop do
        error_code = WinAPI.SetConsoleTextAttribute $hStdOut, @decoration | foreground | background
        if error_code == 0
          if WinAPI.GetLastError == 6
            $hStdOut = WinAPI.GetStdHandle(0xFFFFFFF5)
            redo
          end
        end
        break
      end
    when /\e\[\d*[a-zA-Z]/, ""
      # do nothing
    else
      console.write token
    end
  end
  WinAPI.SetConsoleTextAttribute $hStdOut, $oldColor
end
