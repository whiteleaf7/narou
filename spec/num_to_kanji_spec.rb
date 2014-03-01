# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/converterbase"

describe ConverterBase, "#convert_kanji_num_with_unit" do
  before do
    @converter = ConverterBase.new(nil, nil, nil)
  end

  def compare(num)
    data = num.dup
    @converter.convert_kanji_num_with_unit(data, 2)
    data.should == num
  end

  def compare_kanji_and_integer(kanji, integer)
    @converter.kanji_num_to_integer(kanji).should == integer
  end

  it "百十 == 百十" do
    compare("百十")
  end

  it "〇" do
    compare_kanji_and_integer("〇", 0)
  end

  it "一" do
    compare_kanji_and_integer("一", 1)
  end

  it "二" do
    compare_kanji_and_integer("二", 2)
  end

  it "三" do
    compare_kanji_and_integer("三", 3)
  end

  it "四" do
    compare_kanji_and_integer("四", 4)
  end

  it "五" do
    compare_kanji_and_integer("五", 5)
  end

  it "六" do
    compare_kanji_and_integer("六", 6)
  end

  it "七" do
    compare_kanji_and_integer("七", 7)
  end

  it "八" do
    compare_kanji_and_integer("八", 8)
  end

  it "九" do
    compare_kanji_and_integer("九", 9)
  end

  it "十" do
    compare_kanji_and_integer("十", 10)
  end

  it "十一" do
    compare_kanji_and_integer("十一", 11)
  end

  it "十二" do
    compare_kanji_and_integer("十二", 12)
  end

  it "十三" do
    compare_kanji_and_integer("十三", 13)
  end

  it "十四" do
    compare_kanji_and_integer("十四", 14)
  end

  it "十五" do
    compare_kanji_and_integer("十五", 15)
  end

  it "十六" do
    compare_kanji_and_integer("十六", 16)
  end

  it "十七" do
    compare_kanji_and_integer("十七", 17)
  end

  it "十八" do
    compare_kanji_and_integer("十八", 18)
  end

  it "十九" do
    compare_kanji_and_integer("十九", 19)
  end

  it "二十" do
    compare_kanji_and_integer("二十", 20)
  end

  it "二十一" do
    compare_kanji_and_integer("二十一", 21)
  end

  it "二十二" do
    compare_kanji_and_integer("二十二", 22)
  end

  it "二十三" do
    compare_kanji_and_integer("二十三", 23)
  end

  it "二十四" do
    compare_kanji_and_integer("二十四", 24)
  end

  it "二十五" do
    compare_kanji_and_integer("二十五", 25)
  end

  it "二十六" do
    compare_kanji_and_integer("二十六", 26)
  end

  it "二十七" do
    compare_kanji_and_integer("二十七", 27)
  end

  it "二十八" do
    compare_kanji_and_integer("二十八", 28)
  end

  it "二十九" do
    compare_kanji_and_integer("二十九", 29)
  end

  it "三十" do
    compare_kanji_and_integer("三十", 30)
  end

  it "三十一" do
    compare_kanji_and_integer("三十一", 31)
  end

  it "三十二" do
    compare_kanji_and_integer("三十二", 32)
  end

  it "三十三" do
    compare_kanji_and_integer("三十三", 33)
  end

  it "三十四" do
    compare_kanji_and_integer("三十四", 34)
  end

  it "三十五" do
    compare_kanji_and_integer("三十五", 35)
  end

  it "三十六" do
    compare_kanji_and_integer("三十六", 36)
  end

  it "三十七" do
    compare_kanji_and_integer("三十七", 37)
  end

  it "三十八" do
    compare_kanji_and_integer("三十八", 38)
  end

  it "三十九" do
    compare_kanji_and_integer("三十九", 39)
  end

  it "四十" do
    compare_kanji_and_integer("四十", 40)
  end

  it "四十一" do
    compare_kanji_and_integer("四十一", 41)
  end

  it "四十二" do
    compare_kanji_and_integer("四十二", 42)
  end

  it "四十三" do
    compare_kanji_and_integer("四十三", 43)
  end

  it "四十四" do
    compare_kanji_and_integer("四十四", 44)
  end

  it "四十五" do
    compare_kanji_and_integer("四十五", 45)
  end

  it "四十六" do
    compare_kanji_and_integer("四十六", 46)
  end

  it "四十七" do
    compare_kanji_and_integer("四十七", 47)
  end

  it "四十八" do
    compare_kanji_and_integer("四十八", 48)
  end

  it "四十九" do
    compare_kanji_and_integer("四十九", 49)
  end

  it "五十" do
    compare_kanji_and_integer("五十", 50)
  end

  it "五十一" do
    compare_kanji_and_integer("五十一", 51)
  end

  it "五十二" do
    compare_kanji_and_integer("五十二", 52)
  end

  it "五十三" do
    compare_kanji_and_integer("五十三", 53)
  end

  it "五十四" do
    compare_kanji_and_integer("五十四", 54)
  end

  it "五十五" do
    compare_kanji_and_integer("五十五", 55)
  end

  it "五十六" do
    compare_kanji_and_integer("五十六", 56)
  end

  it "五十七" do
    compare_kanji_and_integer("五十七", 57)
  end

  it "五十八" do
    compare_kanji_and_integer("五十八", 58)
  end

  it "五十九" do
    compare_kanji_and_integer("五十九", 59)
  end

  it "六十" do
    compare_kanji_and_integer("六十", 60)
  end

  it "六十一" do
    compare_kanji_and_integer("六十一", 61)
  end

  it "六十二" do
    compare_kanji_and_integer("六十二", 62)
  end

  it "六十三" do
    compare_kanji_and_integer("六十三", 63)
  end

  it "六十四" do
    compare_kanji_and_integer("六十四", 64)
  end

  it "六十五" do
    compare_kanji_and_integer("六十五", 65)
  end

  it "六十六" do
    compare_kanji_and_integer("六十六", 66)
  end

  it "六十七" do
    compare_kanji_and_integer("六十七", 67)
  end

  it "六十八" do
    compare_kanji_and_integer("六十八", 68)
  end

  it "六十九" do
    compare_kanji_and_integer("六十九", 69)
  end

  it "七十" do
    compare_kanji_and_integer("七十", 70)
  end

  it "七十一" do
    compare_kanji_and_integer("七十一", 71)
  end

  it "七十二" do
    compare_kanji_and_integer("七十二", 72)
  end

  it "七十三" do
    compare_kanji_and_integer("七十三", 73)
  end

  it "七十四" do
    compare_kanji_and_integer("七十四", 74)
  end

  it "七十五" do
    compare_kanji_and_integer("七十五", 75)
  end

  it "七十六" do
    compare_kanji_and_integer("七十六", 76)
  end

  it "七十七" do
    compare_kanji_and_integer("七十七", 77)
  end

  it "七十八" do
    compare_kanji_and_integer("七十八", 78)
  end

  it "七十九" do
    compare_kanji_and_integer("七十九", 79)
  end

  it "八十" do
    compare_kanji_and_integer("八十", 80)
  end

  it "八十一" do
    compare_kanji_and_integer("八十一", 81)
  end

  it "八十二" do
    compare_kanji_and_integer("八十二", 82)
  end

  it "八十三" do
    compare_kanji_and_integer("八十三", 83)
  end

  it "八十四" do
    compare_kanji_and_integer("八十四", 84)
  end

  it "八十五" do
    compare_kanji_and_integer("八十五", 85)
  end

  it "八十六" do
    compare_kanji_and_integer("八十六", 86)
  end

  it "八十七" do
    compare_kanji_and_integer("八十七", 87)
  end

  it "八十八" do
    compare_kanji_and_integer("八十八", 88)
  end

  it "八十九" do
    compare_kanji_and_integer("八十九", 89)
  end

  it "九十" do
    compare_kanji_and_integer("九十", 90)
  end

  it "九十一" do
    compare_kanji_and_integer("九十一", 91)
  end

  it "九十二" do
    compare_kanji_and_integer("九十二", 92)
  end

  it "九十三" do
    compare_kanji_and_integer("九十三", 93)
  end

  it "九十四" do
    compare_kanji_and_integer("九十四", 94)
  end

  it "九十五" do
    compare_kanji_and_integer("九十五", 95)
  end

  it "九十六" do
    compare_kanji_and_integer("九十六", 96)
  end

  it "九十七" do
    compare_kanji_and_integer("九十七", 97)
  end

  it "九十八" do
    compare_kanji_and_integer("九十八", 98)
  end

  it "九十九" do
    compare_kanji_and_integer("九十九", 99)
  end

  it "百" do
    compare_kanji_and_integer("百", 100)
  end

  it "百一" do
    compare_kanji_and_integer("百一", 101)
  end

  it "百二" do
    compare_kanji_and_integer("百二", 102)
  end

  it "百三" do
    compare_kanji_and_integer("百三", 103)
  end

  it "百四" do
    compare_kanji_and_integer("百四", 104)
  end

  it "百五" do
    compare_kanji_and_integer("百五", 105)
  end

  it "百六" do
    compare_kanji_and_integer("百六", 106)
  end

  it "百七" do
    compare_kanji_and_integer("百七", 107)
  end

  it "百八" do
    compare_kanji_and_integer("百八", 108)
  end

  it "百九" do
    compare_kanji_and_integer("百九", 109)
  end

  it "百十" do
    compare_kanji_and_integer("百十", 110)
  end

  it "百十一" do
    compare_kanji_and_integer("百十一", 111)
  end

  it "百十二" do
    compare_kanji_and_integer("百十二", 112)
  end

  it "百十三" do
    compare_kanji_and_integer("百十三", 113)
  end

  it "百十四" do
    compare_kanji_and_integer("百十四", 114)
  end

  it "百十五" do
    compare_kanji_and_integer("百十五", 115)
  end

  it "百十六" do
    compare_kanji_and_integer("百十六", 116)
  end

  it "百十七" do
    compare_kanji_and_integer("百十七", 117)
  end

  it "百十八" do
    compare_kanji_and_integer("百十八", 118)
  end

  it "百十九" do
    compare_kanji_and_integer("百十九", 119)
  end

  it "百二十" do
    compare_kanji_and_integer("百二十", 120)
  end

  it "百二十一" do
    compare_kanji_and_integer("百二十一", 121)
  end

  it "百二十二" do
    compare_kanji_and_integer("百二十二", 122)
  end

  it "百二十三" do
    compare_kanji_and_integer("百二十三", 123)
  end

  it "百二十四" do
    compare_kanji_and_integer("百二十四", 124)
  end

  it "百二十五" do
    compare_kanji_and_integer("百二十五", 125)
  end

  it "百二十六" do
    compare_kanji_and_integer("百二十六", 126)
  end

  it "百二十七" do
    compare_kanji_and_integer("百二十七", 127)
  end

  it "百二十八" do
    compare_kanji_and_integer("百二十八", 128)
  end

  it "百二十九" do
    compare_kanji_and_integer("百二十九", 129)
  end

  it "百三十" do
    compare_kanji_and_integer("百三十", 130)
  end

  it "百三十一" do
    compare_kanji_and_integer("百三十一", 131)
  end

  it "百三十二" do
    compare_kanji_and_integer("百三十二", 132)
  end

  it "百三十三" do
    compare_kanji_and_integer("百三十三", 133)
  end

  it "百三十四" do
    compare_kanji_and_integer("百三十四", 134)
  end

  it "百三十五" do
    compare_kanji_and_integer("百三十五", 135)
  end

  it "百三十六" do
    compare_kanji_and_integer("百三十六", 136)
  end

  it "百三十七" do
    compare_kanji_and_integer("百三十七", 137)
  end

  it "百三十八" do
    compare_kanji_and_integer("百三十八", 138)
  end

  it "百三十九" do
    compare_kanji_and_integer("百三十九", 139)
  end

  it "百四十" do
    compare_kanji_and_integer("百四十", 140)
  end

  it "百四十一" do
    compare_kanji_and_integer("百四十一", 141)
  end

  it "百四十二" do
    compare_kanji_and_integer("百四十二", 142)
  end

  it "百四十三" do
    compare_kanji_and_integer("百四十三", 143)
  end

  it "百四十四" do
    compare_kanji_and_integer("百四十四", 144)
  end

  it "百四十五" do
    compare_kanji_and_integer("百四十五", 145)
  end

  it "百四十六" do
    compare_kanji_and_integer("百四十六", 146)
  end

  it "百四十七" do
    compare_kanji_and_integer("百四十七", 147)
  end

  it "百四十八" do
    compare_kanji_and_integer("百四十八", 148)
  end

  it "百四十九" do
    compare_kanji_and_integer("百四十九", 149)
  end

  it "百五十" do
    compare_kanji_and_integer("百五十", 150)
  end

  it "百五十一" do
    compare_kanji_and_integer("百五十一", 151)
  end

  it "百五十二" do
    compare_kanji_and_integer("百五十二", 152)
  end

  it "百五十三" do
    compare_kanji_and_integer("百五十三", 153)
  end

  it "百五十四" do
    compare_kanji_and_integer("百五十四", 154)
  end

  it "百五十五" do
    compare_kanji_and_integer("百五十五", 155)
  end

  it "百五十六" do
    compare_kanji_and_integer("百五十六", 156)
  end

  it "百五十七" do
    compare_kanji_and_integer("百五十七", 157)
  end

  it "百五十八" do
    compare_kanji_and_integer("百五十八", 158)
  end

  it "百五十九" do
    compare_kanji_and_integer("百五十九", 159)
  end

  it "百六十" do
    compare_kanji_and_integer("百六十", 160)
  end

  it "百六十一" do
    compare_kanji_and_integer("百六十一", 161)
  end

  it "百六十二" do
    compare_kanji_and_integer("百六十二", 162)
  end

  it "百六十三" do
    compare_kanji_and_integer("百六十三", 163)
  end

  it "百六十四" do
    compare_kanji_and_integer("百六十四", 164)
  end

  it "百六十五" do
    compare_kanji_and_integer("百六十五", 165)
  end

  it "百六十六" do
    compare_kanji_and_integer("百六十六", 166)
  end

  it "百六十七" do
    compare_kanji_and_integer("百六十七", 167)
  end

  it "百六十八" do
    compare_kanji_and_integer("百六十八", 168)
  end

  it "百六十九" do
    compare_kanji_and_integer("百六十九", 169)
  end

  it "百七十" do
    compare_kanji_and_integer("百七十", 170)
  end

  it "百七十一" do
    compare_kanji_and_integer("百七十一", 171)
  end

  it "百七十二" do
    compare_kanji_and_integer("百七十二", 172)
  end

  it "百七十三" do
    compare_kanji_and_integer("百七十三", 173)
  end

  it "百七十四" do
    compare_kanji_and_integer("百七十四", 174)
  end

  it "百七十五" do
    compare_kanji_and_integer("百七十五", 175)
  end

  it "百七十六" do
    compare_kanji_and_integer("百七十六", 176)
  end

  it "百七十七" do
    compare_kanji_and_integer("百七十七", 177)
  end

  it "百七十八" do
    compare_kanji_and_integer("百七十八", 178)
  end

  it "百七十九" do
    compare_kanji_and_integer("百七十九", 179)
  end

  it "百八十" do
    compare_kanji_and_integer("百八十", 180)
  end

  it "百八十一" do
    compare_kanji_and_integer("百八十一", 181)
  end

  it "百八十二" do
    compare_kanji_and_integer("百八十二", 182)
  end

  it "百八十三" do
    compare_kanji_and_integer("百八十三", 183)
  end

  it "百八十四" do
    compare_kanji_and_integer("百八十四", 184)
  end

  it "百八十五" do
    compare_kanji_and_integer("百八十五", 185)
  end

  it "百八十六" do
    compare_kanji_and_integer("百八十六", 186)
  end

  it "百八十七" do
    compare_kanji_and_integer("百八十七", 187)
  end

  it "百八十八" do
    compare_kanji_and_integer("百八十八", 188)
  end

  it "百八十九" do
    compare_kanji_and_integer("百八十九", 189)
  end

  it "百九十" do
    compare_kanji_and_integer("百九十", 190)
  end

  it "百九十一" do
    compare_kanji_and_integer("百九十一", 191)
  end

  it "百九十二" do
    compare_kanji_and_integer("百九十二", 192)
  end

  it "百九十三" do
    compare_kanji_and_integer("百九十三", 193)
  end

  it "百九十四" do
    compare_kanji_and_integer("百九十四", 194)
  end

  it "百九十五" do
    compare_kanji_and_integer("百九十五", 195)
  end

  it "百九十六" do
    compare_kanji_and_integer("百九十六", 196)
  end

  it "百九十七" do
    compare_kanji_and_integer("百九十七", 197)
  end

  it "百九十八" do
    compare_kanji_and_integer("百九十八", 198)
  end

  it "百九十九" do
    compare_kanji_and_integer("百九十九", 199)
  end

  it "二百" do
    compare_kanji_and_integer("二百", 200)
  end

  it "二百一" do
    compare_kanji_and_integer("二百一", 201)
  end

  it "二百二" do
    compare_kanji_and_integer("二百二", 202)
  end

  it "二百三" do
    compare_kanji_and_integer("二百三", 203)
  end

  it "二百四" do
    compare_kanji_and_integer("二百四", 204)
  end

  it "二百五" do
    compare_kanji_and_integer("二百五", 205)
  end

  it "二百六" do
    compare_kanji_and_integer("二百六", 206)
  end

  it "二百七" do
    compare_kanji_and_integer("二百七", 207)
  end

  it "二百八" do
    compare_kanji_and_integer("二百八", 208)
  end

  it "二百九" do
    compare_kanji_and_integer("二百九", 209)
  end

  it "二百十" do
    compare_kanji_and_integer("二百十", 210)
  end

  it "二百十一" do
    compare_kanji_and_integer("二百十一", 211)
  end

  it "二百十二" do
    compare_kanji_and_integer("二百十二", 212)
  end

  it "二百十三" do
    compare_kanji_and_integer("二百十三", 213)
  end

  it "二百十四" do
    compare_kanji_and_integer("二百十四", 214)
  end

  it "二百十五" do
    compare_kanji_and_integer("二百十五", 215)
  end

  it "二百十六" do
    compare_kanji_and_integer("二百十六", 216)
  end

  it "二百十七" do
    compare_kanji_and_integer("二百十七", 217)
  end

  it "二百十八" do
    compare_kanji_and_integer("二百十八", 218)
  end

  it "二百十九" do
    compare_kanji_and_integer("二百十九", 219)
  end

  it "二百二十" do
    compare_kanji_and_integer("二百二十", 220)
  end

  it "二百二十一" do
    compare_kanji_and_integer("二百二十一", 221)
  end

  it "二百二十二" do
    compare_kanji_and_integer("二百二十二", 222)
  end

  it "二百二十三" do
    compare_kanji_and_integer("二百二十三", 223)
  end

  it "二百二十四" do
    compare_kanji_and_integer("二百二十四", 224)
  end

  it "二百二十五" do
    compare_kanji_and_integer("二百二十五", 225)
  end

  it "二百二十六" do
    compare_kanji_and_integer("二百二十六", 226)
  end

  it "二百二十七" do
    compare_kanji_and_integer("二百二十七", 227)
  end

  it "二百二十八" do
    compare_kanji_and_integer("二百二十八", 228)
  end

  it "二百二十九" do
    compare_kanji_and_integer("二百二十九", 229)
  end

  it "二百三十" do
    compare_kanji_and_integer("二百三十", 230)
  end

  it "二百三十一" do
    compare_kanji_and_integer("二百三十一", 231)
  end

  it "二百三十二" do
    compare_kanji_and_integer("二百三十二", 232)
  end

  it "二百三十三" do
    compare_kanji_and_integer("二百三十三", 233)
  end

  it "二百三十四" do
    compare_kanji_and_integer("二百三十四", 234)
  end

  it "二百三十五" do
    compare_kanji_and_integer("二百三十五", 235)
  end

  it "二百三十六" do
    compare_kanji_and_integer("二百三十六", 236)
  end

  it "二百三十七" do
    compare_kanji_and_integer("二百三十七", 237)
  end

  it "二百三十八" do
    compare_kanji_and_integer("二百三十八", 238)
  end

  it "二百三十九" do
    compare_kanji_and_integer("二百三十九", 239)
  end

  it "二百四十" do
    compare_kanji_and_integer("二百四十", 240)
  end

  it "二百四十一" do
    compare_kanji_and_integer("二百四十一", 241)
  end

  it "二百四十二" do
    compare_kanji_and_integer("二百四十二", 242)
  end

  it "二百四十三" do
    compare_kanji_and_integer("二百四十三", 243)
  end

  it "二百四十四" do
    compare_kanji_and_integer("二百四十四", 244)
  end

  it "二百四十五" do
    compare_kanji_and_integer("二百四十五", 245)
  end

  it "二百四十六" do
    compare_kanji_and_integer("二百四十六", 246)
  end

  it "二百四十七" do
    compare_kanji_and_integer("二百四十七", 247)
  end

  it "二百四十八" do
    compare_kanji_and_integer("二百四十八", 248)
  end

  it "二百四十九" do
    compare_kanji_and_integer("二百四十九", 249)
  end

  it "二百五十" do
    compare_kanji_and_integer("二百五十", 250)
  end

  it "二百五十一" do
    compare_kanji_and_integer("二百五十一", 251)
  end

  it "二百五十二" do
    compare_kanji_and_integer("二百五十二", 252)
  end

  it "二百五十三" do
    compare_kanji_and_integer("二百五十三", 253)
  end

  it "二百五十四" do
    compare_kanji_and_integer("二百五十四", 254)
  end

  it "二百五十五" do
    compare_kanji_and_integer("二百五十五", 255)
  end

  it "二百五十六" do
    compare_kanji_and_integer("二百五十六", 256)
  end

  it "二百五十七" do
    compare_kanji_and_integer("二百五十七", 257)
  end

  it "二百五十八" do
    compare_kanji_and_integer("二百五十八", 258)
  end

  it "二百五十九" do
    compare_kanji_and_integer("二百五十九", 259)
  end

  it "二百六十" do
    compare_kanji_and_integer("二百六十", 260)
  end

  it "二百六十一" do
    compare_kanji_and_integer("二百六十一", 261)
  end

  it "二百六十二" do
    compare_kanji_and_integer("二百六十二", 262)
  end

  it "二百六十三" do
    compare_kanji_and_integer("二百六十三", 263)
  end

  it "二百六十四" do
    compare_kanji_and_integer("二百六十四", 264)
  end

  it "二百六十五" do
    compare_kanji_and_integer("二百六十五", 265)
  end

  it "二百六十六" do
    compare_kanji_and_integer("二百六十六", 266)
  end

  it "二百六十七" do
    compare_kanji_and_integer("二百六十七", 267)
  end

  it "二百六十八" do
    compare_kanji_and_integer("二百六十八", 268)
  end

  it "二百六十九" do
    compare_kanji_and_integer("二百六十九", 269)
  end

  it "二百七十" do
    compare_kanji_and_integer("二百七十", 270)
  end

  it "二百七十一" do
    compare_kanji_and_integer("二百七十一", 271)
  end

  it "二百七十二" do
    compare_kanji_and_integer("二百七十二", 272)
  end

  it "二百七十三" do
    compare_kanji_and_integer("二百七十三", 273)
  end

  it "二百七十四" do
    compare_kanji_and_integer("二百七十四", 274)
  end

  it "二百七十五" do
    compare_kanji_and_integer("二百七十五", 275)
  end

  it "二百七十六" do
    compare_kanji_and_integer("二百七十六", 276)
  end

  it "二百七十七" do
    compare_kanji_and_integer("二百七十七", 277)
  end

  it "二百七十八" do
    compare_kanji_and_integer("二百七十八", 278)
  end

  it "二百七十九" do
    compare_kanji_and_integer("二百七十九", 279)
  end

  it "二百八十" do
    compare_kanji_and_integer("二百八十", 280)
  end

  it "二百八十一" do
    compare_kanji_and_integer("二百八十一", 281)
  end

  it "二百八十二" do
    compare_kanji_and_integer("二百八十二", 282)
  end

  it "二百八十三" do
    compare_kanji_and_integer("二百八十三", 283)
  end

  it "二百八十四" do
    compare_kanji_and_integer("二百八十四", 284)
  end

  it "二百八十五" do
    compare_kanji_and_integer("二百八十五", 285)
  end

  it "二百八十六" do
    compare_kanji_and_integer("二百八十六", 286)
  end

  it "二百八十七" do
    compare_kanji_and_integer("二百八十七", 287)
  end

  it "二百八十八" do
    compare_kanji_and_integer("二百八十八", 288)
  end

  it "二百八十九" do
    compare_kanji_and_integer("二百八十九", 289)
  end

  it "二百九十" do
    compare_kanji_and_integer("二百九十", 290)
  end

  it "二百九十一" do
    compare_kanji_and_integer("二百九十一", 291)
  end

  it "二百九十二" do
    compare_kanji_and_integer("二百九十二", 292)
  end

  it "二百九十三" do
    compare_kanji_and_integer("二百九十三", 293)
  end

  it "二百九十四" do
    compare_kanji_and_integer("二百九十四", 294)
  end

  it "二百九十五" do
    compare_kanji_and_integer("二百九十五", 295)
end

  it "二百九十六" do
    compare_kanji_and_integer("二百九十六", 296)
  end

  it "二百九十七" do
    compare_kanji_and_integer("二百九十七", 297)
  end

  it "二百九十八" do
    compare_kanji_and_integer("二百九十八", 298)
  end

  it "二百九十九" do
    compare_kanji_and_integer("二百九十九", 299)
  end

  it "三百" do
    compare_kanji_and_integer("三百", 300)
  end

  it "三百一" do
    compare_kanji_and_integer("三百一", 301)
  end

  it "三百二" do
    compare_kanji_and_integer("三百二", 302)
  end

  it "三百三" do
    compare_kanji_and_integer("三百三", 303)
  end

  it "三百四" do
    compare_kanji_and_integer("三百四", 304)
  end

  it "三百五" do
    compare_kanji_and_integer("三百五", 305)
  end

  it "三百六" do
    compare_kanji_and_integer("三百六", 306)
  end

  it "三百七" do
    compare_kanji_and_integer("三百七", 307)
  end

  it "三百八" do
    compare_kanji_and_integer("三百八", 308)
  end

  it "三百九" do
    compare_kanji_and_integer("三百九", 309)
  end

  it "三百十" do
    compare_kanji_and_integer("三百十", 310)
  end

  it "三百十一" do
    compare_kanji_and_integer("三百十一", 311)
  end

  it "三百十二" do
    compare_kanji_and_integer("三百十二", 312)
  end

  it "三百十三" do
    compare_kanji_and_integer("三百十三", 313)
  end

  it "三百十四" do
    compare_kanji_and_integer("三百十四", 314)
  end

  it "三百十五" do
    compare_kanji_and_integer("三百十五", 315)
  end

  it "三百十六" do
    compare_kanji_and_integer("三百十六", 316)
  end

  it "三百十七" do
    compare_kanji_and_integer("三百十七", 317)
  end

  it "三百十八" do
    compare_kanji_and_integer("三百十八", 318)
  end

  it "三百十九" do
    compare_kanji_and_integer("三百十九", 319)
  end

  it "三百二十" do
    compare_kanji_and_integer("三百二十", 320)
  end

  it "三百二十一" do
    compare_kanji_and_integer("三百二十一", 321)
  end

  it "三百二十二" do
    compare_kanji_and_integer("三百二十二", 322)
  end

  it "三百二十三" do
    compare_kanji_and_integer("三百二十三", 323)
  end

  it "三百二十四" do
    compare_kanji_and_integer("三百二十四", 324)
  end

  it "三百二十五" do
    compare_kanji_and_integer("三百二十五", 325)
  end

  it "三百二十六" do
    compare_kanji_and_integer("三百二十六", 326)
  end

  it "三百二十七" do
    compare_kanji_and_integer("三百二十七", 327)
  end

  it "三百二十八" do
    compare_kanji_and_integer("三百二十八", 328)
  end

  it "三百二十九" do
    compare_kanji_and_integer("三百二十九", 329)
  end

  it "三百三十" do
    compare_kanji_and_integer("三百三十", 330)
  end

  it "三百三十一" do
    compare_kanji_and_integer("三百三十一", 331)
  end

  it "三百三十二" do
    compare_kanji_and_integer("三百三十二", 332)
  end

  it "三百三十三" do
    compare_kanji_and_integer("三百三十三", 333)
  end

  it "三百三十四" do
    compare_kanji_and_integer("三百三十四", 334)
  end

  it "三百三十五" do
    compare_kanji_and_integer("三百三十五", 335)
  end

  it "三百三十六" do
    compare_kanji_and_integer("三百三十六", 336)
  end

  it "三百三十七" do
    compare_kanji_and_integer("三百三十七", 337)
  end

  it "三百三十八" do
    compare_kanji_and_integer("三百三十八", 338)
  end

  it "三百三十九" do
    compare_kanji_and_integer("三百三十九", 339)
  end

  it "三百四十" do
    compare_kanji_and_integer("三百四十", 340)
  end

  it "三百四十一" do
    compare_kanji_and_integer("三百四十一", 341)
  end

  it "三百四十二" do
    compare_kanji_and_integer("三百四十二", 342)
  end

  it "三百四十三" do
    compare_kanji_and_integer("三百四十三", 343)
  end

  it "三百四十四" do
    compare_kanji_and_integer("三百四十四", 344)
  end

  it "三百四十五" do
    compare_kanji_and_integer("三百四十五", 345)
  end

  it "三百四十六" do
    compare_kanji_and_integer("三百四十六", 346)
  end

  it "三百四十七" do
    compare_kanji_and_integer("三百四十七", 347)
  end

  it "三百四十八" do
    compare_kanji_and_integer("三百四十八", 348)
  end

  it "三百四十九" do
    compare_kanji_and_integer("三百四十九", 349)
  end

  it "三百五十" do
    compare_kanji_and_integer("三百五十", 350)
  end

  it "三百五十一" do
    compare_kanji_and_integer("三百五十一", 351)
  end

  it "三百五十二" do
    compare_kanji_and_integer("三百五十二", 352)
  end

  it "三百五十三" do
    compare_kanji_and_integer("三百五十三", 353)
  end

  it "三百五十四" do
    compare_kanji_and_integer("三百五十四", 354)
  end

  it "三百五十五" do
    compare_kanji_and_integer("三百五十五", 355)
  end

  it "三百五十六" do
    compare_kanji_and_integer("三百五十六", 356)
  end

  it "三百五十七" do
    compare_kanji_and_integer("三百五十七", 357)
  end

  it "三百五十八" do
    compare_kanji_and_integer("三百五十八", 358)
  end

  it "三百五十九" do
    compare_kanji_and_integer("三百五十九", 359)
  end

  it "三百六十" do
    compare_kanji_and_integer("三百六十", 360)
  end

  it "三百六十一" do
    compare_kanji_and_integer("三百六十一", 361)
  end

  it "三百六十二" do
    compare_kanji_and_integer("三百六十二", 362)
  end

  it "三百六十三" do
    compare_kanji_and_integer("三百六十三", 363)
  end

  it "三百六十四" do
    compare_kanji_and_integer("三百六十四", 364)
  end

  it "三百六十五" do
    compare_kanji_and_integer("三百六十五", 365)
  end

  it "三百六十六" do
    compare_kanji_and_integer("三百六十六", 366)
  end

  it "三百六十七" do
    compare_kanji_and_integer("三百六十七", 367)
  end

  it "三百六十八" do
    compare_kanji_and_integer("三百六十八", 368)
  end

  it "三百六十九" do
    compare_kanji_and_integer("三百六十九", 369)
  end

  it "三百七十" do
    compare_kanji_and_integer("三百七十", 370)
  end

  it "三百七十一" do
    compare_kanji_and_integer("三百七十一", 371)
  end

  it "三百七十二" do
    compare_kanji_and_integer("三百七十二", 372)
  end

  it "三百七十三" do
    compare_kanji_and_integer("三百七十三", 373)
  end

  it "三百七十四" do
    compare_kanji_and_integer("三百七十四", 374)
  end

  it "三百七十五" do
    compare_kanji_and_integer("三百七十五", 375)
  end

  it "三百七十六" do
    compare_kanji_and_integer("三百七十六", 376)
  end

  it "三百七十七" do
    compare_kanji_and_integer("三百七十七", 377)
  end

  it "三百七十八" do
    compare_kanji_and_integer("三百七十八", 378)
  end

  it "三百七十九" do
    compare_kanji_and_integer("三百七十九", 379)
  end

  it "三百八十" do
    compare_kanji_and_integer("三百八十", 380)
  end

  it "三百八十一" do
    compare_kanji_and_integer("三百八十一", 381)
  end

  it "三百八十二" do
    compare_kanji_and_integer("三百八十二", 382)
  end

  it "三百八十三" do
    compare_kanji_and_integer("三百八十三", 383)
  end

  it "三百八十四" do
    compare_kanji_and_integer("三百八十四", 384)
  end

  it "三百八十五" do
    compare_kanji_and_integer("三百八十五", 385)
  end

  it "三百八十六" do
    compare_kanji_and_integer("三百八十六", 386)
  end

  it "三百八十七" do
    compare_kanji_and_integer("三百八十七", 387)
  end

  it "三百八十八" do
    compare_kanji_and_integer("三百八十八", 388)
  end

  it "三百八十九" do
    compare_kanji_and_integer("三百八十九", 389)
  end

  it "三百九十" do
    compare_kanji_and_integer("三百九十", 390)
  end

  it "三百九十一" do
    compare_kanji_and_integer("三百九十一", 391)
  end

  it "三百九十二" do
    compare_kanji_and_integer("三百九十二", 392)
  end

  it "三百九十三" do
    compare_kanji_and_integer("三百九十三", 393)
  end

  it "三百九十四" do
    compare_kanji_and_integer("三百九十四", 394)
  end

  it "三百九十五" do
    compare_kanji_and_integer("三百九十五", 395)
  end

  it "三百九十六" do
    compare_kanji_and_integer("三百九十六", 396)
  end

  it "三百九十七" do
    compare_kanji_and_integer("三百九十七", 397)
  end

  it "三百九十八" do
    compare_kanji_and_integer("三百九十八", 398)
  end

  it "三百九十九" do
    compare_kanji_and_integer("三百九十九", 399)
  end

  it "四百" do
    compare_kanji_and_integer("四百", 400)
  end

  it "四百一" do
    compare_kanji_and_integer("四百一", 401)
  end

  it "四百二" do
    compare_kanji_and_integer("四百二", 402)
  end

  it "四百三" do
    compare_kanji_and_integer("四百三", 403)
  end

  it "四百四" do
    compare_kanji_and_integer("四百四", 404)
  end

  it "四百五" do
    compare_kanji_and_integer("四百五", 405)
  end

  it "四百六" do
    compare_kanji_and_integer("四百六", 406)
  end

  it "四百七" do
    compare_kanji_and_integer("四百七", 407)
  end

  it "四百八" do
    compare_kanji_and_integer("四百八", 408)
  end

  it "四百九" do
    compare_kanji_and_integer("四百九", 409)
  end

  it "四百十" do
    compare_kanji_and_integer("四百十", 410)
  end

  it "四百十一" do
    compare_kanji_and_integer("四百十一", 411)
  end

  it "四百十二" do
    compare_kanji_and_integer("四百十二", 412)
  end

  it "四百十三" do
    compare_kanji_and_integer("四百十三", 413)
  end

  it "四百十四" do
    compare_kanji_and_integer("四百十四", 414)
  end

  it "四百十五" do
    compare_kanji_and_integer("四百十五", 415)
  end

  it "四百十六" do
    compare_kanji_and_integer("四百十六", 416)
  end

  it "四百十七" do
    compare_kanji_and_integer("四百十七", 417)
  end

  it "四百十八" do
    compare_kanji_and_integer("四百十八", 418)
  end

  it "四百十九" do
    compare_kanji_and_integer("四百十九", 419)
  end

  it "四百二十" do
    compare_kanji_and_integer("四百二十", 420)
  end

  it "四百二十一" do
    compare_kanji_and_integer("四百二十一", 421)
  end

  it "四百二十二" do
    compare_kanji_and_integer("四百二十二", 422)
  end

  it "四百二十三" do
    compare_kanji_and_integer("四百二十三", 423)
  end

  it "四百二十四" do
    compare_kanji_and_integer("四百二十四", 424)
  end

  it "四百二十五" do
    compare_kanji_and_integer("四百二十五", 425)
  end

  it "四百二十六" do
    compare_kanji_and_integer("四百二十六", 426)
  end

  it "四百二十七" do
    compare_kanji_and_integer("四百二十七", 427)
  end

  it "四百二十八" do
    compare_kanji_and_integer("四百二十八", 428)
  end

  it "四百二十九" do
    compare_kanji_and_integer("四百二十九", 429)
  end

  it "四百三十" do
    compare_kanji_and_integer("四百三十", 430)
  end

  it "四百三十一" do
    compare_kanji_and_integer("四百三十一", 431)
  end

  it "四百三十二" do
    compare_kanji_and_integer("四百三十二", 432)
  end

  it "四百三十三" do
    compare_kanji_and_integer("四百三十三", 433)
  end

  it "四百三十四" do
    compare_kanji_and_integer("四百三十四", 434)
  end

  it "四百三十五" do
    compare_kanji_and_integer("四百三十五", 435)
  end

  it "四百三十六" do
    compare_kanji_and_integer("四百三十六", 436)
  end

  it "四百三十七" do
    compare_kanji_and_integer("四百三十七", 437)
  end

  it "四百三十八" do
    compare_kanji_and_integer("四百三十八", 438)
  end

  it "四百三十九" do
    compare_kanji_and_integer("四百三十九", 439)
  end

  it "四百四十" do
    compare_kanji_and_integer("四百四十", 440)
  end

  it "四百四十一" do
    compare_kanji_and_integer("四百四十一", 441)
  end

  it "四百四十二" do
    compare_kanji_and_integer("四百四十二", 442)
  end

  it "四百四十三" do
    compare_kanji_and_integer("四百四十三", 443)
  end

  it "四百四十四" do
    compare_kanji_and_integer("四百四十四", 444)
  end

  it "四百四十五" do
    compare_kanji_and_integer("四百四十五", 445)
  end

  it "四百四十六" do
    compare_kanji_and_integer("四百四十六", 446)
  end

  it "四百四十七" do
    compare_kanji_and_integer("四百四十七", 447)
  end

  it "四百四十八" do
    compare_kanji_and_integer("四百四十八", 448)
  end

  it "四百四十九" do
    compare_kanji_and_integer("四百四十九", 449)
  end

  it "四百五十" do
    compare_kanji_and_integer("四百五十", 450)
  end

  it "四百五十一" do
    compare_kanji_and_integer("四百五十一", 451)
  end

  it "四百五十二" do
    compare_kanji_and_integer("四百五十二", 452)
  end

  it "四百五十三" do
    compare_kanji_and_integer("四百五十三", 453)
  end

  it "九百八十三" do
    compare_kanji_and_integer("九百八十三", 983)
  end

  it "九百八十四" do
    compare_kanji_and_integer("九百八十四", 984)
  end

  it "九百八十五" do
    compare_kanji_and_integer("九百八十五", 985)
  end

  it "九百八十六" do
    compare_kanji_and_integer("九百八十六", 986)
  end

  it "九百八十七" do
    compare_kanji_and_integer("九百八十七", 987)
  end

  it "九百八十八" do
    compare_kanji_and_integer("九百八十八", 988)
  end

  it "九百八十九" do
    compare_kanji_and_integer("九百八十九", 989)
  end

  it "九百九十" do
    compare_kanji_and_integer("九百九十", 990)
  end

  it "九百九十一" do
    compare_kanji_and_integer("九百九十一", 991)
  end

  it "九百九十二" do
    compare_kanji_and_integer("九百九十二", 992)
  end

  it "九百九十三" do
    compare_kanji_and_integer("九百九十三", 993)
  end

  it "九百九十四" do
    compare_kanji_and_integer("九百九十四", 994)
  end

  it "九百九十五" do
    compare_kanji_and_integer("九百九十五", 995)
  end

  it "九百九十六" do
    compare_kanji_and_integer("九百九十六", 996)
  end

  it "九百九十七" do
    compare_kanji_and_integer("九百九十七", 997)
  end

  it "九百九十八" do
    compare_kanji_and_integer("九百九十八", 998)
  end

  it "九百九十九" do
    compare_kanji_and_integer("九百九十九", 999)
  end

  it "千" do
    compare_kanji_and_integer("千", 1000)
  end

  it "千一" do
    compare_kanji_and_integer("千一", 1001)
  end

  it "千二" do
    compare_kanji_and_integer("千二", 1002)
  end

  it "千三" do
    compare_kanji_and_integer("千三", 1003)
  end

  it "千四" do
    compare_kanji_and_integer("千四", 1004)
  end

  it "千五" do
    compare_kanji_and_integer("千五", 1005)
  end

  it "千六" do
    compare_kanji_and_integer("千六", 1006)
  end

  it "千七" do
    compare_kanji_and_integer("千七", 1007)
  end

  it "千八" do
    compare_kanji_and_integer("千八", 1008)
  end

  it "千九" do
    compare_kanji_and_integer("千九", 1009)
  end

  it "千十" do
    compare_kanji_and_integer("千十", 1010)
  end

  it "千十一" do
    compare_kanji_and_integer("千十一", 1011)
  end

  it "千十二" do
    compare_kanji_and_integer("千十二", 1012)
  end

  it "千十三" do
    compare_kanji_and_integer("千十三", 1013)
  end

  it "千十四" do
    compare_kanji_and_integer("千十四", 1014)
  end

  it "千十五" do
    compare_kanji_and_integer("千十五", 1015)
  end

  it "千十六" do
    compare_kanji_and_integer("千十六", 1016)
  end

  it "千十七" do
    compare_kanji_and_integer("千十七", 1017)
  end

  it "千十八" do
    compare_kanji_and_integer("千十八", 1018)
  end

  it "千十九" do
    compare_kanji_and_integer("千十九", 1019)
  end

  it "千二十" do
    compare_kanji_and_integer("千二十", 1020)
  end

  it "千二十一" do
    compare_kanji_and_integer("千二十一", 1021)
  end

  it "千二十二" do
    compare_kanji_and_integer("千二十二", 1022)
  end

  it "千二十三" do
    compare_kanji_and_integer("千二十三", 1023)
  end

  it "千二十四" do
    compare_kanji_and_integer("千二十四", 1024)
  end

  it "千二十五" do
    compare_kanji_and_integer("千二十五", 1025)
  end

  it "千二十六" do
    compare_kanji_and_integer("千二十六", 1026)
  end

  it "千二十七" do
    compare_kanji_and_integer("千二十七", 1027)
  end

  it "千二十八" do
    compare_kanji_and_integer("千二十八", 1028)
  end

  it "千二十九" do
    compare_kanji_and_integer("千二十九", 1029)
  end

  it "千三十" do
    compare_kanji_and_integer("千三十", 1030)
  end

  it "千三十一" do
    compare_kanji_and_integer("千三十一", 1031)
  end

  it "千三十二" do
    compare_kanji_and_integer("千三十二", 1032)
  end

  it "千三十三" do
    compare_kanji_and_integer("千三十三", 1033)
  end

  it "千三十四" do
    compare_kanji_and_integer("千三十四", 1034)
  end

  it "千三十五" do
    compare_kanji_and_integer("千三十五", 1035)
  end

  it "千三十六" do
    compare_kanji_and_integer("千三十六", 1036)
  end

  it "千三十七" do
    compare_kanji_and_integer("千三十七", 1037)
  end

  it "千三十八" do
    compare_kanji_and_integer("千三十八", 1038)
  end

  it "千三十九" do
    compare_kanji_and_integer("千三十九", 1039)
  end

  it "千四十" do
    compare_kanji_and_integer("千四十", 1040)
  end

  it "千四十一" do
    compare_kanji_and_integer("千四十一", 1041)
  end

  it "千四十二" do
    compare_kanji_and_integer("千四十二", 1042)
  end

  it "千四十三" do
    compare_kanji_and_integer("千四十三", 1043)
  end

  it "千四十四" do
    compare_kanji_and_integer("千四十四", 1044)
  end

  it "千四十五" do
    compare_kanji_and_integer("千四十五", 1045)
  end

  it "千四十六" do
    compare_kanji_and_integer("千四十六", 1046)
  end

  it "千四十七" do
    compare_kanji_and_integer("千四十七", 1047)
  end

  it "千四十八" do
    compare_kanji_and_integer("千四十八", 1048)
  end

  it "千四十九" do
    compare_kanji_and_integer("千四十九", 1049)
  end

  it "千五十" do
    compare_kanji_and_integer("千五十", 1050)
  end

  it "千五十一" do
    compare_kanji_and_integer("千五十一", 1051)
  end

  it "千五十二" do
    compare_kanji_and_integer("千五十二", 1052)
  end

  it "千五十三" do
    compare_kanji_and_integer("千五十三", 1053)
  end

  it "千五十四" do
    compare_kanji_and_integer("千五十四", 1054)
  end

  it "千五十五" do
    compare_kanji_and_integer("千五十五", 1055)
  end

  it "千五十六" do
    compare_kanji_and_integer("千五十六", 1056)
  end

  it "千五十七" do
    compare_kanji_and_integer("千五十七", 1057)
  end

  it "千五十八" do
    compare_kanji_and_integer("千五十八", 1058)
  end

  it "千五十九" do
    compare_kanji_and_integer("千五十九", 1059)
  end

  it "千六十" do
    compare_kanji_and_integer("千六十", 1060)
  end

  it "千六十一" do
    compare_kanji_and_integer("千六十一", 1061)
  end

  it "千六十二" do
    compare_kanji_and_integer("千六十二", 1062)
  end

  it "千六十三" do
    compare_kanji_and_integer("千六十三", 1063)
  end

  it "千六十四" do
    compare_kanji_and_integer("千六十四", 1064)
  end

  it "千六十五" do
    compare_kanji_and_integer("千六十五", 1065)
  end

  it "千六十六" do
    compare_kanji_and_integer("千六十六", 1066)
  end

  it "千六十七" do
    compare_kanji_and_integer("千六十七", 1067)
  end

  it "千六十八" do
    compare_kanji_and_integer("千六十八", 1068)
  end

  it "千六十九" do
    compare_kanji_and_integer("千六十九", 1069)
  end

  it "千七十" do
    compare_kanji_and_integer("千七十", 1070)
  end

  it "千七十一" do
    compare_kanji_and_integer("千七十一", 1071)
  end

  it "千七十二" do
    compare_kanji_and_integer("千七十二", 1072)
  end

  it "千七十三" do
    compare_kanji_and_integer("千七十三", 1073)
  end

  it "千七十四" do
    compare_kanji_and_integer("千七十四", 1074)
  end

  it "千七十五" do
    compare_kanji_and_integer("千七十五", 1075)
  end

  it "千七十六" do
    compare_kanji_and_integer("千七十六", 1076)
  end

  it "千七十七" do
    compare_kanji_and_integer("千七十七", 1077)
  end

  it "千七十八" do
    compare_kanji_and_integer("千七十八", 1078)
  end

  it "千七十九" do
    compare_kanji_and_integer("千七十九", 1079)
  end

  it "千八十" do
    compare_kanji_and_integer("千八十", 1080)
  end

  it "千八十一" do
    compare_kanji_and_integer("千八十一", 1081)
  end

  it "千八十二" do
    compare_kanji_and_integer("千八十二", 1082)
  end

  it "千八十三" do
    compare_kanji_and_integer("千八十三", 1083)
  end

  it "千八十四" do
    compare_kanji_and_integer("千八十四", 1084)
  end

  it "千八十五" do
    compare_kanji_and_integer("千八十五", 1085)
  end

  it "千八十六" do
    compare_kanji_and_integer("千八十六", 1086)
  end

  it "千八十七" do
    compare_kanji_and_integer("千八十七", 1087)
  end

  it "千八十八" do
    compare_kanji_and_integer("千八十八", 1088)
  end

  it "千八十九" do
    compare_kanji_and_integer("千八十九", 1089)
  end

  it "千九十" do
    compare_kanji_and_integer("千九十", 1090)
  end

  it "千九十一" do
    compare_kanji_and_integer("千九十一", 1091)
  end

  it "千九十二" do
    compare_kanji_and_integer("千九十二", 1092)
  end

  it "千九十三" do
    compare_kanji_and_integer("千九十三", 1093)
  end

  it "千九十四" do
    compare_kanji_and_integer("千九十四", 1094)
  end

  it "千九十五" do
    compare_kanji_and_integer("千九十五", 1095)
  end

  it "千九十六" do
    compare_kanji_and_integer("千九十六", 1096)
  end

  it "千九十七" do
    compare_kanji_and_integer("千九十七", 1097)
  end

  it "千九十八" do
    compare_kanji_and_integer("千九十八", 1098)
  end

  it "千九十九" do
    compare_kanji_and_integer("千九十九", 1099)
  end

  it "千百" do
    compare_kanji_and_integer("千百", 1100)
  end

  it "千百一" do
    compare_kanji_and_integer("千百一", 1101)
  end

  it "千百二" do
    compare_kanji_and_integer("千百二", 1102)
  end

  it "千百三" do
    compare_kanji_and_integer("千百三", 1103)
  end

  it "千百四" do
    compare_kanji_and_integer("千百四", 1104)
  end

  it "千百五" do
    compare_kanji_and_integer("千百五", 1105)
  end

  it "千百六" do
    compare_kanji_and_integer("千百六", 1106)
  end

  it "千百七" do
    compare_kanji_and_integer("千百七", 1107)
  end

  it "千百八" do
    compare_kanji_and_integer("千百八", 1108)
  end

  it "千百九" do
    compare_kanji_and_integer("千百九", 1109)
  end

  it "千百十" do
    compare_kanji_and_integer("千百十", 1110)
  end

  it "千百十一" do
    compare_kanji_and_integer("千百十一", 1111)
  end

  it "千百十二" do
    compare_kanji_and_integer("千百十二", 1112)
  end

  it "千百十三" do
    compare_kanji_and_integer("千百十三", 1113)
  end

  it "千百十四" do
    compare_kanji_and_integer("千百十四", 1114)
  end

  it "千百十五" do
    compare_kanji_and_integer("千百十五", 1115)
  end

  it "千百十六" do
    compare_kanji_and_integer("千百十六", 1116)
  end

  it "千百十七" do
    compare_kanji_and_integer("千百十七", 1117)
  end

  it "千百十八" do
    compare_kanji_and_integer("千百十八", 1118)
  end

  it "千百十九" do
    compare_kanji_and_integer("千百十九", 1119)
  end

  it "千百二十" do
    compare_kanji_and_integer("千百二十", 1120)
  end

  it "千百二十一" do
    compare_kanji_and_integer("千百二十一", 1121)
  end

  it "千百二十二" do
    compare_kanji_and_integer("千百二十二", 1122)
  end

  it "千百二十三" do
    compare_kanji_and_integer("千百二十三", 1123)
  end

  it "千百二十四" do
    compare_kanji_and_integer("千百二十四", 1124)
  end

  it "千百二十五" do
    compare_kanji_and_integer("千百二十五", 1125)
  end

  it "千百二十六" do
    compare_kanji_and_integer("千百二十六", 1126)
  end

  it "千百二十七" do
    compare_kanji_and_integer("千百二十七", 1127)
  end

  it "千百二十八" do
    compare_kanji_and_integer("千百二十八", 1128)
  end

  it "千百二十九" do
    compare_kanji_and_integer("千百二十九", 1129)
  end

  it "千百三十" do
    compare_kanji_and_integer("千百三十", 1130)
  end

  it "千百三十一" do
    compare_kanji_and_integer("千百三十一", 1131)
  end

  it "千百三十二" do
    compare_kanji_and_integer("千百三十二", 1132)
  end

  it "千百三十三" do
    compare_kanji_and_integer("千百三十三", 1133)
  end

  it "千百三十四" do
    compare_kanji_and_integer("千百三十四", 1134)
  end

  it "千百三十五" do
    compare_kanji_and_integer("千百三十五", 1135)
  end

  it "千百三十六" do
    compare_kanji_and_integer("千百三十六", 1136)
  end

  it "千百三十七" do
    compare_kanji_and_integer("千百三十七", 1137)
  end

  it "千百三十八" do
    compare_kanji_and_integer("千百三十八", 1138)
  end

  it "千百三十九" do
    compare_kanji_and_integer("千百三十九", 1139)
  end

  it "千百四十" do
    compare_kanji_and_integer("千百四十", 1140)
  end

  it "千百四十一" do
    compare_kanji_and_integer("千百四十一", 1141)
  end

  it "千百四十二" do
    compare_kanji_and_integer("千百四十二", 1142)
  end

  it "千百四十三" do
    compare_kanji_and_integer("千百四十三", 1143)
  end

  it "千百四十四" do
    compare_kanji_and_integer("千百四十四", 1144)
  end

  it "千百四十五" do
    compare_kanji_and_integer("千百四十五", 1145)
  end

  it "千百四十六" do
    compare_kanji_and_integer("千百四十六", 1146)
  end

  it "千百四十七" do
    compare_kanji_and_integer("千百四十七", 1147)
  end

  it "千百四十八" do
    compare_kanji_and_integer("千百四十八", 1148)
  end

  it "千百四十九" do
    compare_kanji_and_integer("千百四十九", 1149)
  end

  it "千百五十" do
    compare_kanji_and_integer("千百五十", 1150)
  end

  it "千百五十一" do
    compare_kanji_and_integer("千百五十一", 1151)
  end

  it "千百五十二" do
    compare_kanji_and_integer("千百五十二", 1152)
  end

  it "千百五十三" do
    compare_kanji_and_integer("千百五十三", 1153)
  end

  it "千百五十四" do
    compare_kanji_and_integer("千百五十四", 1154)
  end

  it "千百五十五" do
    compare_kanji_and_integer("千百五十五", 1155)
  end

  it "千百五十六" do
    compare_kanji_and_integer("千百五十六", 1156)
  end

  it "千三百四" do
    compare_kanji_and_integer("千三百四", 1304)
  end

  it "千三百五" do
    compare_kanji_and_integer("千三百五", 1305)
  end

  it "千三百六" do
    compare_kanji_and_integer("千三百六", 1306)
  end

  it "千三百七" do
    compare_kanji_and_integer("千三百七", 1307)
  end

  it "千三百八" do
    compare_kanji_and_integer("千三百八", 1308)
  end

  it "千三百九" do
    compare_kanji_and_integer("千三百九", 1309)
  end

  it "千三百十" do
    compare_kanji_and_integer("千三百十", 1310)
  end

  it "千三百十一" do
    compare_kanji_and_integer("千三百十一", 1311)
  end

  it "千三百十二" do
    compare_kanji_and_integer("千三百十二", 1312)
  end

  it "千三百十三" do
    compare_kanji_and_integer("千三百十三", 1313)
  end

  it "千三百十四" do
    compare_kanji_and_integer("千三百十四", 1314)
  end

  it "千三百十五" do
    compare_kanji_and_integer("千三百十五", 1315)
  end

  it "千三百十六" do
    compare_kanji_and_integer("千三百十六", 1316)
  end

  it "千三百十七" do
    compare_kanji_and_integer("千三百十七", 1317)
  end

  it "千三百十八" do
    compare_kanji_and_integer("千三百十八", 1318)
  end

  it "千三百十九" do
    compare_kanji_and_integer("千三百十九", 1319)
  end

  it "千三百二十" do
    compare_kanji_and_integer("千三百二十", 1320)
  end

  it "千三百二十一" do
    compare_kanji_and_integer("千三百二十一", 1321)
  end

  it "千三百二十二" do
    compare_kanji_and_integer("千三百二十二", 1322)
  end

  it "千三百二十三" do
    compare_kanji_and_integer("千三百二十三", 1323)
  end

  it "千三百二十四" do
    compare_kanji_and_integer("千三百二十四", 1324)
  end

  it "千三百二十五" do
    compare_kanji_and_integer("千三百二十五", 1325)
  end

  it "千三百二十六" do
    compare_kanji_and_integer("千三百二十六", 1326)
  end

  it "千三百二十七" do
    compare_kanji_and_integer("千三百二十七", 1327)
  end

  it "千三百二十八" do
    compare_kanji_and_integer("千三百二十八", 1328)
  end

  it "千三百二十九" do
    compare_kanji_and_integer("千三百二十九", 1329)
  end

  it "千三百三十" do
    compare_kanji_and_integer("千三百三十", 1330)
  end

  it "千三百三十一" do
    compare_kanji_and_integer("千三百三十一", 1331)
  end

  it "千三百三十二" do
    compare_kanji_and_integer("千三百三十二", 1332)
  end

  it "千三百三十三" do
    compare_kanji_and_integer("千三百三十三", 1333)
  end

  it "千三百三十四" do
    compare_kanji_and_integer("千三百三十四", 1334)
  end

  it "千三百三十五" do
    compare_kanji_and_integer("千三百三十五", 1335)
  end

  it "千三百三十六" do
    compare_kanji_and_integer("千三百三十六", 1336)
  end

  it "千三百三十七" do
    compare_kanji_and_integer("千三百三十七", 1337)
  end

  it "千三百三十八" do
    compare_kanji_and_integer("千三百三十八", 1338)
  end

  it "千三百三十九" do
    compare_kanji_and_integer("千三百三十九", 1339)
  end

  it "千三百四十" do
    compare_kanji_and_integer("千三百四十", 1340)
  end

  it "千三百四十一" do
    compare_kanji_and_integer("千三百四十一", 1341)
  end

  it "千三百四十二" do
    compare_kanji_and_integer("千三百四十二", 1342)
  end

  it "千三百四十三" do
    compare_kanji_and_integer("千三百四十三", 1343)
  end

  it "千三百四十四" do
    compare_kanji_and_integer("千三百四十四", 1344)
  end

  it "千三百四十五" do
    compare_kanji_and_integer("千三百四十五", 1345)
  end

  it "千三百四十六" do
    compare_kanji_and_integer("千三百四十六", 1346)
  end

  it "千三百四十七" do
    compare_kanji_and_integer("千三百四十七", 1347)
  end

  it "千三百四十八" do
    compare_kanji_and_integer("千三百四十八", 1348)
  end

  it "千三百四十九" do
    compare_kanji_and_integer("千三百四十九", 1349)
  end

  it "千三百五十" do
    compare_kanji_and_integer("千三百五十", 1350)
  end

  it "千三百五十一" do
    compare_kanji_and_integer("千三百五十一", 1351)
  end

  it "千三百五十二" do
    compare_kanji_and_integer("千三百五十二", 1352)
  end

  it "千三百五十三" do
    compare_kanji_and_integer("千三百五十三", 1353)
  end

  it "千三百五十四" do
    compare_kanji_and_integer("千三百五十四", 1354)
  end

  it "千三百五十五" do
    compare_kanji_and_integer("千三百五十五", 1355)
  end

  it "千三百五十六" do
    compare_kanji_and_integer("千三百五十六", 1356)
  end

  it "千三百五十七" do
    compare_kanji_and_integer("千三百五十七", 1357)
  end

  it "千三百五十八" do
    compare_kanji_and_integer("千三百五十八", 1358)
  end

  it "千三百五十九" do
    compare_kanji_and_integer("千三百五十九", 1359)
  end

  it "千三百六十" do
    compare_kanji_and_integer("千三百六十", 1360)
  end

  it "千七百六十一" do
    compare_kanji_and_integer("千七百六十一", 1761)
  end

  it "千七百六十二" do
    compare_kanji_and_integer("千七百六十二", 1762)
  end

  it "千七百六十三" do
    compare_kanji_and_integer("千七百六十三", 1763)
  end

  it "千七百六十四" do
    compare_kanji_and_integer("千七百六十四", 1764)
  end

  it "千七百六十五" do
    compare_kanji_and_integer("千七百六十五", 1765)
  end

  it "千七百六十六" do
    compare_kanji_and_integer("千七百六十六", 1766)
  end

  it "千七百六十七" do
    compare_kanji_and_integer("千七百六十七", 1767)
  end

  it "千七百六十八" do
    compare_kanji_and_integer("千七百六十八", 1768)
  end

  it "千七百六十九" do
    compare_kanji_and_integer("千七百六十九", 1769)
  end

  it "千七百七十" do
    compare_kanji_and_integer("千七百七十", 1770)
  end

  it "千七百七十一" do
    compare_kanji_and_integer("千七百七十一", 1771)
  end

  it "千七百七十二" do
    compare_kanji_and_integer("千七百七十二", 1772)
  end

  it "千七百七十三" do
    compare_kanji_and_integer("千七百七十三", 1773)
  end

  it "千七百七十四" do
    compare_kanji_and_integer("千七百七十四", 1774)
  end

  it "千七百七十五" do
    compare_kanji_and_integer("千七百七十五", 1775)
  end

  it "千七百七十六" do
    compare_kanji_and_integer("千七百七十六", 1776)
  end

  it "千七百七十七" do
    compare_kanji_and_integer("千七百七十七", 1777)
  end

  it "千七百七十八" do
    compare_kanji_and_integer("千七百七十八", 1778)
  end

  it "千七百七十九" do
    compare_kanji_and_integer("千七百七十九", 1779)
  end

  it "千七百八十" do
    compare_kanji_and_integer("千七百八十", 1780)
  end

  it "千七百八十一" do
    compare_kanji_and_integer("千七百八十一", 1781)
  end

  it "千七百八十二" do
    compare_kanji_and_integer("千七百八十二", 1782)
  end

  it "千七百八十三" do
    compare_kanji_and_integer("千七百八十三", 1783)
  end

  it "千七百八十四" do
    compare_kanji_and_integer("千七百八十四", 1784)
  end

  it "千七百八十五" do
    compare_kanji_and_integer("千七百八十五", 1785)
  end

  it "千七百八十六" do
    compare_kanji_and_integer("千七百八十六", 1786)
  end

  it "千七百八十七" do
    compare_kanji_and_integer("千七百八十七", 1787)
  end

  it "千七百八十八" do
    compare_kanji_and_integer("千七百八十八", 1788)
  end

  it "千七百八十九" do
    compare_kanji_and_integer("千七百八十九", 1789)
  end

  it "千七百九十" do
    compare_kanji_and_integer("千七百九十", 1790)
  end

  it "千七百九十一" do
    compare_kanji_and_integer("千七百九十一", 1791)
  end

  it "千七百九十二" do
    compare_kanji_and_integer("千七百九十二", 1792)
  end

  it "千七百九十三" do
    compare_kanji_and_integer("千七百九十三", 1793)
  end

  it "千七百九十四" do
    compare_kanji_and_integer("千七百九十四", 1794)
  end

  it "千七百九十五" do
    compare_kanji_and_integer("千七百九十五", 1795)
  end

  it "千七百九十六" do
    compare_kanji_and_integer("千七百九十六", 1796)
  end

  it "千七百九十七" do
    compare_kanji_and_integer("千七百九十七", 1797)
  end

  it "千七百九十八" do
    compare_kanji_and_integer("千七百九十八", 1798)
  end

  it "千七百九十九" do
    compare_kanji_and_integer("千七百九十九", 1799)
  end

  it "千八百" do
    compare_kanji_and_integer("千八百", 1800)
  end

  it "千八百一" do
    compare_kanji_and_integer("千八百一", 1801)
  end

  it "千八百二" do
    compare_kanji_and_integer("千八百二", 1802)
  end

  it "千八百三" do
    compare_kanji_and_integer("千八百三", 1803)
  end

  it "千八百四" do
    compare_kanji_and_integer("千八百四", 1804)
  end

  it "千八百五" do
    compare_kanji_and_integer("千八百五", 1805)
  end

  it "千八百六" do
    compare_kanji_and_integer("千八百六", 1806)
  end

  it "千八百七" do
    compare_kanji_and_integer("千八百七", 1807)
  end

  it "千八百八" do
    compare_kanji_and_integer("千八百八", 1808)
  end

  it "千八百九" do
    compare_kanji_and_integer("千八百九", 1809)
  end

  it "千八百十" do
    compare_kanji_and_integer("千八百十", 1810)
  end

  it "千八百十一" do
    compare_kanji_and_integer("千八百十一", 1811)
  end

  it "千八百十二" do
    compare_kanji_and_integer("千八百十二", 1812)
  end

  it "千八百十三" do
    compare_kanji_and_integer("千八百十三", 1813)
  end

  it "千八百十四" do
    compare_kanji_and_integer("千八百十四", 1814)
  end

  it "千八百十五" do
    compare_kanji_and_integer("千八百十五", 1815)
  end

  it "千八百十六" do
    compare_kanji_and_integer("千八百十六", 1816)
  end

  it "千八百十七" do
    compare_kanji_and_integer("千八百十七", 1817)
  end

  it "千八百十八" do
    compare_kanji_and_integer("千八百十八", 1818)
  end

  it "千八百十九" do
    compare_kanji_and_integer("千八百十九", 1819)
  end

  it "千八百二十" do
    compare_kanji_and_integer("千八百二十", 1820)
  end

  it "千八百二十一" do
    compare_kanji_and_integer("千八百二十一", 1821)
  end

  it "千八百二十二" do
    compare_kanji_and_integer("千八百二十二", 1822)
  end

  it "千八百二十三" do
    compare_kanji_and_integer("千八百二十三", 1823)
  end

  it "千八百二十四" do
    compare_kanji_and_integer("千八百二十四", 1824)
  end

  it "千八百二十五" do
    compare_kanji_and_integer("千八百二十五", 1825)
  end

  it "千八百二十六" do
    compare_kanji_and_integer("千八百二十六", 1826)
  end

  it "千八百二十七" do
    compare_kanji_and_integer("千八百二十七", 1827)
  end

  it "千八百二十八" do
    compare_kanji_and_integer("千八百二十八", 1828)
  end

  it "千八百二十九" do
    compare_kanji_and_integer("千八百二十九", 1829)
  end

  it "千八百三十" do
    compare_kanji_and_integer("千八百三十", 1830)
  end

  it "千八百三十一" do
    compare_kanji_and_integer("千八百三十一", 1831)
  end

  it "千八百三十二" do
    compare_kanji_and_integer("千八百三十二", 1832)
  end

  it "千八百三十三" do
    compare_kanji_and_integer("千八百三十三", 1833)
  end

  it "千八百三十四" do
    compare_kanji_and_integer("千八百三十四", 1834)
  end

  it "千八百三十五" do
    compare_kanji_and_integer("千八百三十五", 1835)
  end

  it "千八百三十六" do
    compare_kanji_and_integer("千八百三十六", 1836)
  end

  it "千八百三十七" do
    compare_kanji_and_integer("千八百三十七", 1837)
  end

  it "千八百三十八" do
    compare_kanji_and_integer("千八百三十八", 1838)
  end

  it "千八百三十九" do
    compare_kanji_and_integer("千八百三十九", 1839)
  end

  it "千八百四十" do
    compare_kanji_and_integer("千八百四十", 1840)
  end

  it "千八百四十一" do
    compare_kanji_and_integer("千八百四十一", 1841)
  end

  it "千八百四十二" do
    compare_kanji_and_integer("千八百四十二", 1842)
  end

  it "千八百四十三" do
    compare_kanji_and_integer("千八百四十三", 1843)
  end

  it "千八百四十四" do
    compare_kanji_and_integer("千八百四十四", 1844)
  end

  it "千八百四十五" do
    compare_kanji_and_integer("千八百四十五", 1845)
  end

  it "千八百四十六" do
    compare_kanji_and_integer("千八百四十六", 1846)
  end

  it "千八百四十七" do
    compare_kanji_and_integer("千八百四十七", 1847)
  end

  it "千八百四十八" do
    compare_kanji_and_integer("千八百四十八", 1848)
  end

  it "千八百四十九" do
    compare_kanji_and_integer("千八百四十九", 1849)
  end

  it "千八百五十" do
    compare_kanji_and_integer("千八百五十", 1850)
  end

  it "千八百五十一" do
    compare_kanji_and_integer("千八百五十一", 1851)
  end

  it "千八百五十二" do
    compare_kanji_and_integer("千八百五十二", 1852)
  end

  it "千八百五十三" do
    compare_kanji_and_integer("千八百五十三", 1853)
  end

  it "千八百五十四" do
    compare_kanji_and_integer("千八百五十四", 1854)
  end

  it "千八百五十五" do
    compare_kanji_and_integer("千八百五十五", 1855)
  end

  it "千八百五十六" do
    compare_kanji_and_integer("千八百五十六", 1856)
  end

  it "千八百五十七" do
    compare_kanji_and_integer("千八百五十七", 1857)
  end

  it "千八百五十八" do
    compare_kanji_and_integer("千八百五十八", 1858)
  end

  it "千八百五十九" do
    compare_kanji_and_integer("千八百五十九", 1859)
  end

  it "千八百六十" do
    compare_kanji_and_integer("千八百六十", 1860)
  end

  it "千八百六十一" do
    compare_kanji_and_integer("千八百六十一", 1861)
  end

  it "千八百六十二" do
    compare_kanji_and_integer("千八百六十二", 1862)
  end

  it "千八百六十三" do
    compare_kanji_and_integer("千八百六十三", 1863)
  end

  it "千八百六十四" do
    compare_kanji_and_integer("千八百六十四", 1864)
  end

  it "千八百六十五" do
    compare_kanji_and_integer("千八百六十五", 1865)
  end

  it "千八百六十六" do
    compare_kanji_and_integer("千八百六十六", 1866)
  end

  it "千八百六十七" do
    compare_kanji_and_integer("千八百六十七", 1867)
  end

  it "千八百六十八" do
    compare_kanji_and_integer("千八百六十八", 1868)
  end

  it "千八百六十九" do
    compare_kanji_and_integer("千八百六十九", 1869)
  end

  it "千八百七十" do
    compare_kanji_and_integer("千八百七十", 1870)
  end

  it "千八百七十一" do
    compare_kanji_and_integer("千八百七十一", 1871)
  end

  it "千八百七十二" do
    compare_kanji_and_integer("千八百七十二", 1872)
  end

  it "千八百七十三" do
    compare_kanji_and_integer("千八百七十三", 1873)
  end

  it "千八百七十四" do
    compare_kanji_and_integer("千八百七十四", 1874)
  end

  it "千八百七十五" do
    compare_kanji_and_integer("千八百七十五", 1875)
  end

  it "千八百七十六" do
    compare_kanji_and_integer("千八百七十六", 1876)
  end

  it "千八百七十七" do
    compare_kanji_and_integer("千八百七十七", 1877)
  end

  it "千八百七十八" do
    compare_kanji_and_integer("千八百七十八", 1878)
  end

  it "千八百七十九" do
    compare_kanji_and_integer("千八百七十九", 1879)
  end

  it "千八百八十" do
    compare_kanji_and_integer("千八百八十", 1880)
  end

  it "千八百八十一" do
    compare_kanji_and_integer("千八百八十一", 1881)
  end

  it "千八百八十二" do
    compare_kanji_and_integer("千八百八十二", 1882)
  end

  it "千八百八十三" do
    compare_kanji_and_integer("千八百八十三", 1883)
  end

  it "千八百八十四" do
    compare_kanji_and_integer("千八百八十四", 1884)
  end

  it "千八百八十五" do
    compare_kanji_and_integer("千八百八十五", 1885)
  end

  it "千八百八十六" do
    compare_kanji_and_integer("千八百八十六", 1886)
  end

  it "千八百八十七" do
    compare_kanji_and_integer("千八百八十七", 1887)
  end

  it "千八百八十八" do
    compare_kanji_and_integer("千八百八十八", 1888)
  end

  it "千八百八十九" do
    compare_kanji_and_integer("千八百八十九", 1889)
  end

  it "千八百九十" do
    compare_kanji_and_integer("千八百九十", 1890)
  end

  it "千八百九十一" do
    compare_kanji_and_integer("千八百九十一", 1891)
  end

  it "千八百九十二" do
    compare_kanji_and_integer("千八百九十二", 1892)
  end

  it "千八百九十三" do
    compare_kanji_and_integer("千八百九十三", 1893)
  end

  it "千八百九十四" do
    compare_kanji_and_integer("千八百九十四", 1894)
  end

  it "千八百九十五" do
    compare_kanji_and_integer("千八百九十五", 1895)
  end

  it "千八百九十六" do
    compare_kanji_and_integer("千八百九十六", 1896)
  end

  it "千八百九十七" do
    compare_kanji_and_integer("千八百九十七", 1897)
  end

  it "千八百九十八" do
    compare_kanji_and_integer("千八百九十八", 1898)
  end

  it "千八百九十九" do
    compare_kanji_and_integer("千八百九十九", 1899)
  end

  it "千九百" do
    compare_kanji_and_integer("千九百", 1900)
  end

  it "千九百一" do
    compare_kanji_and_integer("千九百一", 1901)
  end

  it "千九百二" do
    compare_kanji_and_integer("千九百二", 1902)
  end

  it "千九百三" do
    compare_kanji_and_integer("千九百三", 1903)
  end

  it "千九百四" do
    compare_kanji_and_integer("千九百四", 1904)
  end

  it "千九百五" do
    compare_kanji_and_integer("千九百五", 1905)
  end

  it "千九百六" do
    compare_kanji_and_integer("千九百六", 1906)
  end

  it "千九百七" do
    compare_kanji_and_integer("千九百七", 1907)
  end

  it "千九百八" do
    compare_kanji_and_integer("千九百八", 1908)
  end

  it "千九百九" do
    compare_kanji_and_integer("千九百九", 1909)
  end

  it "千九百十" do
    compare_kanji_and_integer("千九百十", 1910)
  end

  it "千九百十一" do
    compare_kanji_and_integer("千九百十一", 1911)
  end

  it "千九百十二" do
    compare_kanji_and_integer("千九百十二", 1912)
  end

  it "千九百十三" do
    compare_kanji_and_integer("千九百十三", 1913)
  end

  it "千九百十四" do
    compare_kanji_and_integer("千九百十四", 1914)
  end

  it "千九百十五" do
    compare_kanji_and_integer("千九百十五", 1915)
  end

  it "千九百十六" do
    compare_kanji_and_integer("千九百十六", 1916)
  end

  it "千九百十七" do
    compare_kanji_and_integer("千九百十七", 1917)
  end

  it "千九百十八" do
    compare_kanji_and_integer("千九百十八", 1918)
  end

  it "千九百十九" do
    compare_kanji_and_integer("千九百十九", 1919)
  end

  it "千九百二十" do
    compare_kanji_and_integer("千九百二十", 1920)
  end

  it "千九百二十一" do
    compare_kanji_and_integer("千九百二十一", 1921)
  end

  it "千九百二十二" do
    compare_kanji_and_integer("千九百二十二", 1922)
  end

  it "千九百二十三" do
    compare_kanji_and_integer("千九百二十三", 1923)
  end

  it "千九百二十四" do
    compare_kanji_and_integer("千九百二十四", 1924)
  end

  it "千九百二十五" do
    compare_kanji_and_integer("千九百二十五", 1925)
  end

  it "千九百二十六" do
    compare_kanji_and_integer("千九百二十六", 1926)
  end

  it "千九百二十七" do
    compare_kanji_and_integer("千九百二十七", 1927)
  end

  it "千九百二十八" do
    compare_kanji_and_integer("千九百二十八", 1928)
  end

  it "千九百二十九" do
    compare_kanji_and_integer("千九百二十九", 1929)
  end

  it "千九百三十" do
    compare_kanji_and_integer("千九百三十", 1930)
  end

  it "千九百三十一" do
    compare_kanji_and_integer("千九百三十一", 1931)
  end

  it "千九百三十二" do
    compare_kanji_and_integer("千九百三十二", 1932)
  end

  it "千九百三十三" do
    compare_kanji_and_integer("千九百三十三", 1933)
  end

  it "千九百三十四" do
    compare_kanji_and_integer("千九百三十四", 1934)
  end

  it "千九百三十五" do
    compare_kanji_and_integer("千九百三十五", 1935)
  end

  it "千九百三十六" do
    compare_kanji_and_integer("千九百三十六", 1936)
  end

  it "千九百三十七" do
    compare_kanji_and_integer("千九百三十七", 1937)
  end

  it "千九百三十八" do
    compare_kanji_and_integer("千九百三十八", 1938)
  end

  it "千九百三十九" do
    compare_kanji_and_integer("千九百三十九", 1939)
  end

  it "千九百四十" do
    compare_kanji_and_integer("千九百四十", 1940)
  end

  it "千九百四十一" do
    compare_kanji_and_integer("千九百四十一", 1941)
  end

  it "千九百四十二" do
    compare_kanji_and_integer("千九百四十二", 1942)
  end

  it "千九百四十三" do
    compare_kanji_and_integer("千九百四十三", 1943)
  end

  it "千九百四十四" do
    compare_kanji_and_integer("千九百四十四", 1944)
  end

  it "千九百四十五" do
    compare_kanji_and_integer("千九百四十五", 1945)
  end

  it "千九百四十六" do
    compare_kanji_and_integer("千九百四十六", 1946)
  end

  it "千九百四十七" do
    compare_kanji_and_integer("千九百四十七", 1947)
  end

  it "千九百四十八" do
    compare_kanji_and_integer("千九百四十八", 1948)
  end

  it "千九百四十九" do
    compare_kanji_and_integer("千九百四十九", 1949)
  end

  it "千九百五十" do
    compare_kanji_and_integer("千九百五十", 1950)
  end

  it "千九百五十一" do
    compare_kanji_and_integer("千九百五十一", 1951)
  end

  it "千九百五十二" do
    compare_kanji_and_integer("千九百五十二", 1952)
  end

  it "千九百五十三" do
    compare_kanji_and_integer("千九百五十三", 1953)
  end

  it "千九百五十四" do
    compare_kanji_and_integer("千九百五十四", 1954)
  end

  it "千九百五十五" do
    compare_kanji_and_integer("千九百五十五", 1955)
  end

  it "千九百五十六" do
    compare_kanji_and_integer("千九百五十六", 1956)
  end

  it "千九百五十七" do
    compare_kanji_and_integer("千九百五十七", 1957)
  end

  it "千九百五十八" do
    compare_kanji_and_integer("千九百五十八", 1958)
  end

  it "千九百五十九" do
    compare_kanji_and_integer("千九百五十九", 1959)
  end

  it "千九百六十" do
    compare_kanji_and_integer("千九百六十", 1960)
  end

  it "千九百六十一" do
    compare_kanji_and_integer("千九百六十一", 1961)
  end

  it "千九百六十二" do
    compare_kanji_and_integer("千九百六十二", 1962)
  end

  it "千九百六十三" do
    compare_kanji_and_integer("千九百六十三", 1963)
  end

  it "千九百六十四" do
    compare_kanji_and_integer("千九百六十四", 1964)
  end

  it "千九百六十五" do
    compare_kanji_and_integer("千九百六十五", 1965)
  end

  it "千九百六十六" do
    compare_kanji_and_integer("千九百六十六", 1966)
  end

  it "千九百六十七" do
    compare_kanji_and_integer("千九百六十七", 1967)
  end

  it "千九百六十八" do
    compare_kanji_and_integer("千九百六十八", 1968)
  end

  it "千九百六十九" do
    compare_kanji_and_integer("千九百六十九", 1969)
  end

  it "千九百七十" do
    compare_kanji_and_integer("千九百七十", 1970)
  end

  it "千九百七十一" do
    compare_kanji_and_integer("千九百七十一", 1971)
  end

  it "千九百七十二" do
    compare_kanji_and_integer("千九百七十二", 1972)
  end

  it "千九百七十三" do
    compare_kanji_and_integer("千九百七十三", 1973)
  end

  it "千九百七十四" do
    compare_kanji_and_integer("千九百七十四", 1974)
  end

  it "千九百七十五" do
    compare_kanji_and_integer("千九百七十五", 1975)
  end

  it "千九百七十六" do
    compare_kanji_and_integer("千九百七十六", 1976)
  end

  it "千九百七十七" do
    compare_kanji_and_integer("千九百七十七", 1977)
  end

  it "千九百七十八" do
    compare_kanji_and_integer("千九百七十八", 1978)
  end

  it "千九百七十九" do
    compare_kanji_and_integer("千九百七十九", 1979)
  end

  it "千九百八十" do
    compare_kanji_and_integer("千九百八十", 1980)
  end

  it "千九百八十一" do
    compare_kanji_and_integer("千九百八十一", 1981)
  end

  it "千九百八十二" do
    compare_kanji_and_integer("千九百八十二", 1982)
  end

  it "千九百八十三" do
    compare_kanji_and_integer("千九百八十三", 1983)
  end

  it "千九百八十四" do
    compare_kanji_and_integer("千九百八十四", 1984)
  end

  it "千九百八十五" do
    compare_kanji_and_integer("千九百八十五", 1985)
  end

  it "千九百八十六" do
    compare_kanji_and_integer("千九百八十六", 1986)
  end

  it "千九百八十七" do
    compare_kanji_and_integer("千九百八十七", 1987)
  end

  it "千九百八十八" do
    compare_kanji_and_integer("千九百八十八", 1988)
  end

  it "千九百八十九" do
    compare_kanji_and_integer("千九百八十九", 1989)
  end

  it "千九百九十" do
    compare_kanji_and_integer("千九百九十", 1990)
  end

  it "千九百九十一" do
    compare_kanji_and_integer("千九百九十一", 1991)
  end

  it "千九百九十二" do
    compare_kanji_and_integer("千九百九十二", 1992)
  end

  it "千九百九十三" do
    compare_kanji_and_integer("千九百九十三", 1993)
  end

  it "千九百九十四" do
    compare_kanji_and_integer("千九百九十四", 1994)
  end

  it "千九百九十五" do
    compare_kanji_and_integer("千九百九十五", 1995)
  end

  it "千九百九十六" do
    compare_kanji_and_integer("千九百九十六", 1996)
  end

  it "千九百九十七" do
    compare_kanji_and_integer("千九百九十七", 1997)
  end

  it "千九百九十八" do
    compare_kanji_and_integer("千九百九十八", 1998)
  end

  it "千九百九十九" do
    compare_kanji_and_integer("千九百九十九", 1999)
  end

  it "二千" do
    compare_kanji_and_integer("二千", 2000)
  end

  it "一万一千百十" do
    compare_kanji_and_integer("一万一千百十", 11110)
  end
end
