# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

#require "pry"

require_relative "../../lib/converterbase"

converter = ConverterBase.new(nil, nil, nil)

11111.times do |i|
  str = i.to_s
  converter.num_to_kanji(str)
  converter.convert_kanji_num_with_unit(str)
  puts
  puts "  it \"#{str}\" do".encode("sjis")
  puts "    compare_kanji_and_integer(\"#{str}\", #{i})".encode("sjis")
  puts "  end"
end

__END__

サンプル

  it "百十" do
    compare_kanji_and_integer("百十", 110)
  end

  it "二百十" do
    compare_kanji_and_integer("二百十", 210)
  end
end
