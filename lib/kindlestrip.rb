#! ruby
# -*- coding: UTF-8 -*-
#
# It was translated into Ruby script by whiteleaf.
#
# original source code:
# kindlestrip.py v.1.35 http://www.mobileread.com/forums/showthread.php?t=96903
#
# This script strips the penultimate record from a Mobipocket file.
# This is useful because the current KindleGen add a compressed copy
# of the source files used in this record, making the ebook produced
# about twice as big as it needs to be.
#
#
# This is free and unencumbered software released into the public domain.
# 
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
# 
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
# 
# For more information, please refer to <http://unlicense.org/>
#
# Written by Paul Durrant, 2010-2011, paul@durrant.co.uk, pdurrant on mobileread.com
# With enhancements by Kevin Hendricks, KevinH on mobileread.com
#
# Changelog
#  1.00 - Initial version
#  1.10 - Added an option to output the stripped data
#  1.20 - Added check for source files section (thanks Piquan)
#  1.30 - Added prelim Support for K8 style mobis
#  1.31 - removed the SRCS section but kept a 0 size entry for it
#  1.32 - removes the SRCS section and its entry, now updates metadata 121 if needed
#  1.33 - now uses and modifies mobiheader SRCS and CNT
#  1.34 - added credit for Kevin Hendricks
#  1.35 - fixed bug when more than one compilation (SRCS/CMET) records

KINDLESTRIP_VERSION = '1.35'

class StripException < StandardError; end

class SectionStripper
  def load_section(section)
    if section + 1 == @num_sections
      endoff = @data_file.length
    else
      endoff = @sections[section + 1][0]
    end
    off = @sections[section][0]
    @data_file[off...endoff]
  end

  def patch(off, _new)
    @data_file = @data_file[0, off] + new + @data_file[off + _new.length .. -1]
  end

  def strip(off, len)
    @data_file = @data_file[0, off] + @data_file[off + len .. -1]
  end

  def patch_section(section, _new, in_off = 0)
    if section + 1 == @num_sections
      endoff = @data_file.length
    else
      endoff = @sections[section + 1][0]
    end
    raise unless off + in_off + _new.length <= endoff
    patch(off + in_off, _new)
  end

  def updateEXTH121(srcs_secnum, srcs_cnt, mobiheader)
    mobi_length, = mobiheader[0x14...0x18].unpack("N")
    exth_flag, = mobiheader[0x80...0x84].unpack("N")
    exth = "NONE"
    begin
      if exth_flag & 0x40 != 0
        exth = mobiheader[16 + mobi_length .. -1]
        if exth.length >= 4 && exth[0, 4] == "EXTH"
          nitems, = exth[8...12].unpack("N")
          pos = 12
          nitems.times do
            type, size = exth[pos ... pos + 8].unpack("NN")
            #puts "#{type}, #{size}"
            if type == 121
              boundaryptr, = exth[pos + 8 ... pos + size].unpack("N")
              if srcs_secnum <= boundaryptr
                boundaryptr -= srcs_cnt
                prefix = mobiheader[0, 16 + mobi_length + pos + 8]
                suffix = mobiheader[16 + mobi_length + pos + 8 + 4 .. -1]
                nval = [boundaryptr].pack("N")
                mobiheader = prefix + nval + suffix
              end
            end
            pos += size
          end
        end
      end
    rescue
    end
    mobiheader
  end

  def initialize(datain, verbose = true)
    @verbose = verbose
    if datain[0x3C...0x3C+8] != "BOOKMOBI"
      raise StripException, "invalid file format"
    end
    @num_sections, = datain[76...78].unpack("n")

    # get mobiheader and check SRCS section number and count
    offset0, = datain.unpack("@78N")
    offset1, = datain.unpack("@86N")
    mobiheader = datain[offset0 ... offset1]
    srcs_secnum, srcs_cnt = mobiheader.unpack("@224NN")
    if srcs_secnum == 0xffffffff || srcs_cnt == 0
      raise StripException, "File doesn't contain the sources section."
    end

    puts "Found SRCS section number %d, and count %d" % [srcs_secnum, srcs_cnt] if @verbose
    # find its offset and length
    _next = srcs_secnum + srcs_cnt
    srcs_offset, = datain.unpack("@#{78+srcs_secnum*8}NN")
    next_offset, = datain.unpack("@#{78+_next*8}NN")
    srcs_length = next_offset - srcs_offset
    if datain[srcs_offset ... srcs_offset+4] != "SRCS"
      raise StripException, "SRCS section num does not point to SRCS."
    end
    puts "   beginning at offset %0x and ending at offset %0x" % [srcs_offset, srcs_length] if @verbose

    # it appears bytes 68-71 always contain (2*num_sections) + 1
    # this is not documented anyplace at all but it appears to be some sort of next 
    # available unique_id used to identify specific sections in the palm db
    @data_file = datain[0, 68] + [(@num_sections - srcs_cnt) * 2 + 1].pack("N")
    @data_file += datain[72...76]

    # write out the number of sections reduced by srtcs_cnt
    @data_file = @data_file + [@num_sections - srcs_cnt].pack("n")

    # we are going to remove srcs_cnt SRCS sections so the offset of every entry in the table
    # up to the srcs secnum must begin 8 bytes earlier per section removed (each table entry is 8 )
    delta = -8 * srcs_cnt
    srcs_secnum.times do |i|
      offset, flgval = datain.unpack("@#{78+i*8}NN")
      offset += delta
      @data_file += [offset].pack("N") + [flgval].pack("N")
    end

    # for every record after the srcs_cnt SRCS records we must start it
    # earlier by 8*srcs_cnt + the length of the srcs sections themselves)
    delta = delta - srcs_length
    (srcs_secnum + srcs_cnt ... @num_sections).each do |i|
      offset, = datain.unpack("@#{78+i*8}NN")
      offset += delta
      flgval = 2 * (i - srcs_cnt)
      @data_file += [offset].pack("N") + [flgval].pack("N")
    end

    # now pad it out to begin right at the first offset
    # typically this is 2 bytes of nulls
    first_offset, = @data_file.unpack("@78NN")
    @data_file += "\0" * (first_offset - @data_file.length)

    # now finally add on every thing up to the original src_offset
    @data_file += datain[offset0...srcs_offset]
    
    # and everything afterwards
    @data_file += datain[srcs_offset + srcs_length .. -1]

    #store away the SRCS section in case the user wants it output
    @stripped_data_header = datain[srcs_offset ... srcs_offset + 16]
    @stripped_data = datain[srcs_offset + 16 ... srcs_offset + srcs_length]

    # update the number of sections count
    @num_section = @num_sections - srcs_cnt

    # update the srcs_secnum and srcs_cnt in the mobiheader
    offset0, = @data_file.unpack("@78NN")
    offset1, = @data_file.unpack("@86NN")
    mobiheader = @data_file[offset0 ... offset1]
    mobiheader = mobiheader[0, 0xe0] + [-1].pack("N") + [0].pack("N") + mobiheader[0xe8 .. -1]

    # if K8 mobi, handle metadata 121 in old mobiheader
    mobiheader = updateEXTH121(srcs_secnum, srcs_cnt, mobiheader)
    @data_file = @data_file[0, offset0] + mobiheader + @data_file[offset1 .. -1]
    puts "done" if @verbose
  end

  def get_result
    @data_file
  end

  def get_stripped_data
    @stripped_data
  end

  def get_header
    @stripped_data_header
  end

  def self.strip(infile, outfile = nil, verbose = true)
    outfile = infile unless outfile
    data_file = File.binread(infile)
    stripped_file = new(data_file, verbose)
    File.binwrite(outfile, stripped_file.get_result)
    stripped_file
  end
end

if __FILE__ == $0
  puts "KndleStrip v#{KINDLESTRIP_VERSION}. " +
       "Written 2010-2012 by Paul Durrant and Kevin Hendricks."
  if ARGV.length < 2 || ARGV.length > 3
    puts "Strips the Sources record from Mobipocket ebooks"
    puts "For ebooks generated using KindleGen 1.1 and later that add the source"
    puts "Usage:"
    puts "    %s <infile> <outfile> <strippeddatafile>" % File.basename(__FILE__)
    puts "<strippeddatafile> is optional."
    exit 1
  else
    infile = ARGV[0]
    outfile = ARGV[1]
    begin
      stripped_file = SectionStripper.strip(infile, outfile)
      #print "Header Bytes: " + binascii.b2a_hex(strippedFile.getHeader())
      if ARGV.length == 3
        File.binwrite(ARGV[2], stripped_file.get_stripped_data)
      end
    rescue StripException => e
      warn "Error: #{e.message}"
      exit 1
    end
  end
end
