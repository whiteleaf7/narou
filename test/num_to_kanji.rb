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

  it "四百五十四" do
    compare_kanji_and_integer("四百五十四", 454)
  end

  it "四百五十五" do
    compare_kanji_and_integer("四百五十五", 455)
  end

  it "四百五十六" do
    compare_kanji_and_integer("四百五十六", 456)
  end

  it "四百五十七" do
    compare_kanji_and_integer("四百五十七", 457)
  end

  it "四百五十八" do
    compare_kanji_and_integer("四百五十八", 458)
  end

  it "四百五十九" do
    compare_kanji_and_integer("四百五十九", 459)
  end

  it "四百六十" do
    compare_kanji_and_integer("四百六十", 460)
  end

  it "四百六十一" do
    compare_kanji_and_integer("四百六十一", 461)
  end

  it "四百六十二" do
    compare_kanji_and_integer("四百六十二", 462)
  end

  it "四百六十三" do
    compare_kanji_and_integer("四百六十三", 463)
  end

  it "四百六十四" do
    compare_kanji_and_integer("四百六十四", 464)
  end

  it "四百六十五" do
    compare_kanji_and_integer("四百六十五", 465)
  end

  it "四百六十六" do
    compare_kanji_and_integer("四百六十六", 466)
  end

  it "四百六十七" do
    compare_kanji_and_integer("四百六十七", 467)
  end

  it "四百六十八" do
    compare_kanji_and_integer("四百六十八", 468)
  end

  it "四百六十九" do
    compare_kanji_and_integer("四百六十九", 469)
  end

  it "四百七十" do
    compare_kanji_and_integer("四百七十", 470)
  end

  it "四百七十一" do
    compare_kanji_and_integer("四百七十一", 471)
  end

  it "四百七十二" do
    compare_kanji_and_integer("四百七十二", 472)
  end

  it "四百七十三" do
    compare_kanji_and_integer("四百七十三", 473)
  end

  it "四百七十四" do
    compare_kanji_and_integer("四百七十四", 474)
  end

  it "四百七十五" do
    compare_kanji_and_integer("四百七十五", 475)
  end

  it "四百七十六" do
    compare_kanji_and_integer("四百七十六", 476)
  end

  it "四百七十七" do
    compare_kanji_and_integer("四百七十七", 477)
  end

  it "四百七十八" do
    compare_kanji_and_integer("四百七十八", 478)
  end

  it "四百七十九" do
    compare_kanji_and_integer("四百七十九", 479)
  end

  it "四百八十" do
    compare_kanji_and_integer("四百八十", 480)
  end

  it "四百八十一" do
    compare_kanji_and_integer("四百八十一", 481)
  end

  it "四百八十二" do
    compare_kanji_and_integer("四百八十二", 482)
  end

  it "四百八十三" do
    compare_kanji_and_integer("四百八十三", 483)
  end

  it "四百八十四" do
    compare_kanji_and_integer("四百八十四", 484)
  end

  it "四百八十五" do
    compare_kanji_and_integer("四百八十五", 485)
  end

  it "四百八十六" do
    compare_kanji_and_integer("四百八十六", 486)
  end

  it "四百八十七" do
    compare_kanji_and_integer("四百八十七", 487)
  end

  it "四百八十八" do
    compare_kanji_and_integer("四百八十八", 488)
  end

  it "四百八十九" do
    compare_kanji_and_integer("四百八十九", 489)
  end

  it "四百九十" do
    compare_kanji_and_integer("四百九十", 490)
  end

  it "四百九十一" do
    compare_kanji_and_integer("四百九十一", 491)
  end

  it "四百九十二" do
    compare_kanji_and_integer("四百九十二", 492)
  end

  it "四百九十三" do
    compare_kanji_and_integer("四百九十三", 493)
  end

  it "四百九十四" do
    compare_kanji_and_integer("四百九十四", 494)
  end

  it "四百九十五" do
    compare_kanji_and_integer("四百九十五", 495)
  end

  it "四百九十六" do
    compare_kanji_and_integer("四百九十六", 496)
  end

  it "四百九十七" do
    compare_kanji_and_integer("四百九十七", 497)
  end

  it "四百九十八" do
    compare_kanji_and_integer("四百九十八", 498)
  end

  it "四百九十九" do
    compare_kanji_and_integer("四百九十九", 499)
  end

  it "五百" do
    compare_kanji_and_integer("五百", 500)
  end

  it "五百一" do
    compare_kanji_and_integer("五百一", 501)
  end

  it "五百二" do
    compare_kanji_and_integer("五百二", 502)
  end

  it "五百三" do
    compare_kanji_and_integer("五百三", 503)
  end

  it "五百四" do
    compare_kanji_and_integer("五百四", 504)
  end

  it "五百五" do
    compare_kanji_and_integer("五百五", 505)
  end

  it "五百六" do
    compare_kanji_and_integer("五百六", 506)
  end

  it "五百七" do
    compare_kanji_and_integer("五百七", 507)
  end

  it "五百八" do
    compare_kanji_and_integer("五百八", 508)
  end

  it "五百九" do
    compare_kanji_and_integer("五百九", 509)
  end

  it "五百十" do
    compare_kanji_and_integer("五百十", 510)
  end

  it "五百十一" do
    compare_kanji_and_integer("五百十一", 511)
  end

  it "五百十二" do
    compare_kanji_and_integer("五百十二", 512)
  end

  it "五百十三" do
    compare_kanji_and_integer("五百十三", 513)
  end

  it "五百十四" do
    compare_kanji_and_integer("五百十四", 514)
  end

  it "五百十五" do
    compare_kanji_and_integer("五百十五", 515)
  end

  it "五百十六" do
    compare_kanji_and_integer("五百十六", 516)
  end

  it "五百十七" do
    compare_kanji_and_integer("五百十七", 517)
  end

  it "五百十八" do
    compare_kanji_and_integer("五百十八", 518)
  end

  it "五百十九" do
    compare_kanji_and_integer("五百十九", 519)
  end

  it "五百二十" do
    compare_kanji_and_integer("五百二十", 520)
  end

  it "五百二十一" do
    compare_kanji_and_integer("五百二十一", 521)
  end

  it "五百二十二" do
    compare_kanji_and_integer("五百二十二", 522)
  end

  it "五百二十三" do
    compare_kanji_and_integer("五百二十三", 523)
  end

  it "五百二十四" do
    compare_kanji_and_integer("五百二十四", 524)
  end

  it "五百二十五" do
    compare_kanji_and_integer("五百二十五", 525)
  end

  it "五百二十六" do
    compare_kanji_and_integer("五百二十六", 526)
  end

  it "五百二十七" do
    compare_kanji_and_integer("五百二十七", 527)
  end

  it "五百二十八" do
    compare_kanji_and_integer("五百二十八", 528)
  end

  it "五百二十九" do
    compare_kanji_and_integer("五百二十九", 529)
  end

  it "五百三十" do
    compare_kanji_and_integer("五百三十", 530)
  end

  it "五百三十一" do
    compare_kanji_and_integer("五百三十一", 531)
  end

  it "五百三十二" do
    compare_kanji_and_integer("五百三十二", 532)
  end

  it "五百三十三" do
    compare_kanji_and_integer("五百三十三", 533)
  end

  it "五百三十四" do
    compare_kanji_and_integer("五百三十四", 534)
  end

  it "五百三十五" do
    compare_kanji_and_integer("五百三十五", 535)
  end

  it "五百三十六" do
    compare_kanji_and_integer("五百三十六", 536)
  end

  it "五百三十七" do
    compare_kanji_and_integer("五百三十七", 537)
  end

  it "五百三十八" do
    compare_kanji_and_integer("五百三十八", 538)
  end

  it "五百三十九" do
    compare_kanji_and_integer("五百三十九", 539)
  end

  it "五百四十" do
    compare_kanji_and_integer("五百四十", 540)
  end

  it "五百四十一" do
    compare_kanji_and_integer("五百四十一", 541)
  end

  it "五百四十二" do
    compare_kanji_and_integer("五百四十二", 542)
  end

  it "五百四十三" do
    compare_kanji_and_integer("五百四十三", 543)
  end

  it "五百四十四" do
    compare_kanji_and_integer("五百四十四", 544)
  end

  it "五百四十五" do
    compare_kanji_and_integer("五百四十五", 545)
  end

  it "五百四十六" do
    compare_kanji_and_integer("五百四十六", 546)
  end

  it "五百四十七" do
    compare_kanji_and_integer("五百四十七", 547)
  end

  it "五百四十八" do
    compare_kanji_and_integer("五百四十八", 548)
  end

  it "五百四十九" do
    compare_kanji_and_integer("五百四十九", 549)
  end

  it "五百五十" do
    compare_kanji_and_integer("五百五十", 550)
  end

  it "五百五十一" do
    compare_kanji_and_integer("五百五十一", 551)
  end

  it "五百五十二" do
    compare_kanji_and_integer("五百五十二", 552)
  end

  it "五百五十三" do
    compare_kanji_and_integer("五百五十三", 553)
  end

  it "五百五十四" do
    compare_kanji_and_integer("五百五十四", 554)
  end

  it "五百五十五" do
    compare_kanji_and_integer("五百五十五", 555)
  end

  it "五百五十六" do
    compare_kanji_and_integer("五百五十六", 556)
  end

  it "五百五十七" do
    compare_kanji_and_integer("五百五十七", 557)
  end

  it "五百五十八" do
    compare_kanji_and_integer("五百五十八", 558)
  end

  it "五百五十九" do
    compare_kanji_and_integer("五百五十九", 559)
  end

  it "五百六十" do
    compare_kanji_and_integer("五百六十", 560)
  end

  it "五百六十一" do
    compare_kanji_and_integer("五百六十一", 561)
  end

  it "五百六十二" do
    compare_kanji_and_integer("五百六十二", 562)
  end

  it "五百六十三" do
    compare_kanji_and_integer("五百六十三", 563)
  end

  it "五百六十四" do
    compare_kanji_and_integer("五百六十四", 564)
  end

  it "五百六十五" do
    compare_kanji_and_integer("五百六十五", 565)
  end

  it "五百六十六" do
    compare_kanji_and_integer("五百六十六", 566)
  end

  it "五百六十七" do
    compare_kanji_and_integer("五百六十七", 567)
  end

  it "五百六十八" do
    compare_kanji_and_integer("五百六十八", 568)
  end

  it "五百六十九" do
    compare_kanji_and_integer("五百六十九", 569)
  end

  it "五百七十" do
    compare_kanji_and_integer("五百七十", 570)
  end

  it "五百七十一" do
    compare_kanji_and_integer("五百七十一", 571)
  end

  it "五百七十二" do
    compare_kanji_and_integer("五百七十二", 572)
  end

  it "五百七十三" do
    compare_kanji_and_integer("五百七十三", 573)
  end

  it "五百七十四" do
    compare_kanji_and_integer("五百七十四", 574)
  end

  it "五百七十五" do
    compare_kanji_and_integer("五百七十五", 575)
  end

  it "五百七十六" do
    compare_kanji_and_integer("五百七十六", 576)
  end

  it "五百七十七" do
    compare_kanji_and_integer("五百七十七", 577)
  end

  it "五百七十八" do
    compare_kanji_and_integer("五百七十八", 578)
  end

  it "五百七十九" do
    compare_kanji_and_integer("五百七十九", 579)
  end

  it "五百八十" do
    compare_kanji_and_integer("五百八十", 580)
  end

  it "五百八十一" do
    compare_kanji_and_integer("五百八十一", 581)
  end

  it "五百八十二" do
    compare_kanji_and_integer("五百八十二", 582)
  end

  it "五百八十三" do
    compare_kanji_and_integer("五百八十三", 583)
  end

  it "五百八十四" do
    compare_kanji_and_integer("五百八十四", 584)
  end

  it "五百八十五" do
    compare_kanji_and_integer("五百八十五", 585)
  end

  it "五百八十六" do
    compare_kanji_and_integer("五百八十六", 586)
  end

  it "五百八十七" do
    compare_kanji_and_integer("五百八十七", 587)
  end

  it "五百八十八" do
    compare_kanji_and_integer("五百八十八", 588)
  end

  it "五百八十九" do
    compare_kanji_and_integer("五百八十九", 589)
  end

  it "五百九十" do
    compare_kanji_and_integer("五百九十", 590)
  end

  it "五百九十一" do
    compare_kanji_and_integer("五百九十一", 591)
  end

  it "五百九十二" do
    compare_kanji_and_integer("五百九十二", 592)
  end

  it "五百九十三" do
    compare_kanji_and_integer("五百九十三", 593)
  end

  it "五百九十四" do
    compare_kanji_and_integer("五百九十四", 594)
  end

  it "五百九十五" do
    compare_kanji_and_integer("五百九十五", 595)
  end

  it "五百九十六" do
    compare_kanji_and_integer("五百九十六", 596)
  end

  it "五百九十七" do
    compare_kanji_and_integer("五百九十七", 597)
  end

  it "五百九十八" do
    compare_kanji_and_integer("五百九十八", 598)
  end

  it "五百九十九" do
    compare_kanji_and_integer("五百九十九", 599)
  end

  it "六百" do
    compare_kanji_and_integer("六百", 600)
  end

  it "六百一" do
    compare_kanji_and_integer("六百一", 601)
  end

  it "六百二" do
    compare_kanji_and_integer("六百二", 602)
  end

  it "六百三" do
    compare_kanji_and_integer("六百三", 603)
  end

  it "六百四" do
    compare_kanji_and_integer("六百四", 604)
  end

  it "六百五" do
    compare_kanji_and_integer("六百五", 605)
  end

  it "六百六" do
    compare_kanji_and_integer("六百六", 606)
  end

  it "六百七" do
    compare_kanji_and_integer("六百七", 607)
  end

  it "六百八" do
    compare_kanji_and_integer("六百八", 608)
  end

  it "六百九" do
    compare_kanji_and_integer("六百九", 609)
  end

  it "六百十" do
    compare_kanji_and_integer("六百十", 610)
  end

  it "六百十一" do
    compare_kanji_and_integer("六百十一", 611)
  end

  it "六百十二" do
    compare_kanji_and_integer("六百十二", 612)
  end

  it "六百十三" do
    compare_kanji_and_integer("六百十三", 613)
  end

  it "六百十四" do
    compare_kanji_and_integer("六百十四", 614)
  end

  it "六百十五" do
    compare_kanji_and_integer("六百十五", 615)
  end

  it "六百十六" do
    compare_kanji_and_integer("六百十六", 616)
  end

  it "六百十七" do
    compare_kanji_and_integer("六百十七", 617)
  end

  it "六百十八" do
    compare_kanji_and_integer("六百十八", 618)
  end

  it "六百十九" do
    compare_kanji_and_integer("六百十九", 619)
  end

  it "六百二十" do
    compare_kanji_and_integer("六百二十", 620)
  end

  it "六百二十一" do
    compare_kanji_and_integer("六百二十一", 621)
  end

  it "六百二十二" do
    compare_kanji_and_integer("六百二十二", 622)
  end

  it "六百二十三" do
    compare_kanji_and_integer("六百二十三", 623)
  end

  it "六百二十四" do
    compare_kanji_and_integer("六百二十四", 624)
  end

  it "六百二十五" do
    compare_kanji_and_integer("六百二十五", 625)
  end

  it "六百二十六" do
    compare_kanji_and_integer("六百二十六", 626)
  end

  it "六百二十七" do
    compare_kanji_and_integer("六百二十七", 627)
  end

  it "六百二十八" do
    compare_kanji_and_integer("六百二十八", 628)
  end

  it "六百二十九" do
    compare_kanji_and_integer("六百二十九", 629)
  end

  it "六百三十" do
    compare_kanji_and_integer("六百三十", 630)
  end

  it "六百三十一" do
    compare_kanji_and_integer("六百三十一", 631)
  end

  it "六百三十二" do
    compare_kanji_and_integer("六百三十二", 632)
  end

  it "六百三十三" do
    compare_kanji_and_integer("六百三十三", 633)
  end

  it "六百三十四" do
    compare_kanji_and_integer("六百三十四", 634)
  end

  it "六百三十五" do
    compare_kanji_and_integer("六百三十五", 635)
  end

  it "六百三十六" do
    compare_kanji_and_integer("六百三十六", 636)
  end

  it "六百三十七" do
    compare_kanji_and_integer("六百三十七", 637)
  end

  it "六百三十八" do
    compare_kanji_and_integer("六百三十八", 638)
  end

  it "六百三十九" do
    compare_kanji_and_integer("六百三十九", 639)
  end

  it "六百四十" do
    compare_kanji_and_integer("六百四十", 640)
  end

  it "六百四十一" do
    compare_kanji_and_integer("六百四十一", 641)
  end

  it "六百四十二" do
    compare_kanji_and_integer("六百四十二", 642)
  end

  it "六百四十三" do
    compare_kanji_and_integer("六百四十三", 643)
  end

  it "六百四十四" do
    compare_kanji_and_integer("六百四十四", 644)
  end

  it "六百四十五" do
    compare_kanji_and_integer("六百四十五", 645)
  end

  it "六百四十六" do
    compare_kanji_and_integer("六百四十六", 646)
  end

  it "六百四十七" do
    compare_kanji_and_integer("六百四十七", 647)
  end

  it "六百四十八" do
    compare_kanji_and_integer("六百四十八", 648)
  end

  it "六百四十九" do
    compare_kanji_and_integer("六百四十九", 649)
  end

  it "六百五十" do
    compare_kanji_and_integer("六百五十", 650)
  end

  it "六百五十一" do
    compare_kanji_and_integer("六百五十一", 651)
  end

  it "六百五十二" do
    compare_kanji_and_integer("六百五十二", 652)
  end

  it "六百五十三" do
    compare_kanji_and_integer("六百五十三", 653)
  end

  it "六百五十四" do
    compare_kanji_and_integer("六百五十四", 654)
  end

  it "六百五十五" do
    compare_kanji_and_integer("六百五十五", 655)
  end

  it "六百五十六" do
    compare_kanji_and_integer("六百五十六", 656)
  end

  it "六百五十七" do
    compare_kanji_and_integer("六百五十七", 657)
  end

  it "六百五十八" do
    compare_kanji_and_integer("六百五十八", 658)
  end

  it "六百五十九" do
    compare_kanji_and_integer("六百五十九", 659)
  end

  it "六百六十" do
    compare_kanji_and_integer("六百六十", 660)
  end

  it "六百六十一" do
    compare_kanji_and_integer("六百六十一", 661)
  end

  it "六百六十二" do
    compare_kanji_and_integer("六百六十二", 662)
  end

  it "六百六十三" do
    compare_kanji_and_integer("六百六十三", 663)
  end

  it "六百六十四" do
    compare_kanji_and_integer("六百六十四", 664)
  end

  it "六百六十五" do
    compare_kanji_and_integer("六百六十五", 665)
  end

  it "六百六十六" do
    compare_kanji_and_integer("六百六十六", 666)
  end

  it "六百六十七" do
    compare_kanji_and_integer("六百六十七", 667)
  end

  it "六百六十八" do
    compare_kanji_and_integer("六百六十八", 668)
  end

  it "六百六十九" do
    compare_kanji_and_integer("六百六十九", 669)
  end

  it "六百七十" do
    compare_kanji_and_integer("六百七十", 670)
  end

  it "六百七十一" do
    compare_kanji_and_integer("六百七十一", 671)
  end

  it "六百七十二" do
    compare_kanji_and_integer("六百七十二", 672)
  end

  it "六百七十三" do
    compare_kanji_and_integer("六百七十三", 673)
  end

  it "六百七十四" do
    compare_kanji_and_integer("六百七十四", 674)
  end

  it "六百七十五" do
    compare_kanji_and_integer("六百七十五", 675)
  end

  it "六百七十六" do
    compare_kanji_and_integer("六百七十六", 676)
  end

  it "六百七十七" do
    compare_kanji_and_integer("六百七十七", 677)
  end

  it "六百七十八" do
    compare_kanji_and_integer("六百七十八", 678)
  end

  it "六百七十九" do
    compare_kanji_and_integer("六百七十九", 679)
  end

  it "六百八十" do
    compare_kanji_and_integer("六百八十", 680)
  end

  it "六百八十一" do
    compare_kanji_and_integer("六百八十一", 681)
  end

  it "六百八十二" do
    compare_kanji_and_integer("六百八十二", 682)
  end

  it "六百八十三" do
    compare_kanji_and_integer("六百八十三", 683)
  end

  it "六百八十四" do
    compare_kanji_and_integer("六百八十四", 684)
  end

  it "六百八十五" do
    compare_kanji_and_integer("六百八十五", 685)
  end

  it "六百八十六" do
    compare_kanji_and_integer("六百八十六", 686)
  end

  it "六百八十七" do
    compare_kanji_and_integer("六百八十七", 687)
  end

  it "六百八十八" do
    compare_kanji_and_integer("六百八十八", 688)
  end

  it "六百八十九" do
    compare_kanji_and_integer("六百八十九", 689)
  end

  it "六百九十" do
    compare_kanji_and_integer("六百九十", 690)
  end

  it "六百九十一" do
    compare_kanji_and_integer("六百九十一", 691)
  end

  it "六百九十二" do
    compare_kanji_and_integer("六百九十二", 692)
  end

  it "六百九十三" do
    compare_kanji_and_integer("六百九十三", 693)
  end

  it "六百九十四" do
    compare_kanji_and_integer("六百九十四", 694)
  end

  it "六百九十五" do
    compare_kanji_and_integer("六百九十五", 695)
  end

  it "六百九十六" do
    compare_kanji_and_integer("六百九十六", 696)
  end

  it "六百九十七" do
    compare_kanji_and_integer("六百九十七", 697)
  end

  it "六百九十八" do
    compare_kanji_and_integer("六百九十八", 698)
  end

  it "六百九十九" do
    compare_kanji_and_integer("六百九十九", 699)
  end

  it "七百" do
    compare_kanji_and_integer("七百", 700)
  end

  it "七百一" do
    compare_kanji_and_integer("七百一", 701)
  end

  it "七百二" do
    compare_kanji_and_integer("七百二", 702)
  end

  it "七百三" do
    compare_kanji_and_integer("七百三", 703)
  end

  it "七百四" do
    compare_kanji_and_integer("七百四", 704)
  end

  it "七百五" do
    compare_kanji_and_integer("七百五", 705)
  end

  it "七百六" do
    compare_kanji_and_integer("七百六", 706)
  end

  it "七百七" do
    compare_kanji_and_integer("七百七", 707)
  end

  it "七百八" do
    compare_kanji_and_integer("七百八", 708)
  end

  it "七百九" do
    compare_kanji_and_integer("七百九", 709)
  end

  it "七百十" do
    compare_kanji_and_integer("七百十", 710)
  end

  it "七百十一" do
    compare_kanji_and_integer("七百十一", 711)
  end

  it "七百十二" do
    compare_kanji_and_integer("七百十二", 712)
  end

  it "七百十三" do
    compare_kanji_and_integer("七百十三", 713)
  end

  it "七百十四" do
    compare_kanji_and_integer("七百十四", 714)
  end

  it "七百十五" do
    compare_kanji_and_integer("七百十五", 715)
  end

  it "七百十六" do
    compare_kanji_and_integer("七百十六", 716)
  end

  it "七百十七" do
    compare_kanji_and_integer("七百十七", 717)
  end

  it "七百十八" do
    compare_kanji_and_integer("七百十八", 718)
  end

  it "七百十九" do
    compare_kanji_and_integer("七百十九", 719)
  end

  it "七百二十" do
    compare_kanji_and_integer("七百二十", 720)
  end

  it "七百二十一" do
    compare_kanji_and_integer("七百二十一", 721)
  end

  it "七百二十二" do
    compare_kanji_and_integer("七百二十二", 722)
  end

  it "七百二十三" do
    compare_kanji_and_integer("七百二十三", 723)
  end

  it "七百二十四" do
    compare_kanji_and_integer("七百二十四", 724)
  end

  it "七百二十五" do
    compare_kanji_and_integer("七百二十五", 725)
  end

  it "七百二十六" do
    compare_kanji_and_integer("七百二十六", 726)
  end

  it "七百二十七" do
    compare_kanji_and_integer("七百二十七", 727)
  end

  it "七百二十八" do
    compare_kanji_and_integer("七百二十八", 728)
  end

  it "七百二十九" do
    compare_kanji_and_integer("七百二十九", 729)
  end

  it "七百三十" do
    compare_kanji_and_integer("七百三十", 730)
  end

  it "七百三十一" do
    compare_kanji_and_integer("七百三十一", 731)
  end

  it "七百三十二" do
    compare_kanji_and_integer("七百三十二", 732)
  end

  it "七百三十三" do
    compare_kanji_and_integer("七百三十三", 733)
  end

  it "七百三十四" do
    compare_kanji_and_integer("七百三十四", 734)
  end

  it "七百三十五" do
    compare_kanji_and_integer("七百三十五", 735)
  end

  it "七百三十六" do
    compare_kanji_and_integer("七百三十六", 736)
  end

  it "七百三十七" do
    compare_kanji_and_integer("七百三十七", 737)
  end

  it "七百三十八" do
    compare_kanji_and_integer("七百三十八", 738)
  end

  it "七百三十九" do
    compare_kanji_and_integer("七百三十九", 739)
  end

  it "七百四十" do
    compare_kanji_and_integer("七百四十", 740)
  end

  it "七百四十一" do
    compare_kanji_and_integer("七百四十一", 741)
  end

  it "七百四十二" do
    compare_kanji_and_integer("七百四十二", 742)
  end

  it "七百四十三" do
    compare_kanji_and_integer("七百四十三", 743)
  end

  it "七百四十四" do
    compare_kanji_and_integer("七百四十四", 744)
  end

  it "七百四十五" do
    compare_kanji_and_integer("七百四十五", 745)
  end

  it "七百四十六" do
    compare_kanji_and_integer("七百四十六", 746)
  end

  it "七百四十七" do
    compare_kanji_and_integer("七百四十七", 747)
  end

  it "七百四十八" do
    compare_kanji_and_integer("七百四十八", 748)
  end

  it "七百四十九" do
    compare_kanji_and_integer("七百四十九", 749)
  end

  it "七百五十" do
    compare_kanji_and_integer("七百五十", 750)
  end

  it "七百五十一" do
    compare_kanji_and_integer("七百五十一", 751)
  end

  it "七百五十二" do
    compare_kanji_and_integer("七百五十二", 752)
  end

  it "七百五十三" do
    compare_kanji_and_integer("七百五十三", 753)
  end

  it "七百五十四" do
    compare_kanji_and_integer("七百五十四", 754)
  end

  it "七百五十五" do
    compare_kanji_and_integer("七百五十五", 755)
  end

  it "七百五十六" do
    compare_kanji_and_integer("七百五十六", 756)
  end

  it "七百五十七" do
    compare_kanji_and_integer("七百五十七", 757)
  end

  it "七百五十八" do
    compare_kanji_and_integer("七百五十八", 758)
  end

  it "七百五十九" do
    compare_kanji_and_integer("七百五十九", 759)
  end

  it "七百六十" do
    compare_kanji_and_integer("七百六十", 760)
  end

  it "七百六十一" do
    compare_kanji_and_integer("七百六十一", 761)
  end

  it "七百六十二" do
    compare_kanji_and_integer("七百六十二", 762)
  end

  it "七百六十三" do
    compare_kanji_and_integer("七百六十三", 763)
  end

  it "七百六十四" do
    compare_kanji_and_integer("七百六十四", 764)
  end

  it "七百六十五" do
    compare_kanji_and_integer("七百六十五", 765)
  end

  it "七百六十六" do
    compare_kanji_and_integer("七百六十六", 766)
  end

  it "七百六十七" do
    compare_kanji_and_integer("七百六十七", 767)
  end

  it "七百六十八" do
    compare_kanji_and_integer("七百六十八", 768)
  end

  it "七百六十九" do
    compare_kanji_and_integer("七百六十九", 769)
  end

  it "七百七十" do
    compare_kanji_and_integer("七百七十", 770)
  end

  it "七百七十一" do
    compare_kanji_and_integer("七百七十一", 771)
  end

  it "七百七十二" do
    compare_kanji_and_integer("七百七十二", 772)
  end

  it "七百七十三" do
    compare_kanji_and_integer("七百七十三", 773)
  end

  it "七百七十四" do
    compare_kanji_and_integer("七百七十四", 774)
  end

  it "七百七十五" do
    compare_kanji_and_integer("七百七十五", 775)
  end

  it "七百七十六" do
    compare_kanji_and_integer("七百七十六", 776)
  end

  it "七百七十七" do
    compare_kanji_and_integer("七百七十七", 777)
  end

  it "七百七十八" do
    compare_kanji_and_integer("七百七十八", 778)
  end

  it "七百七十九" do
    compare_kanji_and_integer("七百七十九", 779)
  end

  it "七百八十" do
    compare_kanji_and_integer("七百八十", 780)
  end

  it "七百八十一" do
    compare_kanji_and_integer("七百八十一", 781)
  end

  it "七百八十二" do
    compare_kanji_and_integer("七百八十二", 782)
  end

  it "七百八十三" do
    compare_kanji_and_integer("七百八十三", 783)
  end

  it "七百八十四" do
    compare_kanji_and_integer("七百八十四", 784)
  end

  it "七百八十五" do
    compare_kanji_and_integer("七百八十五", 785)
  end

  it "七百八十六" do
    compare_kanji_and_integer("七百八十六", 786)
  end

  it "七百八十七" do
    compare_kanji_and_integer("七百八十七", 787)
  end

  it "七百八十八" do
    compare_kanji_and_integer("七百八十八", 788)
  end

  it "七百八十九" do
    compare_kanji_and_integer("七百八十九", 789)
  end

  it "七百九十" do
    compare_kanji_and_integer("七百九十", 790)
  end

  it "七百九十一" do
    compare_kanji_and_integer("七百九十一", 791)
  end

  it "七百九十二" do
    compare_kanji_and_integer("七百九十二", 792)
  end

  it "七百九十三" do
    compare_kanji_and_integer("七百九十三", 793)
  end

  it "七百九十四" do
    compare_kanji_and_integer("七百九十四", 794)
  end

  it "七百九十五" do
    compare_kanji_and_integer("七百九十五", 795)
  end

  it "七百九十六" do
    compare_kanji_and_integer("七百九十六", 796)
  end

  it "七百九十七" do
    compare_kanji_and_integer("七百九十七", 797)
  end

  it "七百九十八" do
    compare_kanji_and_integer("七百九十八", 798)
  end

  it "七百九十九" do
    compare_kanji_and_integer("七百九十九", 799)
  end

  it "八百" do
    compare_kanji_and_integer("八百", 800)
  end

  it "八百一" do
    compare_kanji_and_integer("八百一", 801)
  end

  it "八百二" do
    compare_kanji_and_integer("八百二", 802)
  end

  it "八百三" do
    compare_kanji_and_integer("八百三", 803)
  end

  it "八百四" do
    compare_kanji_and_integer("八百四", 804)
  end

  it "八百五" do
    compare_kanji_and_integer("八百五", 805)
  end

  it "八百六" do
    compare_kanji_and_integer("八百六", 806)
  end

  it "八百七" do
    compare_kanji_and_integer("八百七", 807)
  end

  it "八百八" do
    compare_kanji_and_integer("八百八", 808)
  end

  it "八百九" do
    compare_kanji_and_integer("八百九", 809)
  end

  it "八百十" do
    compare_kanji_and_integer("八百十", 810)
  end

  it "八百十一" do
    compare_kanji_and_integer("八百十一", 811)
  end

  it "八百十二" do
    compare_kanji_and_integer("八百十二", 812)
  end

  it "八百十三" do
    compare_kanji_and_integer("八百十三", 813)
  end

  it "八百十四" do
    compare_kanji_and_integer("八百十四", 814)
  end

  it "八百十五" do
    compare_kanji_and_integer("八百十五", 815)
  end

  it "八百十六" do
    compare_kanji_and_integer("八百十六", 816)
  end

  it "八百十七" do
    compare_kanji_and_integer("八百十七", 817)
  end

  it "八百十八" do
    compare_kanji_and_integer("八百十八", 818)
  end

  it "八百十九" do
    compare_kanji_and_integer("八百十九", 819)
  end

  it "八百二十" do
    compare_kanji_and_integer("八百二十", 820)
  end

  it "八百二十一" do
    compare_kanji_and_integer("八百二十一", 821)
  end

  it "八百二十二" do
    compare_kanji_and_integer("八百二十二", 822)
  end

  it "八百二十三" do
    compare_kanji_and_integer("八百二十三", 823)
  end

  it "八百二十四" do
    compare_kanji_and_integer("八百二十四", 824)
  end

  it "八百二十五" do
    compare_kanji_and_integer("八百二十五", 825)
  end

  it "八百二十六" do
    compare_kanji_and_integer("八百二十六", 826)
  end

  it "八百二十七" do
    compare_kanji_and_integer("八百二十七", 827)
  end

  it "八百二十八" do
    compare_kanji_and_integer("八百二十八", 828)
  end

  it "八百二十九" do
    compare_kanji_and_integer("八百二十九", 829)
  end

  it "八百三十" do
    compare_kanji_and_integer("八百三十", 830)
  end

  it "八百三十一" do
    compare_kanji_and_integer("八百三十一", 831)
  end

  it "八百三十二" do
    compare_kanji_and_integer("八百三十二", 832)
  end

  it "八百三十三" do
    compare_kanji_and_integer("八百三十三", 833)
  end

  it "八百三十四" do
    compare_kanji_and_integer("八百三十四", 834)
  end

  it "八百三十五" do
    compare_kanji_and_integer("八百三十五", 835)
  end

  it "八百三十六" do
    compare_kanji_and_integer("八百三十六", 836)
  end

  it "八百三十七" do
    compare_kanji_and_integer("八百三十七", 837)
  end

  it "八百三十八" do
    compare_kanji_and_integer("八百三十八", 838)
  end

  it "八百三十九" do
    compare_kanji_and_integer("八百三十九", 839)
  end

  it "八百四十" do
    compare_kanji_and_integer("八百四十", 840)
  end

  it "八百四十一" do
    compare_kanji_and_integer("八百四十一", 841)
  end

  it "八百四十二" do
    compare_kanji_and_integer("八百四十二", 842)
  end

  it "八百四十三" do
    compare_kanji_and_integer("八百四十三", 843)
  end

  it "八百四十四" do
    compare_kanji_and_integer("八百四十四", 844)
  end

  it "八百四十五" do
    compare_kanji_and_integer("八百四十五", 845)
  end

  it "八百四十六" do
    compare_kanji_and_integer("八百四十六", 846)
  end

  it "八百四十七" do
    compare_kanji_and_integer("八百四十七", 847)
  end

  it "八百四十八" do
    compare_kanji_and_integer("八百四十八", 848)
  end

  it "八百四十九" do
    compare_kanji_and_integer("八百四十九", 849)
  end

  it "八百五十" do
    compare_kanji_and_integer("八百五十", 850)
  end

  it "八百五十一" do
    compare_kanji_and_integer("八百五十一", 851)
  end

  it "八百五十二" do
    compare_kanji_and_integer("八百五十二", 852)
  end

  it "八百五十三" do
    compare_kanji_and_integer("八百五十三", 853)
  end

  it "八百五十四" do
    compare_kanji_and_integer("八百五十四", 854)
  end

  it "八百五十五" do
    compare_kanji_and_integer("八百五十五", 855)
  end

  it "八百五十六" do
    compare_kanji_and_integer("八百五十六", 856)
  end

  it "八百五十七" do
    compare_kanji_and_integer("八百五十七", 857)
  end

  it "八百五十八" do
    compare_kanji_and_integer("八百五十八", 858)
  end

  it "八百五十九" do
    compare_kanji_and_integer("八百五十九", 859)
  end

  it "八百六十" do
    compare_kanji_and_integer("八百六十", 860)
  end

  it "八百六十一" do
    compare_kanji_and_integer("八百六十一", 861)
  end

  it "八百六十二" do
    compare_kanji_and_integer("八百六十二", 862)
  end

  it "八百六十三" do
    compare_kanji_and_integer("八百六十三", 863)
  end

  it "八百六十四" do
    compare_kanji_and_integer("八百六十四", 864)
  end

  it "八百六十五" do
    compare_kanji_and_integer("八百六十五", 865)
  end

  it "八百六十六" do
    compare_kanji_and_integer("八百六十六", 866)
  end

  it "八百六十七" do
    compare_kanji_and_integer("八百六十七", 867)
  end

  it "八百六十八" do
    compare_kanji_and_integer("八百六十八", 868)
  end

  it "八百六十九" do
    compare_kanji_and_integer("八百六十九", 869)
  end

  it "八百七十" do
    compare_kanji_and_integer("八百七十", 870)
  end

  it "八百七十一" do
    compare_kanji_and_integer("八百七十一", 871)
  end

  it "八百七十二" do
    compare_kanji_and_integer("八百七十二", 872)
  end

  it "八百七十三" do
    compare_kanji_and_integer("八百七十三", 873)
  end

  it "八百七十四" do
    compare_kanji_and_integer("八百七十四", 874)
  end

  it "八百七十五" do
    compare_kanji_and_integer("八百七十五", 875)
  end

  it "八百七十六" do
    compare_kanji_and_integer("八百七十六", 876)
  end

  it "八百七十七" do
    compare_kanji_and_integer("八百七十七", 877)
  end

  it "八百七十八" do
    compare_kanji_and_integer("八百七十八", 878)
  end

  it "八百七十九" do
    compare_kanji_and_integer("八百七十九", 879)
  end

  it "八百八十" do
    compare_kanji_and_integer("八百八十", 880)
  end

  it "八百八十一" do
    compare_kanji_and_integer("八百八十一", 881)
  end

  it "八百八十二" do
    compare_kanji_and_integer("八百八十二", 882)
  end

  it "八百八十三" do
    compare_kanji_and_integer("八百八十三", 883)
  end

  it "八百八十四" do
    compare_kanji_and_integer("八百八十四", 884)
  end

  it "八百八十五" do
    compare_kanji_and_integer("八百八十五", 885)
  end

  it "八百八十六" do
    compare_kanji_and_integer("八百八十六", 886)
  end

  it "八百八十七" do
    compare_kanji_and_integer("八百八十七", 887)
  end

  it "八百八十八" do
    compare_kanji_and_integer("八百八十八", 888)
  end

  it "八百八十九" do
    compare_kanji_and_integer("八百八十九", 889)
  end

  it "八百九十" do
    compare_kanji_and_integer("八百九十", 890)
  end

  it "八百九十一" do
    compare_kanji_and_integer("八百九十一", 891)
  end

  it "八百九十二" do
    compare_kanji_and_integer("八百九十二", 892)
  end

  it "八百九十三" do
    compare_kanji_and_integer("八百九十三", 893)
  end

  it "八百九十四" do
    compare_kanji_and_integer("八百九十四", 894)
  end

  it "八百九十五" do
    compare_kanji_and_integer("八百九十五", 895)
  end

  it "八百九十六" do
    compare_kanji_and_integer("八百九十六", 896)
  end

  it "八百九十七" do
    compare_kanji_and_integer("八百九十七", 897)
  end

  it "八百九十八" do
    compare_kanji_and_integer("八百九十八", 898)
  end

  it "八百九十九" do
    compare_kanji_and_integer("八百九十九", 899)
  end

  it "九百" do
    compare_kanji_and_integer("九百", 900)
  end

  it "九百一" do
    compare_kanji_and_integer("九百一", 901)
  end

  it "九百二" do
    compare_kanji_and_integer("九百二", 902)
  end

  it "九百三" do
    compare_kanji_and_integer("九百三", 903)
  end

  it "九百四" do
    compare_kanji_and_integer("九百四", 904)
  end

  it "九百五" do
    compare_kanji_and_integer("九百五", 905)
  end

  it "九百六" do
    compare_kanji_and_integer("九百六", 906)
  end

  it "九百七" do
    compare_kanji_and_integer("九百七", 907)
  end

  it "九百八" do
    compare_kanji_and_integer("九百八", 908)
  end

  it "九百九" do
    compare_kanji_and_integer("九百九", 909)
  end

  it "九百十" do
    compare_kanji_and_integer("九百十", 910)
  end

  it "九百十一" do
    compare_kanji_and_integer("九百十一", 911)
  end

  it "九百十二" do
    compare_kanji_and_integer("九百十二", 912)
  end

  it "九百十三" do
    compare_kanji_and_integer("九百十三", 913)
  end

  it "九百十四" do
    compare_kanji_and_integer("九百十四", 914)
  end

  it "九百十五" do
    compare_kanji_and_integer("九百十五", 915)
  end

  it "九百十六" do
    compare_kanji_and_integer("九百十六", 916)
  end

  it "九百十七" do
    compare_kanji_and_integer("九百十七", 917)
  end

  it "九百十八" do
    compare_kanji_and_integer("九百十八", 918)
  end

  it "九百十九" do
    compare_kanji_and_integer("九百十九", 919)
  end

  it "九百二十" do
    compare_kanji_and_integer("九百二十", 920)
  end

  it "九百二十一" do
    compare_kanji_and_integer("九百二十一", 921)
  end

  it "九百二十二" do
    compare_kanji_and_integer("九百二十二", 922)
  end

  it "九百二十三" do
    compare_kanji_and_integer("九百二十三", 923)
  end

  it "九百二十四" do
    compare_kanji_and_integer("九百二十四", 924)
  end

  it "九百二十五" do
    compare_kanji_and_integer("九百二十五", 925)
  end

  it "九百二十六" do
    compare_kanji_and_integer("九百二十六", 926)
  end

  it "九百二十七" do
    compare_kanji_and_integer("九百二十七", 927)
  end

  it "九百二十八" do
    compare_kanji_and_integer("九百二十八", 928)
  end

  it "九百二十九" do
    compare_kanji_and_integer("九百二十九", 929)
  end

  it "九百三十" do
    compare_kanji_and_integer("九百三十", 930)
  end

  it "九百三十一" do
    compare_kanji_and_integer("九百三十一", 931)
  end

  it "九百三十二" do
    compare_kanji_and_integer("九百三十二", 932)
  end

  it "九百三十三" do
    compare_kanji_and_integer("九百三十三", 933)
  end

  it "九百三十四" do
    compare_kanji_and_integer("九百三十四", 934)
  end

  it "九百三十五" do
    compare_kanji_and_integer("九百三十五", 935)
  end

  it "九百三十六" do
    compare_kanji_and_integer("九百三十六", 936)
  end

  it "九百三十七" do
    compare_kanji_and_integer("九百三十七", 937)
  end

  it "九百三十八" do
    compare_kanji_and_integer("九百三十八", 938)
  end

  it "九百三十九" do
    compare_kanji_and_integer("九百三十九", 939)
  end

  it "九百四十" do
    compare_kanji_and_integer("九百四十", 940)
  end

  it "九百四十一" do
    compare_kanji_and_integer("九百四十一", 941)
  end

  it "九百四十二" do
    compare_kanji_and_integer("九百四十二", 942)
  end

  it "九百四十三" do
    compare_kanji_and_integer("九百四十三", 943)
  end

  it "九百四十四" do
    compare_kanji_and_integer("九百四十四", 944)
  end

  it "九百四十五" do
    compare_kanji_and_integer("九百四十五", 945)
  end

  it "九百四十六" do
    compare_kanji_and_integer("九百四十六", 946)
  end

  it "九百四十七" do
    compare_kanji_and_integer("九百四十七", 947)
  end

  it "九百四十八" do
    compare_kanji_and_integer("九百四十八", 948)
  end

  it "九百四十九" do
    compare_kanji_and_integer("九百四十九", 949)
  end

  it "九百五十" do
    compare_kanji_and_integer("九百五十", 950)
  end

  it "九百五十一" do
    compare_kanji_and_integer("九百五十一", 951)
  end

  it "九百五十二" do
    compare_kanji_and_integer("九百五十二", 952)
  end

  it "九百五十三" do
    compare_kanji_and_integer("九百五十三", 953)
  end

  it "九百五十四" do
    compare_kanji_and_integer("九百五十四", 954)
  end

  it "九百五十五" do
    compare_kanji_and_integer("九百五十五", 955)
  end

  it "九百五十六" do
    compare_kanji_and_integer("九百五十六", 956)
  end

  it "九百五十七" do
    compare_kanji_and_integer("九百五十七", 957)
  end

  it "九百五十八" do
    compare_kanji_and_integer("九百五十八", 958)
  end

  it "九百五十九" do
    compare_kanji_and_integer("九百五十九", 959)
  end

  it "九百六十" do
    compare_kanji_and_integer("九百六十", 960)
  end

  it "九百六十一" do
    compare_kanji_and_integer("九百六十一", 961)
  end

  it "九百六十二" do
    compare_kanji_and_integer("九百六十二", 962)
  end

  it "九百六十三" do
    compare_kanji_and_integer("九百六十三", 963)
  end

  it "九百六十四" do
    compare_kanji_and_integer("九百六十四", 964)
  end

  it "九百六十五" do
    compare_kanji_and_integer("九百六十五", 965)
  end

  it "九百六十六" do
    compare_kanji_and_integer("九百六十六", 966)
  end

  it "九百六十七" do
    compare_kanji_and_integer("九百六十七", 967)
  end

  it "九百六十八" do
    compare_kanji_and_integer("九百六十八", 968)
  end

  it "九百六十九" do
    compare_kanji_and_integer("九百六十九", 969)
  end

  it "九百七十" do
    compare_kanji_and_integer("九百七十", 970)
  end

  it "九百七十一" do
    compare_kanji_and_integer("九百七十一", 971)
  end

  it "九百七十二" do
    compare_kanji_and_integer("九百七十二", 972)
  end

  it "九百七十三" do
    compare_kanji_and_integer("九百七十三", 973)
  end

  it "九百七十四" do
    compare_kanji_and_integer("九百七十四", 974)
  end

  it "九百七十五" do
    compare_kanji_and_integer("九百七十五", 975)
  end

  it "九百七十六" do
    compare_kanji_and_integer("九百七十六", 976)
  end

  it "九百七十七" do
    compare_kanji_and_integer("九百七十七", 977)
  end

  it "九百七十八" do
    compare_kanji_and_integer("九百七十八", 978)
  end

  it "九百七十九" do
    compare_kanji_and_integer("九百七十九", 979)
  end

  it "九百八十" do
    compare_kanji_and_integer("九百八十", 980)
  end

  it "九百八十一" do
    compare_kanji_and_integer("九百八十一", 981)
  end

  it "九百八十二" do
    compare_kanji_and_integer("九百八十二", 982)
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

  it "千百五十七" do
    compare_kanji_and_integer("千百五十七", 1157)
  end

  it "千百五十八" do
    compare_kanji_and_integer("千百五十八", 1158)
  end

  it "千百五十九" do
    compare_kanji_and_integer("千百五十九", 1159)
  end

  it "千百六十" do
    compare_kanji_and_integer("千百六十", 1160)
  end

  it "千百六十一" do
    compare_kanji_and_integer("千百六十一", 1161)
  end

  it "千百六十二" do
    compare_kanji_and_integer("千百六十二", 1162)
  end

  it "千百六十三" do
    compare_kanji_and_integer("千百六十三", 1163)
  end

  it "千百六十四" do
    compare_kanji_and_integer("千百六十四", 1164)
  end

  it "千百六十五" do
    compare_kanji_and_integer("千百六十五", 1165)
  end

  it "千百六十六" do
    compare_kanji_and_integer("千百六十六", 1166)
  end

  it "千百六十七" do
    compare_kanji_and_integer("千百六十七", 1167)
  end

  it "千百六十八" do
    compare_kanji_and_integer("千百六十八", 1168)
  end

  it "千百六十九" do
    compare_kanji_and_integer("千百六十九", 1169)
  end

  it "千百七十" do
    compare_kanji_and_integer("千百七十", 1170)
  end

  it "千百七十一" do
    compare_kanji_and_integer("千百七十一", 1171)
  end

  it "千百七十二" do
    compare_kanji_and_integer("千百七十二", 1172)
  end

  it "千百七十三" do
    compare_kanji_and_integer("千百七十三", 1173)
  end

  it "千百七十四" do
    compare_kanji_and_integer("千百七十四", 1174)
  end

  it "千百七十五" do
    compare_kanji_and_integer("千百七十五", 1175)
  end

  it "千百七十六" do
    compare_kanji_and_integer("千百七十六", 1176)
  end

  it "千百七十七" do
    compare_kanji_and_integer("千百七十七", 1177)
  end

  it "千百七十八" do
    compare_kanji_and_integer("千百七十八", 1178)
  end

  it "千百七十九" do
    compare_kanji_and_integer("千百七十九", 1179)
  end

  it "千百八十" do
    compare_kanji_and_integer("千百八十", 1180)
  end

  it "千百八十一" do
    compare_kanji_and_integer("千百八十一", 1181)
  end

  it "千百八十二" do
    compare_kanji_and_integer("千百八十二", 1182)
  end

  it "千百八十三" do
    compare_kanji_and_integer("千百八十三", 1183)
  end

  it "千百八十四" do
    compare_kanji_and_integer("千百八十四", 1184)
  end

  it "千百八十五" do
    compare_kanji_and_integer("千百八十五", 1185)
  end

  it "千百八十六" do
    compare_kanji_and_integer("千百八十六", 1186)
  end

  it "千百八十七" do
    compare_kanji_and_integer("千百八十七", 1187)
  end

  it "千百八十八" do
    compare_kanji_and_integer("千百八十八", 1188)
  end

  it "千百八十九" do
    compare_kanji_and_integer("千百八十九", 1189)
  end

  it "千百九十" do
    compare_kanji_and_integer("千百九十", 1190)
  end

  it "千百九十一" do
    compare_kanji_and_integer("千百九十一", 1191)
  end

  it "千百九十二" do
    compare_kanji_and_integer("千百九十二", 1192)
  end

  it "千百九十三" do
    compare_kanji_and_integer("千百九十三", 1193)
  end

  it "千百九十四" do
    compare_kanji_and_integer("千百九十四", 1194)
  end

  it "千百九十五" do
    compare_kanji_and_integer("千百九十五", 1195)
  end

  it "千百九十六" do
    compare_kanji_and_integer("千百九十六", 1196)
  end

  it "千百九十七" do
    compare_kanji_and_integer("千百九十七", 1197)
  end

  it "千百九十八" do
    compare_kanji_and_integer("千百九十八", 1198)
  end

  it "千百九十九" do
    compare_kanji_and_integer("千百九十九", 1199)
  end

  it "千二百" do
    compare_kanji_and_integer("千二百", 1200)
  end

  it "千二百一" do
    compare_kanji_and_integer("千二百一", 1201)
  end

  it "千二百二" do
    compare_kanji_and_integer("千二百二", 1202)
  end

  it "千二百三" do
    compare_kanji_and_integer("千二百三", 1203)
  end

  it "千二百四" do
    compare_kanji_and_integer("千二百四", 1204)
  end

  it "千二百五" do
    compare_kanji_and_integer("千二百五", 1205)
  end

  it "千二百六" do
    compare_kanji_and_integer("千二百六", 1206)
  end

  it "千二百七" do
    compare_kanji_and_integer("千二百七", 1207)
  end

  it "千二百八" do
    compare_kanji_and_integer("千二百八", 1208)
  end

  it "千二百九" do
    compare_kanji_and_integer("千二百九", 1209)
  end

  it "千二百十" do
    compare_kanji_and_integer("千二百十", 1210)
  end

  it "千二百十一" do
    compare_kanji_and_integer("千二百十一", 1211)
  end

  it "千二百十二" do
    compare_kanji_and_integer("千二百十二", 1212)
  end

  it "千二百十三" do
    compare_kanji_and_integer("千二百十三", 1213)
  end

  it "千二百十四" do
    compare_kanji_and_integer("千二百十四", 1214)
  end

  it "千二百十五" do
    compare_kanji_and_integer("千二百十五", 1215)
  end

  it "千二百十六" do
    compare_kanji_and_integer("千二百十六", 1216)
  end

  it "千二百十七" do
    compare_kanji_and_integer("千二百十七", 1217)
  end

  it "千二百十八" do
    compare_kanji_and_integer("千二百十八", 1218)
  end

  it "千二百十九" do
    compare_kanji_and_integer("千二百十九", 1219)
  end

  it "千二百二十" do
    compare_kanji_and_integer("千二百二十", 1220)
  end

  it "千二百二十一" do
    compare_kanji_and_integer("千二百二十一", 1221)
  end

  it "千二百二十二" do
    compare_kanji_and_integer("千二百二十二", 1222)
  end

  it "千二百二十三" do
    compare_kanji_and_integer("千二百二十三", 1223)
  end

  it "千二百二十四" do
    compare_kanji_and_integer("千二百二十四", 1224)
  end

  it "千二百二十五" do
    compare_kanji_and_integer("千二百二十五", 1225)
  end

  it "千二百二十六" do
    compare_kanji_and_integer("千二百二十六", 1226)
  end

  it "千二百二十七" do
    compare_kanji_and_integer("千二百二十七", 1227)
  end

  it "千二百二十八" do
    compare_kanji_and_integer("千二百二十八", 1228)
  end

  it "千二百二十九" do
    compare_kanji_and_integer("千二百二十九", 1229)
  end

  it "千二百三十" do
    compare_kanji_and_integer("千二百三十", 1230)
  end

  it "千二百三十一" do
    compare_kanji_and_integer("千二百三十一", 1231)
  end

  it "千二百三十二" do
    compare_kanji_and_integer("千二百三十二", 1232)
  end

  it "千二百三十三" do
    compare_kanji_and_integer("千二百三十三", 1233)
  end

  it "千二百三十四" do
    compare_kanji_and_integer("千二百三十四", 1234)
  end

  it "千二百三十五" do
    compare_kanji_and_integer("千二百三十五", 1235)
  end

  it "千二百三十六" do
    compare_kanji_and_integer("千二百三十六", 1236)
  end

  it "千二百三十七" do
    compare_kanji_and_integer("千二百三十七", 1237)
  end

  it "千二百三十八" do
    compare_kanji_and_integer("千二百三十八", 1238)
  end

  it "千二百三十九" do
    compare_kanji_and_integer("千二百三十九", 1239)
  end

  it "千二百四十" do
    compare_kanji_and_integer("千二百四十", 1240)
  end

  it "千二百四十一" do
    compare_kanji_and_integer("千二百四十一", 1241)
  end

  it "千二百四十二" do
    compare_kanji_and_integer("千二百四十二", 1242)
  end

  it "千二百四十三" do
    compare_kanji_and_integer("千二百四十三", 1243)
  end

  it "千二百四十四" do
    compare_kanji_and_integer("千二百四十四", 1244)
  end

  it "千二百四十五" do
    compare_kanji_and_integer("千二百四十五", 1245)
  end

  it "千二百四十六" do
    compare_kanji_and_integer("千二百四十六", 1246)
  end

  it "千二百四十七" do
    compare_kanji_and_integer("千二百四十七", 1247)
  end

  it "千二百四十八" do
    compare_kanji_and_integer("千二百四十八", 1248)
  end

  it "千二百四十九" do
    compare_kanji_and_integer("千二百四十九", 1249)
  end

  it "千二百五十" do
    compare_kanji_and_integer("千二百五十", 1250)
  end

  it "千二百五十一" do
    compare_kanji_and_integer("千二百五十一", 1251)
  end

  it "千二百五十二" do
    compare_kanji_and_integer("千二百五十二", 1252)
  end

  it "千二百五十三" do
    compare_kanji_and_integer("千二百五十三", 1253)
  end

  it "千二百五十四" do
    compare_kanji_and_integer("千二百五十四", 1254)
  end

  it "千二百五十五" do
    compare_kanji_and_integer("千二百五十五", 1255)
  end

  it "千二百五十六" do
    compare_kanji_and_integer("千二百五十六", 1256)
  end

  it "千二百五十七" do
    compare_kanji_and_integer("千二百五十七", 1257)
  end

  it "千二百五十八" do
    compare_kanji_and_integer("千二百五十八", 1258)
  end

  it "千二百五十九" do
    compare_kanji_and_integer("千二百五十九", 1259)
  end

  it "千二百六十" do
    compare_kanji_and_integer("千二百六十", 1260)
  end

  it "千二百六十一" do
    compare_kanji_and_integer("千二百六十一", 1261)
  end

  it "千二百六十二" do
    compare_kanji_and_integer("千二百六十二", 1262)
  end

  it "千二百六十三" do
    compare_kanji_and_integer("千二百六十三", 1263)
  end

  it "千二百六十四" do
    compare_kanji_and_integer("千二百六十四", 1264)
  end

  it "千二百六十五" do
    compare_kanji_and_integer("千二百六十五", 1265)
  end

  it "千二百六十六" do
    compare_kanji_and_integer("千二百六十六", 1266)
  end

  it "千二百六十七" do
    compare_kanji_and_integer("千二百六十七", 1267)
  end

  it "千二百六十八" do
    compare_kanji_and_integer("千二百六十八", 1268)
  end

  it "千二百六十九" do
    compare_kanji_and_integer("千二百六十九", 1269)
  end

  it "千二百七十" do
    compare_kanji_and_integer("千二百七十", 1270)
  end

  it "千二百七十一" do
    compare_kanji_and_integer("千二百七十一", 1271)
  end

  it "千二百七十二" do
    compare_kanji_and_integer("千二百七十二", 1272)
  end

  it "千二百七十三" do
    compare_kanji_and_integer("千二百七十三", 1273)
  end

  it "千二百七十四" do
    compare_kanji_and_integer("千二百七十四", 1274)
  end

  it "千二百七十五" do
    compare_kanji_and_integer("千二百七十五", 1275)
  end

  it "千二百七十六" do
    compare_kanji_and_integer("千二百七十六", 1276)
  end

  it "千二百七十七" do
    compare_kanji_and_integer("千二百七十七", 1277)
  end

  it "千二百七十八" do
    compare_kanji_and_integer("千二百七十八", 1278)
  end

  it "千二百七十九" do
    compare_kanji_and_integer("千二百七十九", 1279)
  end

  it "千二百八十" do
    compare_kanji_and_integer("千二百八十", 1280)
  end

  it "千二百八十一" do
    compare_kanji_and_integer("千二百八十一", 1281)
  end

  it "千二百八十二" do
    compare_kanji_and_integer("千二百八十二", 1282)
  end

  it "千二百八十三" do
    compare_kanji_and_integer("千二百八十三", 1283)
  end

  it "千二百八十四" do
    compare_kanji_and_integer("千二百八十四", 1284)
  end

  it "千二百八十五" do
    compare_kanji_and_integer("千二百八十五", 1285)
  end

  it "千二百八十六" do
    compare_kanji_and_integer("千二百八十六", 1286)
  end

  it "千二百八十七" do
    compare_kanji_and_integer("千二百八十七", 1287)
  end

  it "千二百八十八" do
    compare_kanji_and_integer("千二百八十八", 1288)
  end

  it "千二百八十九" do
    compare_kanji_and_integer("千二百八十九", 1289)
  end

  it "千二百九十" do
    compare_kanji_and_integer("千二百九十", 1290)
  end

  it "千二百九十一" do
    compare_kanji_and_integer("千二百九十一", 1291)
  end

  it "千二百九十二" do
    compare_kanji_and_integer("千二百九十二", 1292)
  end

  it "千二百九十三" do
    compare_kanji_and_integer("千二百九十三", 1293)
  end

  it "千二百九十四" do
    compare_kanji_and_integer("千二百九十四", 1294)
  end

  it "千二百九十五" do
    compare_kanji_and_integer("千二百九十五", 1295)
  end

  it "千二百九十六" do
    compare_kanji_and_integer("千二百九十六", 1296)
  end

  it "千二百九十七" do
    compare_kanji_and_integer("千二百九十七", 1297)
  end

  it "千二百九十八" do
    compare_kanji_and_integer("千二百九十八", 1298)
  end

  it "千二百九十九" do
    compare_kanji_and_integer("千二百九十九", 1299)
  end

  it "千三百" do
    compare_kanji_and_integer("千三百", 1300)
  end

  it "千三百一" do
    compare_kanji_and_integer("千三百一", 1301)
  end

  it "千三百二" do
    compare_kanji_and_integer("千三百二", 1302)
  end

  it "千三百三" do
    compare_kanji_and_integer("千三百三", 1303)
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

  it "千三百六十一" do
    compare_kanji_and_integer("千三百六十一", 1361)
  end

  it "千三百六十二" do
    compare_kanji_and_integer("千三百六十二", 1362)
  end

  it "千三百六十三" do
    compare_kanji_and_integer("千三百六十三", 1363)
  end

  it "千三百六十四" do
    compare_kanji_and_integer("千三百六十四", 1364)
  end

  it "千三百六十五" do
    compare_kanji_and_integer("千三百六十五", 1365)
  end

  it "千三百六十六" do
    compare_kanji_and_integer("千三百六十六", 1366)
  end

  it "千三百六十七" do
    compare_kanji_and_integer("千三百六十七", 1367)
  end

  it "千三百六十八" do
    compare_kanji_and_integer("千三百六十八", 1368)
  end

  it "千三百六十九" do
    compare_kanji_and_integer("千三百六十九", 1369)
  end

  it "千三百七十" do
    compare_kanji_and_integer("千三百七十", 1370)
  end

  it "千三百七十一" do
    compare_kanji_and_integer("千三百七十一", 1371)
  end

  it "千三百七十二" do
    compare_kanji_and_integer("千三百七十二", 1372)
  end

  it "千三百七十三" do
    compare_kanji_and_integer("千三百七十三", 1373)
  end

  it "千三百七十四" do
    compare_kanji_and_integer("千三百七十四", 1374)
  end

  it "千三百七十五" do
    compare_kanji_and_integer("千三百七十五", 1375)
  end

  it "千三百七十六" do
    compare_kanji_and_integer("千三百七十六", 1376)
  end

  it "千三百七十七" do
    compare_kanji_and_integer("千三百七十七", 1377)
  end

  it "千三百七十八" do
    compare_kanji_and_integer("千三百七十八", 1378)
  end

  it "千三百七十九" do
    compare_kanji_and_integer("千三百七十九", 1379)
  end

  it "千三百八十" do
    compare_kanji_and_integer("千三百八十", 1380)
  end

  it "千三百八十一" do
    compare_kanji_and_integer("千三百八十一", 1381)
  end

  it "千三百八十二" do
    compare_kanji_and_integer("千三百八十二", 1382)
  end

  it "千三百八十三" do
    compare_kanji_and_integer("千三百八十三", 1383)
  end

  it "千三百八十四" do
    compare_kanji_and_integer("千三百八十四", 1384)
  end

  it "千三百八十五" do
    compare_kanji_and_integer("千三百八十五", 1385)
  end

  it "千三百八十六" do
    compare_kanji_and_integer("千三百八十六", 1386)
  end

  it "千三百八十七" do
    compare_kanji_and_integer("千三百八十七", 1387)
  end

  it "千三百八十八" do
    compare_kanji_and_integer("千三百八十八", 1388)
  end

  it "千三百八十九" do
    compare_kanji_and_integer("千三百八十九", 1389)
  end

  it "千三百九十" do
    compare_kanji_and_integer("千三百九十", 1390)
  end

  it "千三百九十一" do
    compare_kanji_and_integer("千三百九十一", 1391)
  end

  it "千三百九十二" do
    compare_kanji_and_integer("千三百九十二", 1392)
  end

  it "千三百九十三" do
    compare_kanji_and_integer("千三百九十三", 1393)
  end

  it "千三百九十四" do
    compare_kanji_and_integer("千三百九十四", 1394)
  end

  it "千三百九十五" do
    compare_kanji_and_integer("千三百九十五", 1395)
  end

  it "千三百九十六" do
    compare_kanji_and_integer("千三百九十六", 1396)
  end

  it "千三百九十七" do
    compare_kanji_and_integer("千三百九十七", 1397)
  end

  it "千三百九十八" do
    compare_kanji_and_integer("千三百九十八", 1398)
  end

  it "千三百九十九" do
    compare_kanji_and_integer("千三百九十九", 1399)
  end

  it "千四百" do
    compare_kanji_and_integer("千四百", 1400)
  end

  it "千四百一" do
    compare_kanji_and_integer("千四百一", 1401)
  end

  it "千四百二" do
    compare_kanji_and_integer("千四百二", 1402)
  end

  it "千四百三" do
    compare_kanji_and_integer("千四百三", 1403)
  end

  it "千四百四" do
    compare_kanji_and_integer("千四百四", 1404)
  end

  it "千四百五" do
    compare_kanji_and_integer("千四百五", 1405)
  end

  it "千四百六" do
    compare_kanji_and_integer("千四百六", 1406)
  end

  it "千四百七" do
    compare_kanji_and_integer("千四百七", 1407)
  end

  it "千四百八" do
    compare_kanji_and_integer("千四百八", 1408)
  end

  it "千四百九" do
    compare_kanji_and_integer("千四百九", 1409)
  end

  it "千四百十" do
    compare_kanji_and_integer("千四百十", 1410)
  end

  it "千四百十一" do
    compare_kanji_and_integer("千四百十一", 1411)
  end

  it "千四百十二" do
    compare_kanji_and_integer("千四百十二", 1412)
  end

  it "千四百十三" do
    compare_kanji_and_integer("千四百十三", 1413)
  end

  it "千四百十四" do
    compare_kanji_and_integer("千四百十四", 1414)
  end

  it "千四百十五" do
    compare_kanji_and_integer("千四百十五", 1415)
  end

  it "千四百十六" do
    compare_kanji_and_integer("千四百十六", 1416)
  end

  it "千四百十七" do
    compare_kanji_and_integer("千四百十七", 1417)
  end

  it "千四百十八" do
    compare_kanji_and_integer("千四百十八", 1418)
  end

  it "千四百十九" do
    compare_kanji_and_integer("千四百十九", 1419)
  end

  it "千四百二十" do
    compare_kanji_and_integer("千四百二十", 1420)
  end

  it "千四百二十一" do
    compare_kanji_and_integer("千四百二十一", 1421)
  end

  it "千四百二十二" do
    compare_kanji_and_integer("千四百二十二", 1422)
  end

  it "千四百二十三" do
    compare_kanji_and_integer("千四百二十三", 1423)
  end

  it "千四百二十四" do
    compare_kanji_and_integer("千四百二十四", 1424)
  end

  it "千四百二十五" do
    compare_kanji_and_integer("千四百二十五", 1425)
  end

  it "千四百二十六" do
    compare_kanji_and_integer("千四百二十六", 1426)
  end

  it "千四百二十七" do
    compare_kanji_and_integer("千四百二十七", 1427)
  end

  it "千四百二十八" do
    compare_kanji_and_integer("千四百二十八", 1428)
  end

  it "千四百二十九" do
    compare_kanji_and_integer("千四百二十九", 1429)
  end

  it "千四百三十" do
    compare_kanji_and_integer("千四百三十", 1430)
  end

  it "千四百三十一" do
    compare_kanji_and_integer("千四百三十一", 1431)
  end

  it "千四百三十二" do
    compare_kanji_and_integer("千四百三十二", 1432)
  end

  it "千四百三十三" do
    compare_kanji_and_integer("千四百三十三", 1433)
  end

  it "千四百三十四" do
    compare_kanji_and_integer("千四百三十四", 1434)
  end

  it "千四百三十五" do
    compare_kanji_and_integer("千四百三十五", 1435)
  end

  it "千四百三十六" do
    compare_kanji_and_integer("千四百三十六", 1436)
  end

  it "千四百三十七" do
    compare_kanji_and_integer("千四百三十七", 1437)
  end

  it "千四百三十八" do
    compare_kanji_and_integer("千四百三十八", 1438)
  end

  it "千四百三十九" do
    compare_kanji_and_integer("千四百三十九", 1439)
  end

  it "千四百四十" do
    compare_kanji_and_integer("千四百四十", 1440)
  end

  it "千四百四十一" do
    compare_kanji_and_integer("千四百四十一", 1441)
  end

  it "千四百四十二" do
    compare_kanji_and_integer("千四百四十二", 1442)
  end

  it "千四百四十三" do
    compare_kanji_and_integer("千四百四十三", 1443)
  end

  it "千四百四十四" do
    compare_kanji_and_integer("千四百四十四", 1444)
  end

  it "千四百四十五" do
    compare_kanji_and_integer("千四百四十五", 1445)
  end

  it "千四百四十六" do
    compare_kanji_and_integer("千四百四十六", 1446)
  end

  it "千四百四十七" do
    compare_kanji_and_integer("千四百四十七", 1447)
  end

  it "千四百四十八" do
    compare_kanji_and_integer("千四百四十八", 1448)
  end

  it "千四百四十九" do
    compare_kanji_and_integer("千四百四十九", 1449)
  end

  it "千四百五十" do
    compare_kanji_and_integer("千四百五十", 1450)
  end

  it "千四百五十一" do
    compare_kanji_and_integer("千四百五十一", 1451)
  end

  it "千四百五十二" do
    compare_kanji_and_integer("千四百五十二", 1452)
  end

  it "千四百五十三" do
    compare_kanji_and_integer("千四百五十三", 1453)
  end

  it "千四百五十四" do
    compare_kanji_and_integer("千四百五十四", 1454)
  end

  it "千四百五十五" do
    compare_kanji_and_integer("千四百五十五", 1455)
  end

  it "千四百五十六" do
    compare_kanji_and_integer("千四百五十六", 1456)
  end

  it "千四百五十七" do
    compare_kanji_and_integer("千四百五十七", 1457)
  end

  it "千四百五十八" do
    compare_kanji_and_integer("千四百五十八", 1458)
  end

  it "千四百五十九" do
    compare_kanji_and_integer("千四百五十九", 1459)
  end

  it "千四百六十" do
    compare_kanji_and_integer("千四百六十", 1460)
  end

  it "千四百六十一" do
    compare_kanji_and_integer("千四百六十一", 1461)
  end

  it "千四百六十二" do
    compare_kanji_and_integer("千四百六十二", 1462)
  end

  it "千四百六十三" do
    compare_kanji_and_integer("千四百六十三", 1463)
  end

  it "千四百六十四" do
    compare_kanji_and_integer("千四百六十四", 1464)
  end

  it "千四百六十五" do
    compare_kanji_and_integer("千四百六十五", 1465)
  end

  it "千四百六十六" do
    compare_kanji_and_integer("千四百六十六", 1466)
  end

  it "千四百六十七" do
    compare_kanji_and_integer("千四百六十七", 1467)
  end

  it "千四百六十八" do
    compare_kanji_and_integer("千四百六十八", 1468)
  end

  it "千四百六十九" do
    compare_kanji_and_integer("千四百六十九", 1469)
  end

  it "千四百七十" do
    compare_kanji_and_integer("千四百七十", 1470)
  end

  it "千四百七十一" do
    compare_kanji_and_integer("千四百七十一", 1471)
  end

  it "千四百七十二" do
    compare_kanji_and_integer("千四百七十二", 1472)
  end

  it "千四百七十三" do
    compare_kanji_and_integer("千四百七十三", 1473)
  end

  it "千四百七十四" do
    compare_kanji_and_integer("千四百七十四", 1474)
  end

  it "千四百七十五" do
    compare_kanji_and_integer("千四百七十五", 1475)
  end

  it "千四百七十六" do
    compare_kanji_and_integer("千四百七十六", 1476)
  end

  it "千四百七十七" do
    compare_kanji_and_integer("千四百七十七", 1477)
  end

  it "千四百七十八" do
    compare_kanji_and_integer("千四百七十八", 1478)
  end

  it "千四百七十九" do
    compare_kanji_and_integer("千四百七十九", 1479)
  end

  it "千四百八十" do
    compare_kanji_and_integer("千四百八十", 1480)
  end

  it "千四百八十一" do
    compare_kanji_and_integer("千四百八十一", 1481)
  end

  it "千四百八十二" do
    compare_kanji_and_integer("千四百八十二", 1482)
  end

  it "千四百八十三" do
    compare_kanji_and_integer("千四百八十三", 1483)
  end

  it "千四百八十四" do
    compare_kanji_and_integer("千四百八十四", 1484)
  end

  it "千四百八十五" do
    compare_kanji_and_integer("千四百八十五", 1485)
  end

  it "千四百八十六" do
    compare_kanji_and_integer("千四百八十六", 1486)
  end

  it "千四百八十七" do
    compare_kanji_and_integer("千四百八十七", 1487)
  end

  it "千四百八十八" do
    compare_kanji_and_integer("千四百八十八", 1488)
  end

  it "千四百八十九" do
    compare_kanji_and_integer("千四百八十九", 1489)
  end

  it "千四百九十" do
    compare_kanji_and_integer("千四百九十", 1490)
  end

  it "千四百九十一" do
    compare_kanji_and_integer("千四百九十一", 1491)
  end

  it "千四百九十二" do
    compare_kanji_and_integer("千四百九十二", 1492)
  end

  it "千四百九十三" do
    compare_kanji_and_integer("千四百九十三", 1493)
  end

  it "千四百九十四" do
    compare_kanji_and_integer("千四百九十四", 1494)
  end

  it "千四百九十五" do
    compare_kanji_and_integer("千四百九十五", 1495)
  end

  it "千四百九十六" do
    compare_kanji_and_integer("千四百九十六", 1496)
  end

  it "千四百九十七" do
    compare_kanji_and_integer("千四百九十七", 1497)
  end

  it "千四百九十八" do
    compare_kanji_and_integer("千四百九十八", 1498)
  end

  it "千四百九十九" do
    compare_kanji_and_integer("千四百九十九", 1499)
  end

  it "千五百" do
    compare_kanji_and_integer("千五百", 1500)
  end

  it "千五百一" do
    compare_kanji_and_integer("千五百一", 1501)
  end

  it "千五百二" do
    compare_kanji_and_integer("千五百二", 1502)
  end

  it "千五百三" do
    compare_kanji_and_integer("千五百三", 1503)
  end

  it "千五百四" do
    compare_kanji_and_integer("千五百四", 1504)
  end

  it "千五百五" do
    compare_kanji_and_integer("千五百五", 1505)
  end

  it "千五百六" do
    compare_kanji_and_integer("千五百六", 1506)
  end

  it "千五百七" do
    compare_kanji_and_integer("千五百七", 1507)
  end

  it "千五百八" do
    compare_kanji_and_integer("千五百八", 1508)
  end

  it "千五百九" do
    compare_kanji_and_integer("千五百九", 1509)
  end

  it "千五百十" do
    compare_kanji_and_integer("千五百十", 1510)
  end

  it "千五百十一" do
    compare_kanji_and_integer("千五百十一", 1511)
  end

  it "千五百十二" do
    compare_kanji_and_integer("千五百十二", 1512)
  end

  it "千五百十三" do
    compare_kanji_and_integer("千五百十三", 1513)
  end

  it "千五百十四" do
    compare_kanji_and_integer("千五百十四", 1514)
  end

  it "千五百十五" do
    compare_kanji_and_integer("千五百十五", 1515)
  end

  it "千五百十六" do
    compare_kanji_and_integer("千五百十六", 1516)
  end

  it "千五百十七" do
    compare_kanji_and_integer("千五百十七", 1517)
  end

  it "千五百十八" do
    compare_kanji_and_integer("千五百十八", 1518)
  end

  it "千五百十九" do
    compare_kanji_and_integer("千五百十九", 1519)
  end

  it "千五百二十" do
    compare_kanji_and_integer("千五百二十", 1520)
  end

  it "千五百二十一" do
    compare_kanji_and_integer("千五百二十一", 1521)
  end

  it "千五百二十二" do
    compare_kanji_and_integer("千五百二十二", 1522)
  end

  it "千五百二十三" do
    compare_kanji_and_integer("千五百二十三", 1523)
  end

  it "千五百二十四" do
    compare_kanji_and_integer("千五百二十四", 1524)
  end

  it "千五百二十五" do
    compare_kanji_and_integer("千五百二十五", 1525)
  end

  it "千五百二十六" do
    compare_kanji_and_integer("千五百二十六", 1526)
  end

  it "千五百二十七" do
    compare_kanji_and_integer("千五百二十七", 1527)
  end

  it "千五百二十八" do
    compare_kanji_and_integer("千五百二十八", 1528)
  end

  it "千五百二十九" do
    compare_kanji_and_integer("千五百二十九", 1529)
  end

  it "千五百三十" do
    compare_kanji_and_integer("千五百三十", 1530)
  end

  it "千五百三十一" do
    compare_kanji_and_integer("千五百三十一", 1531)
  end

  it "千五百三十二" do
    compare_kanji_and_integer("千五百三十二", 1532)
  end

  it "千五百三十三" do
    compare_kanji_and_integer("千五百三十三", 1533)
  end

  it "千五百三十四" do
    compare_kanji_and_integer("千五百三十四", 1534)
  end

  it "千五百三十五" do
    compare_kanji_and_integer("千五百三十五", 1535)
  end

  it "千五百三十六" do
    compare_kanji_and_integer("千五百三十六", 1536)
  end

  it "千五百三十七" do
    compare_kanji_and_integer("千五百三十七", 1537)
  end

  it "千五百三十八" do
    compare_kanji_and_integer("千五百三十八", 1538)
  end

  it "千五百三十九" do
    compare_kanji_and_integer("千五百三十九", 1539)
  end

  it "千五百四十" do
    compare_kanji_and_integer("千五百四十", 1540)
  end

  it "千五百四十一" do
    compare_kanji_and_integer("千五百四十一", 1541)
  end

  it "千五百四十二" do
    compare_kanji_and_integer("千五百四十二", 1542)
  end

  it "千五百四十三" do
    compare_kanji_and_integer("千五百四十三", 1543)
  end

  it "千五百四十四" do
    compare_kanji_and_integer("千五百四十四", 1544)
  end

  it "千五百四十五" do
    compare_kanji_and_integer("千五百四十五", 1545)
  end

  it "千五百四十六" do
    compare_kanji_and_integer("千五百四十六", 1546)
  end

  it "千五百四十七" do
    compare_kanji_and_integer("千五百四十七", 1547)
  end

  it "千五百四十八" do
    compare_kanji_and_integer("千五百四十八", 1548)
  end

  it "千五百四十九" do
    compare_kanji_and_integer("千五百四十九", 1549)
  end

  it "千五百五十" do
    compare_kanji_and_integer("千五百五十", 1550)
  end

  it "千五百五十一" do
    compare_kanji_and_integer("千五百五十一", 1551)
  end

  it "千五百五十二" do
    compare_kanji_and_integer("千五百五十二", 1552)
  end

  it "千五百五十三" do
    compare_kanji_and_integer("千五百五十三", 1553)
  end

  it "千五百五十四" do
    compare_kanji_and_integer("千五百五十四", 1554)
  end

  it "千五百五十五" do
    compare_kanji_and_integer("千五百五十五", 1555)
  end

  it "千五百五十六" do
    compare_kanji_and_integer("千五百五十六", 1556)
  end

  it "千五百五十七" do
    compare_kanji_and_integer("千五百五十七", 1557)
  end

  it "千五百五十八" do
    compare_kanji_and_integer("千五百五十八", 1558)
  end

  it "千五百五十九" do
    compare_kanji_and_integer("千五百五十九", 1559)
  end

  it "千五百六十" do
    compare_kanji_and_integer("千五百六十", 1560)
  end

  it "千五百六十一" do
    compare_kanji_and_integer("千五百六十一", 1561)
  end

  it "千五百六十二" do
    compare_kanji_and_integer("千五百六十二", 1562)
  end

  it "千五百六十三" do
    compare_kanji_and_integer("千五百六十三", 1563)
  end

  it "千五百六十四" do
    compare_kanji_and_integer("千五百六十四", 1564)
  end

  it "千五百六十五" do
    compare_kanji_and_integer("千五百六十五", 1565)
  end

  it "千五百六十六" do
    compare_kanji_and_integer("千五百六十六", 1566)
  end

  it "千五百六十七" do
    compare_kanji_and_integer("千五百六十七", 1567)
  end

  it "千五百六十八" do
    compare_kanji_and_integer("千五百六十八", 1568)
  end

  it "千五百六十九" do
    compare_kanji_and_integer("千五百六十九", 1569)
  end

  it "千五百七十" do
    compare_kanji_and_integer("千五百七十", 1570)
  end

  it "千五百七十一" do
    compare_kanji_and_integer("千五百七十一", 1571)
  end

  it "千五百七十二" do
    compare_kanji_and_integer("千五百七十二", 1572)
  end

  it "千五百七十三" do
    compare_kanji_and_integer("千五百七十三", 1573)
  end

  it "千五百七十四" do
    compare_kanji_and_integer("千五百七十四", 1574)
  end

  it "千五百七十五" do
    compare_kanji_and_integer("千五百七十五", 1575)
  end

  it "千五百七十六" do
    compare_kanji_and_integer("千五百七十六", 1576)
  end

  it "千五百七十七" do
    compare_kanji_and_integer("千五百七十七", 1577)
  end

  it "千五百七十八" do
    compare_kanji_and_integer("千五百七十八", 1578)
  end

  it "千五百七十九" do
    compare_kanji_and_integer("千五百七十九", 1579)
  end

  it "千五百八十" do
    compare_kanji_and_integer("千五百八十", 1580)
  end

  it "千五百八十一" do
    compare_kanji_and_integer("千五百八十一", 1581)
  end

  it "千五百八十二" do
    compare_kanji_and_integer("千五百八十二", 1582)
  end

  it "千五百八十三" do
    compare_kanji_and_integer("千五百八十三", 1583)
  end

  it "千五百八十四" do
    compare_kanji_and_integer("千五百八十四", 1584)
  end

  it "千五百八十五" do
    compare_kanji_and_integer("千五百八十五", 1585)
  end

  it "千五百八十六" do
    compare_kanji_and_integer("千五百八十六", 1586)
  end

  it "千五百八十七" do
    compare_kanji_and_integer("千五百八十七", 1587)
  end

  it "千五百八十八" do
    compare_kanji_and_integer("千五百八十八", 1588)
  end

  it "千五百八十九" do
    compare_kanji_and_integer("千五百八十九", 1589)
  end

  it "千五百九十" do
    compare_kanji_and_integer("千五百九十", 1590)
  end

  it "千五百九十一" do
    compare_kanji_and_integer("千五百九十一", 1591)
  end

  it "千五百九十二" do
    compare_kanji_and_integer("千五百九十二", 1592)
  end

  it "千五百九十三" do
    compare_kanji_and_integer("千五百九十三", 1593)
  end

  it "千五百九十四" do
    compare_kanji_and_integer("千五百九十四", 1594)
  end

  it "千五百九十五" do
    compare_kanji_and_integer("千五百九十五", 1595)
  end

  it "千五百九十六" do
    compare_kanji_and_integer("千五百九十六", 1596)
  end

  it "千五百九十七" do
    compare_kanji_and_integer("千五百九十七", 1597)
  end

  it "千五百九十八" do
    compare_kanji_and_integer("千五百九十八", 1598)
  end

  it "千五百九十九" do
    compare_kanji_and_integer("千五百九十九", 1599)
  end

  it "千六百" do
    compare_kanji_and_integer("千六百", 1600)
  end

  it "千六百一" do
    compare_kanji_and_integer("千六百一", 1601)
  end

  it "千六百二" do
    compare_kanji_and_integer("千六百二", 1602)
  end

  it "千六百三" do
    compare_kanji_and_integer("千六百三", 1603)
  end

  it "千六百四" do
    compare_kanji_and_integer("千六百四", 1604)
  end

  it "千六百五" do
    compare_kanji_and_integer("千六百五", 1605)
  end

  it "千六百六" do
    compare_kanji_and_integer("千六百六", 1606)
  end

  it "千六百七" do
    compare_kanji_and_integer("千六百七", 1607)
  end

  it "千六百八" do
    compare_kanji_and_integer("千六百八", 1608)
  end

  it "千六百九" do
    compare_kanji_and_integer("千六百九", 1609)
  end

  it "千六百十" do
    compare_kanji_and_integer("千六百十", 1610)
  end

  it "千六百十一" do
    compare_kanji_and_integer("千六百十一", 1611)
  end

  it "千六百十二" do
    compare_kanji_and_integer("千六百十二", 1612)
  end

  it "千六百十三" do
    compare_kanji_and_integer("千六百十三", 1613)
  end

  it "千六百十四" do
    compare_kanji_and_integer("千六百十四", 1614)
  end

  it "千六百十五" do
    compare_kanji_and_integer("千六百十五", 1615)
  end

  it "千六百十六" do
    compare_kanji_and_integer("千六百十六", 1616)
  end

  it "千六百十七" do
    compare_kanji_and_integer("千六百十七", 1617)
  end

  it "千六百十八" do
    compare_kanji_and_integer("千六百十八", 1618)
  end

  it "千六百十九" do
    compare_kanji_and_integer("千六百十九", 1619)
  end

  it "千六百二十" do
    compare_kanji_and_integer("千六百二十", 1620)
  end

  it "千六百二十一" do
    compare_kanji_and_integer("千六百二十一", 1621)
  end

  it "千六百二十二" do
    compare_kanji_and_integer("千六百二十二", 1622)
  end

  it "千六百二十三" do
    compare_kanji_and_integer("千六百二十三", 1623)
  end

  it "千六百二十四" do
    compare_kanji_and_integer("千六百二十四", 1624)
  end

  it "千六百二十五" do
    compare_kanji_and_integer("千六百二十五", 1625)
  end

  it "千六百二十六" do
    compare_kanji_and_integer("千六百二十六", 1626)
  end

  it "千六百二十七" do
    compare_kanji_and_integer("千六百二十七", 1627)
  end

  it "千六百二十八" do
    compare_kanji_and_integer("千六百二十八", 1628)
  end

  it "千六百二十九" do
    compare_kanji_and_integer("千六百二十九", 1629)
  end

  it "千六百三十" do
    compare_kanji_and_integer("千六百三十", 1630)
  end

  it "千六百三十一" do
    compare_kanji_and_integer("千六百三十一", 1631)
  end

  it "千六百三十二" do
    compare_kanji_and_integer("千六百三十二", 1632)
  end

  it "千六百三十三" do
    compare_kanji_and_integer("千六百三十三", 1633)
  end

  it "千六百三十四" do
    compare_kanji_and_integer("千六百三十四", 1634)
  end

  it "千六百三十五" do
    compare_kanji_and_integer("千六百三十五", 1635)
  end

  it "千六百三十六" do
    compare_kanji_and_integer("千六百三十六", 1636)
  end

  it "千六百三十七" do
    compare_kanji_and_integer("千六百三十七", 1637)
  end

  it "千六百三十八" do
    compare_kanji_and_integer("千六百三十八", 1638)
  end

  it "千六百三十九" do
    compare_kanji_and_integer("千六百三十九", 1639)
  end

  it "千六百四十" do
    compare_kanji_and_integer("千六百四十", 1640)
  end

  it "千六百四十一" do
    compare_kanji_and_integer("千六百四十一", 1641)
  end

  it "千六百四十二" do
    compare_kanji_and_integer("千六百四十二", 1642)
  end

  it "千六百四十三" do
    compare_kanji_and_integer("千六百四十三", 1643)
  end

  it "千六百四十四" do
    compare_kanji_and_integer("千六百四十四", 1644)
  end

  it "千六百四十五" do
    compare_kanji_and_integer("千六百四十五", 1645)
  end

  it "千六百四十六" do
    compare_kanji_and_integer("千六百四十六", 1646)
  end

  it "千六百四十七" do
    compare_kanji_and_integer("千六百四十七", 1647)
  end

  it "千六百四十八" do
    compare_kanji_and_integer("千六百四十八", 1648)
  end

  it "千六百四十九" do
    compare_kanji_and_integer("千六百四十九", 1649)
  end

  it "千六百五十" do
    compare_kanji_and_integer("千六百五十", 1650)
  end

  it "千六百五十一" do
    compare_kanji_and_integer("千六百五十一", 1651)
  end

  it "千六百五十二" do
    compare_kanji_and_integer("千六百五十二", 1652)
  end

  it "千六百五十三" do
    compare_kanji_and_integer("千六百五十三", 1653)
  end

  it "千六百五十四" do
    compare_kanji_and_integer("千六百五十四", 1654)
  end

  it "千六百五十五" do
    compare_kanji_and_integer("千六百五十五", 1655)
  end

  it "千六百五十六" do
    compare_kanji_and_integer("千六百五十六", 1656)
  end

  it "千六百五十七" do
    compare_kanji_and_integer("千六百五十七", 1657)
  end

  it "千六百五十八" do
    compare_kanji_and_integer("千六百五十八", 1658)
  end

  it "千六百五十九" do
    compare_kanji_and_integer("千六百五十九", 1659)
  end

  it "千六百六十" do
    compare_kanji_and_integer("千六百六十", 1660)
  end

  it "千六百六十一" do
    compare_kanji_and_integer("千六百六十一", 1661)
  end

  it "千六百六十二" do
    compare_kanji_and_integer("千六百六十二", 1662)
  end

  it "千六百六十三" do
    compare_kanji_and_integer("千六百六十三", 1663)
  end

  it "千六百六十四" do
    compare_kanji_and_integer("千六百六十四", 1664)
  end

  it "千六百六十五" do
    compare_kanji_and_integer("千六百六十五", 1665)
  end

  it "千六百六十六" do
    compare_kanji_and_integer("千六百六十六", 1666)
  end

  it "千六百六十七" do
    compare_kanji_and_integer("千六百六十七", 1667)
  end

  it "千六百六十八" do
    compare_kanji_and_integer("千六百六十八", 1668)
  end

  it "千六百六十九" do
    compare_kanji_and_integer("千六百六十九", 1669)
  end

  it "千六百七十" do
    compare_kanji_and_integer("千六百七十", 1670)
  end

  it "千六百七十一" do
    compare_kanji_and_integer("千六百七十一", 1671)
  end

  it "千六百七十二" do
    compare_kanji_and_integer("千六百七十二", 1672)
  end

  it "千六百七十三" do
    compare_kanji_and_integer("千六百七十三", 1673)
  end

  it "千六百七十四" do
    compare_kanji_and_integer("千六百七十四", 1674)
  end

  it "千六百七十五" do
    compare_kanji_and_integer("千六百七十五", 1675)
  end

  it "千六百七十六" do
    compare_kanji_and_integer("千六百七十六", 1676)
  end

  it "千六百七十七" do
    compare_kanji_and_integer("千六百七十七", 1677)
  end

  it "千六百七十八" do
    compare_kanji_and_integer("千六百七十八", 1678)
  end

  it "千六百七十九" do
    compare_kanji_and_integer("千六百七十九", 1679)
  end

  it "千六百八十" do
    compare_kanji_and_integer("千六百八十", 1680)
  end

  it "千六百八十一" do
    compare_kanji_and_integer("千六百八十一", 1681)
  end

  it "千六百八十二" do
    compare_kanji_and_integer("千六百八十二", 1682)
  end

  it "千六百八十三" do
    compare_kanji_and_integer("千六百八十三", 1683)
  end

  it "千六百八十四" do
    compare_kanji_and_integer("千六百八十四", 1684)
  end

  it "千六百八十五" do
    compare_kanji_and_integer("千六百八十五", 1685)
  end

  it "千六百八十六" do
    compare_kanji_and_integer("千六百八十六", 1686)
  end

  it "千六百八十七" do
    compare_kanji_and_integer("千六百八十七", 1687)
  end

  it "千六百八十八" do
    compare_kanji_and_integer("千六百八十八", 1688)
  end

  it "千六百八十九" do
    compare_kanji_and_integer("千六百八十九", 1689)
  end

  it "千六百九十" do
    compare_kanji_and_integer("千六百九十", 1690)
  end

  it "千六百九十一" do
    compare_kanji_and_integer("千六百九十一", 1691)
  end

  it "千六百九十二" do
    compare_kanji_and_integer("千六百九十二", 1692)
  end

  it "千六百九十三" do
    compare_kanji_and_integer("千六百九十三", 1693)
  end

  it "千六百九十四" do
    compare_kanji_and_integer("千六百九十四", 1694)
  end

  it "千六百九十五" do
    compare_kanji_and_integer("千六百九十五", 1695)
  end

  it "千六百九十六" do
    compare_kanji_and_integer("千六百九十六", 1696)
  end

  it "千六百九十七" do
    compare_kanji_and_integer("千六百九十七", 1697)
  end

  it "千六百九十八" do
    compare_kanji_and_integer("千六百九十八", 1698)
  end

  it "千六百九十九" do
    compare_kanji_and_integer("千六百九十九", 1699)
  end

  it "千七百" do
    compare_kanji_and_integer("千七百", 1700)
  end

  it "千七百一" do
    compare_kanji_and_integer("千七百一", 1701)
  end

  it "千七百二" do
    compare_kanji_and_integer("千七百二", 1702)
  end

  it "千七百三" do
    compare_kanji_and_integer("千七百三", 1703)
  end

  it "千七百四" do
    compare_kanji_and_integer("千七百四", 1704)
  end

  it "千七百五" do
    compare_kanji_and_integer("千七百五", 1705)
  end

  it "千七百六" do
    compare_kanji_and_integer("千七百六", 1706)
  end

  it "千七百七" do
    compare_kanji_and_integer("千七百七", 1707)
  end

  it "千七百八" do
    compare_kanji_and_integer("千七百八", 1708)
  end

  it "千七百九" do
    compare_kanji_and_integer("千七百九", 1709)
  end

  it "千七百十" do
    compare_kanji_and_integer("千七百十", 1710)
  end

  it "千七百十一" do
    compare_kanji_and_integer("千七百十一", 1711)
  end

  it "千七百十二" do
    compare_kanji_and_integer("千七百十二", 1712)
  end

  it "千七百十三" do
    compare_kanji_and_integer("千七百十三", 1713)
  end

  it "千七百十四" do
    compare_kanji_and_integer("千七百十四", 1714)
  end

  it "千七百十五" do
    compare_kanji_and_integer("千七百十五", 1715)
  end

  it "千七百十六" do
    compare_kanji_and_integer("千七百十六", 1716)
  end

  it "千七百十七" do
    compare_kanji_and_integer("千七百十七", 1717)
  end

  it "千七百十八" do
    compare_kanji_and_integer("千七百十八", 1718)
  end

  it "千七百十九" do
    compare_kanji_and_integer("千七百十九", 1719)
  end

  it "千七百二十" do
    compare_kanji_and_integer("千七百二十", 1720)
  end

  it "千七百二十一" do
    compare_kanji_and_integer("千七百二十一", 1721)
  end

  it "千七百二十二" do
    compare_kanji_and_integer("千七百二十二", 1722)
  end

  it "千七百二十三" do
    compare_kanji_and_integer("千七百二十三", 1723)
  end

  it "千七百二十四" do
    compare_kanji_and_integer("千七百二十四", 1724)
  end

  it "千七百二十五" do
    compare_kanji_and_integer("千七百二十五", 1725)
  end

  it "千七百二十六" do
    compare_kanji_and_integer("千七百二十六", 1726)
  end

  it "千七百二十七" do
    compare_kanji_and_integer("千七百二十七", 1727)
  end

  it "千七百二十八" do
    compare_kanji_and_integer("千七百二十八", 1728)
  end

  it "千七百二十九" do
    compare_kanji_and_integer("千七百二十九", 1729)
  end

  it "千七百三十" do
    compare_kanji_and_integer("千七百三十", 1730)
  end

  it "千七百三十一" do
    compare_kanji_and_integer("千七百三十一", 1731)
  end

  it "千七百三十二" do
    compare_kanji_and_integer("千七百三十二", 1732)
  end

  it "千七百三十三" do
    compare_kanji_and_integer("千七百三十三", 1733)
  end

  it "千七百三十四" do
    compare_kanji_and_integer("千七百三十四", 1734)
  end

  it "千七百三十五" do
    compare_kanji_and_integer("千七百三十五", 1735)
  end

  it "千七百三十六" do
    compare_kanji_and_integer("千七百三十六", 1736)
  end

  it "千七百三十七" do
    compare_kanji_and_integer("千七百三十七", 1737)
  end

  it "千七百三十八" do
    compare_kanji_and_integer("千七百三十八", 1738)
  end

  it "千七百三十九" do
    compare_kanji_and_integer("千七百三十九", 1739)
  end

  it "千七百四十" do
    compare_kanji_and_integer("千七百四十", 1740)
  end

  it "千七百四十一" do
    compare_kanji_and_integer("千七百四十一", 1741)
  end

  it "千七百四十二" do
    compare_kanji_and_integer("千七百四十二", 1742)
  end

  it "千七百四十三" do
    compare_kanji_and_integer("千七百四十三", 1743)
  end

  it "千七百四十四" do
    compare_kanji_and_integer("千七百四十四", 1744)
  end

  it "千七百四十五" do
    compare_kanji_and_integer("千七百四十五", 1745)
  end

  it "千七百四十六" do
    compare_kanji_and_integer("千七百四十六", 1746)
  end

  it "千七百四十七" do
    compare_kanji_and_integer("千七百四十七", 1747)
  end

  it "千七百四十八" do
    compare_kanji_and_integer("千七百四十八", 1748)
  end

  it "千七百四十九" do
    compare_kanji_and_integer("千七百四十九", 1749)
  end

  it "千七百五十" do
    compare_kanji_and_integer("千七百五十", 1750)
  end

  it "千七百五十一" do
    compare_kanji_and_integer("千七百五十一", 1751)
  end

  it "千七百五十二" do
    compare_kanji_and_integer("千七百五十二", 1752)
  end

  it "千七百五十三" do
    compare_kanji_and_integer("千七百五十三", 1753)
  end

  it "千七百五十四" do
    compare_kanji_and_integer("千七百五十四", 1754)
  end

  it "千七百五十五" do
    compare_kanji_and_integer("千七百五十五", 1755)
  end

  it "千七百五十六" do
    compare_kanji_and_integer("千七百五十六", 1756)
  end

  it "千七百五十七" do
    compare_kanji_and_integer("千七百五十七", 1757)
  end

  it "千七百五十八" do
    compare_kanji_and_integer("千七百五十八", 1758)
  end

  it "千七百五十九" do
    compare_kanji_and_integer("千七百五十九", 1759)
  end

  it "千七百六十" do
    compare_kanji_and_integer("千七百六十", 1760)
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

  it "二千一" do
    compare_kanji_and_integer("二千一", 2001)
  end

  it "二千二" do
    compare_kanji_and_integer("二千二", 2002)
  end

  it "二千三" do
    compare_kanji_and_integer("二千三", 2003)
  end

  it "二千四" do
    compare_kanji_and_integer("二千四", 2004)
  end

  it "二千五" do
    compare_kanji_and_integer("二千五", 2005)
  end

  it "二千六" do
    compare_kanji_and_integer("二千六", 2006)
  end

  it "二千七" do
    compare_kanji_and_integer("二千七", 2007)
  end

  it "二千八" do
    compare_kanji_and_integer("二千八", 2008)
  end

  it "二千九" do
    compare_kanji_and_integer("二千九", 2009)
  end

  it "二千十" do
    compare_kanji_and_integer("二千十", 2010)
  end

  it "二千十一" do
    compare_kanji_and_integer("二千十一", 2011)
  end

  it "二千十二" do
    compare_kanji_and_integer("二千十二", 2012)
  end

  it "二千十三" do
    compare_kanji_and_integer("二千十三", 2013)
  end

  it "二千十四" do
    compare_kanji_and_integer("二千十四", 2014)
  end

  it "二千十五" do
    compare_kanji_and_integer("二千十五", 2015)
  end

  it "二千十六" do
    compare_kanji_and_integer("二千十六", 2016)
  end

  it "二千十七" do
    compare_kanji_and_integer("二千十七", 2017)
  end

  it "二千十八" do
    compare_kanji_and_integer("二千十八", 2018)
  end

  it "二千十九" do
    compare_kanji_and_integer("二千十九", 2019)
  end

  it "二千二十" do
    compare_kanji_and_integer("二千二十", 2020)
  end

  it "二千二十一" do
    compare_kanji_and_integer("二千二十一", 2021)
  end

  it "二千二十二" do
    compare_kanji_and_integer("二千二十二", 2022)
  end

  it "二千二十三" do
    compare_kanji_and_integer("二千二十三", 2023)
  end

  it "二千二十四" do
    compare_kanji_and_integer("二千二十四", 2024)
  end

  it "二千二十五" do
    compare_kanji_and_integer("二千二十五", 2025)
  end

  it "二千二十六" do
    compare_kanji_and_integer("二千二十六", 2026)
  end

  it "二千二十七" do
    compare_kanji_and_integer("二千二十七", 2027)
  end

  it "二千二十八" do
    compare_kanji_and_integer("二千二十八", 2028)
  end

  it "二千二十九" do
    compare_kanji_and_integer("二千二十九", 2029)
  end

  it "二千三十" do
    compare_kanji_and_integer("二千三十", 2030)
  end

  it "二千三十一" do
    compare_kanji_and_integer("二千三十一", 2031)
  end

  it "二千三十二" do
    compare_kanji_and_integer("二千三十二", 2032)
  end

  it "二千三十三" do
    compare_kanji_and_integer("二千三十三", 2033)
  end

  it "二千三十四" do
    compare_kanji_and_integer("二千三十四", 2034)
  end

  it "二千三十五" do
    compare_kanji_and_integer("二千三十五", 2035)
  end

  it "二千三十六" do
    compare_kanji_and_integer("二千三十六", 2036)
  end

  it "二千三十七" do
    compare_kanji_and_integer("二千三十七", 2037)
  end

  it "二千三十八" do
    compare_kanji_and_integer("二千三十八", 2038)
  end

  it "二千三十九" do
    compare_kanji_and_integer("二千三十九", 2039)
  end

  it "二千四十" do
    compare_kanji_and_integer("二千四十", 2040)
  end

  it "二千四十一" do
    compare_kanji_and_integer("二千四十一", 2041)
  end

  it "二千四十二" do
    compare_kanji_and_integer("二千四十二", 2042)
  end

  it "二千四十三" do
    compare_kanji_and_integer("二千四十三", 2043)
  end

  it "二千四十四" do
    compare_kanji_and_integer("二千四十四", 2044)
  end

  it "二千四十五" do
    compare_kanji_and_integer("二千四十五", 2045)
  end

  it "二千四十六" do
    compare_kanji_and_integer("二千四十六", 2046)
  end

  it "二千四十七" do
    compare_kanji_and_integer("二千四十七", 2047)
  end

  it "二千四十八" do
    compare_kanji_and_integer("二千四十八", 2048)
  end

  it "二千四十九" do
    compare_kanji_and_integer("二千四十九", 2049)
  end

  it "二千五十" do
    compare_kanji_and_integer("二千五十", 2050)
  end

  it "二千五十一" do
    compare_kanji_and_integer("二千五十一", 2051)
  end

  it "二千五十二" do
    compare_kanji_and_integer("二千五十二", 2052)
  end

  it "二千五十三" do
    compare_kanji_and_integer("二千五十三", 2053)
  end

  it "二千五十四" do
    compare_kanji_and_integer("二千五十四", 2054)
  end

  it "二千五十五" do
    compare_kanji_and_integer("二千五十五", 2055)
  end

  it "二千五十六" do
    compare_kanji_and_integer("二千五十六", 2056)
  end

  it "二千五十七" do
    compare_kanji_and_integer("二千五十七", 2057)
  end

  it "二千五十八" do
    compare_kanji_and_integer("二千五十八", 2058)
  end

  it "二千五十九" do
    compare_kanji_and_integer("二千五十九", 2059)
  end

  it "二千六十" do
    compare_kanji_and_integer("二千六十", 2060)
  end

  it "二千六十一" do
    compare_kanji_and_integer("二千六十一", 2061)
  end

  it "二千六十二" do
    compare_kanji_and_integer("二千六十二", 2062)
  end

  it "二千六十三" do
    compare_kanji_and_integer("二千六十三", 2063)
  end

  it "二千六十四" do
    compare_kanji_and_integer("二千六十四", 2064)
  end

  it "二千六十五" do
    compare_kanji_and_integer("二千六十五", 2065)
  end

  it "二千六十六" do
    compare_kanji_and_integer("二千六十六", 2066)
  end

  it "二千六十七" do
    compare_kanji_and_integer("二千六十七", 2067)
  end

  it "二千六十八" do
    compare_kanji_and_integer("二千六十八", 2068)
  end

  it "二千六十九" do
    compare_kanji_and_integer("二千六十九", 2069)
  end

  it "二千七十" do
    compare_kanji_and_integer("二千七十", 2070)
  end

  it "二千七十一" do
    compare_kanji_and_integer("二千七十一", 2071)
  end

  it "二千七十二" do
    compare_kanji_and_integer("二千七十二", 2072)
  end

  it "二千七十三" do
    compare_kanji_and_integer("二千七十三", 2073)
  end

  it "二千七十四" do
    compare_kanji_and_integer("二千七十四", 2074)
  end

  it "二千七十五" do
    compare_kanji_and_integer("二千七十五", 2075)
  end

  it "二千七十六" do
    compare_kanji_and_integer("二千七十六", 2076)
  end

  it "二千七十七" do
    compare_kanji_and_integer("二千七十七", 2077)
  end

  it "二千七十八" do
    compare_kanji_and_integer("二千七十八", 2078)
  end

  it "二千七十九" do
    compare_kanji_and_integer("二千七十九", 2079)
  end

  it "二千八十" do
    compare_kanji_and_integer("二千八十", 2080)
  end

  it "二千八十一" do
    compare_kanji_and_integer("二千八十一", 2081)
  end

  it "二千八十二" do
    compare_kanji_and_integer("二千八十二", 2082)
  end

  it "二千八十三" do
    compare_kanji_and_integer("二千八十三", 2083)
  end

  it "二千八十四" do
    compare_kanji_and_integer("二千八十四", 2084)
  end

  it "二千八十五" do
    compare_kanji_and_integer("二千八十五", 2085)
  end

  it "二千八十六" do
    compare_kanji_and_integer("二千八十六", 2086)
  end

  it "二千八十七" do
    compare_kanji_and_integer("二千八十七", 2087)
  end

  it "二千八十八" do
    compare_kanji_and_integer("二千八十八", 2088)
  end

  it "二千八十九" do
    compare_kanji_and_integer("二千八十九", 2089)
  end

  it "二千九十" do
    compare_kanji_and_integer("二千九十", 2090)
  end

  it "二千九十一" do
    compare_kanji_and_integer("二千九十一", 2091)
  end

  it "二千九十二" do
    compare_kanji_and_integer("二千九十二", 2092)
  end

  it "二千九十三" do
    compare_kanji_and_integer("二千九十三", 2093)
  end

  it "二千九十四" do
    compare_kanji_and_integer("二千九十四", 2094)
  end

  it "二千九十五" do
    compare_kanji_and_integer("二千九十五", 2095)
  end

  it "二千九十六" do
    compare_kanji_and_integer("二千九十六", 2096)
  end

  it "二千九十七" do
    compare_kanji_and_integer("二千九十七", 2097)
  end

  it "二千九十八" do
    compare_kanji_and_integer("二千九十八", 2098)
  end

  it "二千九十九" do
    compare_kanji_and_integer("二千九十九", 2099)
  end

  it "二千百" do
    compare_kanji_and_integer("二千百", 2100)
  end

  it "二千百一" do
    compare_kanji_and_integer("二千百一", 2101)
  end

  it "二千百二" do
    compare_kanji_and_integer("二千百二", 2102)
  end

  it "二千百三" do
    compare_kanji_and_integer("二千百三", 2103)
  end

  it "二千百四" do
    compare_kanji_and_integer("二千百四", 2104)
  end

  it "二千百五" do
    compare_kanji_and_integer("二千百五", 2105)
  end

  it "二千百六" do
    compare_kanji_and_integer("二千百六", 2106)
  end

  it "二千百七" do
    compare_kanji_and_integer("二千百七", 2107)
  end

  it "二千百八" do
    compare_kanji_and_integer("二千百八", 2108)
  end

  it "二千百九" do
    compare_kanji_and_integer("二千百九", 2109)
  end

  it "二千百十" do
    compare_kanji_and_integer("二千百十", 2110)
  end

  it "二千百十一" do
    compare_kanji_and_integer("二千百十一", 2111)
  end

  it "二千百十二" do
    compare_kanji_and_integer("二千百十二", 2112)
  end

  it "二千百十三" do
    compare_kanji_and_integer("二千百十三", 2113)
  end

  it "二千百十四" do
    compare_kanji_and_integer("二千百十四", 2114)
  end

  it "二千百十五" do
    compare_kanji_and_integer("二千百十五", 2115)
  end

  it "二千百十六" do
    compare_kanji_and_integer("二千百十六", 2116)
  end

  it "二千百十七" do
    compare_kanji_and_integer("二千百十七", 2117)
  end

  it "二千百十八" do
    compare_kanji_and_integer("二千百十八", 2118)
  end

  it "二千百十九" do
    compare_kanji_and_integer("二千百十九", 2119)
  end

  it "二千百二十" do
    compare_kanji_and_integer("二千百二十", 2120)
  end

  it "二千百二十一" do
    compare_kanji_and_integer("二千百二十一", 2121)
  end

  it "二千百二十二" do
    compare_kanji_and_integer("二千百二十二", 2122)
  end

  it "二千百二十三" do
    compare_kanji_and_integer("二千百二十三", 2123)
  end

  it "二千百二十四" do
    compare_kanji_and_integer("二千百二十四", 2124)
  end

  it "二千百二十五" do
    compare_kanji_and_integer("二千百二十五", 2125)
  end

  it "二千百二十六" do
    compare_kanji_and_integer("二千百二十六", 2126)
  end

  it "二千百二十七" do
    compare_kanji_and_integer("二千百二十七", 2127)
  end

  it "二千百二十八" do
    compare_kanji_and_integer("二千百二十八", 2128)
  end

  it "二千百二十九" do
    compare_kanji_and_integer("二千百二十九", 2129)
  end

  it "二千百三十" do
    compare_kanji_and_integer("二千百三十", 2130)
  end

  it "二千百三十一" do
    compare_kanji_and_integer("二千百三十一", 2131)
  end

  it "二千百三十二" do
    compare_kanji_and_integer("二千百三十二", 2132)
  end

  it "二千百三十三" do
    compare_kanji_and_integer("二千百三十三", 2133)
  end

  it "二千百三十四" do
    compare_kanji_and_integer("二千百三十四", 2134)
  end

  it "二千百三十五" do
    compare_kanji_and_integer("二千百三十五", 2135)
  end

  it "二千百三十六" do
    compare_kanji_and_integer("二千百三十六", 2136)
  end

  it "二千百三十七" do
    compare_kanji_and_integer("二千百三十七", 2137)
  end

  it "二千百三十八" do
    compare_kanji_and_integer("二千百三十八", 2138)
  end

  it "二千百三十九" do
    compare_kanji_and_integer("二千百三十九", 2139)
  end

  it "二千百四十" do
    compare_kanji_and_integer("二千百四十", 2140)
  end

  it "二千百四十一" do
    compare_kanji_and_integer("二千百四十一", 2141)
  end

  it "二千百四十二" do
    compare_kanji_and_integer("二千百四十二", 2142)
  end

  it "二千百四十三" do
    compare_kanji_and_integer("二千百四十三", 2143)
  end

  it "二千百四十四" do
    compare_kanji_and_integer("二千百四十四", 2144)
  end

  it "二千百四十五" do
    compare_kanji_and_integer("二千百四十五", 2145)
  end

  it "二千百四十六" do
    compare_kanji_and_integer("二千百四十六", 2146)
  end

  it "二千百四十七" do
    compare_kanji_and_integer("二千百四十七", 2147)
  end

  it "二千百四十八" do
    compare_kanji_and_integer("二千百四十八", 2148)
  end

  it "二千百四十九" do
    compare_kanji_and_integer("二千百四十九", 2149)
  end

  it "二千百五十" do
    compare_kanji_and_integer("二千百五十", 2150)
  end

  it "二千百五十一" do
    compare_kanji_and_integer("二千百五十一", 2151)
  end

  it "二千百五十二" do
    compare_kanji_and_integer("二千百五十二", 2152)
  end

  it "二千百五十三" do
    compare_kanji_and_integer("二千百五十三", 2153)
  end

  it "二千百五十四" do
    compare_kanji_and_integer("二千百五十四", 2154)
  end

  it "二千百五十五" do
    compare_kanji_and_integer("二千百五十五", 2155)
  end

  it "二千百五十六" do
    compare_kanji_and_integer("二千百五十六", 2156)
  end

  it "二千百五十七" do
    compare_kanji_and_integer("二千百五十七", 2157)
  end

  it "二千百五十八" do
    compare_kanji_and_integer("二千百五十八", 2158)
  end

  it "二千百五十九" do
    compare_kanji_and_integer("二千百五十九", 2159)
  end

  it "二千百六十" do
    compare_kanji_and_integer("二千百六十", 2160)
  end

  it "二千百六十一" do
    compare_kanji_and_integer("二千百六十一", 2161)
  end

  it "二千百六十二" do
    compare_kanji_and_integer("二千百六十二", 2162)
  end

  it "二千百六十三" do
    compare_kanji_and_integer("二千百六十三", 2163)
  end

  it "二千百六十四" do
    compare_kanji_and_integer("二千百六十四", 2164)
  end

  it "二千百六十五" do
    compare_kanji_and_integer("二千百六十五", 2165)
  end

  it "二千百六十六" do
    compare_kanji_and_integer("二千百六十六", 2166)
  end

  it "二千百六十七" do
    compare_kanji_and_integer("二千百六十七", 2167)
  end

  it "二千百六十八" do
    compare_kanji_and_integer("二千百六十八", 2168)
  end

  it "二千百六十九" do
    compare_kanji_and_integer("二千百六十九", 2169)
  end

  it "二千百七十" do
    compare_kanji_and_integer("二千百七十", 2170)
  end

  it "二千百七十一" do
    compare_kanji_and_integer("二千百七十一", 2171)
  end

  it "二千百七十二" do
    compare_kanji_and_integer("二千百七十二", 2172)
  end

  it "二千百七十三" do
    compare_kanji_and_integer("二千百七十三", 2173)
  end

  it "二千百七十四" do
    compare_kanji_and_integer("二千百七十四", 2174)
  end

  it "二千百七十五" do
    compare_kanji_and_integer("二千百七十五", 2175)
  end

  it "二千百七十六" do
    compare_kanji_and_integer("二千百七十六", 2176)
  end

  it "二千百七十七" do
    compare_kanji_and_integer("二千百七十七", 2177)
  end

  it "二千百七十八" do
    compare_kanji_and_integer("二千百七十八", 2178)
  end

  it "二千百七十九" do
    compare_kanji_and_integer("二千百七十九", 2179)
  end

  it "二千百八十" do
    compare_kanji_and_integer("二千百八十", 2180)
  end

  it "二千百八十一" do
    compare_kanji_and_integer("二千百八十一", 2181)
  end

  it "二千百八十二" do
    compare_kanji_and_integer("二千百八十二", 2182)
  end

  it "二千百八十三" do
    compare_kanji_and_integer("二千百八十三", 2183)
  end

  it "二千百八十四" do
    compare_kanji_and_integer("二千百八十四", 2184)
  end

  it "二千百八十五" do
    compare_kanji_and_integer("二千百八十五", 2185)
  end

  it "二千百八十六" do
    compare_kanji_and_integer("二千百八十六", 2186)
  end

  it "二千百八十七" do
    compare_kanji_and_integer("二千百八十七", 2187)
  end

  it "二千百八十八" do
    compare_kanji_and_integer("二千百八十八", 2188)
  end

  it "二千百八十九" do
    compare_kanji_and_integer("二千百八十九", 2189)
  end

  it "二千百九十" do
    compare_kanji_and_integer("二千百九十", 2190)
  end

  it "二千百九十一" do
    compare_kanji_and_integer("二千百九十一", 2191)
  end

  it "二千百九十二" do
    compare_kanji_and_integer("二千百九十二", 2192)
  end

  it "二千百九十三" do
    compare_kanji_and_integer("二千百九十三", 2193)
  end

  it "二千百九十四" do
    compare_kanji_and_integer("二千百九十四", 2194)
  end

  it "二千百九十五" do
    compare_kanji_and_integer("二千百九十五", 2195)
  end

  it "二千百九十六" do
    compare_kanji_and_integer("二千百九十六", 2196)
  end

  it "二千百九十七" do
    compare_kanji_and_integer("二千百九十七", 2197)
  end

  it "二千百九十八" do
    compare_kanji_and_integer("二千百九十八", 2198)
  end

  it "二千百九十九" do
    compare_kanji_and_integer("二千百九十九", 2199)
  end

  it "二千二百" do
    compare_kanji_and_integer("二千二百", 2200)
  end

  it "二千二百一" do
    compare_kanji_and_integer("二千二百一", 2201)
  end

  it "二千二百二" do
    compare_kanji_and_integer("二千二百二", 2202)
  end

  it "二千二百三" do
    compare_kanji_and_integer("二千二百三", 2203)
  end

  it "二千二百四" do
    compare_kanji_and_integer("二千二百四", 2204)
  end

  it "二千二百五" do
    compare_kanji_and_integer("二千二百五", 2205)
  end

  it "二千二百六" do
    compare_kanji_and_integer("二千二百六", 2206)
  end

  it "二千二百七" do
    compare_kanji_and_integer("二千二百七", 2207)
  end

  it "二千二百八" do
    compare_kanji_and_integer("二千二百八", 2208)
  end

  it "二千二百九" do
    compare_kanji_and_integer("二千二百九", 2209)
  end

  it "二千二百十" do
    compare_kanji_and_integer("二千二百十", 2210)
  end

  it "二千二百十一" do
    compare_kanji_and_integer("二千二百十一", 2211)
  end

  it "二千二百十二" do
    compare_kanji_and_integer("二千二百十二", 2212)
  end

  it "二千二百十三" do
    compare_kanji_and_integer("二千二百十三", 2213)
  end

  it "二千二百十四" do
    compare_kanji_and_integer("二千二百十四", 2214)
  end

  it "二千二百十五" do
    compare_kanji_and_integer("二千二百十五", 2215)
  end

  it "二千二百十六" do
    compare_kanji_and_integer("二千二百十六", 2216)
  end

  it "二千二百十七" do
    compare_kanji_and_integer("二千二百十七", 2217)
  end

  it "二千二百十八" do
    compare_kanji_and_integer("二千二百十八", 2218)
  end

  it "二千二百十九" do
    compare_kanji_and_integer("二千二百十九", 2219)
  end

  it "二千二百二十" do
    compare_kanji_and_integer("二千二百二十", 2220)
  end

  it "二千二百二十一" do
    compare_kanji_and_integer("二千二百二十一", 2221)
  end

  it "二千二百二十二" do
    compare_kanji_and_integer("二千二百二十二", 2222)
  end

  it "二千二百二十三" do
    compare_kanji_and_integer("二千二百二十三", 2223)
  end

  it "二千二百二十四" do
    compare_kanji_and_integer("二千二百二十四", 2224)
  end

  it "二千二百二十五" do
    compare_kanji_and_integer("二千二百二十五", 2225)
  end

  it "二千二百二十六" do
    compare_kanji_and_integer("二千二百二十六", 2226)
  end

  it "二千二百二十七" do
    compare_kanji_and_integer("二千二百二十七", 2227)
  end

  it "二千二百二十八" do
    compare_kanji_and_integer("二千二百二十八", 2228)
  end

  it "二千二百二十九" do
    compare_kanji_and_integer("二千二百二十九", 2229)
  end

  it "二千二百三十" do
    compare_kanji_and_integer("二千二百三十", 2230)
  end

  it "二千二百三十一" do
    compare_kanji_and_integer("二千二百三十一", 2231)
  end

  it "二千二百三十二" do
    compare_kanji_and_integer("二千二百三十二", 2232)
  end

  it "二千二百三十三" do
    compare_kanji_and_integer("二千二百三十三", 2233)
  end

  it "二千二百三十四" do
    compare_kanji_and_integer("二千二百三十四", 2234)
  end

  it "二千二百三十五" do
    compare_kanji_and_integer("二千二百三十五", 2235)
  end

  it "二千二百三十六" do
    compare_kanji_and_integer("二千二百三十六", 2236)
  end

  it "二千二百三十七" do
    compare_kanji_and_integer("二千二百三十七", 2237)
  end

  it "二千二百三十八" do
    compare_kanji_and_integer("二千二百三十八", 2238)
  end

  it "二千二百三十九" do
    compare_kanji_and_integer("二千二百三十九", 2239)
  end

  it "二千二百四十" do
    compare_kanji_and_integer("二千二百四十", 2240)
  end

  it "二千二百四十一" do
    compare_kanji_and_integer("二千二百四十一", 2241)
  end

  it "二千二百四十二" do
    compare_kanji_and_integer("二千二百四十二", 2242)
  end

  it "二千二百四十三" do
    compare_kanji_and_integer("二千二百四十三", 2243)
  end

  it "二千二百四十四" do
    compare_kanji_and_integer("二千二百四十四", 2244)
  end

  it "二千二百四十五" do
    compare_kanji_and_integer("二千二百四十五", 2245)
  end

  it "二千二百四十六" do
    compare_kanji_and_integer("二千二百四十六", 2246)
  end

  it "二千二百四十七" do
    compare_kanji_and_integer("二千二百四十七", 2247)
  end

  it "二千二百四十八" do
    compare_kanji_and_integer("二千二百四十八", 2248)
  end

  it "二千二百四十九" do
    compare_kanji_and_integer("二千二百四十九", 2249)
  end

  it "二千二百五十" do
    compare_kanji_and_integer("二千二百五十", 2250)
  end

  it "二千二百五十一" do
    compare_kanji_and_integer("二千二百五十一", 2251)
  end

  it "二千二百五十二" do
    compare_kanji_and_integer("二千二百五十二", 2252)
  end

  it "二千二百五十三" do
    compare_kanji_and_integer("二千二百五十三", 2253)
  end

  it "二千二百五十四" do
    compare_kanji_and_integer("二千二百五十四", 2254)
  end

  it "二千二百五十五" do
    compare_kanji_and_integer("二千二百五十五", 2255)
  end

  it "二千二百五十六" do
    compare_kanji_and_integer("二千二百五十六", 2256)
  end

  it "二千二百五十七" do
    compare_kanji_and_integer("二千二百五十七", 2257)
  end

  it "二千二百五十八" do
    compare_kanji_and_integer("二千二百五十八", 2258)
  end

  it "二千二百五十九" do
    compare_kanji_and_integer("二千二百五十九", 2259)
  end

  it "二千二百六十" do
    compare_kanji_and_integer("二千二百六十", 2260)
  end

  it "二千二百六十一" do
    compare_kanji_and_integer("二千二百六十一", 2261)
  end

  it "二千二百六十二" do
    compare_kanji_and_integer("二千二百六十二", 2262)
  end

  it "二千二百六十三" do
    compare_kanji_and_integer("二千二百六十三", 2263)
  end

  it "二千二百六十四" do
    compare_kanji_and_integer("二千二百六十四", 2264)
  end

  it "二千二百六十五" do
    compare_kanji_and_integer("二千二百六十五", 2265)
  end

  it "二千二百六十六" do
    compare_kanji_and_integer("二千二百六十六", 2266)
  end

  it "二千二百六十七" do
    compare_kanji_and_integer("二千二百六十七", 2267)
  end

  it "二千二百六十八" do
    compare_kanji_and_integer("二千二百六十八", 2268)
  end

  it "二千二百六十九" do
    compare_kanji_and_integer("二千二百六十九", 2269)
  end

  it "二千二百七十" do
    compare_kanji_and_integer("二千二百七十", 2270)
  end

  it "二千二百七十一" do
    compare_kanji_and_integer("二千二百七十一", 2271)
  end

  it "二千二百七十二" do
    compare_kanji_and_integer("二千二百七十二", 2272)
  end

  it "二千二百七十三" do
    compare_kanji_and_integer("二千二百七十三", 2273)
  end

  it "二千二百七十四" do
    compare_kanji_and_integer("二千二百七十四", 2274)
  end

  it "二千二百七十五" do
    compare_kanji_and_integer("二千二百七十五", 2275)
  end

  it "二千二百七十六" do
    compare_kanji_and_integer("二千二百七十六", 2276)
  end

  it "二千二百七十七" do
    compare_kanji_and_integer("二千二百七十七", 2277)
  end

  it "二千二百七十八" do
    compare_kanji_and_integer("二千二百七十八", 2278)
  end

  it "二千二百七十九" do
    compare_kanji_and_integer("二千二百七十九", 2279)
  end

  it "二千二百八十" do
    compare_kanji_and_integer("二千二百八十", 2280)
  end

  it "二千二百八十一" do
    compare_kanji_and_integer("二千二百八十一", 2281)
  end

  it "二千二百八十二" do
    compare_kanji_and_integer("二千二百八十二", 2282)
  end

  it "二千二百八十三" do
    compare_kanji_and_integer("二千二百八十三", 2283)
  end

  it "二千二百八十四" do
    compare_kanji_and_integer("二千二百八十四", 2284)
  end

  it "二千二百八十五" do
    compare_kanji_and_integer("二千二百八十五", 2285)
  end

  it "二千二百八十六" do
    compare_kanji_and_integer("二千二百八十六", 2286)
  end

  it "二千二百八十七" do
    compare_kanji_and_integer("二千二百八十七", 2287)
  end

  it "二千二百八十八" do
    compare_kanji_and_integer("二千二百八十八", 2288)
  end

  it "二千二百八十九" do
    compare_kanji_and_integer("二千二百八十九", 2289)
  end

  it "二千二百九十" do
    compare_kanji_and_integer("二千二百九十", 2290)
  end

  it "二千二百九十一" do
    compare_kanji_and_integer("二千二百九十一", 2291)
  end

  it "二千二百九十二" do
    compare_kanji_and_integer("二千二百九十二", 2292)
  end

  it "二千二百九十三" do
    compare_kanji_and_integer("二千二百九十三", 2293)
  end

  it "二千二百九十四" do
    compare_kanji_and_integer("二千二百九十四", 2294)
  end

  it "二千二百九十五" do
    compare_kanji_and_integer("二千二百九十五", 2295)
  end

  it "二千二百九十六" do
    compare_kanji_and_integer("二千二百九十六", 2296)
  end

  it "二千二百九十七" do
    compare_kanji_and_integer("二千二百九十七", 2297)
  end

  it "二千二百九十八" do
    compare_kanji_and_integer("二千二百九十八", 2298)
  end

  it "二千二百九十九" do
    compare_kanji_and_integer("二千二百九十九", 2299)
  end

  it "二千三百" do
    compare_kanji_and_integer("二千三百", 2300)
  end

  it "二千三百一" do
    compare_kanji_and_integer("二千三百一", 2301)
  end

  it "二千三百二" do
    compare_kanji_and_integer("二千三百二", 2302)
  end

  it "二千三百三" do
    compare_kanji_and_integer("二千三百三", 2303)
  end

  it "二千三百四" do
    compare_kanji_and_integer("二千三百四", 2304)
  end

  it "二千三百五" do
    compare_kanji_and_integer("二千三百五", 2305)
  end

  it "二千三百六" do
    compare_kanji_and_integer("二千三百六", 2306)
  end

  it "二千三百七" do
    compare_kanji_and_integer("二千三百七", 2307)
  end

  it "二千三百八" do
    compare_kanji_and_integer("二千三百八", 2308)
  end

  it "二千三百九" do
    compare_kanji_and_integer("二千三百九", 2309)
  end

  it "二千三百十" do
    compare_kanji_and_integer("二千三百十", 2310)
  end

  it "二千三百十一" do
    compare_kanji_and_integer("二千三百十一", 2311)
  end

  it "二千三百十二" do
    compare_kanji_and_integer("二千三百十二", 2312)
  end

  it "二千三百十三" do
    compare_kanji_and_integer("二千三百十三", 2313)
  end

  it "二千三百十四" do
    compare_kanji_and_integer("二千三百十四", 2314)
  end

  it "二千三百十五" do
    compare_kanji_and_integer("二千三百十五", 2315)
  end

  it "二千三百十六" do
    compare_kanji_and_integer("二千三百十六", 2316)
  end

  it "二千三百十七" do
    compare_kanji_and_integer("二千三百十七", 2317)
  end

  it "二千三百十八" do
    compare_kanji_and_integer("二千三百十八", 2318)
  end

  it "二千三百十九" do
    compare_kanji_and_integer("二千三百十九", 2319)
  end

  it "二千三百二十" do
    compare_kanji_and_integer("二千三百二十", 2320)
  end

  it "二千三百二十一" do
    compare_kanji_and_integer("二千三百二十一", 2321)
  end

  it "二千三百二十二" do
    compare_kanji_and_integer("二千三百二十二", 2322)
  end

  it "二千三百二十三" do
    compare_kanji_and_integer("二千三百二十三", 2323)
  end

  it "二千三百二十四" do
    compare_kanji_and_integer("二千三百二十四", 2324)
  end

  it "二千三百二十五" do
    compare_kanji_and_integer("二千三百二十五", 2325)
  end

  it "二千三百二十六" do
    compare_kanji_and_integer("二千三百二十六", 2326)
  end

  it "二千三百二十七" do
    compare_kanji_and_integer("二千三百二十七", 2327)
  end

  it "二千三百二十八" do
    compare_kanji_and_integer("二千三百二十八", 2328)
  end

  it "二千三百二十九" do
    compare_kanji_and_integer("二千三百二十九", 2329)
  end

  it "二千三百三十" do
    compare_kanji_and_integer("二千三百三十", 2330)
  end

  it "二千三百三十一" do
    compare_kanji_and_integer("二千三百三十一", 2331)
  end

  it "二千三百三十二" do
    compare_kanji_and_integer("二千三百三十二", 2332)
  end

  it "二千三百三十三" do
    compare_kanji_and_integer("二千三百三十三", 2333)
  end

  it "二千三百三十四" do
    compare_kanji_and_integer("二千三百三十四", 2334)
  end

  it "二千三百三十五" do
    compare_kanji_and_integer("二千三百三十五", 2335)
  end

  it "二千三百三十六" do
    compare_kanji_and_integer("二千三百三十六", 2336)
  end

  it "二千三百三十七" do
    compare_kanji_and_integer("二千三百三十七", 2337)
  end

  it "二千三百三十八" do
    compare_kanji_and_integer("二千三百三十八", 2338)
  end

  it "二千三百三十九" do
    compare_kanji_and_integer("二千三百三十九", 2339)
  end

  it "二千三百四十" do
    compare_kanji_and_integer("二千三百四十", 2340)
  end

  it "二千三百四十一" do
    compare_kanji_and_integer("二千三百四十一", 2341)
  end

  it "二千三百四十二" do
    compare_kanji_and_integer("二千三百四十二", 2342)
  end

  it "二千三百四十三" do
    compare_kanji_and_integer("二千三百四十三", 2343)
  end

  it "二千三百四十四" do
    compare_kanji_and_integer("二千三百四十四", 2344)
  end

  it "二千三百四十五" do
    compare_kanji_and_integer("二千三百四十五", 2345)
  end

  it "二千三百四十六" do
    compare_kanji_and_integer("二千三百四十六", 2346)
  end

  it "二千三百四十七" do
    compare_kanji_and_integer("二千三百四十七", 2347)
  end

  it "二千三百四十八" do
    compare_kanji_and_integer("二千三百四十八", 2348)
  end

  it "二千三百四十九" do
    compare_kanji_and_integer("二千三百四十九", 2349)
  end

  it "二千三百五十" do
    compare_kanji_and_integer("二千三百五十", 2350)
  end

  it "二千三百五十一" do
    compare_kanji_and_integer("二千三百五十一", 2351)
  end

  it "二千三百五十二" do
    compare_kanji_and_integer("二千三百五十二", 2352)
  end

  it "二千三百五十三" do
    compare_kanji_and_integer("二千三百五十三", 2353)
  end

  it "二千三百五十四" do
    compare_kanji_and_integer("二千三百五十四", 2354)
  end

  it "二千三百五十五" do
    compare_kanji_and_integer("二千三百五十五", 2355)
  end

  it "二千三百五十六" do
    compare_kanji_and_integer("二千三百五十六", 2356)
  end

  it "二千三百五十七" do
    compare_kanji_and_integer("二千三百五十七", 2357)
  end

  it "二千三百五十八" do
    compare_kanji_and_integer("二千三百五十八", 2358)
  end

  it "二千三百五十九" do
    compare_kanji_and_integer("二千三百五十九", 2359)
  end

  it "二千三百六十" do
    compare_kanji_and_integer("二千三百六十", 2360)
  end

  it "二千三百六十一" do
    compare_kanji_and_integer("二千三百六十一", 2361)
  end

  it "二千三百六十二" do
    compare_kanji_and_integer("二千三百六十二", 2362)
  end

  it "二千三百六十三" do
    compare_kanji_and_integer("二千三百六十三", 2363)
  end

  it "二千三百六十四" do
    compare_kanji_and_integer("二千三百六十四", 2364)
  end

  it "二千三百六十五" do
    compare_kanji_and_integer("二千三百六十五", 2365)
  end

  it "二千三百六十六" do
    compare_kanji_and_integer("二千三百六十六", 2366)
  end

  it "二千三百六十七" do
    compare_kanji_and_integer("二千三百六十七", 2367)
  end

  it "二千三百六十八" do
    compare_kanji_and_integer("二千三百六十八", 2368)
  end

  it "二千三百六十九" do
    compare_kanji_and_integer("二千三百六十九", 2369)
  end

  it "二千三百七十" do
    compare_kanji_and_integer("二千三百七十", 2370)
  end

  it "二千三百七十一" do
    compare_kanji_and_integer("二千三百七十一", 2371)
  end

  it "二千三百七十二" do
    compare_kanji_and_integer("二千三百七十二", 2372)
  end

  it "二千三百七十三" do
    compare_kanji_and_integer("二千三百七十三", 2373)
  end

  it "二千三百七十四" do
    compare_kanji_and_integer("二千三百七十四", 2374)
  end

  it "二千三百七十五" do
    compare_kanji_and_integer("二千三百七十五", 2375)
  end

  it "二千三百七十六" do
    compare_kanji_and_integer("二千三百七十六", 2376)
  end

  it "二千三百七十七" do
    compare_kanji_and_integer("二千三百七十七", 2377)
  end

  it "二千三百七十八" do
    compare_kanji_and_integer("二千三百七十八", 2378)
  end

  it "二千三百七十九" do
    compare_kanji_and_integer("二千三百七十九", 2379)
  end

  it "二千三百八十" do
    compare_kanji_and_integer("二千三百八十", 2380)
  end

  it "二千三百八十一" do
    compare_kanji_and_integer("二千三百八十一", 2381)
  end

  it "二千三百八十二" do
    compare_kanji_and_integer("二千三百八十二", 2382)
  end

  it "二千三百八十三" do
    compare_kanji_and_integer("二千三百八十三", 2383)
  end

  it "二千三百八十四" do
    compare_kanji_and_integer("二千三百八十四", 2384)
  end

  it "二千三百八十五" do
    compare_kanji_and_integer("二千三百八十五", 2385)
  end

  it "二千三百八十六" do
    compare_kanji_and_integer("二千三百八十六", 2386)
  end

  it "二千三百八十七" do
    compare_kanji_and_integer("二千三百八十七", 2387)
  end

  it "二千三百八十八" do
    compare_kanji_and_integer("二千三百八十八", 2388)
  end

  it "二千三百八十九" do
    compare_kanji_and_integer("二千三百八十九", 2389)
  end

  it "二千三百九十" do
    compare_kanji_and_integer("二千三百九十", 2390)
  end

  it "二千三百九十一" do
    compare_kanji_and_integer("二千三百九十一", 2391)
  end

  it "二千三百九十二" do
    compare_kanji_and_integer("二千三百九十二", 2392)
  end

  it "二千三百九十三" do
    compare_kanji_and_integer("二千三百九十三", 2393)
  end

  it "二千三百九十四" do
    compare_kanji_and_integer("二千三百九十四", 2394)
  end

  it "二千三百九十五" do
    compare_kanji_and_integer("二千三百九十五", 2395)
  end

  it "二千三百九十六" do
    compare_kanji_and_integer("二千三百九十六", 2396)
  end

  it "二千三百九十七" do
    compare_kanji_and_integer("二千三百九十七", 2397)
  end

  it "二千三百九十八" do
    compare_kanji_and_integer("二千三百九十八", 2398)
  end

  it "二千三百九十九" do
    compare_kanji_and_integer("二千三百九十九", 2399)
  end

  it "二千四百" do
    compare_kanji_and_integer("二千四百", 2400)
  end

  it "二千四百一" do
    compare_kanji_and_integer("二千四百一", 2401)
  end

  it "二千四百二" do
    compare_kanji_and_integer("二千四百二", 2402)
  end

  it "二千四百三" do
    compare_kanji_and_integer("二千四百三", 2403)
  end

  it "二千四百四" do
    compare_kanji_and_integer("二千四百四", 2404)
  end

  it "二千四百五" do
    compare_kanji_and_integer("二千四百五", 2405)
  end

  it "二千四百六" do
    compare_kanji_and_integer("二千四百六", 2406)
  end

  it "二千四百七" do
    compare_kanji_and_integer("二千四百七", 2407)
  end

  it "二千四百八" do
    compare_kanji_and_integer("二千四百八", 2408)
  end

  it "二千四百九" do
    compare_kanji_and_integer("二千四百九", 2409)
  end

  it "二千四百十" do
    compare_kanji_and_integer("二千四百十", 2410)
  end

  it "二千四百十一" do
    compare_kanji_and_integer("二千四百十一", 2411)
  end

  it "二千四百十二" do
    compare_kanji_and_integer("二千四百十二", 2412)
  end

  it "二千四百十三" do
    compare_kanji_and_integer("二千四百十三", 2413)
  end

  it "二千四百十四" do
    compare_kanji_and_integer("二千四百十四", 2414)
  end

  it "二千四百十五" do
    compare_kanji_and_integer("二千四百十五", 2415)
  end

  it "二千四百十六" do
    compare_kanji_and_integer("二千四百十六", 2416)
  end

  it "二千四百十七" do
    compare_kanji_and_integer("二千四百十七", 2417)
  end

  it "二千四百十八" do
    compare_kanji_and_integer("二千四百十八", 2418)
  end

  it "二千四百十九" do
    compare_kanji_and_integer("二千四百十九", 2419)
  end

  it "二千四百二十" do
    compare_kanji_and_integer("二千四百二十", 2420)
  end

  it "二千四百二十一" do
    compare_kanji_and_integer("二千四百二十一", 2421)
  end

  it "二千四百二十二" do
    compare_kanji_and_integer("二千四百二十二", 2422)
  end

  it "二千四百二十三" do
    compare_kanji_and_integer("二千四百二十三", 2423)
  end

  it "二千四百二十四" do
    compare_kanji_and_integer("二千四百二十四", 2424)
  end

  it "二千四百二十五" do
    compare_kanji_and_integer("二千四百二十五", 2425)
  end

  it "二千四百二十六" do
    compare_kanji_and_integer("二千四百二十六", 2426)
  end

  it "二千四百二十七" do
    compare_kanji_and_integer("二千四百二十七", 2427)
  end

  it "二千四百二十八" do
    compare_kanji_and_integer("二千四百二十八", 2428)
  end

  it "二千四百二十九" do
    compare_kanji_and_integer("二千四百二十九", 2429)
  end

  it "二千四百三十" do
    compare_kanji_and_integer("二千四百三十", 2430)
  end

  it "二千四百三十一" do
    compare_kanji_and_integer("二千四百三十一", 2431)
  end

  it "二千四百三十二" do
    compare_kanji_and_integer("二千四百三十二", 2432)
  end

  it "二千四百三十三" do
    compare_kanji_and_integer("二千四百三十三", 2433)
  end

  it "二千四百三十四" do
    compare_kanji_and_integer("二千四百三十四", 2434)
  end

  it "二千四百三十五" do
    compare_kanji_and_integer("二千四百三十五", 2435)
  end

  it "二千四百三十六" do
    compare_kanji_and_integer("二千四百三十六", 2436)
  end

  it "二千四百三十七" do
    compare_kanji_and_integer("二千四百三十七", 2437)
  end

  it "二千四百三十八" do
    compare_kanji_and_integer("二千四百三十八", 2438)
  end

  it "二千四百三十九" do
    compare_kanji_and_integer("二千四百三十九", 2439)
  end

  it "二千四百四十" do
    compare_kanji_and_integer("二千四百四十", 2440)
  end

  it "二千四百四十一" do
    compare_kanji_and_integer("二千四百四十一", 2441)
  end

  it "二千四百四十二" do
    compare_kanji_and_integer("二千四百四十二", 2442)
  end

  it "二千四百四十三" do
    compare_kanji_and_integer("二千四百四十三", 2443)
  end

  it "二千四百四十四" do
    compare_kanji_and_integer("二千四百四十四", 2444)
  end

  it "二千四百四十五" do
    compare_kanji_and_integer("二千四百四十五", 2445)
  end

  it "二千四百四十六" do
    compare_kanji_and_integer("二千四百四十六", 2446)
  end

  it "二千四百四十七" do
    compare_kanji_and_integer("二千四百四十七", 2447)
  end

  it "二千四百四十八" do
    compare_kanji_and_integer("二千四百四十八", 2448)
  end

  it "二千四百四十九" do
    compare_kanji_and_integer("二千四百四十九", 2449)
  end

  it "二千四百五十" do
    compare_kanji_and_integer("二千四百五十", 2450)
  end

  it "二千四百五十一" do
    compare_kanji_and_integer("二千四百五十一", 2451)
  end

  it "二千四百五十二" do
    compare_kanji_and_integer("二千四百五十二", 2452)
  end

  it "二千四百五十三" do
    compare_kanji_and_integer("二千四百五十三", 2453)
  end

  it "二千四百五十四" do
    compare_kanji_and_integer("二千四百五十四", 2454)
  end

  it "二千四百五十五" do
    compare_kanji_and_integer("二千四百五十五", 2455)
  end

  it "二千四百五十六" do
    compare_kanji_and_integer("二千四百五十六", 2456)
  end

  it "二千四百五十七" do
    compare_kanji_and_integer("二千四百五十七", 2457)
  end

  it "二千四百五十八" do
    compare_kanji_and_integer("二千四百五十八", 2458)
  end

  it "二千四百五十九" do
    compare_kanji_and_integer("二千四百五十九", 2459)
  end

  it "二千四百六十" do
    compare_kanji_and_integer("二千四百六十", 2460)
  end

  it "二千四百六十一" do
    compare_kanji_and_integer("二千四百六十一", 2461)
  end

  it "二千四百六十二" do
    compare_kanji_and_integer("二千四百六十二", 2462)
  end

  it "二千四百六十三" do
    compare_kanji_and_integer("二千四百六十三", 2463)
  end

  it "二千四百六十四" do
    compare_kanji_and_integer("二千四百六十四", 2464)
  end

  it "二千四百六十五" do
    compare_kanji_and_integer("二千四百六十五", 2465)
  end

  it "二千四百六十六" do
    compare_kanji_and_integer("二千四百六十六", 2466)
  end

  it "二千四百六十七" do
    compare_kanji_and_integer("二千四百六十七", 2467)
  end

  it "二千四百六十八" do
    compare_kanji_and_integer("二千四百六十八", 2468)
  end

  it "二千四百六十九" do
    compare_kanji_and_integer("二千四百六十九", 2469)
  end

  it "二千四百七十" do
    compare_kanji_and_integer("二千四百七十", 2470)
  end

  it "二千四百七十一" do
    compare_kanji_and_integer("二千四百七十一", 2471)
  end

  it "二千四百七十二" do
    compare_kanji_and_integer("二千四百七十二", 2472)
  end

  it "二千四百七十三" do
    compare_kanji_and_integer("二千四百七十三", 2473)
  end

  it "二千四百七十四" do
    compare_kanji_and_integer("二千四百七十四", 2474)
  end

  it "二千四百七十五" do
    compare_kanji_and_integer("二千四百七十五", 2475)
  end

  it "二千四百七十六" do
    compare_kanji_and_integer("二千四百七十六", 2476)
  end

  it "二千四百七十七" do
    compare_kanji_and_integer("二千四百七十七", 2477)
  end

  it "二千四百七十八" do
    compare_kanji_and_integer("二千四百七十八", 2478)
  end

  it "二千四百七十九" do
    compare_kanji_and_integer("二千四百七十九", 2479)
  end

  it "二千四百八十" do
    compare_kanji_and_integer("二千四百八十", 2480)
  end

  it "二千四百八十一" do
    compare_kanji_and_integer("二千四百八十一", 2481)
  end

  it "二千四百八十二" do
    compare_kanji_and_integer("二千四百八十二", 2482)
  end

  it "二千四百八十三" do
    compare_kanji_and_integer("二千四百八十三", 2483)
  end

  it "二千四百八十四" do
    compare_kanji_and_integer("二千四百八十四", 2484)
  end

  it "二千四百八十五" do
    compare_kanji_and_integer("二千四百八十五", 2485)
  end

  it "二千四百八十六" do
    compare_kanji_and_integer("二千四百八十六", 2486)
  end

  it "二千四百八十七" do
    compare_kanji_and_integer("二千四百八十七", 2487)
  end

  it "二千四百八十八" do
    compare_kanji_and_integer("二千四百八十八", 2488)
  end

  it "二千四百八十九" do
    compare_kanji_and_integer("二千四百八十九", 2489)
  end

  it "二千四百九十" do
    compare_kanji_and_integer("二千四百九十", 2490)
  end

  it "二千四百九十一" do
    compare_kanji_and_integer("二千四百九十一", 2491)
  end

  it "二千四百九十二" do
    compare_kanji_and_integer("二千四百九十二", 2492)
  end

  it "二千四百九十三" do
    compare_kanji_and_integer("二千四百九十三", 2493)
  end

  it "二千四百九十四" do
    compare_kanji_and_integer("二千四百九十四", 2494)
  end

  it "二千四百九十五" do
    compare_kanji_and_integer("二千四百九十五", 2495)
  end

  it "二千四百九十六" do
    compare_kanji_and_integer("二千四百九十六", 2496)
  end

  it "二千四百九十七" do
    compare_kanji_and_integer("二千四百九十七", 2497)
  end

  it "二千四百九十八" do
    compare_kanji_and_integer("二千四百九十八", 2498)
  end

  it "二千四百九十九" do
    compare_kanji_and_integer("二千四百九十九", 2499)
  end

  it "二千五百" do
    compare_kanji_and_integer("二千五百", 2500)
  end

  it "二千五百一" do
    compare_kanji_and_integer("二千五百一", 2501)
  end

  it "二千五百二" do
    compare_kanji_and_integer("二千五百二", 2502)
  end

  it "二千五百三" do
    compare_kanji_and_integer("二千五百三", 2503)
  end

  it "二千五百四" do
    compare_kanji_and_integer("二千五百四", 2504)
  end

  it "二千五百五" do
    compare_kanji_and_integer("二千五百五", 2505)
  end

  it "二千五百六" do
    compare_kanji_and_integer("二千五百六", 2506)
  end

  it "二千五百七" do
    compare_kanji_and_integer("二千五百七", 2507)
  end

  it "二千五百八" do
    compare_kanji_and_integer("二千五百八", 2508)
  end

  it "二千五百九" do
    compare_kanji_and_integer("二千五百九", 2509)
  end

  it "二千五百十" do
    compare_kanji_and_integer("二千五百十", 2510)
  end

  it "二千五百十一" do
    compare_kanji_and_integer("二千五百十一", 2511)
  end

  it "二千五百十二" do
    compare_kanji_and_integer("二千五百十二", 2512)
  end

  it "二千五百十三" do
    compare_kanji_and_integer("二千五百十三", 2513)
  end

  it "二千五百十四" do
    compare_kanji_and_integer("二千五百十四", 2514)
  end

  it "二千五百十五" do
    compare_kanji_and_integer("二千五百十五", 2515)
  end

  it "二千五百十六" do
    compare_kanji_and_integer("二千五百十六", 2516)
  end

  it "二千五百十七" do
    compare_kanji_and_integer("二千五百十七", 2517)
  end

  it "二千五百十八" do
    compare_kanji_and_integer("二千五百十八", 2518)
  end

  it "二千五百十九" do
    compare_kanji_and_integer("二千五百十九", 2519)
  end

  it "二千五百二十" do
    compare_kanji_and_integer("二千五百二十", 2520)
  end

  it "二千五百二十一" do
    compare_kanji_and_integer("二千五百二十一", 2521)
  end

  it "二千五百二十二" do
    compare_kanji_and_integer("二千五百二十二", 2522)
  end

  it "二千五百二十三" do
    compare_kanji_and_integer("二千五百二十三", 2523)
  end

  it "二千五百二十四" do
    compare_kanji_and_integer("二千五百二十四", 2524)
  end

  it "二千五百二十五" do
    compare_kanji_and_integer("二千五百二十五", 2525)
  end

  it "二千五百二十六" do
    compare_kanji_and_integer("二千五百二十六", 2526)
  end

  it "二千五百二十七" do
    compare_kanji_and_integer("二千五百二十七", 2527)
  end

  it "二千五百二十八" do
    compare_kanji_and_integer("二千五百二十八", 2528)
  end

  it "二千五百二十九" do
    compare_kanji_and_integer("二千五百二十九", 2529)
  end

  it "二千五百三十" do
    compare_kanji_and_integer("二千五百三十", 2530)
  end

  it "二千五百三十一" do
    compare_kanji_and_integer("二千五百三十一", 2531)
  end

  it "二千五百三十二" do
    compare_kanji_and_integer("二千五百三十二", 2532)
  end

  it "二千五百三十三" do
    compare_kanji_and_integer("二千五百三十三", 2533)
  end

  it "二千五百三十四" do
    compare_kanji_and_integer("二千五百三十四", 2534)
  end

  it "二千五百三十五" do
    compare_kanji_and_integer("二千五百三十五", 2535)
  end

  it "二千五百三十六" do
    compare_kanji_and_integer("二千五百三十六", 2536)
  end

  it "二千五百三十七" do
    compare_kanji_and_integer("二千五百三十七", 2537)
  end

  it "二千五百三十八" do
    compare_kanji_and_integer("二千五百三十八", 2538)
  end

  it "二千五百三十九" do
    compare_kanji_and_integer("二千五百三十九", 2539)
  end

  it "二千五百四十" do
    compare_kanji_and_integer("二千五百四十", 2540)
  end

  it "二千五百四十一" do
    compare_kanji_and_integer("二千五百四十一", 2541)
  end

  it "二千五百四十二" do
    compare_kanji_and_integer("二千五百四十二", 2542)
  end

  it "二千五百四十三" do
    compare_kanji_and_integer("二千五百四十三", 2543)
  end

  it "二千五百四十四" do
    compare_kanji_and_integer("二千五百四十四", 2544)
  end

  it "二千五百四十五" do
    compare_kanji_and_integer("二千五百四十五", 2545)
  end

  it "二千五百四十六" do
    compare_kanji_and_integer("二千五百四十六", 2546)
  end

  it "二千五百四十七" do
    compare_kanji_and_integer("二千五百四十七", 2547)
  end

  it "二千五百四十八" do
    compare_kanji_and_integer("二千五百四十八", 2548)
  end

  it "二千五百四十九" do
    compare_kanji_and_integer("二千五百四十九", 2549)
  end

  it "二千五百五十" do
    compare_kanji_and_integer("二千五百五十", 2550)
  end

  it "二千五百五十一" do
    compare_kanji_and_integer("二千五百五十一", 2551)
  end

  it "二千五百五十二" do
    compare_kanji_and_integer("二千五百五十二", 2552)
  end

  it "二千五百五十三" do
    compare_kanji_and_integer("二千五百五十三", 2553)
  end

  it "二千五百五十四" do
    compare_kanji_and_integer("二千五百五十四", 2554)
  end

  it "二千五百五十五" do
    compare_kanji_and_integer("二千五百五十五", 2555)
  end

  it "二千五百五十六" do
    compare_kanji_and_integer("二千五百五十六", 2556)
  end

  it "二千五百五十七" do
    compare_kanji_and_integer("二千五百五十七", 2557)
  end

  it "二千五百五十八" do
    compare_kanji_and_integer("二千五百五十八", 2558)
  end

  it "二千五百五十九" do
    compare_kanji_and_integer("二千五百五十九", 2559)
  end

  it "二千五百六十" do
    compare_kanji_and_integer("二千五百六十", 2560)
  end

  it "二千五百六十一" do
    compare_kanji_and_integer("二千五百六十一", 2561)
  end

  it "二千五百六十二" do
    compare_kanji_and_integer("二千五百六十二", 2562)
  end

  it "二千五百六十三" do
    compare_kanji_and_integer("二千五百六十三", 2563)
  end

  it "二千五百六十四" do
    compare_kanji_and_integer("二千五百六十四", 2564)
  end

  it "二千五百六十五" do
    compare_kanji_and_integer("二千五百六十五", 2565)
  end

  it "二千五百六十六" do
    compare_kanji_and_integer("二千五百六十六", 2566)
  end

  it "二千五百六十七" do
    compare_kanji_and_integer("二千五百六十七", 2567)
  end

  it "二千五百六十八" do
    compare_kanji_and_integer("二千五百六十八", 2568)
  end

  it "二千五百六十九" do
    compare_kanji_and_integer("二千五百六十九", 2569)
  end

  it "二千五百七十" do
    compare_kanji_and_integer("二千五百七十", 2570)
  end

  it "二千五百七十一" do
    compare_kanji_and_integer("二千五百七十一", 2571)
  end

  it "二千五百七十二" do
    compare_kanji_and_integer("二千五百七十二", 2572)
  end

  it "二千五百七十三" do
    compare_kanji_and_integer("二千五百七十三", 2573)
  end

  it "二千五百七十四" do
    compare_kanji_and_integer("二千五百七十四", 2574)
  end

  it "二千五百七十五" do
    compare_kanji_and_integer("二千五百七十五", 2575)
  end

  it "二千五百七十六" do
    compare_kanji_and_integer("二千五百七十六", 2576)
  end

  it "二千五百七十七" do
    compare_kanji_and_integer("二千五百七十七", 2577)
  end

  it "二千五百七十八" do
    compare_kanji_and_integer("二千五百七十八", 2578)
  end

  it "二千五百七十九" do
    compare_kanji_and_integer("二千五百七十九", 2579)
  end

  it "二千五百八十" do
    compare_kanji_and_integer("二千五百八十", 2580)
  end

  it "二千五百八十一" do
    compare_kanji_and_integer("二千五百八十一", 2581)
  end

  it "二千五百八十二" do
    compare_kanji_and_integer("二千五百八十二", 2582)
  end

  it "二千五百八十三" do
    compare_kanji_and_integer("二千五百八十三", 2583)
  end

  it "二千五百八十四" do
    compare_kanji_and_integer("二千五百八十四", 2584)
  end

  it "二千五百八十五" do
    compare_kanji_and_integer("二千五百八十五", 2585)
  end

  it "二千五百八十六" do
    compare_kanji_and_integer("二千五百八十六", 2586)
  end

  it "二千五百八十七" do
    compare_kanji_and_integer("二千五百八十七", 2587)
  end

  it "二千五百八十八" do
    compare_kanji_and_integer("二千五百八十八", 2588)
  end

  it "二千五百八十九" do
    compare_kanji_and_integer("二千五百八十九", 2589)
  end

  it "二千五百九十" do
    compare_kanji_and_integer("二千五百九十", 2590)
  end

  it "二千五百九十一" do
    compare_kanji_and_integer("二千五百九十一", 2591)
  end

  it "二千五百九十二" do
    compare_kanji_and_integer("二千五百九十二", 2592)
  end

  it "二千五百九十三" do
    compare_kanji_and_integer("二千五百九十三", 2593)
  end

  it "二千五百九十四" do
    compare_kanji_and_integer("二千五百九十四", 2594)
  end

  it "二千五百九十五" do
    compare_kanji_and_integer("二千五百九十五", 2595)
  end

  it "二千五百九十六" do
    compare_kanji_and_integer("二千五百九十六", 2596)
  end

  it "二千五百九十七" do
    compare_kanji_and_integer("二千五百九十七", 2597)
  end

  it "二千五百九十八" do
    compare_kanji_and_integer("二千五百九十八", 2598)
  end

  it "二千五百九十九" do
    compare_kanji_and_integer("二千五百九十九", 2599)
  end

  it "二千六百" do
    compare_kanji_and_integer("二千六百", 2600)
  end

  it "二千六百一" do
    compare_kanji_and_integer("二千六百一", 2601)
  end

  it "二千六百二" do
    compare_kanji_and_integer("二千六百二", 2602)
  end

  it "二千六百三" do
    compare_kanji_and_integer("二千六百三", 2603)
  end

  it "二千六百四" do
    compare_kanji_and_integer("二千六百四", 2604)
  end

  it "二千六百五" do
    compare_kanji_and_integer("二千六百五", 2605)
  end

  it "二千六百六" do
    compare_kanji_and_integer("二千六百六", 2606)
  end

  it "二千六百七" do
    compare_kanji_and_integer("二千六百七", 2607)
  end

  it "二千六百八" do
    compare_kanji_and_integer("二千六百八", 2608)
  end

  it "二千六百九" do
    compare_kanji_and_integer("二千六百九", 2609)
  end

  it "二千六百十" do
    compare_kanji_and_integer("二千六百十", 2610)
  end

  it "二千六百十一" do
    compare_kanji_and_integer("二千六百十一", 2611)
  end

  it "二千六百十二" do
    compare_kanji_and_integer("二千六百十二", 2612)
  end

  it "二千六百十三" do
    compare_kanji_and_integer("二千六百十三", 2613)
  end

  it "二千六百十四" do
    compare_kanji_and_integer("二千六百十四", 2614)
  end

  it "二千六百十五" do
    compare_kanji_and_integer("二千六百十五", 2615)
  end

  it "二千六百十六" do
    compare_kanji_and_integer("二千六百十六", 2616)
  end

  it "二千六百十七" do
    compare_kanji_and_integer("二千六百十七", 2617)
  end

  it "二千六百十八" do
    compare_kanji_and_integer("二千六百十八", 2618)
  end

  it "二千六百十九" do
    compare_kanji_and_integer("二千六百十九", 2619)
  end

  it "二千六百二十" do
    compare_kanji_and_integer("二千六百二十", 2620)
  end

  it "二千六百二十一" do
    compare_kanji_and_integer("二千六百二十一", 2621)
  end

  it "二千六百二十二" do
    compare_kanji_and_integer("二千六百二十二", 2622)
  end

  it "二千六百二十三" do
    compare_kanji_and_integer("二千六百二十三", 2623)
  end

  it "二千六百二十四" do
    compare_kanji_and_integer("二千六百二十四", 2624)
  end

  it "二千六百二十五" do
    compare_kanji_and_integer("二千六百二十五", 2625)
  end

  it "二千六百二十六" do
    compare_kanji_and_integer("二千六百二十六", 2626)
  end

  it "二千六百二十七" do
    compare_kanji_and_integer("二千六百二十七", 2627)
  end

  it "二千六百二十八" do
    compare_kanji_and_integer("二千六百二十八", 2628)
  end

  it "二千六百二十九" do
    compare_kanji_and_integer("二千六百二十九", 2629)
  end

  it "二千六百三十" do
    compare_kanji_and_integer("二千六百三十", 2630)
  end

  it "二千六百三十一" do
    compare_kanji_and_integer("二千六百三十一", 2631)
  end

  it "二千六百三十二" do
    compare_kanji_and_integer("二千六百三十二", 2632)
  end

  it "二千六百三十三" do
    compare_kanji_and_integer("二千六百三十三", 2633)
  end

  it "二千六百三十四" do
    compare_kanji_and_integer("二千六百三十四", 2634)
  end

  it "二千六百三十五" do
    compare_kanji_and_integer("二千六百三十五", 2635)
  end

  it "二千六百三十六" do
    compare_kanji_and_integer("二千六百三十六", 2636)
  end

  it "二千六百三十七" do
    compare_kanji_and_integer("二千六百三十七", 2637)
  end

  it "二千六百三十八" do
    compare_kanji_and_integer("二千六百三十八", 2638)
  end

  it "二千六百三十九" do
    compare_kanji_and_integer("二千六百三十九", 2639)
  end

  it "二千六百四十" do
    compare_kanji_and_integer("二千六百四十", 2640)
  end

  it "二千六百四十一" do
    compare_kanji_and_integer("二千六百四十一", 2641)
  end

  it "二千六百四十二" do
    compare_kanji_and_integer("二千六百四十二", 2642)
  end

  it "二千六百四十三" do
    compare_kanji_and_integer("二千六百四十三", 2643)
  end

  it "二千六百四十四" do
    compare_kanji_and_integer("二千六百四十四", 2644)
  end

  it "二千六百四十五" do
    compare_kanji_and_integer("二千六百四十五", 2645)
  end

  it "二千六百四十六" do
    compare_kanji_and_integer("二千六百四十六", 2646)
  end

  it "二千六百四十七" do
    compare_kanji_and_integer("二千六百四十七", 2647)
  end

  it "二千六百四十八" do
    compare_kanji_and_integer("二千六百四十八", 2648)
  end

  it "二千六百四十九" do
    compare_kanji_and_integer("二千六百四十九", 2649)
  end

  it "二千六百五十" do
    compare_kanji_and_integer("二千六百五十", 2650)
  end

  it "二千六百五十一" do
    compare_kanji_and_integer("二千六百五十一", 2651)
  end

  it "二千六百五十二" do
    compare_kanji_and_integer("二千六百五十二", 2652)
  end

  it "二千六百五十三" do
    compare_kanji_and_integer("二千六百五十三", 2653)
  end

  it "二千六百五十四" do
    compare_kanji_and_integer("二千六百五十四", 2654)
  end

  it "二千六百五十五" do
    compare_kanji_and_integer("二千六百五十五", 2655)
  end

  it "二千六百五十六" do
    compare_kanji_and_integer("二千六百五十六", 2656)
  end

  it "二千六百五十七" do
    compare_kanji_and_integer("二千六百五十七", 2657)
  end

  it "二千六百五十八" do
    compare_kanji_and_integer("二千六百五十八", 2658)
  end

  it "二千六百五十九" do
    compare_kanji_and_integer("二千六百五十九", 2659)
  end

  it "二千六百六十" do
    compare_kanji_and_integer("二千六百六十", 2660)
  end

  it "二千六百六十一" do
    compare_kanji_and_integer("二千六百六十一", 2661)
  end

  it "二千六百六十二" do
    compare_kanji_and_integer("二千六百六十二", 2662)
  end

  it "二千六百六十三" do
    compare_kanji_and_integer("二千六百六十三", 2663)
  end

  it "二千六百六十四" do
    compare_kanji_and_integer("二千六百六十四", 2664)
  end

  it "二千六百六十五" do
    compare_kanji_and_integer("二千六百六十五", 2665)
  end

  it "二千六百六十六" do
    compare_kanji_and_integer("二千六百六十六", 2666)
  end

  it "二千六百六十七" do
    compare_kanji_and_integer("二千六百六十七", 2667)
  end

  it "二千六百六十八" do
    compare_kanji_and_integer("二千六百六十八", 2668)
  end

  it "二千六百六十九" do
    compare_kanji_and_integer("二千六百六十九", 2669)
  end

  it "二千六百七十" do
    compare_kanji_and_integer("二千六百七十", 2670)
  end

  it "二千六百七十一" do
    compare_kanji_and_integer("二千六百七十一", 2671)
  end

  it "二千六百七十二" do
    compare_kanji_and_integer("二千六百七十二", 2672)
  end

  it "二千六百七十三" do
    compare_kanji_and_integer("二千六百七十三", 2673)
  end

  it "二千六百七十四" do
    compare_kanji_and_integer("二千六百七十四", 2674)
  end

  it "二千六百七十五" do
    compare_kanji_and_integer("二千六百七十五", 2675)
  end

  it "二千六百七十六" do
    compare_kanji_and_integer("二千六百七十六", 2676)
  end

  it "二千六百七十七" do
    compare_kanji_and_integer("二千六百七十七", 2677)
  end

  it "二千六百七十八" do
    compare_kanji_and_integer("二千六百七十八", 2678)
  end

  it "二千六百七十九" do
    compare_kanji_and_integer("二千六百七十九", 2679)
  end

  it "二千六百八十" do
    compare_kanji_and_integer("二千六百八十", 2680)
  end

  it "二千六百八十一" do
    compare_kanji_and_integer("二千六百八十一", 2681)
  end

  it "二千六百八十二" do
    compare_kanji_and_integer("二千六百八十二", 2682)
  end

  it "二千六百八十三" do
    compare_kanji_and_integer("二千六百八十三", 2683)
  end

  it "二千六百八十四" do
    compare_kanji_and_integer("二千六百八十四", 2684)
  end

  it "二千六百八十五" do
    compare_kanji_and_integer("二千六百八十五", 2685)
  end

  it "二千六百八十六" do
    compare_kanji_and_integer("二千六百八十六", 2686)
  end

  it "二千六百八十七" do
    compare_kanji_and_integer("二千六百八十七", 2687)
  end

  it "二千六百八十八" do
    compare_kanji_and_integer("二千六百八十八", 2688)
  end

  it "二千六百八十九" do
    compare_kanji_and_integer("二千六百八十九", 2689)
  end

  it "二千六百九十" do
    compare_kanji_and_integer("二千六百九十", 2690)
  end

  it "二千六百九十一" do
    compare_kanji_and_integer("二千六百九十一", 2691)
  end

  it "二千六百九十二" do
    compare_kanji_and_integer("二千六百九十二", 2692)
  end

  it "二千六百九十三" do
    compare_kanji_and_integer("二千六百九十三", 2693)
  end

  it "二千六百九十四" do
    compare_kanji_and_integer("二千六百九十四", 2694)
  end

  it "二千六百九十五" do
    compare_kanji_and_integer("二千六百九十五", 2695)
  end

  it "二千六百九十六" do
    compare_kanji_and_integer("二千六百九十六", 2696)
  end

  it "二千六百九十七" do
    compare_kanji_and_integer("二千六百九十七", 2697)
  end

  it "二千六百九十八" do
    compare_kanji_and_integer("二千六百九十八", 2698)
  end

  it "二千六百九十九" do
    compare_kanji_and_integer("二千六百九十九", 2699)
  end

  it "二千七百" do
    compare_kanji_and_integer("二千七百", 2700)
  end

  it "二千七百一" do
    compare_kanji_and_integer("二千七百一", 2701)
  end

  it "二千七百二" do
    compare_kanji_and_integer("二千七百二", 2702)
  end

  it "二千七百三" do
    compare_kanji_and_integer("二千七百三", 2703)
  end

  it "二千七百四" do
    compare_kanji_and_integer("二千七百四", 2704)
  end

  it "二千七百五" do
    compare_kanji_and_integer("二千七百五", 2705)
  end

  it "二千七百六" do
    compare_kanji_and_integer("二千七百六", 2706)
  end

  it "二千七百七" do
    compare_kanji_and_integer("二千七百七", 2707)
  end

  it "二千七百八" do
    compare_kanji_and_integer("二千七百八", 2708)
  end

  it "二千七百九" do
    compare_kanji_and_integer("二千七百九", 2709)
  end

  it "二千七百十" do
    compare_kanji_and_integer("二千七百十", 2710)
  end

  it "二千七百十一" do
    compare_kanji_and_integer("二千七百十一", 2711)
  end

  it "二千七百十二" do
    compare_kanji_and_integer("二千七百十二", 2712)
  end

  it "二千七百十三" do
    compare_kanji_and_integer("二千七百十三", 2713)
  end

  it "二千七百十四" do
    compare_kanji_and_integer("二千七百十四", 2714)
  end

  it "二千七百十五" do
    compare_kanji_and_integer("二千七百十五", 2715)
  end

  it "二千七百十六" do
    compare_kanji_and_integer("二千七百十六", 2716)
  end

  it "二千七百十七" do
    compare_kanji_and_integer("二千七百十七", 2717)
  end

  it "二千七百十八" do
    compare_kanji_and_integer("二千七百十八", 2718)
  end

  it "二千七百十九" do
    compare_kanji_and_integer("二千七百十九", 2719)
  end

  it "二千七百二十" do
    compare_kanji_and_integer("二千七百二十", 2720)
  end

  it "二千七百二十一" do
    compare_kanji_and_integer("二千七百二十一", 2721)
  end

  it "二千七百二十二" do
    compare_kanji_and_integer("二千七百二十二", 2722)
  end

  it "二千七百二十三" do
    compare_kanji_and_integer("二千七百二十三", 2723)
  end

  it "二千七百二十四" do
    compare_kanji_and_integer("二千七百二十四", 2724)
  end

  it "二千七百二十五" do
    compare_kanji_and_integer("二千七百二十五", 2725)
  end

  it "二千七百二十六" do
    compare_kanji_and_integer("二千七百二十六", 2726)
  end

  it "二千七百二十七" do
    compare_kanji_and_integer("二千七百二十七", 2727)
  end

  it "二千七百二十八" do
    compare_kanji_and_integer("二千七百二十八", 2728)
  end

  it "二千七百二十九" do
    compare_kanji_and_integer("二千七百二十九", 2729)
  end

  it "二千七百三十" do
    compare_kanji_and_integer("二千七百三十", 2730)
  end

  it "二千七百三十一" do
    compare_kanji_and_integer("二千七百三十一", 2731)
  end

  it "二千七百三十二" do
    compare_kanji_and_integer("二千七百三十二", 2732)
  end

  it "二千七百三十三" do
    compare_kanji_and_integer("二千七百三十三", 2733)
  end

  it "二千七百三十四" do
    compare_kanji_and_integer("二千七百三十四", 2734)
  end

  it "二千七百三十五" do
    compare_kanji_and_integer("二千七百三十五", 2735)
  end

  it "二千七百三十六" do
    compare_kanji_and_integer("二千七百三十六", 2736)
  end

  it "二千七百三十七" do
    compare_kanji_and_integer("二千七百三十七", 2737)
  end

  it "二千七百三十八" do
    compare_kanji_and_integer("二千七百三十八", 2738)
  end

  it "二千七百三十九" do
    compare_kanji_and_integer("二千七百三十九", 2739)
  end

  it "二千七百四十" do
    compare_kanji_and_integer("二千七百四十", 2740)
  end

  it "二千七百四十一" do
    compare_kanji_and_integer("二千七百四十一", 2741)
  end

  it "二千七百四十二" do
    compare_kanji_and_integer("二千七百四十二", 2742)
  end

  it "二千七百四十三" do
    compare_kanji_and_integer("二千七百四十三", 2743)
  end

  it "二千七百四十四" do
    compare_kanji_and_integer("二千七百四十四", 2744)
  end

  it "二千七百四十五" do
    compare_kanji_and_integer("二千七百四十五", 2745)
  end

  it "二千七百四十六" do
    compare_kanji_and_integer("二千七百四十六", 2746)
  end

  it "二千七百四十七" do
    compare_kanji_and_integer("二千七百四十七", 2747)
  end

  it "二千七百四十八" do
    compare_kanji_and_integer("二千七百四十八", 2748)
  end

  it "二千七百四十九" do
    compare_kanji_and_integer("二千七百四十九", 2749)
  end

  it "二千七百五十" do
    compare_kanji_and_integer("二千七百五十", 2750)
  end

  it "二千七百五十一" do
    compare_kanji_and_integer("二千七百五十一", 2751)
  end

  it "二千七百五十二" do
    compare_kanji_and_integer("二千七百五十二", 2752)
  end

  it "二千七百五十三" do
    compare_kanji_and_integer("二千七百五十三", 2753)
  end

  it "二千七百五十四" do
    compare_kanji_and_integer("二千七百五十四", 2754)
  end

  it "二千七百五十五" do
    compare_kanji_and_integer("二千七百五十五", 2755)
  end

  it "二千七百五十六" do
    compare_kanji_and_integer("二千七百五十六", 2756)
  end

  it "二千七百五十七" do
    compare_kanji_and_integer("二千七百五十七", 2757)
  end

  it "二千七百五十八" do
    compare_kanji_and_integer("二千七百五十八", 2758)
  end

  it "二千七百五十九" do
    compare_kanji_and_integer("二千七百五十九", 2759)
  end

  it "二千七百六十" do
    compare_kanji_and_integer("二千七百六十", 2760)
  end

  it "二千七百六十一" do
    compare_kanji_and_integer("二千七百六十一", 2761)
  end

  it "二千七百六十二" do
    compare_kanji_and_integer("二千七百六十二", 2762)
  end

  it "二千七百六十三" do
    compare_kanji_and_integer("二千七百六十三", 2763)
  end

  it "二千七百六十四" do
    compare_kanji_and_integer("二千七百六十四", 2764)
  end

  it "二千七百六十五" do
    compare_kanji_and_integer("二千七百六十五", 2765)
  end

  it "二千七百六十六" do
    compare_kanji_and_integer("二千七百六十六", 2766)
  end

  it "二千七百六十七" do
    compare_kanji_and_integer("二千七百六十七", 2767)
  end

  it "二千七百六十八" do
    compare_kanji_and_integer("二千七百六十八", 2768)
  end

  it "二千七百六十九" do
    compare_kanji_and_integer("二千七百六十九", 2769)
  end

  it "二千七百七十" do
    compare_kanji_and_integer("二千七百七十", 2770)
  end

  it "二千七百七十一" do
    compare_kanji_and_integer("二千七百七十一", 2771)
  end

  it "二千七百七十二" do
    compare_kanji_and_integer("二千七百七十二", 2772)
  end

  it "二千七百七十三" do
    compare_kanji_and_integer("二千七百七十三", 2773)
  end

  it "二千七百七十四" do
    compare_kanji_and_integer("二千七百七十四", 2774)
  end

  it "二千七百七十五" do
    compare_kanji_and_integer("二千七百七十五", 2775)
  end

  it "二千七百七十六" do
    compare_kanji_and_integer("二千七百七十六", 2776)
  end

  it "二千七百七十七" do
    compare_kanji_and_integer("二千七百七十七", 2777)
  end

  it "二千七百七十八" do
    compare_kanji_and_integer("二千七百七十八", 2778)
  end

  it "二千七百七十九" do
    compare_kanji_and_integer("二千七百七十九", 2779)
  end

  it "二千七百八十" do
    compare_kanji_and_integer("二千七百八十", 2780)
  end

  it "二千七百八十一" do
    compare_kanji_and_integer("二千七百八十一", 2781)
  end

  it "二千七百八十二" do
    compare_kanji_and_integer("二千七百八十二", 2782)
  end

  it "二千七百八十三" do
    compare_kanji_and_integer("二千七百八十三", 2783)
  end

  it "二千七百八十四" do
    compare_kanji_and_integer("二千七百八十四", 2784)
  end

  it "二千七百八十五" do
    compare_kanji_and_integer("二千七百八十五", 2785)
  end

  it "二千七百八十六" do
    compare_kanji_and_integer("二千七百八十六", 2786)
  end

  it "二千七百八十七" do
    compare_kanji_and_integer("二千七百八十七", 2787)
  end

  it "二千七百八十八" do
    compare_kanji_and_integer("二千七百八十八", 2788)
  end

  it "二千七百八十九" do
    compare_kanji_and_integer("二千七百八十九", 2789)
  end

  it "二千七百九十" do
    compare_kanji_and_integer("二千七百九十", 2790)
  end

  it "二千七百九十一" do
    compare_kanji_and_integer("二千七百九十一", 2791)
  end

  it "二千七百九十二" do
    compare_kanji_and_integer("二千七百九十二", 2792)
  end

  it "二千七百九十三" do
    compare_kanji_and_integer("二千七百九十三", 2793)
  end

  it "二千七百九十四" do
    compare_kanji_and_integer("二千七百九十四", 2794)
  end

  it "二千七百九十五" do
    compare_kanji_and_integer("二千七百九十五", 2795)
  end

  it "二千七百九十六" do
    compare_kanji_and_integer("二千七百九十六", 2796)
  end

  it "二千七百九十七" do
    compare_kanji_and_integer("二千七百九十七", 2797)
  end

  it "二千七百九十八" do
    compare_kanji_and_integer("二千七百九十八", 2798)
  end

  it "二千七百九十九" do
    compare_kanji_and_integer("二千七百九十九", 2799)
  end

  it "二千八百" do
    compare_kanji_and_integer("二千八百", 2800)
  end

  it "二千八百一" do
    compare_kanji_and_integer("二千八百一", 2801)
  end

  it "二千八百二" do
    compare_kanji_and_integer("二千八百二", 2802)
  end

  it "二千八百三" do
    compare_kanji_and_integer("二千八百三", 2803)
  end

  it "二千八百四" do
    compare_kanji_and_integer("二千八百四", 2804)
  end

  it "二千八百五" do
    compare_kanji_and_integer("二千八百五", 2805)
  end

  it "二千八百六" do
    compare_kanji_and_integer("二千八百六", 2806)
  end

  it "二千八百七" do
    compare_kanji_and_integer("二千八百七", 2807)
  end

  it "二千八百八" do
    compare_kanji_and_integer("二千八百八", 2808)
  end

  it "二千八百九" do
    compare_kanji_and_integer("二千八百九", 2809)
  end

  it "二千八百十" do
    compare_kanji_and_integer("二千八百十", 2810)
  end

  it "二千八百十一" do
    compare_kanji_and_integer("二千八百十一", 2811)
  end

  it "二千八百十二" do
    compare_kanji_and_integer("二千八百十二", 2812)
  end

  it "二千八百十三" do
    compare_kanji_and_integer("二千八百十三", 2813)
  end

  it "二千八百十四" do
    compare_kanji_and_integer("二千八百十四", 2814)
  end

  it "二千八百十五" do
    compare_kanji_and_integer("二千八百十五", 2815)
  end

  it "二千八百十六" do
    compare_kanji_and_integer("二千八百十六", 2816)
  end

  it "二千八百十七" do
    compare_kanji_and_integer("二千八百十七", 2817)
  end

  it "二千八百十八" do
    compare_kanji_and_integer("二千八百十八", 2818)
  end

  it "二千八百十九" do
    compare_kanji_and_integer("二千八百十九", 2819)
  end

  it "二千八百二十" do
    compare_kanji_and_integer("二千八百二十", 2820)
  end

  it "二千八百二十一" do
    compare_kanji_and_integer("二千八百二十一", 2821)
  end

  it "二千八百二十二" do
    compare_kanji_and_integer("二千八百二十二", 2822)
  end

  it "二千八百二十三" do
    compare_kanji_and_integer("二千八百二十三", 2823)
  end

  it "二千八百二十四" do
    compare_kanji_and_integer("二千八百二十四", 2824)
  end

  it "二千八百二十五" do
    compare_kanji_and_integer("二千八百二十五", 2825)
  end

  it "二千八百二十六" do
    compare_kanji_and_integer("二千八百二十六", 2826)
  end

  it "二千八百二十七" do
    compare_kanji_and_integer("二千八百二十七", 2827)
  end

  it "二千八百二十八" do
    compare_kanji_and_integer("二千八百二十八", 2828)
  end

  it "二千八百二十九" do
    compare_kanji_and_integer("二千八百二十九", 2829)
  end

  it "二千八百三十" do
    compare_kanji_and_integer("二千八百三十", 2830)
  end

  it "二千八百三十一" do
    compare_kanji_and_integer("二千八百三十一", 2831)
  end

  it "二千八百三十二" do
    compare_kanji_and_integer("二千八百三十二", 2832)
  end

  it "二千八百三十三" do
    compare_kanji_and_integer("二千八百三十三", 2833)
  end

  it "二千八百三十四" do
    compare_kanji_and_integer("二千八百三十四", 2834)
  end

  it "二千八百三十五" do
    compare_kanji_and_integer("二千八百三十五", 2835)
  end

  it "二千八百三十六" do
    compare_kanji_and_integer("二千八百三十六", 2836)
  end

  it "二千八百三十七" do
    compare_kanji_and_integer("二千八百三十七", 2837)
  end

  it "二千八百三十八" do
    compare_kanji_and_integer("二千八百三十八", 2838)
  end

  it "二千八百三十九" do
    compare_kanji_and_integer("二千八百三十九", 2839)
  end

  it "二千八百四十" do
    compare_kanji_and_integer("二千八百四十", 2840)
  end

  it "二千八百四十一" do
    compare_kanji_and_integer("二千八百四十一", 2841)
  end

  it "二千八百四十二" do
    compare_kanji_and_integer("二千八百四十二", 2842)
  end

  it "二千八百四十三" do
    compare_kanji_and_integer("二千八百四十三", 2843)
  end

  it "二千八百四十四" do
    compare_kanji_and_integer("二千八百四十四", 2844)
  end

  it "二千八百四十五" do
    compare_kanji_and_integer("二千八百四十五", 2845)
  end

  it "二千八百四十六" do
    compare_kanji_and_integer("二千八百四十六", 2846)
  end

  it "二千八百四十七" do
    compare_kanji_and_integer("二千八百四十七", 2847)
  end

  it "二千八百四十八" do
    compare_kanji_and_integer("二千八百四十八", 2848)
  end

  it "二千八百四十九" do
    compare_kanji_and_integer("二千八百四十九", 2849)
  end

  it "二千八百五十" do
    compare_kanji_and_integer("二千八百五十", 2850)
  end

  it "二千八百五十一" do
    compare_kanji_and_integer("二千八百五十一", 2851)
  end

  it "二千八百五十二" do
    compare_kanji_and_integer("二千八百五十二", 2852)
  end

  it "二千八百五十三" do
    compare_kanji_and_integer("二千八百五十三", 2853)
  end

  it "二千八百五十四" do
    compare_kanji_and_integer("二千八百五十四", 2854)
  end

  it "二千八百五十五" do
    compare_kanji_and_integer("二千八百五十五", 2855)
  end

  it "二千八百五十六" do
    compare_kanji_and_integer("二千八百五十六", 2856)
  end

  it "二千八百五十七" do
    compare_kanji_and_integer("二千八百五十七", 2857)
  end

  it "二千八百五十八" do
    compare_kanji_and_integer("二千八百五十八", 2858)
  end

  it "二千八百五十九" do
    compare_kanji_and_integer("二千八百五十九", 2859)
  end

  it "二千八百六十" do
    compare_kanji_and_integer("二千八百六十", 2860)
  end

  it "二千八百六十一" do
    compare_kanji_and_integer("二千八百六十一", 2861)
  end

  it "二千八百六十二" do
    compare_kanji_and_integer("二千八百六十二", 2862)
  end

  it "二千八百六十三" do
    compare_kanji_and_integer("二千八百六十三", 2863)
  end

  it "二千八百六十四" do
    compare_kanji_and_integer("二千八百六十四", 2864)
  end

  it "二千八百六十五" do
    compare_kanji_and_integer("二千八百六十五", 2865)
  end

  it "二千八百六十六" do
    compare_kanji_and_integer("二千八百六十六", 2866)
  end

  it "二千八百六十七" do
    compare_kanji_and_integer("二千八百六十七", 2867)
  end

  it "二千八百六十八" do
    compare_kanji_and_integer("二千八百六十八", 2868)
  end

  it "二千八百六十九" do
    compare_kanji_and_integer("二千八百六十九", 2869)
  end

  it "二千八百七十" do
    compare_kanji_and_integer("二千八百七十", 2870)
  end

  it "二千八百七十一" do
    compare_kanji_and_integer("二千八百七十一", 2871)
  end

  it "二千八百七十二" do
    compare_kanji_and_integer("二千八百七十二", 2872)
  end

  it "二千八百七十三" do
    compare_kanji_and_integer("二千八百七十三", 2873)
  end

  it "二千八百七十四" do
    compare_kanji_and_integer("二千八百七十四", 2874)
  end

  it "二千八百七十五" do
    compare_kanji_and_integer("二千八百七十五", 2875)
  end

  it "二千八百七十六" do
    compare_kanji_and_integer("二千八百七十六", 2876)
  end

  it "二千八百七十七" do
    compare_kanji_and_integer("二千八百七十七", 2877)
  end

  it "二千八百七十八" do
    compare_kanji_and_integer("二千八百七十八", 2878)
  end

  it "二千八百七十九" do
    compare_kanji_and_integer("二千八百七十九", 2879)
  end

  it "二千八百八十" do
    compare_kanji_and_integer("二千八百八十", 2880)
  end

  it "二千八百八十一" do
    compare_kanji_and_integer("二千八百八十一", 2881)
  end

  it "二千八百八十二" do
    compare_kanji_and_integer("二千八百八十二", 2882)
  end

  it "二千八百八十三" do
    compare_kanji_and_integer("二千八百八十三", 2883)
  end

  it "二千八百八十四" do
    compare_kanji_and_integer("二千八百八十四", 2884)
  end

  it "二千八百八十五" do
    compare_kanji_and_integer("二千八百八十五", 2885)
  end

  it "二千八百八十六" do
    compare_kanji_and_integer("二千八百八十六", 2886)
  end

  it "二千八百八十七" do
    compare_kanji_and_integer("二千八百八十七", 2887)
  end

  it "二千八百八十八" do
    compare_kanji_and_integer("二千八百八十八", 2888)
  end

  it "二千八百八十九" do
    compare_kanji_and_integer("二千八百八十九", 2889)
  end

  it "二千八百九十" do
    compare_kanji_and_integer("二千八百九十", 2890)
  end

  it "二千八百九十一" do
    compare_kanji_and_integer("二千八百九十一", 2891)
  end

  it "二千八百九十二" do
    compare_kanji_and_integer("二千八百九十二", 2892)
  end

  it "二千八百九十三" do
    compare_kanji_and_integer("二千八百九十三", 2893)
  end

  it "二千八百九十四" do
    compare_kanji_and_integer("二千八百九十四", 2894)
  end

  it "二千八百九十五" do
    compare_kanji_and_integer("二千八百九十五", 2895)
  end

  it "二千八百九十六" do
    compare_kanji_and_integer("二千八百九十六", 2896)
  end

  it "二千八百九十七" do
    compare_kanji_and_integer("二千八百九十七", 2897)
  end

  it "二千八百九十八" do
    compare_kanji_and_integer("二千八百九十八", 2898)
  end

  it "二千八百九十九" do
    compare_kanji_and_integer("二千八百九十九", 2899)
  end

  it "二千九百" do
    compare_kanji_and_integer("二千九百", 2900)
  end

  it "二千九百一" do
    compare_kanji_and_integer("二千九百一", 2901)
  end

  it "二千九百二" do
    compare_kanji_and_integer("二千九百二", 2902)
  end

  it "二千九百三" do
    compare_kanji_and_integer("二千九百三", 2903)
  end

  it "二千九百四" do
    compare_kanji_and_integer("二千九百四", 2904)
  end

  it "二千九百五" do
    compare_kanji_and_integer("二千九百五", 2905)
  end

  it "二千九百六" do
    compare_kanji_and_integer("二千九百六", 2906)
  end

  it "二千九百七" do
    compare_kanji_and_integer("二千九百七", 2907)
  end

  it "二千九百八" do
    compare_kanji_and_integer("二千九百八", 2908)
  end

  it "二千九百九" do
    compare_kanji_and_integer("二千九百九", 2909)
  end

  it "二千九百十" do
    compare_kanji_and_integer("二千九百十", 2910)
  end

  it "二千九百十一" do
    compare_kanji_and_integer("二千九百十一", 2911)
  end

  it "二千九百十二" do
    compare_kanji_and_integer("二千九百十二", 2912)
  end

  it "二千九百十三" do
    compare_kanji_and_integer("二千九百十三", 2913)
  end

  it "二千九百十四" do
    compare_kanji_and_integer("二千九百十四", 2914)
  end

  it "二千九百十五" do
    compare_kanji_and_integer("二千九百十五", 2915)
  end

  it "二千九百十六" do
    compare_kanji_and_integer("二千九百十六", 2916)
  end

  it "二千九百十七" do
    compare_kanji_and_integer("二千九百十七", 2917)
  end

  it "二千九百十八" do
    compare_kanji_and_integer("二千九百十八", 2918)
  end

  it "二千九百十九" do
    compare_kanji_and_integer("二千九百十九", 2919)
  end

  it "二千九百二十" do
    compare_kanji_and_integer("二千九百二十", 2920)
  end

  it "二千九百二十一" do
    compare_kanji_and_integer("二千九百二十一", 2921)
  end

  it "二千九百二十二" do
    compare_kanji_and_integer("二千九百二十二", 2922)
  end

  it "二千九百二十三" do
    compare_kanji_and_integer("二千九百二十三", 2923)
  end

  it "二千九百二十四" do
    compare_kanji_and_integer("二千九百二十四", 2924)
  end

  it "二千九百二十五" do
    compare_kanji_and_integer("二千九百二十五", 2925)
  end

  it "二千九百二十六" do
    compare_kanji_and_integer("二千九百二十六", 2926)
  end

  it "二千九百二十七" do
    compare_kanji_and_integer("二千九百二十七", 2927)
  end

  it "二千九百二十八" do
    compare_kanji_and_integer("二千九百二十八", 2928)
  end

  it "二千九百二十九" do
    compare_kanji_and_integer("二千九百二十九", 2929)
  end

  it "二千九百三十" do
    compare_kanji_and_integer("二千九百三十", 2930)
  end

  it "二千九百三十一" do
    compare_kanji_and_integer("二千九百三十一", 2931)
  end

  it "二千九百三十二" do
    compare_kanji_and_integer("二千九百三十二", 2932)
  end

  it "二千九百三十三" do
    compare_kanji_and_integer("二千九百三十三", 2933)
  end

  it "二千九百三十四" do
    compare_kanji_and_integer("二千九百三十四", 2934)
  end

  it "二千九百三十五" do
    compare_kanji_and_integer("二千九百三十五", 2935)
  end

  it "二千九百三十六" do
    compare_kanji_and_integer("二千九百三十六", 2936)
  end

  it "二千九百三十七" do
    compare_kanji_and_integer("二千九百三十七", 2937)
  end

  it "二千九百三十八" do
    compare_kanji_and_integer("二千九百三十八", 2938)
  end

  it "二千九百三十九" do
    compare_kanji_and_integer("二千九百三十九", 2939)
  end

  it "二千九百四十" do
    compare_kanji_and_integer("二千九百四十", 2940)
  end

  it "二千九百四十一" do
    compare_kanji_and_integer("二千九百四十一", 2941)
  end

  it "二千九百四十二" do
    compare_kanji_and_integer("二千九百四十二", 2942)
  end

  it "二千九百四十三" do
    compare_kanji_and_integer("二千九百四十三", 2943)
  end

  it "二千九百四十四" do
    compare_kanji_and_integer("二千九百四十四", 2944)
  end

  it "二千九百四十五" do
    compare_kanji_and_integer("二千九百四十五", 2945)
  end

  it "二千九百四十六" do
    compare_kanji_and_integer("二千九百四十六", 2946)
  end

  it "二千九百四十七" do
    compare_kanji_and_integer("二千九百四十七", 2947)
  end

  it "二千九百四十八" do
    compare_kanji_and_integer("二千九百四十八", 2948)
  end

  it "二千九百四十九" do
    compare_kanji_and_integer("二千九百四十九", 2949)
  end

  it "二千九百五十" do
    compare_kanji_and_integer("二千九百五十", 2950)
  end

  it "二千九百五十一" do
    compare_kanji_and_integer("二千九百五十一", 2951)
  end

  it "二千九百五十二" do
    compare_kanji_and_integer("二千九百五十二", 2952)
  end

  it "二千九百五十三" do
    compare_kanji_and_integer("二千九百五十三", 2953)
  end

  it "二千九百五十四" do
    compare_kanji_and_integer("二千九百五十四", 2954)
  end

  it "二千九百五十五" do
    compare_kanji_and_integer("二千九百五十五", 2955)
  end

  it "二千九百五十六" do
    compare_kanji_and_integer("二千九百五十六", 2956)
  end

  it "二千九百五十七" do
    compare_kanji_and_integer("二千九百五十七", 2957)
  end

  it "二千九百五十八" do
    compare_kanji_and_integer("二千九百五十八", 2958)
  end

  it "二千九百五十九" do
    compare_kanji_and_integer("二千九百五十九", 2959)
  end

  it "二千九百六十" do
    compare_kanji_and_integer("二千九百六十", 2960)
  end

  it "二千九百六十一" do
    compare_kanji_and_integer("二千九百六十一", 2961)
  end

  it "二千九百六十二" do
    compare_kanji_and_integer("二千九百六十二", 2962)
  end

  it "二千九百六十三" do
    compare_kanji_and_integer("二千九百六十三", 2963)
  end

  it "二千九百六十四" do
    compare_kanji_and_integer("二千九百六十四", 2964)
  end

  it "二千九百六十五" do
    compare_kanji_and_integer("二千九百六十五", 2965)
  end

  it "二千九百六十六" do
    compare_kanji_and_integer("二千九百六十六", 2966)
  end

  it "二千九百六十七" do
    compare_kanji_and_integer("二千九百六十七", 2967)
  end

  it "二千九百六十八" do
    compare_kanji_and_integer("二千九百六十八", 2968)
  end

  it "二千九百六十九" do
    compare_kanji_and_integer("二千九百六十九", 2969)
  end

  it "二千九百七十" do
    compare_kanji_and_integer("二千九百七十", 2970)
  end

  it "二千九百七十一" do
    compare_kanji_and_integer("二千九百七十一", 2971)
  end

  it "二千九百七十二" do
    compare_kanji_and_integer("二千九百七十二", 2972)
  end

  it "二千九百七十三" do
    compare_kanji_and_integer("二千九百七十三", 2973)
  end

  it "二千九百七十四" do
    compare_kanji_and_integer("二千九百七十四", 2974)
  end

  it "二千九百七十五" do
    compare_kanji_and_integer("二千九百七十五", 2975)
  end

  it "二千九百七十六" do
    compare_kanji_and_integer("二千九百七十六", 2976)
  end

  it "二千九百七十七" do
    compare_kanji_and_integer("二千九百七十七", 2977)
  end

  it "二千九百七十八" do
    compare_kanji_and_integer("二千九百七十八", 2978)
  end

  it "二千九百七十九" do
    compare_kanji_and_integer("二千九百七十九", 2979)
  end

  it "二千九百八十" do
    compare_kanji_and_integer("二千九百八十", 2980)
  end

  it "二千九百八十一" do
    compare_kanji_and_integer("二千九百八十一", 2981)
  end

  it "二千九百八十二" do
    compare_kanji_and_integer("二千九百八十二", 2982)
  end

  it "二千九百八十三" do
    compare_kanji_and_integer("二千九百八十三", 2983)
  end

  it "二千九百八十四" do
    compare_kanji_and_integer("二千九百八十四", 2984)
  end

  it "二千九百八十五" do
    compare_kanji_and_integer("二千九百八十五", 2985)
  end

  it "二千九百八十六" do
    compare_kanji_and_integer("二千九百八十六", 2986)
  end

  it "二千九百八十七" do
    compare_kanji_and_integer("二千九百八十七", 2987)
  end

  it "二千九百八十八" do
    compare_kanji_and_integer("二千九百八十八", 2988)
  end

  it "二千九百八十九" do
    compare_kanji_and_integer("二千九百八十九", 2989)
  end

  it "二千九百九十" do
    compare_kanji_and_integer("二千九百九十", 2990)
  end

  it "二千九百九十一" do
    compare_kanji_and_integer("二千九百九十一", 2991)
  end

  it "二千九百九十二" do
    compare_kanji_and_integer("二千九百九十二", 2992)
  end

  it "二千九百九十三" do
    compare_kanji_and_integer("二千九百九十三", 2993)
  end

  it "二千九百九十四" do
    compare_kanji_and_integer("二千九百九十四", 2994)
  end

  it "二千九百九十五" do
    compare_kanji_and_integer("二千九百九十五", 2995)
  end

  it "二千九百九十六" do
    compare_kanji_and_integer("二千九百九十六", 2996)
  end

  it "二千九百九十七" do
    compare_kanji_and_integer("二千九百九十七", 2997)
  end

  it "二千九百九十八" do
    compare_kanji_and_integer("二千九百九十八", 2998)
  end

  it "二千九百九十九" do
    compare_kanji_and_integer("二千九百九十九", 2999)
  end

  it "三千" do
    compare_kanji_and_integer("三千", 3000)
  end

  it "三千一" do
    compare_kanji_and_integer("三千一", 3001)
  end

  it "三千二" do
    compare_kanji_and_integer("三千二", 3002)
  end

  it "三千三" do
    compare_kanji_and_integer("三千三", 3003)
  end

  it "三千四" do
    compare_kanji_and_integer("三千四", 3004)
  end

  it "三千五" do
    compare_kanji_and_integer("三千五", 3005)
  end

  it "三千六" do
    compare_kanji_and_integer("三千六", 3006)
  end

  it "三千七" do
    compare_kanji_and_integer("三千七", 3007)
  end

  it "三千八" do
    compare_kanji_and_integer("三千八", 3008)
  end

  it "三千九" do
    compare_kanji_and_integer("三千九", 3009)
  end

  it "三千十" do
    compare_kanji_and_integer("三千十", 3010)
  end

  it "三千十一" do
    compare_kanji_and_integer("三千十一", 3011)
  end

  it "三千十二" do
    compare_kanji_and_integer("三千十二", 3012)
  end

  it "三千十三" do
    compare_kanji_and_integer("三千十三", 3013)
  end

  it "三千十四" do
    compare_kanji_and_integer("三千十四", 3014)
  end

  it "三千十五" do
    compare_kanji_and_integer("三千十五", 3015)
  end

  it "三千十六" do
    compare_kanji_and_integer("三千十六", 3016)
  end

  it "三千十七" do
    compare_kanji_and_integer("三千十七", 3017)
  end

  it "三千十八" do
    compare_kanji_and_integer("三千十八", 3018)
  end

  it "三千十九" do
    compare_kanji_and_integer("三千十九", 3019)
  end

  it "三千二十" do
    compare_kanji_and_integer("三千二十", 3020)
  end

  it "三千二十一" do
    compare_kanji_and_integer("三千二十一", 3021)
  end

  it "三千二十二" do
    compare_kanji_and_integer("三千二十二", 3022)
  end

  it "三千二十三" do
    compare_kanji_and_integer("三千二十三", 3023)
  end

  it "三千二十四" do
    compare_kanji_and_integer("三千二十四", 3024)
  end

  it "三千二十五" do
    compare_kanji_and_integer("三千二十五", 3025)
  end

  it "三千二十六" do
    compare_kanji_and_integer("三千二十六", 3026)
  end

  it "三千二十七" do
    compare_kanji_and_integer("三千二十七", 3027)
  end

  it "三千二十八" do
    compare_kanji_and_integer("三千二十八", 3028)
  end

  it "三千二十九" do
    compare_kanji_and_integer("三千二十九", 3029)
  end

  it "三千三十" do
    compare_kanji_and_integer("三千三十", 3030)
  end

  it "三千三十一" do
    compare_kanji_and_integer("三千三十一", 3031)
  end

  it "三千三十二" do
    compare_kanji_and_integer("三千三十二", 3032)
  end

  it "三千三十三" do
    compare_kanji_and_integer("三千三十三", 3033)
  end

  it "三千三十四" do
    compare_kanji_and_integer("三千三十四", 3034)
  end

  it "三千三十五" do
    compare_kanji_and_integer("三千三十五", 3035)
  end

  it "三千三十六" do
    compare_kanji_and_integer("三千三十六", 3036)
  end

  it "三千三十七" do
    compare_kanji_and_integer("三千三十七", 3037)
  end

  it "三千三十八" do
    compare_kanji_and_integer("三千三十八", 3038)
  end

  it "三千三十九" do
    compare_kanji_and_integer("三千三十九", 3039)
  end

  it "三千四十" do
    compare_kanji_and_integer("三千四十", 3040)
  end

  it "三千四十一" do
    compare_kanji_and_integer("三千四十一", 3041)
  end

  it "三千四十二" do
    compare_kanji_and_integer("三千四十二", 3042)
  end

  it "三千四十三" do
    compare_kanji_and_integer("三千四十三", 3043)
  end

  it "三千四十四" do
    compare_kanji_and_integer("三千四十四", 3044)
  end

  it "三千四十五" do
    compare_kanji_and_integer("三千四十五", 3045)
  end

  it "三千四十六" do
    compare_kanji_and_integer("三千四十六", 3046)
  end

  it "三千四十七" do
    compare_kanji_and_integer("三千四十七", 3047)
  end

  it "三千四十八" do
    compare_kanji_and_integer("三千四十八", 3048)
  end

  it "三千四十九" do
    compare_kanji_and_integer("三千四十九", 3049)
  end

  it "三千五十" do
    compare_kanji_and_integer("三千五十", 3050)
  end

  it "三千五十一" do
    compare_kanji_and_integer("三千五十一", 3051)
  end

  it "三千五十二" do
    compare_kanji_and_integer("三千五十二", 3052)
  end

  it "三千五十三" do
    compare_kanji_and_integer("三千五十三", 3053)
  end

  it "三千五十四" do
    compare_kanji_and_integer("三千五十四", 3054)
  end

  it "三千五十五" do
    compare_kanji_and_integer("三千五十五", 3055)
  end

  it "三千五十六" do
    compare_kanji_and_integer("三千五十六", 3056)
  end

  it "三千五十七" do
    compare_kanji_and_integer("三千五十七", 3057)
  end

  it "三千五十八" do
    compare_kanji_and_integer("三千五十八", 3058)
  end

  it "三千五十九" do
    compare_kanji_and_integer("三千五十九", 3059)
  end

  it "三千六十" do
    compare_kanji_and_integer("三千六十", 3060)
  end

  it "三千六十一" do
    compare_kanji_and_integer("三千六十一", 3061)
  end

  it "三千六十二" do
    compare_kanji_and_integer("三千六十二", 3062)
  end

  it "三千六十三" do
    compare_kanji_and_integer("三千六十三", 3063)
  end

  it "三千六十四" do
    compare_kanji_and_integer("三千六十四", 3064)
  end

  it "三千六十五" do
    compare_kanji_and_integer("三千六十五", 3065)
  end

  it "三千六十六" do
    compare_kanji_and_integer("三千六十六", 3066)
  end

  it "三千六十七" do
    compare_kanji_and_integer("三千六十七", 3067)
  end

  it "三千六十八" do
    compare_kanji_and_integer("三千六十八", 3068)
  end

  it "三千六十九" do
    compare_kanji_and_integer("三千六十九", 3069)
  end

  it "三千七十" do
    compare_kanji_and_integer("三千七十", 3070)
  end

  it "三千七十一" do
    compare_kanji_and_integer("三千七十一", 3071)
  end

  it "三千七十二" do
    compare_kanji_and_integer("三千七十二", 3072)
  end

  it "三千七十三" do
    compare_kanji_and_integer("三千七十三", 3073)
  end

  it "三千七十四" do
    compare_kanji_and_integer("三千七十四", 3074)
  end

  it "三千七十五" do
    compare_kanji_and_integer("三千七十五", 3075)
  end

  it "三千七十六" do
    compare_kanji_and_integer("三千七十六", 3076)
  end

  it "三千七十七" do
    compare_kanji_and_integer("三千七十七", 3077)
  end

  it "三千七十八" do
    compare_kanji_and_integer("三千七十八", 3078)
  end

  it "三千七十九" do
    compare_kanji_and_integer("三千七十九", 3079)
  end

  it "三千八十" do
    compare_kanji_and_integer("三千八十", 3080)
  end

  it "三千八十一" do
    compare_kanji_and_integer("三千八十一", 3081)
  end

  it "三千八十二" do
    compare_kanji_and_integer("三千八十二", 3082)
  end

  it "三千八十三" do
    compare_kanji_and_integer("三千八十三", 3083)
  end

  it "三千八十四" do
    compare_kanji_and_integer("三千八十四", 3084)
  end

  it "三千八十五" do
    compare_kanji_and_integer("三千八十五", 3085)
  end

  it "三千八十六" do
    compare_kanji_and_integer("三千八十六", 3086)
  end

  it "三千八十七" do
    compare_kanji_and_integer("三千八十七", 3087)
  end

  it "三千八十八" do
    compare_kanji_and_integer("三千八十八", 3088)
  end

  it "三千八十九" do
    compare_kanji_and_integer("三千八十九", 3089)
  end

  it "三千九十" do
    compare_kanji_and_integer("三千九十", 3090)
  end

  it "三千九十一" do
    compare_kanji_and_integer("三千九十一", 3091)
  end

  it "三千九十二" do
    compare_kanji_and_integer("三千九十二", 3092)
  end

  it "三千九十三" do
    compare_kanji_and_integer("三千九十三", 3093)
  end

  it "三千九十四" do
    compare_kanji_and_integer("三千九十四", 3094)
  end

  it "三千九十五" do
    compare_kanji_and_integer("三千九十五", 3095)
  end

  it "三千九十六" do
    compare_kanji_and_integer("三千九十六", 3096)
  end

  it "三千九十七" do
    compare_kanji_and_integer("三千九十七", 3097)
  end

  it "三千九十八" do
    compare_kanji_and_integer("三千九十八", 3098)
  end

  it "三千九十九" do
    compare_kanji_and_integer("三千九十九", 3099)
  end

  it "三千百" do
    compare_kanji_and_integer("三千百", 3100)
  end

  it "三千百一" do
    compare_kanji_and_integer("三千百一", 3101)
  end

  it "三千百二" do
    compare_kanji_and_integer("三千百二", 3102)
  end

  it "三千百三" do
    compare_kanji_and_integer("三千百三", 3103)
  end

  it "三千百四" do
    compare_kanji_and_integer("三千百四", 3104)
  end

  it "三千百五" do
    compare_kanji_and_integer("三千百五", 3105)
  end

  it "三千百六" do
    compare_kanji_and_integer("三千百六", 3106)
  end

  it "三千百七" do
    compare_kanji_and_integer("三千百七", 3107)
  end

  it "三千百八" do
    compare_kanji_and_integer("三千百八", 3108)
  end

  it "三千百九" do
    compare_kanji_and_integer("三千百九", 3109)
  end

  it "三千百十" do
    compare_kanji_and_integer("三千百十", 3110)
  end

  it "三千百十一" do
    compare_kanji_and_integer("三千百十一", 3111)
  end

  it "三千百十二" do
    compare_kanji_and_integer("三千百十二", 3112)
  end

  it "三千百十三" do
    compare_kanji_and_integer("三千百十三", 3113)
  end

  it "三千百十四" do
    compare_kanji_and_integer("三千百十四", 3114)
  end

  it "三千百十五" do
    compare_kanji_and_integer("三千百十五", 3115)
  end

  it "三千百十六" do
    compare_kanji_and_integer("三千百十六", 3116)
  end

  it "三千百十七" do
    compare_kanji_and_integer("三千百十七", 3117)
  end

  it "三千百十八" do
    compare_kanji_and_integer("三千百十八", 3118)
  end

  it "三千百十九" do
    compare_kanji_and_integer("三千百十九", 3119)
  end

  it "三千百二十" do
    compare_kanji_and_integer("三千百二十", 3120)
  end

  it "三千百二十一" do
    compare_kanji_and_integer("三千百二十一", 3121)
  end

  it "三千百二十二" do
    compare_kanji_and_integer("三千百二十二", 3122)
  end

  it "三千百二十三" do
    compare_kanji_and_integer("三千百二十三", 3123)
  end

  it "三千百二十四" do
    compare_kanji_and_integer("三千百二十四", 3124)
  end

  it "三千百二十五" do
    compare_kanji_and_integer("三千百二十五", 3125)
  end

  it "三千百二十六" do
    compare_kanji_and_integer("三千百二十六", 3126)
  end

  it "三千百二十七" do
    compare_kanji_and_integer("三千百二十七", 3127)
  end

  it "三千百二十八" do
    compare_kanji_and_integer("三千百二十八", 3128)
  end

  it "三千百二十九" do
    compare_kanji_and_integer("三千百二十九", 3129)
  end

  it "三千百三十" do
    compare_kanji_and_integer("三千百三十", 3130)
  end

  it "三千百三十一" do
    compare_kanji_and_integer("三千百三十一", 3131)
  end

  it "三千百三十二" do
    compare_kanji_and_integer("三千百三十二", 3132)
  end

  it "三千百三十三" do
    compare_kanji_and_integer("三千百三十三", 3133)
  end

  it "三千百三十四" do
    compare_kanji_and_integer("三千百三十四", 3134)
  end

  it "三千百三十五" do
    compare_kanji_and_integer("三千百三十五", 3135)
  end

  it "三千百三十六" do
    compare_kanji_and_integer("三千百三十六", 3136)
  end

  it "三千百三十七" do
    compare_kanji_and_integer("三千百三十七", 3137)
  end

  it "三千百三十八" do
    compare_kanji_and_integer("三千百三十八", 3138)
  end

  it "三千百三十九" do
    compare_kanji_and_integer("三千百三十九", 3139)
  end

  it "三千百四十" do
    compare_kanji_and_integer("三千百四十", 3140)
  end

  it "三千百四十一" do
    compare_kanji_and_integer("三千百四十一", 3141)
  end

  it "三千百四十二" do
    compare_kanji_and_integer("三千百四十二", 3142)
  end

  it "三千百四十三" do
    compare_kanji_and_integer("三千百四十三", 3143)
  end

  it "三千百四十四" do
    compare_kanji_and_integer("三千百四十四", 3144)
  end

  it "三千百四十五" do
    compare_kanji_and_integer("三千百四十五", 3145)
  end

  it "三千百四十六" do
    compare_kanji_and_integer("三千百四十六", 3146)
  end

  it "三千百四十七" do
    compare_kanji_and_integer("三千百四十七", 3147)
  end

  it "三千百四十八" do
    compare_kanji_and_integer("三千百四十八", 3148)
  end

  it "三千百四十九" do
    compare_kanji_and_integer("三千百四十九", 3149)
  end

  it "三千百五十" do
    compare_kanji_and_integer("三千百五十", 3150)
  end

  it "三千百五十一" do
    compare_kanji_and_integer("三千百五十一", 3151)
  end

  it "三千百五十二" do
    compare_kanji_and_integer("三千百五十二", 3152)
  end

  it "三千百五十三" do
    compare_kanji_and_integer("三千百五十三", 3153)
  end

  it "三千百五十四" do
    compare_kanji_and_integer("三千百五十四", 3154)
  end

  it "三千百五十五" do
    compare_kanji_and_integer("三千百五十五", 3155)
  end

  it "三千百五十六" do
    compare_kanji_and_integer("三千百五十六", 3156)
  end

  it "三千百五十七" do
    compare_kanji_and_integer("三千百五十七", 3157)
  end

  it "三千百五十八" do
    compare_kanji_and_integer("三千百五十八", 3158)
  end

  it "三千百五十九" do
    compare_kanji_and_integer("三千百五十九", 3159)
  end

  it "三千百六十" do
    compare_kanji_and_integer("三千百六十", 3160)
  end

  it "三千百六十一" do
    compare_kanji_and_integer("三千百六十一", 3161)
  end

  it "三千百六十二" do
    compare_kanji_and_integer("三千百六十二", 3162)
  end

  it "三千百六十三" do
    compare_kanji_and_integer("三千百六十三", 3163)
  end

  it "三千百六十四" do
    compare_kanji_and_integer("三千百六十四", 3164)
  end

  it "三千百六十五" do
    compare_kanji_and_integer("三千百六十五", 3165)
  end

  it "三千百六十六" do
    compare_kanji_and_integer("三千百六十六", 3166)
  end

  it "三千百六十七" do
    compare_kanji_and_integer("三千百六十七", 3167)
  end

  it "三千百六十八" do
    compare_kanji_and_integer("三千百六十八", 3168)
  end

  it "三千百六十九" do
    compare_kanji_and_integer("三千百六十九", 3169)
  end

  it "三千百七十" do
    compare_kanji_and_integer("三千百七十", 3170)
  end

  it "三千百七十一" do
    compare_kanji_and_integer("三千百七十一", 3171)
  end

  it "三千百七十二" do
    compare_kanji_and_integer("三千百七十二", 3172)
  end

  it "三千百七十三" do
    compare_kanji_and_integer("三千百七十三", 3173)
  end

  it "三千百七十四" do
    compare_kanji_and_integer("三千百七十四", 3174)
  end

  it "三千百七十五" do
    compare_kanji_and_integer("三千百七十五", 3175)
  end

  it "三千百七十六" do
    compare_kanji_and_integer("三千百七十六", 3176)
  end

  it "三千百七十七" do
    compare_kanji_and_integer("三千百七十七", 3177)
  end

  it "三千百七十八" do
    compare_kanji_and_integer("三千百七十八", 3178)
  end

  it "三千百七十九" do
    compare_kanji_and_integer("三千百七十九", 3179)
  end

  it "三千百八十" do
    compare_kanji_and_integer("三千百八十", 3180)
  end

  it "三千百八十一" do
    compare_kanji_and_integer("三千百八十一", 3181)
  end

  it "三千百八十二" do
    compare_kanji_and_integer("三千百八十二", 3182)
  end

  it "三千百八十三" do
    compare_kanji_and_integer("三千百八十三", 3183)
  end

  it "三千百八十四" do
    compare_kanji_and_integer("三千百八十四", 3184)
  end

  it "三千百八十五" do
    compare_kanji_and_integer("三千百八十五", 3185)
  end

  it "三千百八十六" do
    compare_kanji_and_integer("三千百八十六", 3186)
  end

  it "三千百八十七" do
    compare_kanji_and_integer("三千百八十七", 3187)
  end

  it "三千百八十八" do
    compare_kanji_and_integer("三千百八十八", 3188)
  end

  it "三千百八十九" do
    compare_kanji_and_integer("三千百八十九", 3189)
  end

  it "三千百九十" do
    compare_kanji_and_integer("三千百九十", 3190)
  end

  it "三千百九十一" do
    compare_kanji_and_integer("三千百九十一", 3191)
  end

  it "三千百九十二" do
    compare_kanji_and_integer("三千百九十二", 3192)
  end

  it "三千百九十三" do
    compare_kanji_and_integer("三千百九十三", 3193)
  end

  it "三千百九十四" do
    compare_kanji_and_integer("三千百九十四", 3194)
  end

  it "三千百九十五" do
    compare_kanji_and_integer("三千百九十五", 3195)
  end

  it "三千百九十六" do
    compare_kanji_and_integer("三千百九十六", 3196)
  end

  it "三千百九十七" do
    compare_kanji_and_integer("三千百九十七", 3197)
  end

  it "三千百九十八" do
    compare_kanji_and_integer("三千百九十八", 3198)
  end

  it "三千百九十九" do
    compare_kanji_and_integer("三千百九十九", 3199)
  end

  it "三千二百" do
    compare_kanji_and_integer("三千二百", 3200)
  end

  it "三千二百一" do
    compare_kanji_and_integer("三千二百一", 3201)
  end

  it "三千二百二" do
    compare_kanji_and_integer("三千二百二", 3202)
  end

  it "三千二百三" do
    compare_kanji_and_integer("三千二百三", 3203)
  end

  it "三千二百四" do
    compare_kanji_and_integer("三千二百四", 3204)
  end

  it "三千二百五" do
    compare_kanji_and_integer("三千二百五", 3205)
  end

  it "三千二百六" do
    compare_kanji_and_integer("三千二百六", 3206)
  end

  it "三千二百七" do
    compare_kanji_and_integer("三千二百七", 3207)
  end

  it "三千二百八" do
    compare_kanji_and_integer("三千二百八", 3208)
  end

  it "三千二百九" do
    compare_kanji_and_integer("三千二百九", 3209)
  end

  it "三千二百十" do
    compare_kanji_and_integer("三千二百十", 3210)
  end

  it "三千二百十一" do
    compare_kanji_and_integer("三千二百十一", 3211)
  end

  it "三千二百十二" do
    compare_kanji_and_integer("三千二百十二", 3212)
  end

  it "三千二百十三" do
    compare_kanji_and_integer("三千二百十三", 3213)
  end

  it "三千二百十四" do
    compare_kanji_and_integer("三千二百十四", 3214)
  end

  it "三千二百十五" do
    compare_kanji_and_integer("三千二百十五", 3215)
  end

  it "三千二百十六" do
    compare_kanji_and_integer("三千二百十六", 3216)
  end

  it "三千二百十七" do
    compare_kanji_and_integer("三千二百十七", 3217)
  end

  it "三千二百十八" do
    compare_kanji_and_integer("三千二百十八", 3218)
  end

  it "三千二百十九" do
    compare_kanji_and_integer("三千二百十九", 3219)
  end

  it "三千二百二十" do
    compare_kanji_and_integer("三千二百二十", 3220)
  end

  it "三千二百二十一" do
    compare_kanji_and_integer("三千二百二十一", 3221)
  end

  it "三千二百二十二" do
    compare_kanji_and_integer("三千二百二十二", 3222)
  end

  it "三千二百二十三" do
    compare_kanji_and_integer("三千二百二十三", 3223)
  end

  it "三千二百二十四" do
    compare_kanji_and_integer("三千二百二十四", 3224)
  end

  it "三千二百二十五" do
    compare_kanji_and_integer("三千二百二十五", 3225)
  end

  it "三千二百二十六" do
    compare_kanji_and_integer("三千二百二十六", 3226)
  end

  it "三千二百二十七" do
    compare_kanji_and_integer("三千二百二十七", 3227)
  end

  it "三千二百二十八" do
    compare_kanji_and_integer("三千二百二十八", 3228)
  end

  it "三千二百二十九" do
    compare_kanji_and_integer("三千二百二十九", 3229)
  end

  it "三千二百三十" do
    compare_kanji_and_integer("三千二百三十", 3230)
  end

  it "三千二百三十一" do
    compare_kanji_and_integer("三千二百三十一", 3231)
  end

  it "三千二百三十二" do
    compare_kanji_and_integer("三千二百三十二", 3232)
  end

  it "三千二百三十三" do
    compare_kanji_and_integer("三千二百三十三", 3233)
  end

  it "三千二百三十四" do
    compare_kanji_and_integer("三千二百三十四", 3234)
  end

  it "三千二百三十五" do
    compare_kanji_and_integer("三千二百三十五", 3235)
  end

  it "三千二百三十六" do
    compare_kanji_and_integer("三千二百三十六", 3236)
  end

  it "三千二百三十七" do
    compare_kanji_and_integer("三千二百三十七", 3237)
  end

  it "三千二百三十八" do
    compare_kanji_and_integer("三千二百三十八", 3238)
  end

  it "三千二百三十九" do
    compare_kanji_and_integer("三千二百三十九", 3239)
  end

  it "三千二百四十" do
    compare_kanji_and_integer("三千二百四十", 3240)
  end

  it "三千二百四十一" do
    compare_kanji_and_integer("三千二百四十一", 3241)
  end

  it "三千二百四十二" do
    compare_kanji_and_integer("三千二百四十二", 3242)
  end

  it "三千二百四十三" do
    compare_kanji_and_integer("三千二百四十三", 3243)
  end

  it "三千二百四十四" do
    compare_kanji_and_integer("三千二百四十四", 3244)
  end

  it "三千二百四十五" do
    compare_kanji_and_integer("三千二百四十五", 3245)
  end

  it "三千二百四十六" do
    compare_kanji_and_integer("三千二百四十六", 3246)
  end

  it "三千二百四十七" do
    compare_kanji_and_integer("三千二百四十七", 3247)
  end

  it "三千二百四十八" do
    compare_kanji_and_integer("三千二百四十八", 3248)
  end

  it "三千二百四十九" do
    compare_kanji_and_integer("三千二百四十九", 3249)
  end

  it "三千二百五十" do
    compare_kanji_and_integer("三千二百五十", 3250)
  end

  it "三千二百五十一" do
    compare_kanji_and_integer("三千二百五十一", 3251)
  end

  it "三千二百五十二" do
    compare_kanji_and_integer("三千二百五十二", 3252)
  end

  it "三千二百五十三" do
    compare_kanji_and_integer("三千二百五十三", 3253)
  end

  it "三千二百五十四" do
    compare_kanji_and_integer("三千二百五十四", 3254)
  end

  it "三千二百五十五" do
    compare_kanji_and_integer("三千二百五十五", 3255)
  end

  it "三千二百五十六" do
    compare_kanji_and_integer("三千二百五十六", 3256)
  end

  it "三千二百五十七" do
    compare_kanji_and_integer("三千二百五十七", 3257)
  end

  it "三千二百五十八" do
    compare_kanji_and_integer("三千二百五十八", 3258)
  end

  it "三千二百五十九" do
    compare_kanji_and_integer("三千二百五十九", 3259)
  end

  it "三千二百六十" do
    compare_kanji_and_integer("三千二百六十", 3260)
  end

  it "三千二百六十一" do
    compare_kanji_and_integer("三千二百六十一", 3261)
  end

  it "三千二百六十二" do
    compare_kanji_and_integer("三千二百六十二", 3262)
  end

  it "三千二百六十三" do
    compare_kanji_and_integer("三千二百六十三", 3263)
  end

  it "三千二百六十四" do
    compare_kanji_and_integer("三千二百六十四", 3264)
  end

  it "三千二百六十五" do
    compare_kanji_and_integer("三千二百六十五", 3265)
  end

  it "三千二百六十六" do
    compare_kanji_and_integer("三千二百六十六", 3266)
  end

  it "三千二百六十七" do
    compare_kanji_and_integer("三千二百六十七", 3267)
  end

  it "三千二百六十八" do
    compare_kanji_and_integer("三千二百六十八", 3268)
  end

  it "三千二百六十九" do
    compare_kanji_and_integer("三千二百六十九", 3269)
  end

  it "三千二百七十" do
    compare_kanji_and_integer("三千二百七十", 3270)
  end

  it "三千二百七十一" do
    compare_kanji_and_integer("三千二百七十一", 3271)
  end

  it "三千二百七十二" do
    compare_kanji_and_integer("三千二百七十二", 3272)
  end

  it "三千二百七十三" do
    compare_kanji_and_integer("三千二百七十三", 3273)
  end

  it "三千二百七十四" do
    compare_kanji_and_integer("三千二百七十四", 3274)
  end

  it "三千二百七十五" do
    compare_kanji_and_integer("三千二百七十五", 3275)
  end

  it "三千二百七十六" do
    compare_kanji_and_integer("三千二百七十六", 3276)
  end

  it "三千二百七十七" do
    compare_kanji_and_integer("三千二百七十七", 3277)
  end

  it "三千二百七十八" do
    compare_kanji_and_integer("三千二百七十八", 3278)
  end

  it "三千二百七十九" do
    compare_kanji_and_integer("三千二百七十九", 3279)
  end

  it "三千二百八十" do
    compare_kanji_and_integer("三千二百八十", 3280)
  end

  it "三千二百八十一" do
    compare_kanji_and_integer("三千二百八十一", 3281)
  end

  it "三千二百八十二" do
    compare_kanji_and_integer("三千二百八十二", 3282)
  end

  it "三千二百八十三" do
    compare_kanji_and_integer("三千二百八十三", 3283)
  end

  it "三千二百八十四" do
    compare_kanji_and_integer("三千二百八十四", 3284)
  end

  it "三千二百八十五" do
    compare_kanji_and_integer("三千二百八十五", 3285)
  end

  it "三千二百八十六" do
    compare_kanji_and_integer("三千二百八十六", 3286)
  end

  it "三千二百八十七" do
    compare_kanji_and_integer("三千二百八十七", 3287)
  end

  it "三千二百八十八" do
    compare_kanji_and_integer("三千二百八十八", 3288)
  end

  it "三千二百八十九" do
    compare_kanji_and_integer("三千二百八十九", 3289)
  end

  it "三千二百九十" do
    compare_kanji_and_integer("三千二百九十", 3290)
  end

  it "三千二百九十一" do
    compare_kanji_and_integer("三千二百九十一", 3291)
  end

  it "三千二百九十二" do
    compare_kanji_and_integer("三千二百九十二", 3292)
  end

  it "三千二百九十三" do
    compare_kanji_and_integer("三千二百九十三", 3293)
  end

  it "三千二百九十四" do
    compare_kanji_and_integer("三千二百九十四", 3294)
  end

  it "三千二百九十五" do
    compare_kanji_and_integer("三千二百九十五", 3295)
  end

  it "三千二百九十六" do
    compare_kanji_and_integer("三千二百九十六", 3296)
  end

  it "三千二百九十七" do
    compare_kanji_and_integer("三千二百九十七", 3297)
  end

  it "三千二百九十八" do
    compare_kanji_and_integer("三千二百九十八", 3298)
  end

  it "三千二百九十九" do
    compare_kanji_and_integer("三千二百九十九", 3299)
  end

  it "三千三百" do
    compare_kanji_and_integer("三千三百", 3300)
  end

  it "三千三百一" do
    compare_kanji_and_integer("三千三百一", 3301)
  end

  it "三千三百二" do
    compare_kanji_and_integer("三千三百二", 3302)
  end

  it "三千三百三" do
    compare_kanji_and_integer("三千三百三", 3303)
  end

  it "三千三百四" do
    compare_kanji_and_integer("三千三百四", 3304)
  end

  it "三千三百五" do
    compare_kanji_and_integer("三千三百五", 3305)
  end

  it "三千三百六" do
    compare_kanji_and_integer("三千三百六", 3306)
  end

  it "三千三百七" do
    compare_kanji_and_integer("三千三百七", 3307)
  end

  it "三千三百八" do
    compare_kanji_and_integer("三千三百八", 3308)
  end

  it "三千三百九" do
    compare_kanji_and_integer("三千三百九", 3309)
  end

  it "三千三百十" do
    compare_kanji_and_integer("三千三百十", 3310)
  end

  it "三千三百十一" do
    compare_kanji_and_integer("三千三百十一", 3311)
  end

  it "三千三百十二" do
    compare_kanji_and_integer("三千三百十二", 3312)
  end

  it "三千三百十三" do
    compare_kanji_and_integer("三千三百十三", 3313)
  end

  it "三千三百十四" do
    compare_kanji_and_integer("三千三百十四", 3314)
  end

  it "三千三百十五" do
    compare_kanji_and_integer("三千三百十五", 3315)
  end

  it "三千三百十六" do
    compare_kanji_and_integer("三千三百十六", 3316)
  end

  it "三千三百十七" do
    compare_kanji_and_integer("三千三百十七", 3317)
  end

  it "三千三百十八" do
    compare_kanji_and_integer("三千三百十八", 3318)
  end

  it "三千三百十九" do
    compare_kanji_and_integer("三千三百十九", 3319)
  end

  it "三千三百二十" do
    compare_kanji_and_integer("三千三百二十", 3320)
  end

  it "三千三百二十一" do
    compare_kanji_and_integer("三千三百二十一", 3321)
  end

  it "三千三百二十二" do
    compare_kanji_and_integer("三千三百二十二", 3322)
  end

  it "三千三百二十三" do
    compare_kanji_and_integer("三千三百二十三", 3323)
  end

  it "三千三百二十四" do
    compare_kanji_and_integer("三千三百二十四", 3324)
  end

  it "三千三百二十五" do
    compare_kanji_and_integer("三千三百二十五", 3325)
  end

  it "三千三百二十六" do
    compare_kanji_and_integer("三千三百二十六", 3326)
  end

  it "三千三百二十七" do
    compare_kanji_and_integer("三千三百二十七", 3327)
  end

  it "三千三百二十八" do
    compare_kanji_and_integer("三千三百二十八", 3328)
  end

  it "三千三百二十九" do
    compare_kanji_and_integer("三千三百二十九", 3329)
  end

  it "三千三百三十" do
    compare_kanji_and_integer("三千三百三十", 3330)
  end

  it "三千三百三十一" do
    compare_kanji_and_integer("三千三百三十一", 3331)
  end

  it "三千三百三十二" do
    compare_kanji_and_integer("三千三百三十二", 3332)
  end

  it "三千三百三十三" do
    compare_kanji_and_integer("三千三百三十三", 3333)
  end

  it "三千三百三十四" do
    compare_kanji_and_integer("三千三百三十四", 3334)
  end

  it "三千三百三十五" do
    compare_kanji_and_integer("三千三百三十五", 3335)
  end

  it "三千三百三十六" do
    compare_kanji_and_integer("三千三百三十六", 3336)
  end

  it "三千三百三十七" do
    compare_kanji_and_integer("三千三百三十七", 3337)
  end

  it "三千三百三十八" do
    compare_kanji_and_integer("三千三百三十八", 3338)
  end

  it "三千三百三十九" do
    compare_kanji_and_integer("三千三百三十九", 3339)
  end

  it "三千三百四十" do
    compare_kanji_and_integer("三千三百四十", 3340)
  end

  it "三千三百四十一" do
    compare_kanji_and_integer("三千三百四十一", 3341)
  end

  it "三千三百四十二" do
    compare_kanji_and_integer("三千三百四十二", 3342)
  end

  it "三千三百四十三" do
    compare_kanji_and_integer("三千三百四十三", 3343)
  end

  it "三千三百四十四" do
    compare_kanji_and_integer("三千三百四十四", 3344)
  end

  it "三千三百四十五" do
    compare_kanji_and_integer("三千三百四十五", 3345)
  end

  it "三千三百四十六" do
    compare_kanji_and_integer("三千三百四十六", 3346)
  end

  it "三千三百四十七" do
    compare_kanji_and_integer("三千三百四十七", 3347)
  end

  it "三千三百四十八" do
    compare_kanji_and_integer("三千三百四十八", 3348)
  end

  it "三千三百四十九" do
    compare_kanji_and_integer("三千三百四十九", 3349)
  end

  it "三千三百五十" do
    compare_kanji_and_integer("三千三百五十", 3350)
  end

  it "三千三百五十一" do
    compare_kanji_and_integer("三千三百五十一", 3351)
  end

  it "三千三百五十二" do
    compare_kanji_and_integer("三千三百五十二", 3352)
  end

  it "三千三百五十三" do
    compare_kanji_and_integer("三千三百五十三", 3353)
  end

  it "三千三百五十四" do
    compare_kanji_and_integer("三千三百五十四", 3354)
  end

  it "三千三百五十五" do
    compare_kanji_and_integer("三千三百五十五", 3355)
  end

  it "三千三百五十六" do
    compare_kanji_and_integer("三千三百五十六", 3356)
  end

  it "三千三百五十七" do
    compare_kanji_and_integer("三千三百五十七", 3357)
  end

  it "三千三百五十八" do
    compare_kanji_and_integer("三千三百五十八", 3358)
  end

  it "三千三百五十九" do
    compare_kanji_and_integer("三千三百五十九", 3359)
  end

  it "三千三百六十" do
    compare_kanji_and_integer("三千三百六十", 3360)
  end

  it "三千三百六十一" do
    compare_kanji_and_integer("三千三百六十一", 3361)
  end

  it "三千三百六十二" do
    compare_kanji_and_integer("三千三百六十二", 3362)
  end

  it "三千三百六十三" do
    compare_kanji_and_integer("三千三百六十三", 3363)
  end

  it "三千三百六十四" do
    compare_kanji_and_integer("三千三百六十四", 3364)
  end

  it "三千三百六十五" do
    compare_kanji_and_integer("三千三百六十五", 3365)
  end

  it "三千三百六十六" do
    compare_kanji_and_integer("三千三百六十六", 3366)
  end

  it "三千三百六十七" do
    compare_kanji_and_integer("三千三百六十七", 3367)
  end

  it "三千三百六十八" do
    compare_kanji_and_integer("三千三百六十八", 3368)
  end

  it "三千三百六十九" do
    compare_kanji_and_integer("三千三百六十九", 3369)
  end

  it "三千三百七十" do
    compare_kanji_and_integer("三千三百七十", 3370)
  end

  it "三千三百七十一" do
    compare_kanji_and_integer("三千三百七十一", 3371)
  end

  it "三千三百七十二" do
    compare_kanji_and_integer("三千三百七十二", 3372)
  end

  it "三千三百七十三" do
    compare_kanji_and_integer("三千三百七十三", 3373)
  end

  it "三千三百七十四" do
    compare_kanji_and_integer("三千三百七十四", 3374)
  end

  it "三千三百七十五" do
    compare_kanji_and_integer("三千三百七十五", 3375)
  end

  it "三千三百七十六" do
    compare_kanji_and_integer("三千三百七十六", 3376)
  end

  it "三千三百七十七" do
    compare_kanji_and_integer("三千三百七十七", 3377)
  end

  it "三千三百七十八" do
    compare_kanji_and_integer("三千三百七十八", 3378)
  end

  it "三千三百七十九" do
    compare_kanji_and_integer("三千三百七十九", 3379)
  end

  it "三千三百八十" do
    compare_kanji_and_integer("三千三百八十", 3380)
  end

  it "三千三百八十一" do
    compare_kanji_and_integer("三千三百八十一", 3381)
  end

  it "三千三百八十二" do
    compare_kanji_and_integer("三千三百八十二", 3382)
  end

  it "三千三百八十三" do
    compare_kanji_and_integer("三千三百八十三", 3383)
  end

  it "三千三百八十四" do
    compare_kanji_and_integer("三千三百八十四", 3384)
  end

  it "三千三百八十五" do
    compare_kanji_and_integer("三千三百八十五", 3385)
  end

  it "三千三百八十六" do
    compare_kanji_and_integer("三千三百八十六", 3386)
  end

  it "三千三百八十七" do
    compare_kanji_and_integer("三千三百八十七", 3387)
  end

  it "三千三百八十八" do
    compare_kanji_and_integer("三千三百八十八", 3388)
  end

  it "三千三百八十九" do
    compare_kanji_and_integer("三千三百八十九", 3389)
  end

  it "三千三百九十" do
    compare_kanji_and_integer("三千三百九十", 3390)
  end

  it "三千三百九十一" do
    compare_kanji_and_integer("三千三百九十一", 3391)
  end

  it "三千三百九十二" do
    compare_kanji_and_integer("三千三百九十二", 3392)
  end

  it "三千三百九十三" do
    compare_kanji_and_integer("三千三百九十三", 3393)
  end

  it "三千三百九十四" do
    compare_kanji_and_integer("三千三百九十四", 3394)
  end

  it "三千三百九十五" do
    compare_kanji_and_integer("三千三百九十五", 3395)
  end

  it "三千三百九十六" do
    compare_kanji_and_integer("三千三百九十六", 3396)
  end

  it "三千三百九十七" do
    compare_kanji_and_integer("三千三百九十七", 3397)
  end

  it "三千三百九十八" do
    compare_kanji_and_integer("三千三百九十八", 3398)
  end

  it "三千三百九十九" do
    compare_kanji_and_integer("三千三百九十九", 3399)
  end

  it "三千四百" do
    compare_kanji_and_integer("三千四百", 3400)
  end

  it "三千四百一" do
    compare_kanji_and_integer("三千四百一", 3401)
  end

  it "三千四百二" do
    compare_kanji_and_integer("三千四百二", 3402)
  end

  it "三千四百三" do
    compare_kanji_and_integer("三千四百三", 3403)
  end

  it "三千四百四" do
    compare_kanji_and_integer("三千四百四", 3404)
  end

  it "三千四百五" do
    compare_kanji_and_integer("三千四百五", 3405)
  end

  it "三千四百六" do
    compare_kanji_and_integer("三千四百六", 3406)
  end

  it "三千四百七" do
    compare_kanji_and_integer("三千四百七", 3407)
  end

  it "三千四百八" do
    compare_kanji_and_integer("三千四百八", 3408)
  end

  it "三千四百九" do
    compare_kanji_and_integer("三千四百九", 3409)
  end

  it "三千四百十" do
    compare_kanji_and_integer("三千四百十", 3410)
  end

  it "三千四百十一" do
    compare_kanji_and_integer("三千四百十一", 3411)
  end

  it "三千四百十二" do
    compare_kanji_and_integer("三千四百十二", 3412)
  end

  it "三千四百十三" do
    compare_kanji_and_integer("三千四百十三", 3413)
  end

  it "三千四百十四" do
    compare_kanji_and_integer("三千四百十四", 3414)
  end

  it "三千四百十五" do
    compare_kanji_and_integer("三千四百十五", 3415)
  end

  it "三千四百十六" do
    compare_kanji_and_integer("三千四百十六", 3416)
  end

  it "三千四百十七" do
    compare_kanji_and_integer("三千四百十七", 3417)
  end

  it "三千四百十八" do
    compare_kanji_and_integer("三千四百十八", 3418)
  end

  it "三千四百十九" do
    compare_kanji_and_integer("三千四百十九", 3419)
  end

  it "三千四百二十" do
    compare_kanji_and_integer("三千四百二十", 3420)
  end

  it "三千四百二十一" do
    compare_kanji_and_integer("三千四百二十一", 3421)
  end

  it "三千四百二十二" do
    compare_kanji_and_integer("三千四百二十二", 3422)
  end

  it "三千四百二十三" do
    compare_kanji_and_integer("三千四百二十三", 3423)
  end

  it "三千四百二十四" do
    compare_kanji_and_integer("三千四百二十四", 3424)
  end

  it "三千四百二十五" do
    compare_kanji_and_integer("三千四百二十五", 3425)
  end

  it "三千四百二十六" do
    compare_kanji_and_integer("三千四百二十六", 3426)
  end

  it "三千四百二十七" do
    compare_kanji_and_integer("三千四百二十七", 3427)
  end

  it "三千四百二十八" do
    compare_kanji_and_integer("三千四百二十八", 3428)
  end

  it "三千四百二十九" do
    compare_kanji_and_integer("三千四百二十九", 3429)
  end

  it "三千四百三十" do
    compare_kanji_and_integer("三千四百三十", 3430)
  end

  it "三千四百三十一" do
    compare_kanji_and_integer("三千四百三十一", 3431)
  end

  it "三千四百三十二" do
    compare_kanji_and_integer("三千四百三十二", 3432)
  end

  it "三千四百三十三" do
    compare_kanji_and_integer("三千四百三十三", 3433)
  end

  it "三千四百三十四" do
    compare_kanji_and_integer("三千四百三十四", 3434)
  end

  it "三千四百三十五" do
    compare_kanji_and_integer("三千四百三十五", 3435)
  end

  it "三千四百三十六" do
    compare_kanji_and_integer("三千四百三十六", 3436)
  end

  it "三千四百三十七" do
    compare_kanji_and_integer("三千四百三十七", 3437)
  end

  it "三千四百三十八" do
    compare_kanji_and_integer("三千四百三十八", 3438)
  end

  it "三千四百三十九" do
    compare_kanji_and_integer("三千四百三十九", 3439)
  end

  it "三千四百四十" do
    compare_kanji_and_integer("三千四百四十", 3440)
  end

  it "三千四百四十一" do
    compare_kanji_and_integer("三千四百四十一", 3441)
  end

  it "三千四百四十二" do
    compare_kanji_and_integer("三千四百四十二", 3442)
  end

  it "三千四百四十三" do
    compare_kanji_and_integer("三千四百四十三", 3443)
  end

  it "三千四百四十四" do
    compare_kanji_and_integer("三千四百四十四", 3444)
  end

  it "三千四百四十五" do
    compare_kanji_and_integer("三千四百四十五", 3445)
  end

  it "三千四百四十六" do
    compare_kanji_and_integer("三千四百四十六", 3446)
  end

  it "三千四百四十七" do
    compare_kanji_and_integer("三千四百四十七", 3447)
  end

  it "三千四百四十八" do
    compare_kanji_and_integer("三千四百四十八", 3448)
  end

  it "三千四百四十九" do
    compare_kanji_and_integer("三千四百四十九", 3449)
  end

  it "三千四百五十" do
    compare_kanji_and_integer("三千四百五十", 3450)
  end

  it "三千四百五十一" do
    compare_kanji_and_integer("三千四百五十一", 3451)
  end

  it "三千四百五十二" do
    compare_kanji_and_integer("三千四百五十二", 3452)
  end

  it "三千四百五十三" do
    compare_kanji_and_integer("三千四百五十三", 3453)
  end

  it "三千四百五十四" do
    compare_kanji_and_integer("三千四百五十四", 3454)
  end

  it "三千四百五十五" do
    compare_kanji_and_integer("三千四百五十五", 3455)
  end

  it "三千四百五十六" do
    compare_kanji_and_integer("三千四百五十六", 3456)
  end

  it "三千四百五十七" do
    compare_kanji_and_integer("三千四百五十七", 3457)
  end

  it "三千四百五十八" do
    compare_kanji_and_integer("三千四百五十八", 3458)
  end

  it "三千四百五十九" do
    compare_kanji_and_integer("三千四百五十九", 3459)
  end

  it "三千四百六十" do
    compare_kanji_and_integer("三千四百六十", 3460)
  end

  it "三千四百六十一" do
    compare_kanji_and_integer("三千四百六十一", 3461)
  end

  it "三千四百六十二" do
    compare_kanji_and_integer("三千四百六十二", 3462)
  end

  it "三千四百六十三" do
    compare_kanji_and_integer("三千四百六十三", 3463)
  end

  it "三千四百六十四" do
    compare_kanji_and_integer("三千四百六十四", 3464)
  end

  it "三千四百六十五" do
    compare_kanji_and_integer("三千四百六十五", 3465)
  end

  it "三千四百六十六" do
    compare_kanji_and_integer("三千四百六十六", 3466)
  end

  it "三千四百六十七" do
    compare_kanji_and_integer("三千四百六十七", 3467)
  end

  it "三千四百六十八" do
    compare_kanji_and_integer("三千四百六十八", 3468)
  end

  it "三千四百六十九" do
    compare_kanji_and_integer("三千四百六十九", 3469)
  end

  it "三千四百七十" do
    compare_kanji_and_integer("三千四百七十", 3470)
  end

  it "三千四百七十一" do
    compare_kanji_and_integer("三千四百七十一", 3471)
  end

  it "三千四百七十二" do
    compare_kanji_and_integer("三千四百七十二", 3472)
  end

  it "三千四百七十三" do
    compare_kanji_and_integer("三千四百七十三", 3473)
  end

  it "三千四百七十四" do
    compare_kanji_and_integer("三千四百七十四", 3474)
  end

  it "三千四百七十五" do
    compare_kanji_and_integer("三千四百七十五", 3475)
  end

  it "三千四百七十六" do
    compare_kanji_and_integer("三千四百七十六", 3476)
  end

  it "三千四百七十七" do
    compare_kanji_and_integer("三千四百七十七", 3477)
  end

  it "三千四百七十八" do
    compare_kanji_and_integer("三千四百七十八", 3478)
  end

  it "三千四百七十九" do
    compare_kanji_and_integer("三千四百七十九", 3479)
  end

  it "三千四百八十" do
    compare_kanji_and_integer("三千四百八十", 3480)
  end

  it "三千四百八十一" do
    compare_kanji_and_integer("三千四百八十一", 3481)
  end

  it "三千四百八十二" do
    compare_kanji_and_integer("三千四百八十二", 3482)
  end

  it "三千四百八十三" do
    compare_kanji_and_integer("三千四百八十三", 3483)
  end

  it "三千四百八十四" do
    compare_kanji_and_integer("三千四百八十四", 3484)
  end

  it "三千四百八十五" do
    compare_kanji_and_integer("三千四百八十五", 3485)
  end

  it "三千四百八十六" do
    compare_kanji_and_integer("三千四百八十六", 3486)
  end

  it "三千四百八十七" do
    compare_kanji_and_integer("三千四百八十七", 3487)
  end

  it "三千四百八十八" do
    compare_kanji_and_integer("三千四百八十八", 3488)
  end

  it "三千四百八十九" do
    compare_kanji_and_integer("三千四百八十九", 3489)
  end

  it "三千四百九十" do
    compare_kanji_and_integer("三千四百九十", 3490)
  end

  it "三千四百九十一" do
    compare_kanji_and_integer("三千四百九十一", 3491)
  end

  it "三千四百九十二" do
    compare_kanji_and_integer("三千四百九十二", 3492)
  end

  it "三千四百九十三" do
    compare_kanji_and_integer("三千四百九十三", 3493)
  end

  it "三千四百九十四" do
    compare_kanji_and_integer("三千四百九十四", 3494)
  end

  it "三千四百九十五" do
    compare_kanji_and_integer("三千四百九十五", 3495)
  end

  it "三千四百九十六" do
    compare_kanji_and_integer("三千四百九十六", 3496)
  end

  it "三千四百九十七" do
    compare_kanji_and_integer("三千四百九十七", 3497)
  end

  it "三千四百九十八" do
    compare_kanji_and_integer("三千四百九十八", 3498)
  end

  it "三千四百九十九" do
    compare_kanji_and_integer("三千四百九十九", 3499)
  end

  it "三千五百" do
    compare_kanji_and_integer("三千五百", 3500)
  end

  it "三千五百一" do
    compare_kanji_and_integer("三千五百一", 3501)
  end

  it "三千五百二" do
    compare_kanji_and_integer("三千五百二", 3502)
  end

  it "三千五百三" do
    compare_kanji_and_integer("三千五百三", 3503)
  end

  it "三千五百四" do
    compare_kanji_and_integer("三千五百四", 3504)
  end

  it "三千五百五" do
    compare_kanji_and_integer("三千五百五", 3505)
  end

  it "三千五百六" do
    compare_kanji_and_integer("三千五百六", 3506)
  end

  it "三千五百七" do
    compare_kanji_and_integer("三千五百七", 3507)
  end

  it "三千五百八" do
    compare_kanji_and_integer("三千五百八", 3508)
  end

  it "三千五百九" do
    compare_kanji_and_integer("三千五百九", 3509)
  end

  it "三千五百十" do
    compare_kanji_and_integer("三千五百十", 3510)
  end

  it "三千五百十一" do
    compare_kanji_and_integer("三千五百十一", 3511)
  end

  it "三千五百十二" do
    compare_kanji_and_integer("三千五百十二", 3512)
  end

  it "三千五百十三" do
    compare_kanji_and_integer("三千五百十三", 3513)
  end

  it "三千五百十四" do
    compare_kanji_and_integer("三千五百十四", 3514)
  end

  it "三千五百十五" do
    compare_kanji_and_integer("三千五百十五", 3515)
  end

  it "三千五百十六" do
    compare_kanji_and_integer("三千五百十六", 3516)
  end

  it "三千五百十七" do
    compare_kanji_and_integer("三千五百十七", 3517)
  end

  it "三千五百十八" do
    compare_kanji_and_integer("三千五百十八", 3518)
  end

  it "三千五百十九" do
    compare_kanji_and_integer("三千五百十九", 3519)
  end

  it "三千五百二十" do
    compare_kanji_and_integer("三千五百二十", 3520)
  end

  it "三千五百二十一" do
    compare_kanji_and_integer("三千五百二十一", 3521)
  end

  it "三千五百二十二" do
    compare_kanji_and_integer("三千五百二十二", 3522)
  end

  it "三千五百二十三" do
    compare_kanji_and_integer("三千五百二十三", 3523)
  end

  it "三千五百二十四" do
    compare_kanji_and_integer("三千五百二十四", 3524)
  end

  it "三千五百二十五" do
    compare_kanji_and_integer("三千五百二十五", 3525)
  end

  it "三千五百二十六" do
    compare_kanji_and_integer("三千五百二十六", 3526)
  end

  it "三千五百二十七" do
    compare_kanji_and_integer("三千五百二十七", 3527)
  end

  it "三千五百二十八" do
    compare_kanji_and_integer("三千五百二十八", 3528)
  end

  it "三千五百二十九" do
    compare_kanji_and_integer("三千五百二十九", 3529)
  end

  it "三千五百三十" do
    compare_kanji_and_integer("三千五百三十", 3530)
  end

  it "三千五百三十一" do
    compare_kanji_and_integer("三千五百三十一", 3531)
  end

  it "三千五百三十二" do
    compare_kanji_and_integer("三千五百三十二", 3532)
  end

  it "三千五百三十三" do
    compare_kanji_and_integer("三千五百三十三", 3533)
  end

  it "三千五百三十四" do
    compare_kanji_and_integer("三千五百三十四", 3534)
  end

  it "三千五百三十五" do
    compare_kanji_and_integer("三千五百三十五", 3535)
  end

  it "三千五百三十六" do
    compare_kanji_and_integer("三千五百三十六", 3536)
  end

  it "三千五百三十七" do
    compare_kanji_and_integer("三千五百三十七", 3537)
  end

  it "三千五百三十八" do
    compare_kanji_and_integer("三千五百三十八", 3538)
  end

  it "三千五百三十九" do
    compare_kanji_and_integer("三千五百三十九", 3539)
  end

  it "三千五百四十" do
    compare_kanji_and_integer("三千五百四十", 3540)
  end

  it "三千五百四十一" do
    compare_kanji_and_integer("三千五百四十一", 3541)
  end

  it "三千五百四十二" do
    compare_kanji_and_integer("三千五百四十二", 3542)
  end

  it "三千五百四十三" do
    compare_kanji_and_integer("三千五百四十三", 3543)
  end

  it "三千五百四十四" do
    compare_kanji_and_integer("三千五百四十四", 3544)
  end

  it "三千五百四十五" do
    compare_kanji_and_integer("三千五百四十五", 3545)
  end

  it "三千五百四十六" do
    compare_kanji_and_integer("三千五百四十六", 3546)
  end

  it "三千五百四十七" do
    compare_kanji_and_integer("三千五百四十七", 3547)
  end

  it "三千五百四十八" do
    compare_kanji_and_integer("三千五百四十八", 3548)
  end

  it "三千五百四十九" do
    compare_kanji_and_integer("三千五百四十九", 3549)
  end

  it "三千五百五十" do
    compare_kanji_and_integer("三千五百五十", 3550)
  end

  it "三千五百五十一" do
    compare_kanji_and_integer("三千五百五十一", 3551)
  end

  it "三千五百五十二" do
    compare_kanji_and_integer("三千五百五十二", 3552)
  end

  it "三千五百五十三" do
    compare_kanji_and_integer("三千五百五十三", 3553)
  end

  it "三千五百五十四" do
    compare_kanji_and_integer("三千五百五十四", 3554)
  end

  it "三千五百五十五" do
    compare_kanji_and_integer("三千五百五十五", 3555)
  end

  it "三千五百五十六" do
    compare_kanji_and_integer("三千五百五十六", 3556)
  end

  it "三千五百五十七" do
    compare_kanji_and_integer("三千五百五十七", 3557)
  end

  it "三千五百五十八" do
    compare_kanji_and_integer("三千五百五十八", 3558)
  end

  it "三千五百五十九" do
    compare_kanji_and_integer("三千五百五十九", 3559)
  end

  it "三千五百六十" do
    compare_kanji_and_integer("三千五百六十", 3560)
  end

  it "三千五百六十一" do
    compare_kanji_and_integer("三千五百六十一", 3561)
  end

  it "三千五百六十二" do
    compare_kanji_and_integer("三千五百六十二", 3562)
  end

  it "三千五百六十三" do
    compare_kanji_and_integer("三千五百六十三", 3563)
  end

  it "三千五百六十四" do
    compare_kanji_and_integer("三千五百六十四", 3564)
  end

  it "三千五百六十五" do
    compare_kanji_and_integer("三千五百六十五", 3565)
  end

  it "三千五百六十六" do
    compare_kanji_and_integer("三千五百六十六", 3566)
  end

  it "三千五百六十七" do
    compare_kanji_and_integer("三千五百六十七", 3567)
  end

  it "三千五百六十八" do
    compare_kanji_and_integer("三千五百六十八", 3568)
  end

  it "三千五百六十九" do
    compare_kanji_and_integer("三千五百六十九", 3569)
  end

  it "三千五百七十" do
    compare_kanji_and_integer("三千五百七十", 3570)
  end

  it "三千五百七十一" do
    compare_kanji_and_integer("三千五百七十一", 3571)
  end

  it "三千五百七十二" do
    compare_kanji_and_integer("三千五百七十二", 3572)
  end

  it "三千五百七十三" do
    compare_kanji_and_integer("三千五百七十三", 3573)
  end

  it "三千五百七十四" do
    compare_kanji_and_integer("三千五百七十四", 3574)
  end

  it "三千五百七十五" do
    compare_kanji_and_integer("三千五百七十五", 3575)
  end

  it "三千五百七十六" do
    compare_kanji_and_integer("三千五百七十六", 3576)
  end

  it "三千五百七十七" do
    compare_kanji_and_integer("三千五百七十七", 3577)
  end

  it "三千五百七十八" do
    compare_kanji_and_integer("三千五百七十八", 3578)
  end

  it "三千五百七十九" do
    compare_kanji_and_integer("三千五百七十九", 3579)
  end

  it "三千五百八十" do
    compare_kanji_and_integer("三千五百八十", 3580)
  end

  it "三千五百八十一" do
    compare_kanji_and_integer("三千五百八十一", 3581)
  end

  it "三千五百八十二" do
    compare_kanji_and_integer("三千五百八十二", 3582)
  end

  it "三千五百八十三" do
    compare_kanji_and_integer("三千五百八十三", 3583)
  end

  it "三千五百八十四" do
    compare_kanji_and_integer("三千五百八十四", 3584)
  end

  it "三千五百八十五" do
    compare_kanji_and_integer("三千五百八十五", 3585)
  end

  it "三千五百八十六" do
    compare_kanji_and_integer("三千五百八十六", 3586)
  end

  it "三千五百八十七" do
    compare_kanji_and_integer("三千五百八十七", 3587)
  end

  it "三千五百八十八" do
    compare_kanji_and_integer("三千五百八十八", 3588)
  end

  it "三千五百八十九" do
    compare_kanji_and_integer("三千五百八十九", 3589)
  end

  it "三千五百九十" do
    compare_kanji_and_integer("三千五百九十", 3590)
  end

  it "三千五百九十一" do
    compare_kanji_and_integer("三千五百九十一", 3591)
  end

  it "三千五百九十二" do
    compare_kanji_and_integer("三千五百九十二", 3592)
  end

  it "三千五百九十三" do
    compare_kanji_and_integer("三千五百九十三", 3593)
  end

  it "三千五百九十四" do
    compare_kanji_and_integer("三千五百九十四", 3594)
  end

  it "三千五百九十五" do
    compare_kanji_and_integer("三千五百九十五", 3595)
  end

  it "三千五百九十六" do
    compare_kanji_and_integer("三千五百九十六", 3596)
  end

  it "三千五百九十七" do
    compare_kanji_and_integer("三千五百九十七", 3597)
  end

  it "三千五百九十八" do
    compare_kanji_and_integer("三千五百九十八", 3598)
  end

  it "三千五百九十九" do
    compare_kanji_and_integer("三千五百九十九", 3599)
  end

  it "三千六百" do
    compare_kanji_and_integer("三千六百", 3600)
  end

  it "三千六百一" do
    compare_kanji_and_integer("三千六百一", 3601)
  end

  it "三千六百二" do
    compare_kanji_and_integer("三千六百二", 3602)
  end

  it "三千六百三" do
    compare_kanji_and_integer("三千六百三", 3603)
  end

  it "三千六百四" do
    compare_kanji_and_integer("三千六百四", 3604)
  end

  it "三千六百五" do
    compare_kanji_and_integer("三千六百五", 3605)
  end

  it "三千六百六" do
    compare_kanji_and_integer("三千六百六", 3606)
  end

  it "三千六百七" do
    compare_kanji_and_integer("三千六百七", 3607)
  end

  it "三千六百八" do
    compare_kanji_and_integer("三千六百八", 3608)
  end

  it "三千六百九" do
    compare_kanji_and_integer("三千六百九", 3609)
  end

  it "三千六百十" do
    compare_kanji_and_integer("三千六百十", 3610)
  end

  it "三千六百十一" do
    compare_kanji_and_integer("三千六百十一", 3611)
  end

  it "三千六百十二" do
    compare_kanji_and_integer("三千六百十二", 3612)
  end

  it "三千六百十三" do
    compare_kanji_and_integer("三千六百十三", 3613)
  end

  it "三千六百十四" do
    compare_kanji_and_integer("三千六百十四", 3614)
  end

  it "三千六百十五" do
    compare_kanji_and_integer("三千六百十五", 3615)
  end

  it "三千六百十六" do
    compare_kanji_and_integer("三千六百十六", 3616)
  end

  it "三千六百十七" do
    compare_kanji_and_integer("三千六百十七", 3617)
  end

  it "三千六百十八" do
    compare_kanji_and_integer("三千六百十八", 3618)
  end

  it "三千六百十九" do
    compare_kanji_and_integer("三千六百十九", 3619)
  end

  it "三千六百二十" do
    compare_kanji_and_integer("三千六百二十", 3620)
  end

  it "三千六百二十一" do
    compare_kanji_and_integer("三千六百二十一", 3621)
  end

  it "三千六百二十二" do
    compare_kanji_and_integer("三千六百二十二", 3622)
  end

  it "三千六百二十三" do
    compare_kanji_and_integer("三千六百二十三", 3623)
  end

  it "三千六百二十四" do
    compare_kanji_and_integer("三千六百二十四", 3624)
  end

  it "三千六百二十五" do
    compare_kanji_and_integer("三千六百二十五", 3625)
  end

  it "三千六百二十六" do
    compare_kanji_and_integer("三千六百二十六", 3626)
  end

  it "三千六百二十七" do
    compare_kanji_and_integer("三千六百二十七", 3627)
  end

  it "三千六百二十八" do
    compare_kanji_and_integer("三千六百二十八", 3628)
  end

  it "三千六百二十九" do
    compare_kanji_and_integer("三千六百二十九", 3629)
  end

  it "三千六百三十" do
    compare_kanji_and_integer("三千六百三十", 3630)
  end

  it "三千六百三十一" do
    compare_kanji_and_integer("三千六百三十一", 3631)
  end

  it "三千六百三十二" do
    compare_kanji_and_integer("三千六百三十二", 3632)
  end

  it "三千六百三十三" do
    compare_kanji_and_integer("三千六百三十三", 3633)
  end

  it "三千六百三十四" do
    compare_kanji_and_integer("三千六百三十四", 3634)
  end

  it "三千六百三十五" do
    compare_kanji_and_integer("三千六百三十五", 3635)
  end

  it "三千六百三十六" do
    compare_kanji_and_integer("三千六百三十六", 3636)
  end

  it "三千六百三十七" do
    compare_kanji_and_integer("三千六百三十七", 3637)
  end

  it "三千六百三十八" do
    compare_kanji_and_integer("三千六百三十八", 3638)
  end

  it "三千六百三十九" do
    compare_kanji_and_integer("三千六百三十九", 3639)
  end

  it "三千六百四十" do
    compare_kanji_and_integer("三千六百四十", 3640)
  end

  it "三千六百四十一" do
    compare_kanji_and_integer("三千六百四十一", 3641)
  end

  it "三千六百四十二" do
    compare_kanji_and_integer("三千六百四十二", 3642)
  end

  it "三千六百四十三" do
    compare_kanji_and_integer("三千六百四十三", 3643)
  end

  it "三千六百四十四" do
    compare_kanji_and_integer("三千六百四十四", 3644)
  end

  it "三千六百四十五" do
    compare_kanji_and_integer("三千六百四十五", 3645)
  end

  it "三千六百四十六" do
    compare_kanji_and_integer("三千六百四十六", 3646)
  end

  it "三千六百四十七" do
    compare_kanji_and_integer("三千六百四十七", 3647)
  end

  it "三千六百四十八" do
    compare_kanji_and_integer("三千六百四十八", 3648)
  end

  it "三千六百四十九" do
    compare_kanji_and_integer("三千六百四十九", 3649)
  end

  it "三千六百五十" do
    compare_kanji_and_integer("三千六百五十", 3650)
  end

  it "三千六百五十一" do
    compare_kanji_and_integer("三千六百五十一", 3651)
  end

  it "三千六百五十二" do
    compare_kanji_and_integer("三千六百五十二", 3652)
  end

  it "三千六百五十三" do
    compare_kanji_and_integer("三千六百五十三", 3653)
  end

  it "三千六百五十四" do
    compare_kanji_and_integer("三千六百五十四", 3654)
  end

  it "三千六百五十五" do
    compare_kanji_and_integer("三千六百五十五", 3655)
  end

  it "三千六百五十六" do
    compare_kanji_and_integer("三千六百五十六", 3656)
  end

  it "三千六百五十七" do
    compare_kanji_and_integer("三千六百五十七", 3657)
  end

  it "三千六百五十八" do
    compare_kanji_and_integer("三千六百五十八", 3658)
  end

  it "三千六百五十九" do
    compare_kanji_and_integer("三千六百五十九", 3659)
  end

  it "三千六百六十" do
    compare_kanji_and_integer("三千六百六十", 3660)
  end

  it "三千六百六十一" do
    compare_kanji_and_integer("三千六百六十一", 3661)
  end

  it "三千六百六十二" do
    compare_kanji_and_integer("三千六百六十二", 3662)
  end

  it "三千六百六十三" do
    compare_kanji_and_integer("三千六百六十三", 3663)
  end

  it "三千六百六十四" do
    compare_kanji_and_integer("三千六百六十四", 3664)
  end

  it "三千六百六十五" do
    compare_kanji_and_integer("三千六百六十五", 3665)
  end

  it "三千六百六十六" do
    compare_kanji_and_integer("三千六百六十六", 3666)
  end

  it "三千六百六十七" do
    compare_kanji_and_integer("三千六百六十七", 3667)
  end

  it "三千六百六十八" do
    compare_kanji_and_integer("三千六百六十八", 3668)
  end

  it "三千六百六十九" do
    compare_kanji_and_integer("三千六百六十九", 3669)
  end

  it "三千六百七十" do
    compare_kanji_and_integer("三千六百七十", 3670)
  end

  it "三千六百七十一" do
    compare_kanji_and_integer("三千六百七十一", 3671)
  end

  it "三千六百七十二" do
    compare_kanji_and_integer("三千六百七十二", 3672)
  end

  it "三千六百七十三" do
    compare_kanji_and_integer("三千六百七十三", 3673)
  end

  it "三千六百七十四" do
    compare_kanji_and_integer("三千六百七十四", 3674)
  end

  it "三千六百七十五" do
    compare_kanji_and_integer("三千六百七十五", 3675)
  end

  it "三千六百七十六" do
    compare_kanji_and_integer("三千六百七十六", 3676)
  end

  it "三千六百七十七" do
    compare_kanji_and_integer("三千六百七十七", 3677)
  end

  it "三千六百七十八" do
    compare_kanji_and_integer("三千六百七十八", 3678)
  end

  it "三千六百七十九" do
    compare_kanji_and_integer("三千六百七十九", 3679)
  end

  it "三千六百八十" do
    compare_kanji_and_integer("三千六百八十", 3680)
  end

  it "三千六百八十一" do
    compare_kanji_and_integer("三千六百八十一", 3681)
  end

  it "三千六百八十二" do
    compare_kanji_and_integer("三千六百八十二", 3682)
  end

  it "三千六百八十三" do
    compare_kanji_and_integer("三千六百八十三", 3683)
  end

  it "三千六百八十四" do
    compare_kanji_and_integer("三千六百八十四", 3684)
  end

  it "三千六百八十五" do
    compare_kanji_and_integer("三千六百八十五", 3685)
  end

  it "三千六百八十六" do
    compare_kanji_and_integer("三千六百八十六", 3686)
  end

  it "三千六百八十七" do
    compare_kanji_and_integer("三千六百八十七", 3687)
  end

  it "三千六百八十八" do
    compare_kanji_and_integer("三千六百八十八", 3688)
  end

  it "三千六百八十九" do
    compare_kanji_and_integer("三千六百八十九", 3689)
  end

  it "三千六百九十" do
    compare_kanji_and_integer("三千六百九十", 3690)
  end

  it "三千六百九十一" do
    compare_kanji_and_integer("三千六百九十一", 3691)
  end

  it "三千六百九十二" do
    compare_kanji_and_integer("三千六百九十二", 3692)
  end

  it "三千六百九十三" do
    compare_kanji_and_integer("三千六百九十三", 3693)
  end

  it "三千六百九十四" do
    compare_kanji_and_integer("三千六百九十四", 3694)
  end

  it "三千六百九十五" do
    compare_kanji_and_integer("三千六百九十五", 3695)
  end

  it "三千六百九十六" do
    compare_kanji_and_integer("三千六百九十六", 3696)
  end

  it "三千六百九十七" do
    compare_kanji_and_integer("三千六百九十七", 3697)
  end

  it "三千六百九十八" do
    compare_kanji_and_integer("三千六百九十八", 3698)
  end

  it "三千六百九十九" do
    compare_kanji_and_integer("三千六百九十九", 3699)
  end

  it "三千七百" do
    compare_kanji_and_integer("三千七百", 3700)
  end

  it "三千七百一" do
    compare_kanji_and_integer("三千七百一", 3701)
  end

  it "三千七百二" do
    compare_kanji_and_integer("三千七百二", 3702)
  end

  it "三千七百三" do
    compare_kanji_and_integer("三千七百三", 3703)
  end

  it "三千七百四" do
    compare_kanji_and_integer("三千七百四", 3704)
  end

  it "三千七百五" do
    compare_kanji_and_integer("三千七百五", 3705)
  end

  it "三千七百六" do
    compare_kanji_and_integer("三千七百六", 3706)
  end

  it "三千七百七" do
    compare_kanji_and_integer("三千七百七", 3707)
  end

  it "三千七百八" do
    compare_kanji_and_integer("三千七百八", 3708)
  end

  it "三千七百九" do
    compare_kanji_and_integer("三千七百九", 3709)
  end

  it "三千七百十" do
    compare_kanji_and_integer("三千七百十", 3710)
  end

  it "三千七百十一" do
    compare_kanji_and_integer("三千七百十一", 3711)
  end

  it "三千七百十二" do
    compare_kanji_and_integer("三千七百十二", 3712)
  end

  it "三千七百十三" do
    compare_kanji_and_integer("三千七百十三", 3713)
  end

  it "三千七百十四" do
    compare_kanji_and_integer("三千七百十四", 3714)
  end

  it "三千七百十五" do
    compare_kanji_and_integer("三千七百十五", 3715)
  end

  it "三千七百十六" do
    compare_kanji_and_integer("三千七百十六", 3716)
  end

  it "三千七百十七" do
    compare_kanji_and_integer("三千七百十七", 3717)
  end

  it "三千七百十八" do
    compare_kanji_and_integer("三千七百十八", 3718)
  end

  it "三千七百十九" do
    compare_kanji_and_integer("三千七百十九", 3719)
  end

  it "三千七百二十" do
    compare_kanji_and_integer("三千七百二十", 3720)
  end

  it "三千七百二十一" do
    compare_kanji_and_integer("三千七百二十一", 3721)
  end

  it "三千七百二十二" do
    compare_kanji_and_integer("三千七百二十二", 3722)
  end

  it "三千七百二十三" do
    compare_kanji_and_integer("三千七百二十三", 3723)
  end

  it "三千七百二十四" do
    compare_kanji_and_integer("三千七百二十四", 3724)
  end

  it "三千七百二十五" do
    compare_kanji_and_integer("三千七百二十五", 3725)
  end

  it "三千七百二十六" do
    compare_kanji_and_integer("三千七百二十六", 3726)
  end

  it "三千七百二十七" do
    compare_kanji_and_integer("三千七百二十七", 3727)
  end

  it "三千七百二十八" do
    compare_kanji_and_integer("三千七百二十八", 3728)
  end

  it "三千七百二十九" do
    compare_kanji_and_integer("三千七百二十九", 3729)
  end

  it "三千七百三十" do
    compare_kanji_and_integer("三千七百三十", 3730)
  end

  it "三千七百三十一" do
    compare_kanji_and_integer("三千七百三十一", 3731)
  end

  it "三千七百三十二" do
    compare_kanji_and_integer("三千七百三十二", 3732)
  end

  it "三千七百三十三" do
    compare_kanji_and_integer("三千七百三十三", 3733)
  end

  it "三千七百三十四" do
    compare_kanji_and_integer("三千七百三十四", 3734)
  end

  it "三千七百三十五" do
    compare_kanji_and_integer("三千七百三十五", 3735)
  end

  it "三千七百三十六" do
    compare_kanji_and_integer("三千七百三十六", 3736)
  end

  it "三千七百三十七" do
    compare_kanji_and_integer("三千七百三十七", 3737)
  end

  it "三千七百三十八" do
    compare_kanji_and_integer("三千七百三十八", 3738)
  end

  it "三千七百三十九" do
    compare_kanji_and_integer("三千七百三十九", 3739)
  end

  it "三千七百四十" do
    compare_kanji_and_integer("三千七百四十", 3740)
  end

  it "三千七百四十一" do
    compare_kanji_and_integer("三千七百四十一", 3741)
  end

  it "三千七百四十二" do
    compare_kanji_and_integer("三千七百四十二", 3742)
  end

  it "三千七百四十三" do
    compare_kanji_and_integer("三千七百四十三", 3743)
  end

  it "三千七百四十四" do
    compare_kanji_and_integer("三千七百四十四", 3744)
  end

  it "三千七百四十五" do
    compare_kanji_and_integer("三千七百四十五", 3745)
  end

  it "三千七百四十六" do
    compare_kanji_and_integer("三千七百四十六", 3746)
  end

  it "三千七百四十七" do
    compare_kanji_and_integer("三千七百四十七", 3747)
  end

  it "三千七百四十八" do
    compare_kanji_and_integer("三千七百四十八", 3748)
  end

  it "三千七百四十九" do
    compare_kanji_and_integer("三千七百四十九", 3749)
  end

  it "三千七百五十" do
    compare_kanji_and_integer("三千七百五十", 3750)
  end

  it "三千七百五十一" do
    compare_kanji_and_integer("三千七百五十一", 3751)
  end

  it "三千七百五十二" do
    compare_kanji_and_integer("三千七百五十二", 3752)
  end

  it "三千七百五十三" do
    compare_kanji_and_integer("三千七百五十三", 3753)
  end

  it "三千七百五十四" do
    compare_kanji_and_integer("三千七百五十四", 3754)
  end

  it "三千七百五十五" do
    compare_kanji_and_integer("三千七百五十五", 3755)
  end

  it "三千七百五十六" do
    compare_kanji_and_integer("三千七百五十六", 3756)
  end

  it "三千七百五十七" do
    compare_kanji_and_integer("三千七百五十七", 3757)
  end

  it "三千七百五十八" do
    compare_kanji_and_integer("三千七百五十八", 3758)
  end

  it "三千七百五十九" do
    compare_kanji_and_integer("三千七百五十九", 3759)
  end

  it "三千七百六十" do
    compare_kanji_and_integer("三千七百六十", 3760)
  end

  it "三千七百六十一" do
    compare_kanji_and_integer("三千七百六十一", 3761)
  end

  it "三千七百六十二" do
    compare_kanji_and_integer("三千七百六十二", 3762)
  end

  it "三千七百六十三" do
    compare_kanji_and_integer("三千七百六十三", 3763)
  end

  it "三千七百六十四" do
    compare_kanji_and_integer("三千七百六十四", 3764)
  end

  it "三千七百六十五" do
    compare_kanji_and_integer("三千七百六十五", 3765)
  end

  it "三千七百六十六" do
    compare_kanji_and_integer("三千七百六十六", 3766)
  end

  it "三千七百六十七" do
    compare_kanji_and_integer("三千七百六十七", 3767)
  end

  it "三千七百六十八" do
    compare_kanji_and_integer("三千七百六十八", 3768)
  end

  it "三千七百六十九" do
    compare_kanji_and_integer("三千七百六十九", 3769)
  end

  it "三千七百七十" do
    compare_kanji_and_integer("三千七百七十", 3770)
  end

  it "三千七百七十一" do
    compare_kanji_and_integer("三千七百七十一", 3771)
  end

  it "三千七百七十二" do
    compare_kanji_and_integer("三千七百七十二", 3772)
  end

  it "三千七百七十三" do
    compare_kanji_and_integer("三千七百七十三", 3773)
  end

  it "三千七百七十四" do
    compare_kanji_and_integer("三千七百七十四", 3774)
  end

  it "三千七百七十五" do
    compare_kanji_and_integer("三千七百七十五", 3775)
  end

  it "三千七百七十六" do
    compare_kanji_and_integer("三千七百七十六", 3776)
  end

  it "三千七百七十七" do
    compare_kanji_and_integer("三千七百七十七", 3777)
  end

  it "三千七百七十八" do
    compare_kanji_and_integer("三千七百七十八", 3778)
  end

  it "三千七百七十九" do
    compare_kanji_and_integer("三千七百七十九", 3779)
  end

  it "三千七百八十" do
    compare_kanji_and_integer("三千七百八十", 3780)
  end

  it "三千七百八十一" do
    compare_kanji_and_integer("三千七百八十一", 3781)
  end

  it "三千七百八十二" do
    compare_kanji_and_integer("三千七百八十二", 3782)
  end

  it "三千七百八十三" do
    compare_kanji_and_integer("三千七百八十三", 3783)
  end

  it "三千七百八十四" do
    compare_kanji_and_integer("三千七百八十四", 3784)
  end

  it "三千七百八十五" do
    compare_kanji_and_integer("三千七百八十五", 3785)
  end

  it "三千七百八十六" do
    compare_kanji_and_integer("三千七百八十六", 3786)
  end

  it "三千七百八十七" do
    compare_kanji_and_integer("三千七百八十七", 3787)
  end

  it "三千七百八十八" do
    compare_kanji_and_integer("三千七百八十八", 3788)
  end

  it "三千七百八十九" do
    compare_kanji_and_integer("三千七百八十九", 3789)
  end

  it "三千七百九十" do
    compare_kanji_and_integer("三千七百九十", 3790)
  end

  it "三千七百九十一" do
    compare_kanji_and_integer("三千七百九十一", 3791)
  end

  it "三千七百九十二" do
    compare_kanji_and_integer("三千七百九十二", 3792)
  end

  it "三千七百九十三" do
    compare_kanji_and_integer("三千七百九十三", 3793)
  end

  it "三千七百九十四" do
    compare_kanji_and_integer("三千七百九十四", 3794)
  end

  it "三千七百九十五" do
    compare_kanji_and_integer("三千七百九十五", 3795)
  end

  it "三千七百九十六" do
    compare_kanji_and_integer("三千七百九十六", 3796)
  end

  it "三千七百九十七" do
    compare_kanji_and_integer("三千七百九十七", 3797)
  end

  it "三千七百九十八" do
    compare_kanji_and_integer("三千七百九十八", 3798)
  end

  it "三千七百九十九" do
    compare_kanji_and_integer("三千七百九十九", 3799)
  end

  it "三千八百" do
    compare_kanji_and_integer("三千八百", 3800)
  end

  it "三千八百一" do
    compare_kanji_and_integer("三千八百一", 3801)
  end

  it "三千八百二" do
    compare_kanji_and_integer("三千八百二", 3802)
  end

  it "三千八百三" do
    compare_kanji_and_integer("三千八百三", 3803)
  end

  it "三千八百四" do
    compare_kanji_and_integer("三千八百四", 3804)
  end

  it "三千八百五" do
    compare_kanji_and_integer("三千八百五", 3805)
  end

  it "三千八百六" do
    compare_kanji_and_integer("三千八百六", 3806)
  end

  it "三千八百七" do
    compare_kanji_and_integer("三千八百七", 3807)
  end

  it "三千八百八" do
    compare_kanji_and_integer("三千八百八", 3808)
  end

  it "三千八百九" do
    compare_kanji_and_integer("三千八百九", 3809)
  end

  it "三千八百十" do
    compare_kanji_and_integer("三千八百十", 3810)
  end

  it "三千八百十一" do
    compare_kanji_and_integer("三千八百十一", 3811)
  end

  it "三千八百十二" do
    compare_kanji_and_integer("三千八百十二", 3812)
  end

  it "三千八百十三" do
    compare_kanji_and_integer("三千八百十三", 3813)
  end

  it "三千八百十四" do
    compare_kanji_and_integer("三千八百十四", 3814)
  end

  it "三千八百十五" do
    compare_kanji_and_integer("三千八百十五", 3815)
  end

  it "三千八百十六" do
    compare_kanji_and_integer("三千八百十六", 3816)
  end

  it "三千八百十七" do
    compare_kanji_and_integer("三千八百十七", 3817)
  end

  it "三千八百十八" do
    compare_kanji_and_integer("三千八百十八", 3818)
  end

  it "三千八百十九" do
    compare_kanji_and_integer("三千八百十九", 3819)
  end

  it "三千八百二十" do
    compare_kanji_and_integer("三千八百二十", 3820)
  end

  it "三千八百二十一" do
    compare_kanji_and_integer("三千八百二十一", 3821)
  end

  it "三千八百二十二" do
    compare_kanji_and_integer("三千八百二十二", 3822)
  end

  it "三千八百二十三" do
    compare_kanji_and_integer("三千八百二十三", 3823)
  end

  it "三千八百二十四" do
    compare_kanji_and_integer("三千八百二十四", 3824)
  end

  it "三千八百二十五" do
    compare_kanji_and_integer("三千八百二十五", 3825)
  end

  it "三千八百二十六" do
    compare_kanji_and_integer("三千八百二十六", 3826)
  end

  it "三千八百二十七" do
    compare_kanji_and_integer("三千八百二十七", 3827)
  end

  it "三千八百二十八" do
    compare_kanji_and_integer("三千八百二十八", 3828)
  end

  it "三千八百二十九" do
    compare_kanji_and_integer("三千八百二十九", 3829)
  end

  it "三千八百三十" do
    compare_kanji_and_integer("三千八百三十", 3830)
  end

  it "三千八百三十一" do
    compare_kanji_and_integer("三千八百三十一", 3831)
  end

  it "三千八百三十二" do
    compare_kanji_and_integer("三千八百三十二", 3832)
  end

  it "三千八百三十三" do
    compare_kanji_and_integer("三千八百三十三", 3833)
  end

  it "三千八百三十四" do
    compare_kanji_and_integer("三千八百三十四", 3834)
  end

  it "三千八百三十五" do
    compare_kanji_and_integer("三千八百三十五", 3835)
  end

  it "三千八百三十六" do
    compare_kanji_and_integer("三千八百三十六", 3836)
  end

  it "三千八百三十七" do
    compare_kanji_and_integer("三千八百三十七", 3837)
  end

  it "三千八百三十八" do
    compare_kanji_and_integer("三千八百三十八", 3838)
  end

  it "三千八百三十九" do
    compare_kanji_and_integer("三千八百三十九", 3839)
  end

  it "三千八百四十" do
    compare_kanji_and_integer("三千八百四十", 3840)
  end

  it "三千八百四十一" do
    compare_kanji_and_integer("三千八百四十一", 3841)
  end

  it "三千八百四十二" do
    compare_kanji_and_integer("三千八百四十二", 3842)
  end

  it "三千八百四十三" do
    compare_kanji_and_integer("三千八百四十三", 3843)
  end

  it "三千八百四十四" do
    compare_kanji_and_integer("三千八百四十四", 3844)
  end

  it "三千八百四十五" do
    compare_kanji_and_integer("三千八百四十五", 3845)
  end

  it "三千八百四十六" do
    compare_kanji_and_integer("三千八百四十六", 3846)
  end

  it "三千八百四十七" do
    compare_kanji_and_integer("三千八百四十七", 3847)
  end

  it "三千八百四十八" do
    compare_kanji_and_integer("三千八百四十八", 3848)
  end

  it "三千八百四十九" do
    compare_kanji_and_integer("三千八百四十九", 3849)
  end

  it "三千八百五十" do
    compare_kanji_and_integer("三千八百五十", 3850)
  end

  it "三千八百五十一" do
    compare_kanji_and_integer("三千八百五十一", 3851)
  end

  it "三千八百五十二" do
    compare_kanji_and_integer("三千八百五十二", 3852)
  end

  it "三千八百五十三" do
    compare_kanji_and_integer("三千八百五十三", 3853)
  end

  it "三千八百五十四" do
    compare_kanji_and_integer("三千八百五十四", 3854)
  end

  it "三千八百五十五" do
    compare_kanji_and_integer("三千八百五十五", 3855)
  end

  it "三千八百五十六" do
    compare_kanji_and_integer("三千八百五十六", 3856)
  end

  it "三千八百五十七" do
    compare_kanji_and_integer("三千八百五十七", 3857)
  end

  it "三千八百五十八" do
    compare_kanji_and_integer("三千八百五十八", 3858)
  end

  it "三千八百五十九" do
    compare_kanji_and_integer("三千八百五十九", 3859)
  end

  it "三千八百六十" do
    compare_kanji_and_integer("三千八百六十", 3860)
  end

  it "三千八百六十一" do
    compare_kanji_and_integer("三千八百六十一", 3861)
  end

  it "三千八百六十二" do
    compare_kanji_and_integer("三千八百六十二", 3862)
  end

  it "三千八百六十三" do
    compare_kanji_and_integer("三千八百六十三", 3863)
  end

  it "三千八百六十四" do
    compare_kanji_and_integer("三千八百六十四", 3864)
  end

  it "三千八百六十五" do
    compare_kanji_and_integer("三千八百六十五", 3865)
  end

  it "三千八百六十六" do
    compare_kanji_and_integer("三千八百六十六", 3866)
  end

  it "三千八百六十七" do
    compare_kanji_and_integer("三千八百六十七", 3867)
  end

  it "三千八百六十八" do
    compare_kanji_and_integer("三千八百六十八", 3868)
  end

  it "三千八百六十九" do
    compare_kanji_and_integer("三千八百六十九", 3869)
  end

  it "三千八百七十" do
    compare_kanji_and_integer("三千八百七十", 3870)
  end

  it "三千八百七十一" do
    compare_kanji_and_integer("三千八百七十一", 3871)
  end

  it "三千八百七十二" do
    compare_kanji_and_integer("三千八百七十二", 3872)
  end

  it "三千八百七十三" do
    compare_kanji_and_integer("三千八百七十三", 3873)
  end

  it "三千八百七十四" do
    compare_kanji_and_integer("三千八百七十四", 3874)
  end

  it "三千八百七十五" do
    compare_kanji_and_integer("三千八百七十五", 3875)
  end

  it "三千八百七十六" do
    compare_kanji_and_integer("三千八百七十六", 3876)
  end

  it "三千八百七十七" do
    compare_kanji_and_integer("三千八百七十七", 3877)
  end

  it "三千八百七十八" do
    compare_kanji_and_integer("三千八百七十八", 3878)
  end

  it "三千八百七十九" do
    compare_kanji_and_integer("三千八百七十九", 3879)
  end

  it "三千八百八十" do
    compare_kanji_and_integer("三千八百八十", 3880)
  end

  it "三千八百八十一" do
    compare_kanji_and_integer("三千八百八十一", 3881)
  end

  it "三千八百八十二" do
    compare_kanji_and_integer("三千八百八十二", 3882)
  end

  it "三千八百八十三" do
    compare_kanji_and_integer("三千八百八十三", 3883)
  end

  it "三千八百八十四" do
    compare_kanji_and_integer("三千八百八十四", 3884)
  end

  it "三千八百八十五" do
    compare_kanji_and_integer("三千八百八十五", 3885)
  end

  it "三千八百八十六" do
    compare_kanji_and_integer("三千八百八十六", 3886)
  end

  it "三千八百八十七" do
    compare_kanji_and_integer("三千八百八十七", 3887)
  end

  it "三千八百八十八" do
    compare_kanji_and_integer("三千八百八十八", 3888)
  end

  it "三千八百八十九" do
    compare_kanji_and_integer("三千八百八十九", 3889)
  end

  it "三千八百九十" do
    compare_kanji_and_integer("三千八百九十", 3890)
  end

  it "三千八百九十一" do
    compare_kanji_and_integer("三千八百九十一", 3891)
  end

  it "三千八百九十二" do
    compare_kanji_and_integer("三千八百九十二", 3892)
  end

  it "三千八百九十三" do
    compare_kanji_and_integer("三千八百九十三", 3893)
  end

  it "三千八百九十四" do
    compare_kanji_and_integer("三千八百九十四", 3894)
  end

  it "三千八百九十五" do
    compare_kanji_and_integer("三千八百九十五", 3895)
  end

  it "三千八百九十六" do
    compare_kanji_and_integer("三千八百九十六", 3896)
  end

  it "三千八百九十七" do
    compare_kanji_and_integer("三千八百九十七", 3897)
  end

  it "三千八百九十八" do
    compare_kanji_and_integer("三千八百九十八", 3898)
  end

  it "三千八百九十九" do
    compare_kanji_and_integer("三千八百九十九", 3899)
  end

  it "三千九百" do
    compare_kanji_and_integer("三千九百", 3900)
  end

  it "三千九百一" do
    compare_kanji_and_integer("三千九百一", 3901)
  end

  it "三千九百二" do
    compare_kanji_and_integer("三千九百二", 3902)
  end

  it "三千九百三" do
    compare_kanji_and_integer("三千九百三", 3903)
  end

  it "三千九百四" do
    compare_kanji_and_integer("三千九百四", 3904)
  end

  it "三千九百五" do
    compare_kanji_and_integer("三千九百五", 3905)
  end

  it "三千九百六" do
    compare_kanji_and_integer("三千九百六", 3906)
  end

  it "三千九百七" do
    compare_kanji_and_integer("三千九百七", 3907)
  end

  it "三千九百八" do
    compare_kanji_and_integer("三千九百八", 3908)
  end

  it "三千九百九" do
    compare_kanji_and_integer("三千九百九", 3909)
  end

  it "三千九百十" do
    compare_kanji_and_integer("三千九百十", 3910)
  end

  it "三千九百十一" do
    compare_kanji_and_integer("三千九百十一", 3911)
  end

  it "三千九百十二" do
    compare_kanji_and_integer("三千九百十二", 3912)
  end

  it "三千九百十三" do
    compare_kanji_and_integer("三千九百十三", 3913)
  end

  it "三千九百十四" do
    compare_kanji_and_integer("三千九百十四", 3914)
  end

  it "三千九百十五" do
    compare_kanji_and_integer("三千九百十五", 3915)
  end

  it "三千九百十六" do
    compare_kanji_and_integer("三千九百十六", 3916)
  end

  it "三千九百十七" do
    compare_kanji_and_integer("三千九百十七", 3917)
  end

  it "三千九百十八" do
    compare_kanji_and_integer("三千九百十八", 3918)
  end

  it "三千九百十九" do
    compare_kanji_and_integer("三千九百十九", 3919)
  end

  it "三千九百二十" do
    compare_kanji_and_integer("三千九百二十", 3920)
  end

  it "三千九百二十一" do
    compare_kanji_and_integer("三千九百二十一", 3921)
  end

  it "三千九百二十二" do
    compare_kanji_and_integer("三千九百二十二", 3922)
  end

  it "三千九百二十三" do
    compare_kanji_and_integer("三千九百二十三", 3923)
  end

  it "三千九百二十四" do
    compare_kanji_and_integer("三千九百二十四", 3924)
  end

  it "三千九百二十五" do
    compare_kanji_and_integer("三千九百二十五", 3925)
  end

  it "三千九百二十六" do
    compare_kanji_and_integer("三千九百二十六", 3926)
  end

  it "三千九百二十七" do
    compare_kanji_and_integer("三千九百二十七", 3927)
  end

  it "三千九百二十八" do
    compare_kanji_and_integer("三千九百二十八", 3928)
  end

  it "三千九百二十九" do
    compare_kanji_and_integer("三千九百二十九", 3929)
  end

  it "三千九百三十" do
    compare_kanji_and_integer("三千九百三十", 3930)
  end

  it "三千九百三十一" do
    compare_kanji_and_integer("三千九百三十一", 3931)
  end

  it "三千九百三十二" do
    compare_kanji_and_integer("三千九百三十二", 3932)
  end

  it "三千九百三十三" do
    compare_kanji_and_integer("三千九百三十三", 3933)
  end

  it "三千九百三十四" do
    compare_kanji_and_integer("三千九百三十四", 3934)
  end

  it "三千九百三十五" do
    compare_kanji_and_integer("三千九百三十五", 3935)
  end

  it "三千九百三十六" do
    compare_kanji_and_integer("三千九百三十六", 3936)
  end

  it "三千九百三十七" do
    compare_kanji_and_integer("三千九百三十七", 3937)
  end

  it "三千九百三十八" do
    compare_kanji_and_integer("三千九百三十八", 3938)
  end

  it "三千九百三十九" do
    compare_kanji_and_integer("三千九百三十九", 3939)
  end

  it "三千九百四十" do
    compare_kanji_and_integer("三千九百四十", 3940)
  end

  it "三千九百四十一" do
    compare_kanji_and_integer("三千九百四十一", 3941)
  end

  it "三千九百四十二" do
    compare_kanji_and_integer("三千九百四十二", 3942)
  end

  it "三千九百四十三" do
    compare_kanji_and_integer("三千九百四十三", 3943)
  end

  it "三千九百四十四" do
    compare_kanji_and_integer("三千九百四十四", 3944)
  end

  it "三千九百四十五" do
    compare_kanji_and_integer("三千九百四十五", 3945)
  end

  it "三千九百四十六" do
    compare_kanji_and_integer("三千九百四十六", 3946)
  end

  it "三千九百四十七" do
    compare_kanji_and_integer("三千九百四十七", 3947)
  end

  it "三千九百四十八" do
    compare_kanji_and_integer("三千九百四十八", 3948)
  end

  it "三千九百四十九" do
    compare_kanji_and_integer("三千九百四十九", 3949)
  end

  it "三千九百五十" do
    compare_kanji_and_integer("三千九百五十", 3950)
  end

  it "三千九百五十一" do
    compare_kanji_and_integer("三千九百五十一", 3951)
  end

  it "三千九百五十二" do
    compare_kanji_and_integer("三千九百五十二", 3952)
  end

  it "三千九百五十三" do
    compare_kanji_and_integer("三千九百五十三", 3953)
  end

  it "三千九百五十四" do
    compare_kanji_and_integer("三千九百五十四", 3954)
  end

  it "三千九百五十五" do
    compare_kanji_and_integer("三千九百五十五", 3955)
  end

  it "三千九百五十六" do
    compare_kanji_and_integer("三千九百五十六", 3956)
  end

  it "三千九百五十七" do
    compare_kanji_and_integer("三千九百五十七", 3957)
  end

  it "三千九百五十八" do
    compare_kanji_and_integer("三千九百五十八", 3958)
  end

  it "三千九百五十九" do
    compare_kanji_and_integer("三千九百五十九", 3959)
  end

  it "三千九百六十" do
    compare_kanji_and_integer("三千九百六十", 3960)
  end

  it "三千九百六十一" do
    compare_kanji_and_integer("三千九百六十一", 3961)
  end

  it "三千九百六十二" do
    compare_kanji_and_integer("三千九百六十二", 3962)
  end

  it "三千九百六十三" do
    compare_kanji_and_integer("三千九百六十三", 3963)
  end

  it "三千九百六十四" do
    compare_kanji_and_integer("三千九百六十四", 3964)
  end

  it "三千九百六十五" do
    compare_kanji_and_integer("三千九百六十五", 3965)
  end

  it "三千九百六十六" do
    compare_kanji_and_integer("三千九百六十六", 3966)
  end

  it "三千九百六十七" do
    compare_kanji_and_integer("三千九百六十七", 3967)
  end

  it "三千九百六十八" do
    compare_kanji_and_integer("三千九百六十八", 3968)
  end

  it "三千九百六十九" do
    compare_kanji_and_integer("三千九百六十九", 3969)
  end

  it "三千九百七十" do
    compare_kanji_and_integer("三千九百七十", 3970)
  end

  it "三千九百七十一" do
    compare_kanji_and_integer("三千九百七十一", 3971)
  end

  it "三千九百七十二" do
    compare_kanji_and_integer("三千九百七十二", 3972)
  end

  it "三千九百七十三" do
    compare_kanji_and_integer("三千九百七十三", 3973)
  end

  it "三千九百七十四" do
    compare_kanji_and_integer("三千九百七十四", 3974)
  end

  it "三千九百七十五" do
    compare_kanji_and_integer("三千九百七十五", 3975)
  end

  it "三千九百七十六" do
    compare_kanji_and_integer("三千九百七十六", 3976)
  end

  it "三千九百七十七" do
    compare_kanji_and_integer("三千九百七十七", 3977)
  end

  it "三千九百七十八" do
    compare_kanji_and_integer("三千九百七十八", 3978)
  end

  it "三千九百七十九" do
    compare_kanji_and_integer("三千九百七十九", 3979)
  end

  it "三千九百八十" do
    compare_kanji_and_integer("三千九百八十", 3980)
  end

  it "三千九百八十一" do
    compare_kanji_and_integer("三千九百八十一", 3981)
  end

  it "三千九百八十二" do
    compare_kanji_and_integer("三千九百八十二", 3982)
  end

  it "三千九百八十三" do
    compare_kanji_and_integer("三千九百八十三", 3983)
  end

  it "三千九百八十四" do
    compare_kanji_and_integer("三千九百八十四", 3984)
  end

  it "三千九百八十五" do
    compare_kanji_and_integer("三千九百八十五", 3985)
  end

  it "三千九百八十六" do
    compare_kanji_and_integer("三千九百八十六", 3986)
  end

  it "三千九百八十七" do
    compare_kanji_and_integer("三千九百八十七", 3987)
  end

  it "三千九百八十八" do
    compare_kanji_and_integer("三千九百八十八", 3988)
  end

  it "三千九百八十九" do
    compare_kanji_and_integer("三千九百八十九", 3989)
  end

  it "三千九百九十" do
    compare_kanji_and_integer("三千九百九十", 3990)
  end

  it "三千九百九十一" do
    compare_kanji_and_integer("三千九百九十一", 3991)
  end

  it "三千九百九十二" do
    compare_kanji_and_integer("三千九百九十二", 3992)
  end

  it "三千九百九十三" do
    compare_kanji_and_integer("三千九百九十三", 3993)
  end

  it "三千九百九十四" do
    compare_kanji_and_integer("三千九百九十四", 3994)
  end

  it "三千九百九十五" do
    compare_kanji_and_integer("三千九百九十五", 3995)
  end

  it "三千九百九十六" do
    compare_kanji_and_integer("三千九百九十六", 3996)
  end

  it "三千九百九十七" do
    compare_kanji_and_integer("三千九百九十七", 3997)
  end

  it "三千九百九十八" do
    compare_kanji_and_integer("三千九百九十八", 3998)
  end

  it "三千九百九十九" do
    compare_kanji_and_integer("三千九百九十九", 3999)
  end

  it "四千" do
    compare_kanji_and_integer("四千", 4000)
  end

  it "四千一" do
    compare_kanji_and_integer("四千一", 4001)
  end

  it "四千二" do
    compare_kanji_and_integer("四千二", 4002)
  end

  it "四千三" do
    compare_kanji_and_integer("四千三", 4003)
  end

  it "四千四" do
    compare_kanji_and_integer("四千四", 4004)
  end

  it "四千五" do
    compare_kanji_and_integer("四千五", 4005)
  end

  it "四千六" do
    compare_kanji_and_integer("四千六", 4006)
  end

  it "四千七" do
    compare_kanji_and_integer("四千七", 4007)
  end

  it "四千八" do
    compare_kanji_and_integer("四千八", 4008)
  end

  it "四千九" do
    compare_kanji_and_integer("四千九", 4009)
  end

  it "四千十" do
    compare_kanji_and_integer("四千十", 4010)
  end

  it "四千十一" do
    compare_kanji_and_integer("四千十一", 4011)
  end

  it "四千十二" do
    compare_kanji_and_integer("四千十二", 4012)
  end

  it "四千十三" do
    compare_kanji_and_integer("四千十三", 4013)
  end

  it "四千十四" do
    compare_kanji_and_integer("四千十四", 4014)
  end

  it "四千十五" do
    compare_kanji_and_integer("四千十五", 4015)
  end

  it "四千十六" do
    compare_kanji_and_integer("四千十六", 4016)
  end

  it "四千十七" do
    compare_kanji_and_integer("四千十七", 4017)
  end

  it "四千十八" do
    compare_kanji_and_integer("四千十八", 4018)
  end

  it "四千十九" do
    compare_kanji_and_integer("四千十九", 4019)
  end

  it "四千二十" do
    compare_kanji_and_integer("四千二十", 4020)
  end

  it "四千二十一" do
    compare_kanji_and_integer("四千二十一", 4021)
  end

  it "四千二十二" do
    compare_kanji_and_integer("四千二十二", 4022)
  end

  it "四千二十三" do
    compare_kanji_and_integer("四千二十三", 4023)
  end

  it "四千二十四" do
    compare_kanji_and_integer("四千二十四", 4024)
  end

  it "四千二十五" do
    compare_kanji_and_integer("四千二十五", 4025)
  end

  it "四千二十六" do
    compare_kanji_and_integer("四千二十六", 4026)
  end

  it "四千二十七" do
    compare_kanji_and_integer("四千二十七", 4027)
  end

  it "四千二十八" do
    compare_kanji_and_integer("四千二十八", 4028)
  end

  it "四千二十九" do
    compare_kanji_and_integer("四千二十九", 4029)
  end

  it "四千三十" do
    compare_kanji_and_integer("四千三十", 4030)
  end

  it "四千三十一" do
    compare_kanji_and_integer("四千三十一", 4031)
  end

  it "四千三十二" do
    compare_kanji_and_integer("四千三十二", 4032)
  end

  it "四千三十三" do
    compare_kanji_and_integer("四千三十三", 4033)
  end

  it "四千三十四" do
    compare_kanji_and_integer("四千三十四", 4034)
  end

  it "四千三十五" do
    compare_kanji_and_integer("四千三十五", 4035)
  end

  it "四千三十六" do
    compare_kanji_and_integer("四千三十六", 4036)
  end

  it "四千三十七" do
    compare_kanji_and_integer("四千三十七", 4037)
  end

  it "四千三十八" do
    compare_kanji_and_integer("四千三十八", 4038)
  end

  it "四千三十九" do
    compare_kanji_and_integer("四千三十九", 4039)
  end

  it "四千四十" do
    compare_kanji_and_integer("四千四十", 4040)
  end

  it "四千四十一" do
    compare_kanji_and_integer("四千四十一", 4041)
  end

  it "四千四十二" do
    compare_kanji_and_integer("四千四十二", 4042)
  end

  it "四千四十三" do
    compare_kanji_and_integer("四千四十三", 4043)
  end

  it "四千四十四" do
    compare_kanji_and_integer("四千四十四", 4044)
  end

  it "四千四十五" do
    compare_kanji_and_integer("四千四十五", 4045)
  end

  it "四千四十六" do
    compare_kanji_and_integer("四千四十六", 4046)
  end

  it "四千四十七" do
    compare_kanji_and_integer("四千四十七", 4047)
  end

  it "四千四十八" do
    compare_kanji_and_integer("四千四十八", 4048)
  end

  it "四千四十九" do
    compare_kanji_and_integer("四千四十九", 4049)
  end

  it "四千五十" do
    compare_kanji_and_integer("四千五十", 4050)
  end

  it "四千五十一" do
    compare_kanji_and_integer("四千五十一", 4051)
  end

  it "四千五十二" do
    compare_kanji_and_integer("四千五十二", 4052)
  end

  it "四千五十三" do
    compare_kanji_and_integer("四千五十三", 4053)
  end

  it "四千五十四" do
    compare_kanji_and_integer("四千五十四", 4054)
  end

  it "四千五十五" do
    compare_kanji_and_integer("四千五十五", 4055)
  end

  it "四千五十六" do
    compare_kanji_and_integer("四千五十六", 4056)
  end

  it "四千五十七" do
    compare_kanji_and_integer("四千五十七", 4057)
  end

  it "四千五十八" do
    compare_kanji_and_integer("四千五十八", 4058)
  end

  it "四千五十九" do
    compare_kanji_and_integer("四千五十九", 4059)
  end

  it "四千六十" do
    compare_kanji_and_integer("四千六十", 4060)
  end

  it "四千六十一" do
    compare_kanji_and_integer("四千六十一", 4061)
  end

  it "四千六十二" do
    compare_kanji_and_integer("四千六十二", 4062)
  end

  it "四千六十三" do
    compare_kanji_and_integer("四千六十三", 4063)
  end

  it "四千六十四" do
    compare_kanji_and_integer("四千六十四", 4064)
  end

  it "四千六十五" do
    compare_kanji_and_integer("四千六十五", 4065)
  end

  it "四千六十六" do
    compare_kanji_and_integer("四千六十六", 4066)
  end

  it "四千六十七" do
    compare_kanji_and_integer("四千六十七", 4067)
  end

  it "四千六十八" do
    compare_kanji_and_integer("四千六十八", 4068)
  end

  it "四千六十九" do
    compare_kanji_and_integer("四千六十九", 4069)
  end

  it "四千七十" do
    compare_kanji_and_integer("四千七十", 4070)
  end

  it "四千七十一" do
    compare_kanji_and_integer("四千七十一", 4071)
  end

  it "四千七十二" do
    compare_kanji_and_integer("四千七十二", 4072)
  end

  it "四千七十三" do
    compare_kanji_and_integer("四千七十三", 4073)
  end

  it "四千七十四" do
    compare_kanji_and_integer("四千七十四", 4074)
  end

  it "四千七十五" do
    compare_kanji_and_integer("四千七十五", 4075)
  end

  it "四千七十六" do
    compare_kanji_and_integer("四千七十六", 4076)
  end

  it "四千七十七" do
    compare_kanji_and_integer("四千七十七", 4077)
  end

  it "四千七十八" do
    compare_kanji_and_integer("四千七十八", 4078)
  end

  it "四千七十九" do
    compare_kanji_and_integer("四千七十九", 4079)
  end

  it "四千八十" do
    compare_kanji_and_integer("四千八十", 4080)
  end

  it "四千八十一" do
    compare_kanji_and_integer("四千八十一", 4081)
  end

  it "四千八十二" do
    compare_kanji_and_integer("四千八十二", 4082)
  end

  it "四千八十三" do
    compare_kanji_and_integer("四千八十三", 4083)
  end

  it "四千八十四" do
    compare_kanji_and_integer("四千八十四", 4084)
  end

  it "四千八十五" do
    compare_kanji_and_integer("四千八十五", 4085)
  end

  it "四千八十六" do
    compare_kanji_and_integer("四千八十六", 4086)
  end

  it "四千八十七" do
    compare_kanji_and_integer("四千八十七", 4087)
  end

  it "四千八十八" do
    compare_kanji_and_integer("四千八十八", 4088)
  end

  it "四千八十九" do
    compare_kanji_and_integer("四千八十九", 4089)
  end

  it "四千九十" do
    compare_kanji_and_integer("四千九十", 4090)
  end

  it "四千九十一" do
    compare_kanji_and_integer("四千九十一", 4091)
  end

  it "四千九十二" do
    compare_kanji_and_integer("四千九十二", 4092)
  end

  it "四千九十三" do
    compare_kanji_and_integer("四千九十三", 4093)
  end

  it "四千九十四" do
    compare_kanji_and_integer("四千九十四", 4094)
  end

  it "四千九十五" do
    compare_kanji_and_integer("四千九十五", 4095)
  end

  it "四千九十六" do
    compare_kanji_and_integer("四千九十六", 4096)
  end

  it "四千九十七" do
    compare_kanji_and_integer("四千九十七", 4097)
  end

  it "四千九十八" do
    compare_kanji_and_integer("四千九十八", 4098)
  end

  it "四千九十九" do
    compare_kanji_and_integer("四千九十九", 4099)
  end

  it "四千百" do
    compare_kanji_and_integer("四千百", 4100)
  end

  it "四千百一" do
    compare_kanji_and_integer("四千百一", 4101)
  end

  it "四千百二" do
    compare_kanji_and_integer("四千百二", 4102)
  end

  it "四千百三" do
    compare_kanji_and_integer("四千百三", 4103)
  end

  it "四千百四" do
    compare_kanji_and_integer("四千百四", 4104)
  end

  it "四千百五" do
    compare_kanji_and_integer("四千百五", 4105)
  end

  it "四千百六" do
    compare_kanji_and_integer("四千百六", 4106)
  end

  it "四千百七" do
    compare_kanji_and_integer("四千百七", 4107)
  end

  it "四千百八" do
    compare_kanji_and_integer("四千百八", 4108)
  end

  it "四千百九" do
    compare_kanji_and_integer("四千百九", 4109)
  end

  it "四千百十" do
    compare_kanji_and_integer("四千百十", 4110)
  end

  it "四千百十一" do
    compare_kanji_and_integer("四千百十一", 4111)
  end

  it "四千百十二" do
    compare_kanji_and_integer("四千百十二", 4112)
  end

  it "四千百十三" do
    compare_kanji_and_integer("四千百十三", 4113)
  end

  it "四千百十四" do
    compare_kanji_and_integer("四千百十四", 4114)
  end

  it "四千百十五" do
    compare_kanji_and_integer("四千百十五", 4115)
  end

  it "四千百十六" do
    compare_kanji_and_integer("四千百十六", 4116)
  end

  it "四千百十七" do
    compare_kanji_and_integer("四千百十七", 4117)
  end

  it "四千百十八" do
    compare_kanji_and_integer("四千百十八", 4118)
  end

  it "四千百十九" do
    compare_kanji_and_integer("四千百十九", 4119)
  end

  it "四千百二十" do
    compare_kanji_and_integer("四千百二十", 4120)
  end

  it "四千百二十一" do
    compare_kanji_and_integer("四千百二十一", 4121)
  end

  it "四千百二十二" do
    compare_kanji_and_integer("四千百二十二", 4122)
  end

  it "四千百二十三" do
    compare_kanji_and_integer("四千百二十三", 4123)
  end

  it "四千百二十四" do
    compare_kanji_and_integer("四千百二十四", 4124)
  end

  it "四千百二十五" do
    compare_kanji_and_integer("四千百二十五", 4125)
  end

  it "四千百二十六" do
    compare_kanji_and_integer("四千百二十六", 4126)
  end

  it "四千百二十七" do
    compare_kanji_and_integer("四千百二十七", 4127)
  end

  it "四千百二十八" do
    compare_kanji_and_integer("四千百二十八", 4128)
  end

  it "四千百二十九" do
    compare_kanji_and_integer("四千百二十九", 4129)
  end

  it "四千百三十" do
    compare_kanji_and_integer("四千百三十", 4130)
  end

  it "四千百三十一" do
    compare_kanji_and_integer("四千百三十一", 4131)
  end

  it "四千百三十二" do
    compare_kanji_and_integer("四千百三十二", 4132)
  end

  it "四千百三十三" do
    compare_kanji_and_integer("四千百三十三", 4133)
  end

  it "四千百三十四" do
    compare_kanji_and_integer("四千百三十四", 4134)
  end

  it "四千百三十五" do
    compare_kanji_and_integer("四千百三十五", 4135)
  end

  it "四千百三十六" do
    compare_kanji_and_integer("四千百三十六", 4136)
  end

  it "四千百三十七" do
    compare_kanji_and_integer("四千百三十七", 4137)
  end

  it "四千百三十八" do
    compare_kanji_and_integer("四千百三十八", 4138)
  end

  it "四千百三十九" do
    compare_kanji_and_integer("四千百三十九", 4139)
  end

  it "四千百四十" do
    compare_kanji_and_integer("四千百四十", 4140)
  end

  it "四千百四十一" do
    compare_kanji_and_integer("四千百四十一", 4141)
  end

  it "四千百四十二" do
    compare_kanji_and_integer("四千百四十二", 4142)
  end

  it "四千百四十三" do
    compare_kanji_and_integer("四千百四十三", 4143)
  end

  it "四千百四十四" do
    compare_kanji_and_integer("四千百四十四", 4144)
  end

  it "四千百四十五" do
    compare_kanji_and_integer("四千百四十五", 4145)
  end

  it "四千百四十六" do
    compare_kanji_and_integer("四千百四十六", 4146)
  end

  it "四千百四十七" do
    compare_kanji_and_integer("四千百四十七", 4147)
  end

  it "四千百四十八" do
    compare_kanji_and_integer("四千百四十八", 4148)
  end

  it "四千百四十九" do
    compare_kanji_and_integer("四千百四十九", 4149)
  end

  it "四千百五十" do
    compare_kanji_and_integer("四千百五十", 4150)
  end

  it "四千百五十一" do
    compare_kanji_and_integer("四千百五十一", 4151)
  end

  it "四千百五十二" do
    compare_kanji_and_integer("四千百五十二", 4152)
  end

  it "四千百五十三" do
    compare_kanji_and_integer("四千百五十三", 4153)
  end

  it "四千百五十四" do
    compare_kanji_and_integer("四千百五十四", 4154)
  end

  it "四千百五十五" do
    compare_kanji_and_integer("四千百五十五", 4155)
  end

  it "四千百五十六" do
    compare_kanji_and_integer("四千百五十六", 4156)
  end

  it "四千百五十七" do
    compare_kanji_and_integer("四千百五十七", 4157)
  end

  it "四千百五十八" do
    compare_kanji_and_integer("四千百五十八", 4158)
  end

  it "四千百五十九" do
    compare_kanji_and_integer("四千百五十九", 4159)
  end

  it "四千百六十" do
    compare_kanji_and_integer("四千百六十", 4160)
  end

  it "四千百六十一" do
    compare_kanji_and_integer("四千百六十一", 4161)
  end

  it "四千百六十二" do
    compare_kanji_and_integer("四千百六十二", 4162)
  end

  it "四千百六十三" do
    compare_kanji_and_integer("四千百六十三", 4163)
  end

  it "四千百六十四" do
    compare_kanji_and_integer("四千百六十四", 4164)
  end

  it "四千百六十五" do
    compare_kanji_and_integer("四千百六十五", 4165)
  end

  it "四千百六十六" do
    compare_kanji_and_integer("四千百六十六", 4166)
  end

  it "四千百六十七" do
    compare_kanji_and_integer("四千百六十七", 4167)
  end

  it "四千百六十八" do
    compare_kanji_and_integer("四千百六十八", 4168)
  end

  it "四千百六十九" do
    compare_kanji_and_integer("四千百六十九", 4169)
  end

  it "四千百七十" do
    compare_kanji_and_integer("四千百七十", 4170)
  end

  it "四千百七十一" do
    compare_kanji_and_integer("四千百七十一", 4171)
  end

  it "四千百七十二" do
    compare_kanji_and_integer("四千百七十二", 4172)
  end

  it "四千百七十三" do
    compare_kanji_and_integer("四千百七十三", 4173)
  end

  it "四千百七十四" do
    compare_kanji_and_integer("四千百七十四", 4174)
  end

  it "四千百七十五" do
    compare_kanji_and_integer("四千百七十五", 4175)
  end

  it "四千百七十六" do
    compare_kanji_and_integer("四千百七十六", 4176)
  end

  it "四千百七十七" do
    compare_kanji_and_integer("四千百七十七", 4177)
  end

  it "四千百七十八" do
    compare_kanji_and_integer("四千百七十八", 4178)
  end

  it "四千百七十九" do
    compare_kanji_and_integer("四千百七十九", 4179)
  end

  it "四千百八十" do
    compare_kanji_and_integer("四千百八十", 4180)
  end

  it "四千百八十一" do
    compare_kanji_and_integer("四千百八十一", 4181)
  end

  it "四千百八十二" do
    compare_kanji_and_integer("四千百八十二", 4182)
  end

  it "四千百八十三" do
    compare_kanji_and_integer("四千百八十三", 4183)
  end

  it "四千百八十四" do
    compare_kanji_and_integer("四千百八十四", 4184)
  end

  it "四千百八十五" do
    compare_kanji_and_integer("四千百八十五", 4185)
  end

  it "四千百八十六" do
    compare_kanji_and_integer("四千百八十六", 4186)
  end

  it "四千百八十七" do
    compare_kanji_and_integer("四千百八十七", 4187)
  end

  it "四千百八十八" do
    compare_kanji_and_integer("四千百八十八", 4188)
  end

  it "四千百八十九" do
    compare_kanji_and_integer("四千百八十九", 4189)
  end

  it "四千百九十" do
    compare_kanji_and_integer("四千百九十", 4190)
  end

  it "四千百九十一" do
    compare_kanji_and_integer("四千百九十一", 4191)
  end

  it "四千百九十二" do
    compare_kanji_and_integer("四千百九十二", 4192)
  end

  it "四千百九十三" do
    compare_kanji_and_integer("四千百九十三", 4193)
  end

  it "四千百九十四" do
    compare_kanji_and_integer("四千百九十四", 4194)
  end

  it "四千百九十五" do
    compare_kanji_and_integer("四千百九十五", 4195)
  end

  it "四千百九十六" do
    compare_kanji_and_integer("四千百九十六", 4196)
  end

  it "四千百九十七" do
    compare_kanji_and_integer("四千百九十七", 4197)
  end

  it "四千百九十八" do
    compare_kanji_and_integer("四千百九十八", 4198)
  end

  it "四千百九十九" do
    compare_kanji_and_integer("四千百九十九", 4199)
  end

  it "四千二百" do
    compare_kanji_and_integer("四千二百", 4200)
  end

  it "四千二百一" do
    compare_kanji_and_integer("四千二百一", 4201)
  end

  it "四千二百二" do
    compare_kanji_and_integer("四千二百二", 4202)
  end

  it "四千二百三" do
    compare_kanji_and_integer("四千二百三", 4203)
  end

  it "四千二百四" do
    compare_kanji_and_integer("四千二百四", 4204)
  end

  it "四千二百五" do
    compare_kanji_and_integer("四千二百五", 4205)
  end

  it "四千二百六" do
    compare_kanji_and_integer("四千二百六", 4206)
  end

  it "四千二百七" do
    compare_kanji_and_integer("四千二百七", 4207)
  end

  it "四千二百八" do
    compare_kanji_and_integer("四千二百八", 4208)
  end

  it "四千二百九" do
    compare_kanji_and_integer("四千二百九", 4209)
  end

  it "四千二百十" do
    compare_kanji_and_integer("四千二百十", 4210)
  end

  it "四千二百十一" do
    compare_kanji_and_integer("四千二百十一", 4211)
  end

  it "四千二百十二" do
    compare_kanji_and_integer("四千二百十二", 4212)
  end

  it "四千二百十三" do
    compare_kanji_and_integer("四千二百十三", 4213)
  end

  it "四千二百十四" do
    compare_kanji_and_integer("四千二百十四", 4214)
  end

  it "四千二百十五" do
    compare_kanji_and_integer("四千二百十五", 4215)
  end

  it "四千二百十六" do
    compare_kanji_and_integer("四千二百十六", 4216)
  end

  it "四千二百十七" do
    compare_kanji_and_integer("四千二百十七", 4217)
  end

  it "四千二百十八" do
    compare_kanji_and_integer("四千二百十八", 4218)
  end

  it "四千二百十九" do
    compare_kanji_and_integer("四千二百十九", 4219)
  end

  it "四千二百二十" do
    compare_kanji_and_integer("四千二百二十", 4220)
  end

  it "四千二百二十一" do
    compare_kanji_and_integer("四千二百二十一", 4221)
  end

  it "四千二百二十二" do
    compare_kanji_and_integer("四千二百二十二", 4222)
  end

  it "四千二百二十三" do
    compare_kanji_and_integer("四千二百二十三", 4223)
  end

  it "四千二百二十四" do
    compare_kanji_and_integer("四千二百二十四", 4224)
  end

  it "四千二百二十五" do
    compare_kanji_and_integer("四千二百二十五", 4225)
  end

  it "四千二百二十六" do
    compare_kanji_and_integer("四千二百二十六", 4226)
  end

  it "四千二百二十七" do
    compare_kanji_and_integer("四千二百二十七", 4227)
  end

  it "四千二百二十八" do
    compare_kanji_and_integer("四千二百二十八", 4228)
  end

  it "四千二百二十九" do
    compare_kanji_and_integer("四千二百二十九", 4229)
  end

  it "四千二百三十" do
    compare_kanji_and_integer("四千二百三十", 4230)
  end

  it "四千二百三十一" do
    compare_kanji_and_integer("四千二百三十一", 4231)
  end

  it "四千二百三十二" do
    compare_kanji_and_integer("四千二百三十二", 4232)
  end

  it "四千二百三十三" do
    compare_kanji_and_integer("四千二百三十三", 4233)
  end

  it "四千二百三十四" do
    compare_kanji_and_integer("四千二百三十四", 4234)
  end

  it "四千二百三十五" do
    compare_kanji_and_integer("四千二百三十五", 4235)
  end

  it "四千二百三十六" do
    compare_kanji_and_integer("四千二百三十六", 4236)
  end

  it "四千二百三十七" do
    compare_kanji_and_integer("四千二百三十七", 4237)
  end

  it "四千二百三十八" do
    compare_kanji_and_integer("四千二百三十八", 4238)
  end

  it "四千二百三十九" do
    compare_kanji_and_integer("四千二百三十九", 4239)
  end

  it "四千二百四十" do
    compare_kanji_and_integer("四千二百四十", 4240)
  end

  it "四千二百四十一" do
    compare_kanji_and_integer("四千二百四十一", 4241)
  end

  it "四千二百四十二" do
    compare_kanji_and_integer("四千二百四十二", 4242)
  end

  it "四千二百四十三" do
    compare_kanji_and_integer("四千二百四十三", 4243)
  end

  it "四千二百四十四" do
    compare_kanji_and_integer("四千二百四十四", 4244)
  end

  it "四千二百四十五" do
    compare_kanji_and_integer("四千二百四十五", 4245)
  end

  it "四千二百四十六" do
    compare_kanji_and_integer("四千二百四十六", 4246)
  end

  it "四千二百四十七" do
    compare_kanji_and_integer("四千二百四十七", 4247)
  end

  it "四千二百四十八" do
    compare_kanji_and_integer("四千二百四十八", 4248)
  end

  it "四千二百四十九" do
    compare_kanji_and_integer("四千二百四十九", 4249)
  end

  it "四千二百五十" do
    compare_kanji_and_integer("四千二百五十", 4250)
  end

  it "四千二百五十一" do
    compare_kanji_and_integer("四千二百五十一", 4251)
  end

  it "四千二百五十二" do
    compare_kanji_and_integer("四千二百五十二", 4252)
  end

  it "四千二百五十三" do
    compare_kanji_and_integer("四千二百五十三", 4253)
  end

  it "四千二百五十四" do
    compare_kanji_and_integer("四千二百五十四", 4254)
  end

  it "四千二百五十五" do
    compare_kanji_and_integer("四千二百五十五", 4255)
  end

  it "四千二百五十六" do
    compare_kanji_and_integer("四千二百五十六", 4256)
  end

  it "四千二百五十七" do
    compare_kanji_and_integer("四千二百五十七", 4257)
  end

  it "四千二百五十八" do
    compare_kanji_and_integer("四千二百五十八", 4258)
  end

  it "四千二百五十九" do
    compare_kanji_and_integer("四千二百五十九", 4259)
  end

  it "四千二百六十" do
    compare_kanji_and_integer("四千二百六十", 4260)
  end

  it "四千二百六十一" do
    compare_kanji_and_integer("四千二百六十一", 4261)
  end

  it "四千二百六十二" do
    compare_kanji_and_integer("四千二百六十二", 4262)
  end

  it "四千二百六十三" do
    compare_kanji_and_integer("四千二百六十三", 4263)
  end

  it "四千二百六十四" do
    compare_kanji_and_integer("四千二百六十四", 4264)
  end

  it "四千二百六十五" do
    compare_kanji_and_integer("四千二百六十五", 4265)
  end

  it "四千二百六十六" do
    compare_kanji_and_integer("四千二百六十六", 4266)
  end

  it "四千二百六十七" do
    compare_kanji_and_integer("四千二百六十七", 4267)
  end

  it "四千二百六十八" do
    compare_kanji_and_integer("四千二百六十八", 4268)
  end

  it "四千二百六十九" do
    compare_kanji_and_integer("四千二百六十九", 4269)
  end

  it "四千二百七十" do
    compare_kanji_and_integer("四千二百七十", 4270)
  end

  it "四千二百七十一" do
    compare_kanji_and_integer("四千二百七十一", 4271)
  end

  it "四千二百七十二" do
    compare_kanji_and_integer("四千二百七十二", 4272)
  end

  it "四千二百七十三" do
    compare_kanji_and_integer("四千二百七十三", 4273)
  end

  it "四千二百七十四" do
    compare_kanji_and_integer("四千二百七十四", 4274)
  end

  it "四千二百七十五" do
    compare_kanji_and_integer("四千二百七十五", 4275)
  end

  it "四千二百七十六" do
    compare_kanji_and_integer("四千二百七十六", 4276)
  end

  it "四千二百七十七" do
    compare_kanji_and_integer("四千二百七十七", 4277)
  end

  it "四千二百七十八" do
    compare_kanji_and_integer("四千二百七十八", 4278)
  end

  it "四千二百七十九" do
    compare_kanji_and_integer("四千二百七十九", 4279)
  end

  it "四千二百八十" do
    compare_kanji_and_integer("四千二百八十", 4280)
  end

  it "四千二百八十一" do
    compare_kanji_and_integer("四千二百八十一", 4281)
  end

  it "四千二百八十二" do
    compare_kanji_and_integer("四千二百八十二", 4282)
  end

  it "四千二百八十三" do
    compare_kanji_and_integer("四千二百八十三", 4283)
  end

  it "四千二百八十四" do
    compare_kanji_and_integer("四千二百八十四", 4284)
  end

  it "四千二百八十五" do
    compare_kanji_and_integer("四千二百八十五", 4285)
  end

  it "四千二百八十六" do
    compare_kanji_and_integer("四千二百八十六", 4286)
  end

  it "四千二百八十七" do
    compare_kanji_and_integer("四千二百八十七", 4287)
  end

  it "四千二百八十八" do
    compare_kanji_and_integer("四千二百八十八", 4288)
  end

  it "四千二百八十九" do
    compare_kanji_and_integer("四千二百八十九", 4289)
  end

  it "四千二百九十" do
    compare_kanji_and_integer("四千二百九十", 4290)
  end

  it "四千二百九十一" do
    compare_kanji_and_integer("四千二百九十一", 4291)
  end

  it "四千二百九十二" do
    compare_kanji_and_integer("四千二百九十二", 4292)
  end

  it "四千二百九十三" do
    compare_kanji_and_integer("四千二百九十三", 4293)
  end

  it "四千二百九十四" do
    compare_kanji_and_integer("四千二百九十四", 4294)
  end

  it "四千二百九十五" do
    compare_kanji_and_integer("四千二百九十五", 4295)
  end

  it "四千二百九十六" do
    compare_kanji_and_integer("四千二百九十六", 4296)
  end

  it "四千二百九十七" do
    compare_kanji_and_integer("四千二百九十七", 4297)
  end

  it "四千二百九十八" do
    compare_kanji_and_integer("四千二百九十八", 4298)
  end

  it "四千二百九十九" do
    compare_kanji_and_integer("四千二百九十九", 4299)
  end

  it "四千三百" do
    compare_kanji_and_integer("四千三百", 4300)
  end

  it "四千三百一" do
    compare_kanji_and_integer("四千三百一", 4301)
  end

  it "四千三百二" do
    compare_kanji_and_integer("四千三百二", 4302)
  end

  it "四千三百三" do
    compare_kanji_and_integer("四千三百三", 4303)
  end

  it "四千三百四" do
    compare_kanji_and_integer("四千三百四", 4304)
  end

  it "四千三百五" do
    compare_kanji_and_integer("四千三百五", 4305)
  end

  it "四千三百六" do
    compare_kanji_and_integer("四千三百六", 4306)
  end

  it "四千三百七" do
    compare_kanji_and_integer("四千三百七", 4307)
  end

  it "四千三百八" do
    compare_kanji_and_integer("四千三百八", 4308)
  end

  it "四千三百九" do
    compare_kanji_and_integer("四千三百九", 4309)
  end

  it "四千三百十" do
    compare_kanji_and_integer("四千三百十", 4310)
  end

  it "四千三百十一" do
    compare_kanji_and_integer("四千三百十一", 4311)
  end

  it "四千三百十二" do
    compare_kanji_and_integer("四千三百十二", 4312)
  end

  it "四千三百十三" do
    compare_kanji_and_integer("四千三百十三", 4313)
  end

  it "四千三百十四" do
    compare_kanji_and_integer("四千三百十四", 4314)
  end

  it "四千三百十五" do
    compare_kanji_and_integer("四千三百十五", 4315)
  end

  it "四千三百十六" do
    compare_kanji_and_integer("四千三百十六", 4316)
  end

  it "四千三百十七" do
    compare_kanji_and_integer("四千三百十七", 4317)
  end

  it "四千三百十八" do
    compare_kanji_and_integer("四千三百十八", 4318)
  end

  it "四千三百十九" do
    compare_kanji_and_integer("四千三百十九", 4319)
  end

  it "四千三百二十" do
    compare_kanji_and_integer("四千三百二十", 4320)
  end

  it "四千三百二十一" do
    compare_kanji_and_integer("四千三百二十一", 4321)
  end

  it "四千三百二十二" do
    compare_kanji_and_integer("四千三百二十二", 4322)
  end

  it "四千三百二十三" do
    compare_kanji_and_integer("四千三百二十三", 4323)
  end

  it "四千三百二十四" do
    compare_kanji_and_integer("四千三百二十四", 4324)
  end

  it "四千三百二十五" do
    compare_kanji_and_integer("四千三百二十五", 4325)
  end

  it "四千三百二十六" do
    compare_kanji_and_integer("四千三百二十六", 4326)
  end

  it "四千三百二十七" do
    compare_kanji_and_integer("四千三百二十七", 4327)
  end

  it "四千三百二十八" do
    compare_kanji_and_integer("四千三百二十八", 4328)
  end

  it "四千三百二十九" do
    compare_kanji_and_integer("四千三百二十九", 4329)
  end

  it "四千三百三十" do
    compare_kanji_and_integer("四千三百三十", 4330)
  end

  it "四千三百三十一" do
    compare_kanji_and_integer("四千三百三十一", 4331)
  end

  it "四千三百三十二" do
    compare_kanji_and_integer("四千三百三十二", 4332)
  end

  it "四千三百三十三" do
    compare_kanji_and_integer("四千三百三十三", 4333)
  end

  it "四千三百三十四" do
    compare_kanji_and_integer("四千三百三十四", 4334)
  end

  it "四千三百三十五" do
    compare_kanji_and_integer("四千三百三十五", 4335)
  end

  it "四千三百三十六" do
    compare_kanji_and_integer("四千三百三十六", 4336)
  end

  it "四千三百三十七" do
    compare_kanji_and_integer("四千三百三十七", 4337)
  end

  it "四千三百三十八" do
    compare_kanji_and_integer("四千三百三十八", 4338)
  end

  it "四千三百三十九" do
    compare_kanji_and_integer("四千三百三十九", 4339)
  end

  it "四千三百四十" do
    compare_kanji_and_integer("四千三百四十", 4340)
  end

  it "四千三百四十一" do
    compare_kanji_and_integer("四千三百四十一", 4341)
  end

  it "四千三百四十二" do
    compare_kanji_and_integer("四千三百四十二", 4342)
  end

  it "四千三百四十三" do
    compare_kanji_and_integer("四千三百四十三", 4343)
  end

  it "四千三百四十四" do
    compare_kanji_and_integer("四千三百四十四", 4344)
  end

  it "四千三百四十五" do
    compare_kanji_and_integer("四千三百四十五", 4345)
  end

  it "四千三百四十六" do
    compare_kanji_and_integer("四千三百四十六", 4346)
  end

  it "四千三百四十七" do
    compare_kanji_and_integer("四千三百四十七", 4347)
  end

  it "四千三百四十八" do
    compare_kanji_and_integer("四千三百四十八", 4348)
  end

  it "四千三百四十九" do
    compare_kanji_and_integer("四千三百四十九", 4349)
  end

  it "四千三百五十" do
    compare_kanji_and_integer("四千三百五十", 4350)
  end

  it "四千三百五十一" do
    compare_kanji_and_integer("四千三百五十一", 4351)
  end

  it "四千三百五十二" do
    compare_kanji_and_integer("四千三百五十二", 4352)
  end

  it "四千三百五十三" do
    compare_kanji_and_integer("四千三百五十三", 4353)
  end

  it "四千三百五十四" do
    compare_kanji_and_integer("四千三百五十四", 4354)
  end

  it "四千三百五十五" do
    compare_kanji_and_integer("四千三百五十五", 4355)
  end

  it "四千三百五十六" do
    compare_kanji_and_integer("四千三百五十六", 4356)
  end

  it "四千三百五十七" do
    compare_kanji_and_integer("四千三百五十七", 4357)
  end

  it "四千三百五十八" do
    compare_kanji_and_integer("四千三百五十八", 4358)
  end

  it "四千三百五十九" do
    compare_kanji_and_integer("四千三百五十九", 4359)
  end

  it "四千三百六十" do
    compare_kanji_and_integer("四千三百六十", 4360)
  end

  it "四千三百六十一" do
    compare_kanji_and_integer("四千三百六十一", 4361)
  end

  it "四千三百六十二" do
    compare_kanji_and_integer("四千三百六十二", 4362)
  end

  it "四千三百六十三" do
    compare_kanji_and_integer("四千三百六十三", 4363)
  end

  it "四千三百六十四" do
    compare_kanji_and_integer("四千三百六十四", 4364)
  end

  it "四千三百六十五" do
    compare_kanji_and_integer("四千三百六十五", 4365)
  end

  it "四千三百六十六" do
    compare_kanji_and_integer("四千三百六十六", 4366)
  end

  it "四千三百六十七" do
    compare_kanji_and_integer("四千三百六十七", 4367)
  end

  it "四千三百六十八" do
    compare_kanji_and_integer("四千三百六十八", 4368)
  end

  it "四千三百六十九" do
    compare_kanji_and_integer("四千三百六十九", 4369)
  end

  it "四千三百七十" do
    compare_kanji_and_integer("四千三百七十", 4370)
  end

  it "四千三百七十一" do
    compare_kanji_and_integer("四千三百七十一", 4371)
  end

  it "四千三百七十二" do
    compare_kanji_and_integer("四千三百七十二", 4372)
  end

  it "四千三百七十三" do
    compare_kanji_and_integer("四千三百七十三", 4373)
  end

  it "四千三百七十四" do
    compare_kanji_and_integer("四千三百七十四", 4374)
  end

  it "四千三百七十五" do
    compare_kanji_and_integer("四千三百七十五", 4375)
  end

  it "四千三百七十六" do
    compare_kanji_and_integer("四千三百七十六", 4376)
  end

  it "四千三百七十七" do
    compare_kanji_and_integer("四千三百七十七", 4377)
  end

  it "四千三百七十八" do
    compare_kanji_and_integer("四千三百七十八", 4378)
  end

  it "四千三百七十九" do
    compare_kanji_and_integer("四千三百七十九", 4379)
  end

  it "四千三百八十" do
    compare_kanji_and_integer("四千三百八十", 4380)
  end

  it "四千三百八十一" do
    compare_kanji_and_integer("四千三百八十一", 4381)
  end

  it "四千三百八十二" do
    compare_kanji_and_integer("四千三百八十二", 4382)
  end

  it "四千三百八十三" do
    compare_kanji_and_integer("四千三百八十三", 4383)
  end

  it "四千三百八十四" do
    compare_kanji_and_integer("四千三百八十四", 4384)
  end

  it "四千三百八十五" do
    compare_kanji_and_integer("四千三百八十五", 4385)
  end

  it "四千三百八十六" do
    compare_kanji_and_integer("四千三百八十六", 4386)
  end

  it "四千三百八十七" do
    compare_kanji_and_integer("四千三百八十七", 4387)
  end

  it "四千三百八十八" do
    compare_kanji_and_integer("四千三百八十八", 4388)
  end

  it "四千三百八十九" do
    compare_kanji_and_integer("四千三百八十九", 4389)
  end

  it "四千三百九十" do
    compare_kanji_and_integer("四千三百九十", 4390)
  end

  it "四千三百九十一" do
    compare_kanji_and_integer("四千三百九十一", 4391)
  end

  it "四千三百九十二" do
    compare_kanji_and_integer("四千三百九十二", 4392)
  end

  it "四千三百九十三" do
    compare_kanji_and_integer("四千三百九十三", 4393)
  end

  it "四千三百九十四" do
    compare_kanji_and_integer("四千三百九十四", 4394)
  end

  it "四千三百九十五" do
    compare_kanji_and_integer("四千三百九十五", 4395)
  end

  it "四千三百九十六" do
    compare_kanji_and_integer("四千三百九十六", 4396)
  end

  it "四千三百九十七" do
    compare_kanji_and_integer("四千三百九十七", 4397)
  end

  it "四千三百九十八" do
    compare_kanji_and_integer("四千三百九十八", 4398)
  end

  it "四千三百九十九" do
    compare_kanji_and_integer("四千三百九十九", 4399)
  end

  it "四千四百" do
    compare_kanji_and_integer("四千四百", 4400)
  end

  it "四千四百一" do
    compare_kanji_and_integer("四千四百一", 4401)
  end

  it "四千四百二" do
    compare_kanji_and_integer("四千四百二", 4402)
  end

  it "四千四百三" do
    compare_kanji_and_integer("四千四百三", 4403)
  end

  it "四千四百四" do
    compare_kanji_and_integer("四千四百四", 4404)
  end

  it "四千四百五" do
    compare_kanji_and_integer("四千四百五", 4405)
  end

  it "四千四百六" do
    compare_kanji_and_integer("四千四百六", 4406)
  end

  it "四千四百七" do
    compare_kanji_and_integer("四千四百七", 4407)
  end

  it "四千四百八" do
    compare_kanji_and_integer("四千四百八", 4408)
  end

  it "四千四百九" do
    compare_kanji_and_integer("四千四百九", 4409)
  end

  it "四千四百十" do
    compare_kanji_and_integer("四千四百十", 4410)
  end

  it "四千四百十一" do
    compare_kanji_and_integer("四千四百十一", 4411)
  end

  it "四千四百十二" do
    compare_kanji_and_integer("四千四百十二", 4412)
  end

  it "四千四百十三" do
    compare_kanji_and_integer("四千四百十三", 4413)
  end

  it "四千四百十四" do
    compare_kanji_and_integer("四千四百十四", 4414)
  end

  it "四千四百十五" do
    compare_kanji_and_integer("四千四百十五", 4415)
  end

  it "四千四百十六" do
    compare_kanji_and_integer("四千四百十六", 4416)
  end

  it "四千四百十七" do
    compare_kanji_and_integer("四千四百十七", 4417)
  end

  it "四千四百十八" do
    compare_kanji_and_integer("四千四百十八", 4418)
  end

  it "四千四百十九" do
    compare_kanji_and_integer("四千四百十九", 4419)
  end

  it "四千四百二十" do
    compare_kanji_and_integer("四千四百二十", 4420)
  end

  it "四千四百二十一" do
    compare_kanji_and_integer("四千四百二十一", 4421)
  end

  it "四千四百二十二" do
    compare_kanji_and_integer("四千四百二十二", 4422)
  end

  it "四千四百二十三" do
    compare_kanji_and_integer("四千四百二十三", 4423)
  end

  it "四千四百二十四" do
    compare_kanji_and_integer("四千四百二十四", 4424)
  end

  it "四千四百二十五" do
    compare_kanji_and_integer("四千四百二十五", 4425)
  end

  it "四千四百二十六" do
    compare_kanji_and_integer("四千四百二十六", 4426)
  end

  it "四千四百二十七" do
    compare_kanji_and_integer("四千四百二十七", 4427)
  end

  it "四千四百二十八" do
    compare_kanji_and_integer("四千四百二十八", 4428)
  end

  it "四千四百二十九" do
    compare_kanji_and_integer("四千四百二十九", 4429)
  end

  it "四千四百三十" do
    compare_kanji_and_integer("四千四百三十", 4430)
  end

  it "四千四百三十一" do
    compare_kanji_and_integer("四千四百三十一", 4431)
  end

  it "四千四百三十二" do
    compare_kanji_and_integer("四千四百三十二", 4432)
  end

  it "四千四百三十三" do
    compare_kanji_and_integer("四千四百三十三", 4433)
  end

  it "四千四百三十四" do
    compare_kanji_and_integer("四千四百三十四", 4434)
  end

  it "四千四百三十五" do
    compare_kanji_and_integer("四千四百三十五", 4435)
  end

  it "四千四百三十六" do
    compare_kanji_and_integer("四千四百三十六", 4436)
  end

  it "四千四百三十七" do
    compare_kanji_and_integer("四千四百三十七", 4437)
  end

  it "四千四百三十八" do
    compare_kanji_and_integer("四千四百三十八", 4438)
  end

  it "四千四百三十九" do
    compare_kanji_and_integer("四千四百三十九", 4439)
  end

  it "四千四百四十" do
    compare_kanji_and_integer("四千四百四十", 4440)
  end

  it "四千四百四十一" do
    compare_kanji_and_integer("四千四百四十一", 4441)
  end

  it "四千四百四十二" do
    compare_kanji_and_integer("四千四百四十二", 4442)
  end

  it "四千四百四十三" do
    compare_kanji_and_integer("四千四百四十三", 4443)
  end

  it "四千四百四十四" do
    compare_kanji_and_integer("四千四百四十四", 4444)
  end

  it "四千四百四十五" do
    compare_kanji_and_integer("四千四百四十五", 4445)
  end

  it "四千四百四十六" do
    compare_kanji_and_integer("四千四百四十六", 4446)
  end

  it "四千四百四十七" do
    compare_kanji_and_integer("四千四百四十七", 4447)
  end

  it "四千四百四十八" do
    compare_kanji_and_integer("四千四百四十八", 4448)
  end

  it "四千四百四十九" do
    compare_kanji_and_integer("四千四百四十九", 4449)
  end

  it "四千四百五十" do
    compare_kanji_and_integer("四千四百五十", 4450)
  end

  it "四千四百五十一" do
    compare_kanji_and_integer("四千四百五十一", 4451)
  end

  it "四千四百五十二" do
    compare_kanji_and_integer("四千四百五十二", 4452)
  end

  it "四千四百五十三" do
    compare_kanji_and_integer("四千四百五十三", 4453)
  end

  it "四千四百五十四" do
    compare_kanji_and_integer("四千四百五十四", 4454)
  end

  it "四千四百五十五" do
    compare_kanji_and_integer("四千四百五十五", 4455)
  end

  it "四千四百五十六" do
    compare_kanji_and_integer("四千四百五十六", 4456)
  end

  it "四千四百五十七" do
    compare_kanji_and_integer("四千四百五十七", 4457)
  end

  it "四千四百五十八" do
    compare_kanji_and_integer("四千四百五十八", 4458)
  end

  it "四千四百五十九" do
    compare_kanji_and_integer("四千四百五十九", 4459)
  end

  it "四千四百六十" do
    compare_kanji_and_integer("四千四百六十", 4460)
  end

  it "四千四百六十一" do
    compare_kanji_and_integer("四千四百六十一", 4461)
  end

  it "四千四百六十二" do
    compare_kanji_and_integer("四千四百六十二", 4462)
  end

  it "四千四百六十三" do
    compare_kanji_and_integer("四千四百六十三", 4463)
  end

  it "四千四百六十四" do
    compare_kanji_and_integer("四千四百六十四", 4464)
  end

  it "四千四百六十五" do
    compare_kanji_and_integer("四千四百六十五", 4465)
  end

  it "四千四百六十六" do
    compare_kanji_and_integer("四千四百六十六", 4466)
  end

  it "四千四百六十七" do
    compare_kanji_and_integer("四千四百六十七", 4467)
  end

  it "四千四百六十八" do
    compare_kanji_and_integer("四千四百六十八", 4468)
  end

  it "四千四百六十九" do
    compare_kanji_and_integer("四千四百六十九", 4469)
  end

  it "四千四百七十" do
    compare_kanji_and_integer("四千四百七十", 4470)
  end

  it "四千四百七十一" do
    compare_kanji_and_integer("四千四百七十一", 4471)
  end

  it "四千四百七十二" do
    compare_kanji_and_integer("四千四百七十二", 4472)
  end

  it "四千四百七十三" do
    compare_kanji_and_integer("四千四百七十三", 4473)
  end

  it "四千四百七十四" do
    compare_kanji_and_integer("四千四百七十四", 4474)
  end

  it "四千四百七十五" do
    compare_kanji_and_integer("四千四百七十五", 4475)
  end

  it "四千四百七十六" do
    compare_kanji_and_integer("四千四百七十六", 4476)
  end

  it "四千四百七十七" do
    compare_kanji_and_integer("四千四百七十七", 4477)
  end

  it "四千四百七十八" do
    compare_kanji_and_integer("四千四百七十八", 4478)
  end

  it "四千四百七十九" do
    compare_kanji_and_integer("四千四百七十九", 4479)
  end

  it "四千四百八十" do
    compare_kanji_and_integer("四千四百八十", 4480)
  end

  it "四千四百八十一" do
    compare_kanji_and_integer("四千四百八十一", 4481)
  end

  it "四千四百八十二" do
    compare_kanji_and_integer("四千四百八十二", 4482)
  end

  it "四千四百八十三" do
    compare_kanji_and_integer("四千四百八十三", 4483)
  end

  it "四千四百八十四" do
    compare_kanji_and_integer("四千四百八十四", 4484)
  end

  it "四千四百八十五" do
    compare_kanji_and_integer("四千四百八十五", 4485)
  end

  it "四千四百八十六" do
    compare_kanji_and_integer("四千四百八十六", 4486)
  end

  it "四千四百八十七" do
    compare_kanji_and_integer("四千四百八十七", 4487)
  end

  it "四千四百八十八" do
    compare_kanji_and_integer("四千四百八十八", 4488)
  end

  it "四千四百八十九" do
    compare_kanji_and_integer("四千四百八十九", 4489)
  end

  it "四千四百九十" do
    compare_kanji_and_integer("四千四百九十", 4490)
  end

  it "四千四百九十一" do
    compare_kanji_and_integer("四千四百九十一", 4491)
  end

  it "四千四百九十二" do
    compare_kanji_and_integer("四千四百九十二", 4492)
  end

  it "四千四百九十三" do
    compare_kanji_and_integer("四千四百九十三", 4493)
  end

  it "四千四百九十四" do
    compare_kanji_and_integer("四千四百九十四", 4494)
  end

  it "四千四百九十五" do
    compare_kanji_and_integer("四千四百九十五", 4495)
  end

  it "四千四百九十六" do
    compare_kanji_and_integer("四千四百九十六", 4496)
  end

  it "四千四百九十七" do
    compare_kanji_and_integer("四千四百九十七", 4497)
  end

  it "四千四百九十八" do
    compare_kanji_and_integer("四千四百九十八", 4498)
  end

  it "四千四百九十九" do
    compare_kanji_and_integer("四千四百九十九", 4499)
  end

  it "四千五百" do
    compare_kanji_and_integer("四千五百", 4500)
  end

  it "四千五百一" do
    compare_kanji_and_integer("四千五百一", 4501)
  end

  it "四千五百二" do
    compare_kanji_and_integer("四千五百二", 4502)
  end

  it "四千五百三" do
    compare_kanji_and_integer("四千五百三", 4503)
  end

  it "四千五百四" do
    compare_kanji_and_integer("四千五百四", 4504)
  end

  it "四千五百五" do
    compare_kanji_and_integer("四千五百五", 4505)
  end

  it "四千五百六" do
    compare_kanji_and_integer("四千五百六", 4506)
  end

  it "四千五百七" do
    compare_kanji_and_integer("四千五百七", 4507)
  end

  it "四千五百八" do
    compare_kanji_and_integer("四千五百八", 4508)
  end

  it "四千五百九" do
    compare_kanji_and_integer("四千五百九", 4509)
  end

  it "四千五百十" do
    compare_kanji_and_integer("四千五百十", 4510)
  end

  it "四千五百十一" do
    compare_kanji_and_integer("四千五百十一", 4511)
  end

  it "四千五百十二" do
    compare_kanji_and_integer("四千五百十二", 4512)
  end

  it "四千五百十三" do
    compare_kanji_and_integer("四千五百十三", 4513)
  end

  it "四千五百十四" do
    compare_kanji_and_integer("四千五百十四", 4514)
  end

  it "四千五百十五" do
    compare_kanji_and_integer("四千五百十五", 4515)
  end

  it "四千五百十六" do
    compare_kanji_and_integer("四千五百十六", 4516)
  end

  it "四千五百十七" do
    compare_kanji_and_integer("四千五百十七", 4517)
  end

  it "四千五百十八" do
    compare_kanji_and_integer("四千五百十八", 4518)
  end

  it "四千五百十九" do
    compare_kanji_and_integer("四千五百十九", 4519)
  end

  it "四千五百二十" do
    compare_kanji_and_integer("四千五百二十", 4520)
  end

  it "四千五百二十一" do
    compare_kanji_and_integer("四千五百二十一", 4521)
  end

  it "四千五百二十二" do
    compare_kanji_and_integer("四千五百二十二", 4522)
  end

  it "四千五百二十三" do
    compare_kanji_and_integer("四千五百二十三", 4523)
  end

  it "四千五百二十四" do
    compare_kanji_and_integer("四千五百二十四", 4524)
  end

  it "四千五百二十五" do
    compare_kanji_and_integer("四千五百二十五", 4525)
  end

  it "四千五百二十六" do
    compare_kanji_and_integer("四千五百二十六", 4526)
  end

  it "四千五百二十七" do
    compare_kanji_and_integer("四千五百二十七", 4527)
  end

  it "四千五百二十八" do
    compare_kanji_and_integer("四千五百二十八", 4528)
  end

  it "四千五百二十九" do
    compare_kanji_and_integer("四千五百二十九", 4529)
  end

  it "四千五百三十" do
    compare_kanji_and_integer("四千五百三十", 4530)
  end

  it "四千五百三十一" do
    compare_kanji_and_integer("四千五百三十一", 4531)
  end

  it "四千五百三十二" do
    compare_kanji_and_integer("四千五百三十二", 4532)
  end

  it "四千五百三十三" do
    compare_kanji_and_integer("四千五百三十三", 4533)
  end

  it "四千五百三十四" do
    compare_kanji_and_integer("四千五百三十四", 4534)
  end

  it "四千五百三十五" do
    compare_kanji_and_integer("四千五百三十五", 4535)
  end

  it "四千五百三十六" do
    compare_kanji_and_integer("四千五百三十六", 4536)
  end

  it "四千五百三十七" do
    compare_kanji_and_integer("四千五百三十七", 4537)
  end

  it "四千五百三十八" do
    compare_kanji_and_integer("四千五百三十八", 4538)
  end

  it "四千五百三十九" do
    compare_kanji_and_integer("四千五百三十九", 4539)
  end

  it "四千五百四十" do
    compare_kanji_and_integer("四千五百四十", 4540)
  end

  it "四千五百四十一" do
    compare_kanji_and_integer("四千五百四十一", 4541)
  end

  it "四千五百四十二" do
    compare_kanji_and_integer("四千五百四十二", 4542)
  end

  it "四千五百四十三" do
    compare_kanji_and_integer("四千五百四十三", 4543)
  end

  it "四千五百四十四" do
    compare_kanji_and_integer("四千五百四十四", 4544)
  end

  it "四千五百四十五" do
    compare_kanji_and_integer("四千五百四十五", 4545)
  end

  it "四千五百四十六" do
    compare_kanji_and_integer("四千五百四十六", 4546)
  end

  it "四千五百四十七" do
    compare_kanji_and_integer("四千五百四十七", 4547)
  end

  it "四千五百四十八" do
    compare_kanji_and_integer("四千五百四十八", 4548)
  end

  it "四千五百四十九" do
    compare_kanji_and_integer("四千五百四十九", 4549)
  end

  it "四千五百五十" do
    compare_kanji_and_integer("四千五百五十", 4550)
  end

  it "四千五百五十一" do
    compare_kanji_and_integer("四千五百五十一", 4551)
  end

  it "四千五百五十二" do
    compare_kanji_and_integer("四千五百五十二", 4552)
  end

  it "四千五百五十三" do
    compare_kanji_and_integer("四千五百五十三", 4553)
  end

  it "四千五百五十四" do
    compare_kanji_and_integer("四千五百五十四", 4554)
  end

  it "四千五百五十五" do
    compare_kanji_and_integer("四千五百五十五", 4555)
  end

  it "四千五百五十六" do
    compare_kanji_and_integer("四千五百五十六", 4556)
  end

  it "四千五百五十七" do
    compare_kanji_and_integer("四千五百五十七", 4557)
  end

  it "四千五百五十八" do
    compare_kanji_and_integer("四千五百五十八", 4558)
  end

  it "四千五百五十九" do
    compare_kanji_and_integer("四千五百五十九", 4559)
  end

  it "四千五百六十" do
    compare_kanji_and_integer("四千五百六十", 4560)
  end

  it "四千五百六十一" do
    compare_kanji_and_integer("四千五百六十一", 4561)
  end

  it "四千五百六十二" do
    compare_kanji_and_integer("四千五百六十二", 4562)
  end

  it "四千五百六十三" do
    compare_kanji_and_integer("四千五百六十三", 4563)
  end

  it "四千五百六十四" do
    compare_kanji_and_integer("四千五百六十四", 4564)
  end

  it "四千五百六十五" do
    compare_kanji_and_integer("四千五百六十五", 4565)
  end

  it "四千五百六十六" do
    compare_kanji_and_integer("四千五百六十六", 4566)
  end

  it "四千五百六十七" do
    compare_kanji_and_integer("四千五百六十七", 4567)
  end

  it "四千五百六十八" do
    compare_kanji_and_integer("四千五百六十八", 4568)
  end

  it "四千五百六十九" do
    compare_kanji_and_integer("四千五百六十九", 4569)
  end

  it "四千五百七十" do
    compare_kanji_and_integer("四千五百七十", 4570)
  end

  it "四千五百七十一" do
    compare_kanji_and_integer("四千五百七十一", 4571)
  end

  it "四千五百七十二" do
    compare_kanji_and_integer("四千五百七十二", 4572)
  end

  it "四千五百七十三" do
    compare_kanji_and_integer("四千五百七十三", 4573)
  end

  it "四千五百七十四" do
    compare_kanji_and_integer("四千五百七十四", 4574)
  end

  it "四千五百七十五" do
    compare_kanji_and_integer("四千五百七十五", 4575)
  end

  it "四千五百七十六" do
    compare_kanji_and_integer("四千五百七十六", 4576)
  end

  it "四千五百七十七" do
    compare_kanji_and_integer("四千五百七十七", 4577)
  end

  it "四千五百七十八" do
    compare_kanji_and_integer("四千五百七十八", 4578)
  end

  it "四千五百七十九" do
    compare_kanji_and_integer("四千五百七十九", 4579)
  end

  it "四千五百八十" do
    compare_kanji_and_integer("四千五百八十", 4580)
  end

  it "四千五百八十一" do
    compare_kanji_and_integer("四千五百八十一", 4581)
  end

  it "四千五百八十二" do
    compare_kanji_and_integer("四千五百八十二", 4582)
  end

  it "四千五百八十三" do
    compare_kanji_and_integer("四千五百八十三", 4583)
  end

  it "四千五百八十四" do
    compare_kanji_and_integer("四千五百八十四", 4584)
  end

  it "四千五百八十五" do
    compare_kanji_and_integer("四千五百八十五", 4585)
  end

  it "四千五百八十六" do
    compare_kanji_and_integer("四千五百八十六", 4586)
  end

  it "四千五百八十七" do
    compare_kanji_and_integer("四千五百八十七", 4587)
  end

  it "四千五百八十八" do
    compare_kanji_and_integer("四千五百八十八", 4588)
  end

  it "四千五百八十九" do
    compare_kanji_and_integer("四千五百八十九", 4589)
  end

  it "四千五百九十" do
    compare_kanji_and_integer("四千五百九十", 4590)
  end

  it "四千五百九十一" do
    compare_kanji_and_integer("四千五百九十一", 4591)
  end

  it "四千五百九十二" do
    compare_kanji_and_integer("四千五百九十二", 4592)
  end

  it "四千五百九十三" do
    compare_kanji_and_integer("四千五百九十三", 4593)
  end

  it "四千五百九十四" do
    compare_kanji_and_integer("四千五百九十四", 4594)
  end

  it "四千五百九十五" do
    compare_kanji_and_integer("四千五百九十五", 4595)
  end

  it "四千五百九十六" do
    compare_kanji_and_integer("四千五百九十六", 4596)
  end

  it "四千五百九十七" do
    compare_kanji_and_integer("四千五百九十七", 4597)
  end

  it "四千五百九十八" do
    compare_kanji_and_integer("四千五百九十八", 4598)
  end

  it "四千五百九十九" do
    compare_kanji_and_integer("四千五百九十九", 4599)
  end

  it "四千六百" do
    compare_kanji_and_integer("四千六百", 4600)
  end

  it "四千六百一" do
    compare_kanji_and_integer("四千六百一", 4601)
  end

  it "四千六百二" do
    compare_kanji_and_integer("四千六百二", 4602)
  end

  it "四千六百三" do
    compare_kanji_and_integer("四千六百三", 4603)
  end

  it "四千六百四" do
    compare_kanji_and_integer("四千六百四", 4604)
  end

  it "四千六百五" do
    compare_kanji_and_integer("四千六百五", 4605)
  end

  it "四千六百六" do
    compare_kanji_and_integer("四千六百六", 4606)
  end

  it "四千六百七" do
    compare_kanji_and_integer("四千六百七", 4607)
  end

  it "四千六百八" do
    compare_kanji_and_integer("四千六百八", 4608)
  end

  it "四千六百九" do
    compare_kanji_and_integer("四千六百九", 4609)
  end

  it "四千六百十" do
    compare_kanji_and_integer("四千六百十", 4610)
  end

  it "四千六百十一" do
    compare_kanji_and_integer("四千六百十一", 4611)
  end

  it "四千六百十二" do
    compare_kanji_and_integer("四千六百十二", 4612)
  end

  it "四千六百十三" do
    compare_kanji_and_integer("四千六百十三", 4613)
  end

  it "四千六百十四" do
    compare_kanji_and_integer("四千六百十四", 4614)
  end

  it "四千六百十五" do
    compare_kanji_and_integer("四千六百十五", 4615)
  end

  it "四千六百十六" do
    compare_kanji_and_integer("四千六百十六", 4616)
  end

  it "四千六百十七" do
    compare_kanji_and_integer("四千六百十七", 4617)
  end

  it "四千六百十八" do
    compare_kanji_and_integer("四千六百十八", 4618)
  end

  it "四千六百十九" do
    compare_kanji_and_integer("四千六百十九", 4619)
  end

  it "四千六百二十" do
    compare_kanji_and_integer("四千六百二十", 4620)
  end

  it "四千六百二十一" do
    compare_kanji_and_integer("四千六百二十一", 4621)
  end

  it "四千六百二十二" do
    compare_kanji_and_integer("四千六百二十二", 4622)
  end

  it "四千六百二十三" do
    compare_kanji_and_integer("四千六百二十三", 4623)
  end

  it "四千六百二十四" do
    compare_kanji_and_integer("四千六百二十四", 4624)
  end

  it "四千六百二十五" do
    compare_kanji_and_integer("四千六百二十五", 4625)
  end

  it "四千六百二十六" do
    compare_kanji_and_integer("四千六百二十六", 4626)
  end

  it "四千六百二十七" do
    compare_kanji_and_integer("四千六百二十七", 4627)
  end

  it "四千六百二十八" do
    compare_kanji_and_integer("四千六百二十八", 4628)
  end

  it "四千六百二十九" do
    compare_kanji_and_integer("四千六百二十九", 4629)
  end

  it "四千六百三十" do
    compare_kanji_and_integer("四千六百三十", 4630)
  end

  it "四千六百三十一" do
    compare_kanji_and_integer("四千六百三十一", 4631)
  end

  it "四千六百三十二" do
    compare_kanji_and_integer("四千六百三十二", 4632)
  end

  it "四千六百三十三" do
    compare_kanji_and_integer("四千六百三十三", 4633)
  end

  it "四千六百三十四" do
    compare_kanji_and_integer("四千六百三十四", 4634)
  end

  it "四千六百三十五" do
    compare_kanji_and_integer("四千六百三十五", 4635)
  end

  it "四千六百三十六" do
    compare_kanji_and_integer("四千六百三十六", 4636)
  end

  it "四千六百三十七" do
    compare_kanji_and_integer("四千六百三十七", 4637)
  end

  it "四千六百三十八" do
    compare_kanji_and_integer("四千六百三十八", 4638)
  end

  it "四千六百三十九" do
    compare_kanji_and_integer("四千六百三十九", 4639)
  end

  it "四千六百四十" do
    compare_kanji_and_integer("四千六百四十", 4640)
  end

  it "四千六百四十一" do
    compare_kanji_and_integer("四千六百四十一", 4641)
  end

  it "四千六百四十二" do
    compare_kanji_and_integer("四千六百四十二", 4642)
  end

  it "四千六百四十三" do
    compare_kanji_and_integer("四千六百四十三", 4643)
  end

  it "四千六百四十四" do
    compare_kanji_and_integer("四千六百四十四", 4644)
  end

  it "四千六百四十五" do
    compare_kanji_and_integer("四千六百四十五", 4645)
  end

  it "四千六百四十六" do
    compare_kanji_and_integer("四千六百四十六", 4646)
  end

  it "四千六百四十七" do
    compare_kanji_and_integer("四千六百四十七", 4647)
  end

  it "四千六百四十八" do
    compare_kanji_and_integer("四千六百四十八", 4648)
  end

  it "四千六百四十九" do
    compare_kanji_and_integer("四千六百四十九", 4649)
  end

  it "四千六百五十" do
    compare_kanji_and_integer("四千六百五十", 4650)
  end

  it "四千六百五十一" do
    compare_kanji_and_integer("四千六百五十一", 4651)
  end

  it "四千六百五十二" do
    compare_kanji_and_integer("四千六百五十二", 4652)
  end

  it "四千六百五十三" do
    compare_kanji_and_integer("四千六百五十三", 4653)
  end

  it "四千六百五十四" do
    compare_kanji_and_integer("四千六百五十四", 4654)
  end

  it "四千六百五十五" do
    compare_kanji_and_integer("四千六百五十五", 4655)
  end

  it "四千六百五十六" do
    compare_kanji_and_integer("四千六百五十六", 4656)
  end

  it "四千六百五十七" do
    compare_kanji_and_integer("四千六百五十七", 4657)
  end

  it "四千六百五十八" do
    compare_kanji_and_integer("四千六百五十八", 4658)
  end

  it "四千六百五十九" do
    compare_kanji_and_integer("四千六百五十九", 4659)
  end

  it "四千六百六十" do
    compare_kanji_and_integer("四千六百六十", 4660)
  end

  it "四千六百六十一" do
    compare_kanji_and_integer("四千六百六十一", 4661)
  end

  it "四千六百六十二" do
    compare_kanji_and_integer("四千六百六十二", 4662)
  end

  it "四千六百六十三" do
    compare_kanji_and_integer("四千六百六十三", 4663)
  end

  it "四千六百六十四" do
    compare_kanji_and_integer("四千六百六十四", 4664)
  end

  it "四千六百六十五" do
    compare_kanji_and_integer("四千六百六十五", 4665)
  end

  it "四千六百六十六" do
    compare_kanji_and_integer("四千六百六十六", 4666)
  end

  it "四千六百六十七" do
    compare_kanji_and_integer("四千六百六十七", 4667)
  end

  it "四千六百六十八" do
    compare_kanji_and_integer("四千六百六十八", 4668)
  end

  it "四千六百六十九" do
    compare_kanji_and_integer("四千六百六十九", 4669)
  end

  it "四千六百七十" do
    compare_kanji_and_integer("四千六百七十", 4670)
  end

  it "四千六百七十一" do
    compare_kanji_and_integer("四千六百七十一", 4671)
  end

  it "四千六百七十二" do
    compare_kanji_and_integer("四千六百七十二", 4672)
  end

  it "四千六百七十三" do
    compare_kanji_and_integer("四千六百七十三", 4673)
  end

  it "四千六百七十四" do
    compare_kanji_and_integer("四千六百七十四", 4674)
  end

  it "四千六百七十五" do
    compare_kanji_and_integer("四千六百七十五", 4675)
  end

  it "四千六百七十六" do
    compare_kanji_and_integer("四千六百七十六", 4676)
  end

  it "四千六百七十七" do
    compare_kanji_and_integer("四千六百七十七", 4677)
  end

  it "四千六百七十八" do
    compare_kanji_and_integer("四千六百七十八", 4678)
  end

  it "四千六百七十九" do
    compare_kanji_and_integer("四千六百七十九", 4679)
  end

  it "四千六百八十" do
    compare_kanji_and_integer("四千六百八十", 4680)
  end

  it "四千六百八十一" do
    compare_kanji_and_integer("四千六百八十一", 4681)
  end

  it "四千六百八十二" do
    compare_kanji_and_integer("四千六百八十二", 4682)
  end

  it "四千六百八十三" do
    compare_kanji_and_integer("四千六百八十三", 4683)
  end

  it "四千六百八十四" do
    compare_kanji_and_integer("四千六百八十四", 4684)
  end

  it "四千六百八十五" do
    compare_kanji_and_integer("四千六百八十五", 4685)
  end

  it "四千六百八十六" do
    compare_kanji_and_integer("四千六百八十六", 4686)
  end

  it "四千六百八十七" do
    compare_kanji_and_integer("四千六百八十七", 4687)
  end

  it "四千六百八十八" do
    compare_kanji_and_integer("四千六百八十八", 4688)
  end

  it "四千六百八十九" do
    compare_kanji_and_integer("四千六百八十九", 4689)
  end

  it "四千六百九十" do
    compare_kanji_and_integer("四千六百九十", 4690)
  end

  it "四千六百九十一" do
    compare_kanji_and_integer("四千六百九十一", 4691)
  end

  it "四千六百九十二" do
    compare_kanji_and_integer("四千六百九十二", 4692)
  end

  it "四千六百九十三" do
    compare_kanji_and_integer("四千六百九十三", 4693)
  end

  it "四千六百九十四" do
    compare_kanji_and_integer("四千六百九十四", 4694)
  end

  it "四千六百九十五" do
    compare_kanji_and_integer("四千六百九十五", 4695)
  end

  it "四千六百九十六" do
    compare_kanji_and_integer("四千六百九十六", 4696)
  end

  it "四千六百九十七" do
    compare_kanji_and_integer("四千六百九十七", 4697)
  end

  it "四千六百九十八" do
    compare_kanji_and_integer("四千六百九十八", 4698)
  end

  it "四千六百九十九" do
    compare_kanji_and_integer("四千六百九十九", 4699)
  end

  it "四千七百" do
    compare_kanji_and_integer("四千七百", 4700)
  end

  it "四千七百一" do
    compare_kanji_and_integer("四千七百一", 4701)
  end

  it "四千七百二" do
    compare_kanji_and_integer("四千七百二", 4702)
  end

  it "四千七百三" do
    compare_kanji_and_integer("四千七百三", 4703)
  end

  it "四千七百四" do
    compare_kanji_and_integer("四千七百四", 4704)
  end

  it "四千七百五" do
    compare_kanji_and_integer("四千七百五", 4705)
  end

  it "四千七百六" do
    compare_kanji_and_integer("四千七百六", 4706)
  end

  it "四千七百七" do
    compare_kanji_and_integer("四千七百七", 4707)
  end

  it "四千七百八" do
    compare_kanji_and_integer("四千七百八", 4708)
  end

  it "四千七百九" do
    compare_kanji_and_integer("四千七百九", 4709)
  end

  it "四千七百十" do
    compare_kanji_and_integer("四千七百十", 4710)
  end

  it "四千七百十一" do
    compare_kanji_and_integer("四千七百十一", 4711)
  end

  it "四千七百十二" do
    compare_kanji_and_integer("四千七百十二", 4712)
  end

  it "四千七百十三" do
    compare_kanji_and_integer("四千七百十三", 4713)
  end

  it "四千七百十四" do
    compare_kanji_and_integer("四千七百十四", 4714)
  end

  it "四千七百十五" do
    compare_kanji_and_integer("四千七百十五", 4715)
  end

  it "四千七百十六" do
    compare_kanji_and_integer("四千七百十六", 4716)
  end

  it "四千七百十七" do
    compare_kanji_and_integer("四千七百十七", 4717)
  end

  it "四千七百十八" do
    compare_kanji_and_integer("四千七百十八", 4718)
  end

  it "四千七百十九" do
    compare_kanji_and_integer("四千七百十九", 4719)
  end

  it "四千七百二十" do
    compare_kanji_and_integer("四千七百二十", 4720)
  end

  it "四千七百二十一" do
    compare_kanji_and_integer("四千七百二十一", 4721)
  end

  it "四千七百二十二" do
    compare_kanji_and_integer("四千七百二十二", 4722)
  end

  it "四千七百二十三" do
    compare_kanji_and_integer("四千七百二十三", 4723)
  end

  it "四千七百二十四" do
    compare_kanji_and_integer("四千七百二十四", 4724)
  end

  it "四千七百二十五" do
    compare_kanji_and_integer("四千七百二十五", 4725)
  end

  it "四千七百二十六" do
    compare_kanji_and_integer("四千七百二十六", 4726)
  end

  it "四千七百二十七" do
    compare_kanji_and_integer("四千七百二十七", 4727)
  end

  it "四千七百二十八" do
    compare_kanji_and_integer("四千七百二十八", 4728)
  end

  it "四千七百二十九" do
    compare_kanji_and_integer("四千七百二十九", 4729)
  end

  it "四千七百三十" do
    compare_kanji_and_integer("四千七百三十", 4730)
  end

  it "四千七百三十一" do
    compare_kanji_and_integer("四千七百三十一", 4731)
  end

  it "四千七百三十二" do
    compare_kanji_and_integer("四千七百三十二", 4732)
  end

  it "四千七百三十三" do
    compare_kanji_and_integer("四千七百三十三", 4733)
  end

  it "四千七百三十四" do
    compare_kanji_and_integer("四千七百三十四", 4734)
  end

  it "四千七百三十五" do
    compare_kanji_and_integer("四千七百三十五", 4735)
  end

  it "四千七百三十六" do
    compare_kanji_and_integer("四千七百三十六", 4736)
  end

  it "四千七百三十七" do
    compare_kanji_and_integer("四千七百三十七", 4737)
  end

  it "四千七百三十八" do
    compare_kanji_and_integer("四千七百三十八", 4738)
  end

  it "四千七百三十九" do
    compare_kanji_and_integer("四千七百三十九", 4739)
  end

  it "四千七百四十" do
    compare_kanji_and_integer("四千七百四十", 4740)
  end

  it "四千七百四十一" do
    compare_kanji_and_integer("四千七百四十一", 4741)
  end

  it "四千七百四十二" do
    compare_kanji_and_integer("四千七百四十二", 4742)
  end

  it "四千七百四十三" do
    compare_kanji_and_integer("四千七百四十三", 4743)
  end

  it "四千七百四十四" do
    compare_kanji_and_integer("四千七百四十四", 4744)
  end

  it "四千七百四十五" do
    compare_kanji_and_integer("四千七百四十五", 4745)
  end

  it "四千七百四十六" do
    compare_kanji_and_integer("四千七百四十六", 4746)
  end

  it "四千七百四十七" do
    compare_kanji_and_integer("四千七百四十七", 4747)
  end

  it "四千七百四十八" do
    compare_kanji_and_integer("四千七百四十八", 4748)
  end

  it "四千七百四十九" do
    compare_kanji_and_integer("四千七百四十九", 4749)
  end

  it "四千七百五十" do
    compare_kanji_and_integer("四千七百五十", 4750)
  end

  it "四千七百五十一" do
    compare_kanji_and_integer("四千七百五十一", 4751)
  end

  it "四千七百五十二" do
    compare_kanji_and_integer("四千七百五十二", 4752)
  end

  it "四千七百五十三" do
    compare_kanji_and_integer("四千七百五十三", 4753)
  end

  it "四千七百五十四" do
    compare_kanji_and_integer("四千七百五十四", 4754)
  end

  it "四千七百五十五" do
    compare_kanji_and_integer("四千七百五十五", 4755)
  end

  it "四千七百五十六" do
    compare_kanji_and_integer("四千七百五十六", 4756)
  end

  it "四千七百五十七" do
    compare_kanji_and_integer("四千七百五十七", 4757)
  end

  it "四千七百五十八" do
    compare_kanji_and_integer("四千七百五十八", 4758)
  end

  it "四千七百五十九" do
    compare_kanji_and_integer("四千七百五十九", 4759)
  end

  it "四千七百六十" do
    compare_kanji_and_integer("四千七百六十", 4760)
  end

  it "四千七百六十一" do
    compare_kanji_and_integer("四千七百六十一", 4761)
  end

  it "四千七百六十二" do
    compare_kanji_and_integer("四千七百六十二", 4762)
  end

  it "四千七百六十三" do
    compare_kanji_and_integer("四千七百六十三", 4763)
  end

  it "四千七百六十四" do
    compare_kanji_and_integer("四千七百六十四", 4764)
  end

  it "四千七百六十五" do
    compare_kanji_and_integer("四千七百六十五", 4765)
  end

  it "四千七百六十六" do
    compare_kanji_and_integer("四千七百六十六", 4766)
  end

  it "四千七百六十七" do
    compare_kanji_and_integer("四千七百六十七", 4767)
  end

  it "四千七百六十八" do
    compare_kanji_and_integer("四千七百六十八", 4768)
  end

  it "四千七百六十九" do
    compare_kanji_and_integer("四千七百六十九", 4769)
  end

  it "四千七百七十" do
    compare_kanji_and_integer("四千七百七十", 4770)
  end

  it "四千七百七十一" do
    compare_kanji_and_integer("四千七百七十一", 4771)
  end

  it "四千七百七十二" do
    compare_kanji_and_integer("四千七百七十二", 4772)
  end

  it "四千七百七十三" do
    compare_kanji_and_integer("四千七百七十三", 4773)
  end

  it "四千七百七十四" do
    compare_kanji_and_integer("四千七百七十四", 4774)
  end

  it "四千七百七十五" do
    compare_kanji_and_integer("四千七百七十五", 4775)
  end

  it "四千七百七十六" do
    compare_kanji_and_integer("四千七百七十六", 4776)
  end

  it "四千七百七十七" do
    compare_kanji_and_integer("四千七百七十七", 4777)
  end

  it "四千七百七十八" do
    compare_kanji_and_integer("四千七百七十八", 4778)
  end

  it "四千七百七十九" do
    compare_kanji_and_integer("四千七百七十九", 4779)
  end

  it "四千七百八十" do
    compare_kanji_and_integer("四千七百八十", 4780)
  end

  it "四千七百八十一" do
    compare_kanji_and_integer("四千七百八十一", 4781)
  end

  it "四千七百八十二" do
    compare_kanji_and_integer("四千七百八十二", 4782)
  end

  it "四千七百八十三" do
    compare_kanji_and_integer("四千七百八十三", 4783)
  end

  it "四千七百八十四" do
    compare_kanji_and_integer("四千七百八十四", 4784)
  end

  it "四千七百八十五" do
    compare_kanji_and_integer("四千七百八十五", 4785)
  end

  it "四千七百八十六" do
    compare_kanji_and_integer("四千七百八十六", 4786)
  end

  it "四千七百八十七" do
    compare_kanji_and_integer("四千七百八十七", 4787)
  end

  it "四千七百八十八" do
    compare_kanji_and_integer("四千七百八十八", 4788)
  end

  it "四千七百八十九" do
    compare_kanji_and_integer("四千七百八十九", 4789)
  end

  it "四千七百九十" do
    compare_kanji_and_integer("四千七百九十", 4790)
  end

  it "四千七百九十一" do
    compare_kanji_and_integer("四千七百九十一", 4791)
  end

  it "四千七百九十二" do
    compare_kanji_and_integer("四千七百九十二", 4792)
  end

  it "四千七百九十三" do
    compare_kanji_and_integer("四千七百九十三", 4793)
  end

  it "四千七百九十四" do
    compare_kanji_and_integer("四千七百九十四", 4794)
  end

  it "四千七百九十五" do
    compare_kanji_and_integer("四千七百九十五", 4795)
  end

  it "四千七百九十六" do
    compare_kanji_and_integer("四千七百九十六", 4796)
  end

  it "四千七百九十七" do
    compare_kanji_and_integer("四千七百九十七", 4797)
  end

  it "四千七百九十八" do
    compare_kanji_and_integer("四千七百九十八", 4798)
  end

  it "四千七百九十九" do
    compare_kanji_and_integer("四千七百九十九", 4799)
  end

  it "四千八百" do
    compare_kanji_and_integer("四千八百", 4800)
  end

  it "四千八百一" do
    compare_kanji_and_integer("四千八百一", 4801)
  end

  it "四千八百二" do
    compare_kanji_and_integer("四千八百二", 4802)
  end

  it "四千八百三" do
    compare_kanji_and_integer("四千八百三", 4803)
  end

  it "四千八百四" do
    compare_kanji_and_integer("四千八百四", 4804)
  end

  it "四千八百五" do
    compare_kanji_and_integer("四千八百五", 4805)
  end

  it "四千八百六" do
    compare_kanji_and_integer("四千八百六", 4806)
  end

  it "四千八百七" do
    compare_kanji_and_integer("四千八百七", 4807)
  end

  it "四千八百八" do
    compare_kanji_and_integer("四千八百八", 4808)
  end

  it "四千八百九" do
    compare_kanji_and_integer("四千八百九", 4809)
  end

  it "四千八百十" do
    compare_kanji_and_integer("四千八百十", 4810)
  end

  it "四千八百十一" do
    compare_kanji_and_integer("四千八百十一", 4811)
  end

  it "四千八百十二" do
    compare_kanji_and_integer("四千八百十二", 4812)
  end

  it "四千八百十三" do
    compare_kanji_and_integer("四千八百十三", 4813)
  end

  it "四千八百十四" do
    compare_kanji_and_integer("四千八百十四", 4814)
  end

  it "四千八百十五" do
    compare_kanji_and_integer("四千八百十五", 4815)
  end

  it "四千八百十六" do
    compare_kanji_and_integer("四千八百十六", 4816)
  end

  it "四千八百十七" do
    compare_kanji_and_integer("四千八百十七", 4817)
  end

  it "四千八百十八" do
    compare_kanji_and_integer("四千八百十八", 4818)
  end

  it "四千八百十九" do
    compare_kanji_and_integer("四千八百十九", 4819)
  end

  it "四千八百二十" do
    compare_kanji_and_integer("四千八百二十", 4820)
  end

  it "四千八百二十一" do
    compare_kanji_and_integer("四千八百二十一", 4821)
  end

  it "四千八百二十二" do
    compare_kanji_and_integer("四千八百二十二", 4822)
  end

  it "四千八百二十三" do
    compare_kanji_and_integer("四千八百二十三", 4823)
  end

  it "四千八百二十四" do
    compare_kanji_and_integer("四千八百二十四", 4824)
  end

  it "四千八百二十五" do
    compare_kanji_and_integer("四千八百二十五", 4825)
  end

  it "四千八百二十六" do
    compare_kanji_and_integer("四千八百二十六", 4826)
  end

  it "四千八百二十七" do
    compare_kanji_and_integer("四千八百二十七", 4827)
  end

  it "四千八百二十八" do
    compare_kanji_and_integer("四千八百二十八", 4828)
  end

  it "四千八百二十九" do
    compare_kanji_and_integer("四千八百二十九", 4829)
  end

  it "四千八百三十" do
    compare_kanji_and_integer("四千八百三十", 4830)
  end

  it "四千八百三十一" do
    compare_kanji_and_integer("四千八百三十一", 4831)
  end

  it "四千八百三十二" do
    compare_kanji_and_integer("四千八百三十二", 4832)
  end

  it "四千八百三十三" do
    compare_kanji_and_integer("四千八百三十三", 4833)
  end

  it "四千八百三十四" do
    compare_kanji_and_integer("四千八百三十四", 4834)
  end

  it "四千八百三十五" do
    compare_kanji_and_integer("四千八百三十五", 4835)
  end

  it "四千八百三十六" do
    compare_kanji_and_integer("四千八百三十六", 4836)
  end

  it "四千八百三十七" do
    compare_kanji_and_integer("四千八百三十七", 4837)
  end

  it "四千八百三十八" do
    compare_kanji_and_integer("四千八百三十八", 4838)
  end

  it "四千八百三十九" do
    compare_kanji_and_integer("四千八百三十九", 4839)
  end

  it "四千八百四十" do
    compare_kanji_and_integer("四千八百四十", 4840)
  end

  it "四千八百四十一" do
    compare_kanji_and_integer("四千八百四十一", 4841)
  end

  it "四千八百四十二" do
    compare_kanji_and_integer("四千八百四十二", 4842)
  end

  it "四千八百四十三" do
    compare_kanji_and_integer("四千八百四十三", 4843)
  end

  it "四千八百四十四" do
    compare_kanji_and_integer("四千八百四十四", 4844)
  end

  it "四千八百四十五" do
    compare_kanji_and_integer("四千八百四十五", 4845)
  end

  it "四千八百四十六" do
    compare_kanji_and_integer("四千八百四十六", 4846)
  end

  it "四千八百四十七" do
    compare_kanji_and_integer("四千八百四十七", 4847)
  end

  it "四千八百四十八" do
    compare_kanji_and_integer("四千八百四十八", 4848)
  end

  it "四千八百四十九" do
    compare_kanji_and_integer("四千八百四十九", 4849)
  end

  it "四千八百五十" do
    compare_kanji_and_integer("四千八百五十", 4850)
  end

  it "四千八百五十一" do
    compare_kanji_and_integer("四千八百五十一", 4851)
  end

  it "四千八百五十二" do
    compare_kanji_and_integer("四千八百五十二", 4852)
  end

  it "四千八百五十三" do
    compare_kanji_and_integer("四千八百五十三", 4853)
  end

  it "四千八百五十四" do
    compare_kanji_and_integer("四千八百五十四", 4854)
  end

  it "四千八百五十五" do
    compare_kanji_and_integer("四千八百五十五", 4855)
  end

  it "四千八百五十六" do
    compare_kanji_and_integer("四千八百五十六", 4856)
  end

  it "四千八百五十七" do
    compare_kanji_and_integer("四千八百五十七", 4857)
  end

  it "四千八百五十八" do
    compare_kanji_and_integer("四千八百五十八", 4858)
  end

  it "四千八百五十九" do
    compare_kanji_and_integer("四千八百五十九", 4859)
  end

  it "四千八百六十" do
    compare_kanji_and_integer("四千八百六十", 4860)
  end

  it "四千八百六十一" do
    compare_kanji_and_integer("四千八百六十一", 4861)
  end

  it "四千八百六十二" do
    compare_kanji_and_integer("四千八百六十二", 4862)
  end

  it "四千八百六十三" do
    compare_kanji_and_integer("四千八百六十三", 4863)
  end

  it "四千八百六十四" do
    compare_kanji_and_integer("四千八百六十四", 4864)
  end

  it "四千八百六十五" do
    compare_kanji_and_integer("四千八百六十五", 4865)
  end

  it "四千八百六十六" do
    compare_kanji_and_integer("四千八百六十六", 4866)
  end

  it "四千八百六十七" do
    compare_kanji_and_integer("四千八百六十七", 4867)
  end

  it "四千八百六十八" do
    compare_kanji_and_integer("四千八百六十八", 4868)
  end

  it "四千八百六十九" do
    compare_kanji_and_integer("四千八百六十九", 4869)
  end

  it "四千八百七十" do
    compare_kanji_and_integer("四千八百七十", 4870)
  end

  it "四千八百七十一" do
    compare_kanji_and_integer("四千八百七十一", 4871)
  end

  it "四千八百七十二" do
    compare_kanji_and_integer("四千八百七十二", 4872)
  end

  it "四千八百七十三" do
    compare_kanji_and_integer("四千八百七十三", 4873)
  end

  it "四千八百七十四" do
    compare_kanji_and_integer("四千八百七十四", 4874)
  end

  it "四千八百七十五" do
    compare_kanji_and_integer("四千八百七十五", 4875)
  end

  it "四千八百七十六" do
    compare_kanji_and_integer("四千八百七十六", 4876)
  end

  it "四千八百七十七" do
    compare_kanji_and_integer("四千八百七十七", 4877)
  end

  it "四千八百七十八" do
    compare_kanji_and_integer("四千八百七十八", 4878)
  end

  it "四千八百七十九" do
    compare_kanji_and_integer("四千八百七十九", 4879)
  end

  it "四千八百八十" do
    compare_kanji_and_integer("四千八百八十", 4880)
  end

  it "四千八百八十一" do
    compare_kanji_and_integer("四千八百八十一", 4881)
  end

  it "四千八百八十二" do
    compare_kanji_and_integer("四千八百八十二", 4882)
  end

  it "四千八百八十三" do
    compare_kanji_and_integer("四千八百八十三", 4883)
  end

  it "四千八百八十四" do
    compare_kanji_and_integer("四千八百八十四", 4884)
  end

  it "四千八百八十五" do
    compare_kanji_and_integer("四千八百八十五", 4885)
  end

  it "四千八百八十六" do
    compare_kanji_and_integer("四千八百八十六", 4886)
  end

  it "四千八百八十七" do
    compare_kanji_and_integer("四千八百八十七", 4887)
  end

  it "四千八百八十八" do
    compare_kanji_and_integer("四千八百八十八", 4888)
  end

  it "四千八百八十九" do
    compare_kanji_and_integer("四千八百八十九", 4889)
  end

  it "四千八百九十" do
    compare_kanji_and_integer("四千八百九十", 4890)
  end

  it "四千八百九十一" do
    compare_kanji_and_integer("四千八百九十一", 4891)
  end

  it "四千八百九十二" do
    compare_kanji_and_integer("四千八百九十二", 4892)
  end

  it "四千八百九十三" do
    compare_kanji_and_integer("四千八百九十三", 4893)
  end

  it "四千八百九十四" do
    compare_kanji_and_integer("四千八百九十四", 4894)
  end

  it "四千八百九十五" do
    compare_kanji_and_integer("四千八百九十五", 4895)
  end

  it "四千八百九十六" do
    compare_kanji_and_integer("四千八百九十六", 4896)
  end

  it "四千八百九十七" do
    compare_kanji_and_integer("四千八百九十七", 4897)
  end

  it "四千八百九十八" do
    compare_kanji_and_integer("四千八百九十八", 4898)
  end

  it "四千八百九十九" do
    compare_kanji_and_integer("四千八百九十九", 4899)
  end

  it "四千九百" do
    compare_kanji_and_integer("四千九百", 4900)
  end

  it "四千九百一" do
    compare_kanji_and_integer("四千九百一", 4901)
  end

  it "四千九百二" do
    compare_kanji_and_integer("四千九百二", 4902)
  end

  it "四千九百三" do
    compare_kanji_and_integer("四千九百三", 4903)
  end

  it "四千九百四" do
    compare_kanji_and_integer("四千九百四", 4904)
  end

  it "四千九百五" do
    compare_kanji_and_integer("四千九百五", 4905)
  end

  it "四千九百六" do
    compare_kanji_and_integer("四千九百六", 4906)
  end

  it "四千九百七" do
    compare_kanji_and_integer("四千九百七", 4907)
  end

  it "四千九百八" do
    compare_kanji_and_integer("四千九百八", 4908)
  end

  it "四千九百九" do
    compare_kanji_and_integer("四千九百九", 4909)
  end

  it "四千九百十" do
    compare_kanji_and_integer("四千九百十", 4910)
  end

  it "四千九百十一" do
    compare_kanji_and_integer("四千九百十一", 4911)
  end

  it "四千九百十二" do
    compare_kanji_and_integer("四千九百十二", 4912)
  end

  it "四千九百十三" do
    compare_kanji_and_integer("四千九百十三", 4913)
  end

  it "四千九百十四" do
    compare_kanji_and_integer("四千九百十四", 4914)
  end

  it "四千九百十五" do
    compare_kanji_and_integer("四千九百十五", 4915)
  end

  it "四千九百十六" do
    compare_kanji_and_integer("四千九百十六", 4916)
  end

  it "四千九百十七" do
    compare_kanji_and_integer("四千九百十七", 4917)
  end

  it "四千九百十八" do
    compare_kanji_and_integer("四千九百十八", 4918)
  end

  it "四千九百十九" do
    compare_kanji_and_integer("四千九百十九", 4919)
  end

  it "四千九百二十" do
    compare_kanji_and_integer("四千九百二十", 4920)
  end

  it "四千九百二十一" do
    compare_kanji_and_integer("四千九百二十一", 4921)
  end

  it "四千九百二十二" do
    compare_kanji_and_integer("四千九百二十二", 4922)
  end

  it "四千九百二十三" do
    compare_kanji_and_integer("四千九百二十三", 4923)
  end

  it "四千九百二十四" do
    compare_kanji_and_integer("四千九百二十四", 4924)
  end

  it "四千九百二十五" do
    compare_kanji_and_integer("四千九百二十五", 4925)
  end

  it "四千九百二十六" do
    compare_kanji_and_integer("四千九百二十六", 4926)
  end

  it "四千九百二十七" do
    compare_kanji_and_integer("四千九百二十七", 4927)
  end

  it "四千九百二十八" do
    compare_kanji_and_integer("四千九百二十八", 4928)
  end

  it "四千九百二十九" do
    compare_kanji_and_integer("四千九百二十九", 4929)
  end

  it "四千九百三十" do
    compare_kanji_and_integer("四千九百三十", 4930)
  end

  it "四千九百三十一" do
    compare_kanji_and_integer("四千九百三十一", 4931)
  end

  it "四千九百三十二" do
    compare_kanji_and_integer("四千九百三十二", 4932)
  end

  it "四千九百三十三" do
    compare_kanji_and_integer("四千九百三十三", 4933)
  end

  it "四千九百三十四" do
    compare_kanji_and_integer("四千九百三十四", 4934)
  end

  it "四千九百三十五" do
    compare_kanji_and_integer("四千九百三十五", 4935)
  end

  it "四千九百三十六" do
    compare_kanji_and_integer("四千九百三十六", 4936)
  end

  it "四千九百三十七" do
    compare_kanji_and_integer("四千九百三十七", 4937)
  end

  it "四千九百三十八" do
    compare_kanji_and_integer("四千九百三十八", 4938)
  end

  it "四千九百三十九" do
    compare_kanji_and_integer("四千九百三十九", 4939)
  end

  it "四千九百四十" do
    compare_kanji_and_integer("四千九百四十", 4940)
  end

  it "四千九百四十一" do
    compare_kanji_and_integer("四千九百四十一", 4941)
  end

  it "四千九百四十二" do
    compare_kanji_and_integer("四千九百四十二", 4942)
  end

  it "四千九百四十三" do
    compare_kanji_and_integer("四千九百四十三", 4943)
  end

  it "四千九百四十四" do
    compare_kanji_and_integer("四千九百四十四", 4944)
  end

  it "四千九百四十五" do
    compare_kanji_and_integer("四千九百四十五", 4945)
  end

  it "四千九百四十六" do
    compare_kanji_and_integer("四千九百四十六", 4946)
  end

  it "四千九百四十七" do
    compare_kanji_and_integer("四千九百四十七", 4947)
  end

  it "四千九百四十八" do
    compare_kanji_and_integer("四千九百四十八", 4948)
  end

  it "四千九百四十九" do
    compare_kanji_and_integer("四千九百四十九", 4949)
  end

  it "四千九百五十" do
    compare_kanji_and_integer("四千九百五十", 4950)
  end

  it "四千九百五十一" do
    compare_kanji_and_integer("四千九百五十一", 4951)
  end

  it "四千九百五十二" do
    compare_kanji_and_integer("四千九百五十二", 4952)
  end

  it "四千九百五十三" do
    compare_kanji_and_integer("四千九百五十三", 4953)
  end

  it "四千九百五十四" do
    compare_kanji_and_integer("四千九百五十四", 4954)
  end

  it "四千九百五十五" do
    compare_kanji_and_integer("四千九百五十五", 4955)
  end

  it "四千九百五十六" do
    compare_kanji_and_integer("四千九百五十六", 4956)
  end

  it "四千九百五十七" do
    compare_kanji_and_integer("四千九百五十七", 4957)
  end

  it "四千九百五十八" do
    compare_kanji_and_integer("四千九百五十八", 4958)
  end

  it "四千九百五十九" do
    compare_kanji_and_integer("四千九百五十九", 4959)
  end

  it "四千九百六十" do
    compare_kanji_and_integer("四千九百六十", 4960)
  end

  it "四千九百六十一" do
    compare_kanji_and_integer("四千九百六十一", 4961)
  end

  it "四千九百六十二" do
    compare_kanji_and_integer("四千九百六十二", 4962)
  end

  it "四千九百六十三" do
    compare_kanji_and_integer("四千九百六十三", 4963)
  end

  it "四千九百六十四" do
    compare_kanji_and_integer("四千九百六十四", 4964)
  end

  it "四千九百六十五" do
    compare_kanji_and_integer("四千九百六十五", 4965)
  end

  it "四千九百六十六" do
    compare_kanji_and_integer("四千九百六十六", 4966)
  end

  it "四千九百六十七" do
    compare_kanji_and_integer("四千九百六十七", 4967)
  end

  it "四千九百六十八" do
    compare_kanji_and_integer("四千九百六十八", 4968)
  end

  it "四千九百六十九" do
    compare_kanji_and_integer("四千九百六十九", 4969)
  end

  it "四千九百七十" do
    compare_kanji_and_integer("四千九百七十", 4970)
  end

  it "四千九百七十一" do
    compare_kanji_and_integer("四千九百七十一", 4971)
  end

  it "四千九百七十二" do
    compare_kanji_and_integer("四千九百七十二", 4972)
  end

  it "四千九百七十三" do
    compare_kanji_and_integer("四千九百七十三", 4973)
  end

  it "四千九百七十四" do
    compare_kanji_and_integer("四千九百七十四", 4974)
  end

  it "四千九百七十五" do
    compare_kanji_and_integer("四千九百七十五", 4975)
  end

  it "四千九百七十六" do
    compare_kanji_and_integer("四千九百七十六", 4976)
  end

  it "四千九百七十七" do
    compare_kanji_and_integer("四千九百七十七", 4977)
  end

  it "四千九百七十八" do
    compare_kanji_and_integer("四千九百七十八", 4978)
  end

  it "四千九百七十九" do
    compare_kanji_and_integer("四千九百七十九", 4979)
  end

  it "四千九百八十" do
    compare_kanji_and_integer("四千九百八十", 4980)
  end

  it "四千九百八十一" do
    compare_kanji_and_integer("四千九百八十一", 4981)
  end

  it "四千九百八十二" do
    compare_kanji_and_integer("四千九百八十二", 4982)
  end

  it "四千九百八十三" do
    compare_kanji_and_integer("四千九百八十三", 4983)
  end

  it "四千九百八十四" do
    compare_kanji_and_integer("四千九百八十四", 4984)
  end

  it "四千九百八十五" do
    compare_kanji_and_integer("四千九百八十五", 4985)
  end

  it "四千九百八十六" do
    compare_kanji_and_integer("四千九百八十六", 4986)
  end

  it "四千九百八十七" do
    compare_kanji_and_integer("四千九百八十七", 4987)
  end

  it "四千九百八十八" do
    compare_kanji_and_integer("四千九百八十八", 4988)
  end

  it "四千九百八十九" do
    compare_kanji_and_integer("四千九百八十九", 4989)
  end

  it "四千九百九十" do
    compare_kanji_and_integer("四千九百九十", 4990)
  end

  it "四千九百九十一" do
    compare_kanji_and_integer("四千九百九十一", 4991)
  end

  it "四千九百九十二" do
    compare_kanji_and_integer("四千九百九十二", 4992)
  end

  it "四千九百九十三" do
    compare_kanji_and_integer("四千九百九十三", 4993)
  end

  it "四千九百九十四" do
    compare_kanji_and_integer("四千九百九十四", 4994)
  end

  it "四千九百九十五" do
    compare_kanji_and_integer("四千九百九十五", 4995)
  end

  it "四千九百九十六" do
    compare_kanji_and_integer("四千九百九十六", 4996)
  end

  it "四千九百九十七" do
    compare_kanji_and_integer("四千九百九十七", 4997)
  end

  it "四千九百九十八" do
    compare_kanji_and_integer("四千九百九十八", 4998)
  end

  it "四千九百九十九" do
    compare_kanji_and_integer("四千九百九十九", 4999)
  end

  it "五千" do
    compare_kanji_and_integer("五千", 5000)
  end

  it "五千一" do
    compare_kanji_and_integer("五千一", 5001)
  end

  it "五千二" do
    compare_kanji_and_integer("五千二", 5002)
  end

  it "五千三" do
    compare_kanji_and_integer("五千三", 5003)
  end

  it "五千四" do
    compare_kanji_and_integer("五千四", 5004)
  end

  it "五千五" do
    compare_kanji_and_integer("五千五", 5005)
  end

  it "五千六" do
    compare_kanji_and_integer("五千六", 5006)
  end

  it "五千七" do
    compare_kanji_and_integer("五千七", 5007)
  end

  it "五千八" do
    compare_kanji_and_integer("五千八", 5008)
  end

  it "五千九" do
    compare_kanji_and_integer("五千九", 5009)
  end

  it "五千十" do
    compare_kanji_and_integer("五千十", 5010)
  end

  it "五千十一" do
    compare_kanji_and_integer("五千十一", 5011)
  end

  it "五千十二" do
    compare_kanji_and_integer("五千十二", 5012)
  end

  it "五千十三" do
    compare_kanji_and_integer("五千十三", 5013)
  end

  it "五千十四" do
    compare_kanji_and_integer("五千十四", 5014)
  end

  it "五千十五" do
    compare_kanji_and_integer("五千十五", 5015)
  end

  it "五千十六" do
    compare_kanji_and_integer("五千十六", 5016)
  end

  it "五千十七" do
    compare_kanji_and_integer("五千十七", 5017)
  end

  it "五千十八" do
    compare_kanji_and_integer("五千十八", 5018)
  end

  it "五千十九" do
    compare_kanji_and_integer("五千十九", 5019)
  end

  it "五千二十" do
    compare_kanji_and_integer("五千二十", 5020)
  end

  it "五千二十一" do
    compare_kanji_and_integer("五千二十一", 5021)
  end

  it "五千二十二" do
    compare_kanji_and_integer("五千二十二", 5022)
  end

  it "五千二十三" do
    compare_kanji_and_integer("五千二十三", 5023)
  end

  it "五千二十四" do
    compare_kanji_and_integer("五千二十四", 5024)
  end

  it "五千二十五" do
    compare_kanji_and_integer("五千二十五", 5025)
  end

  it "五千二十六" do
    compare_kanji_and_integer("五千二十六", 5026)
  end

  it "五千二十七" do
    compare_kanji_and_integer("五千二十七", 5027)
  end

  it "五千二十八" do
    compare_kanji_and_integer("五千二十八", 5028)
  end

  it "五千二十九" do
    compare_kanji_and_integer("五千二十九", 5029)
  end

  it "五千三十" do
    compare_kanji_and_integer("五千三十", 5030)
  end

  it "五千三十一" do
    compare_kanji_and_integer("五千三十一", 5031)
  end

  it "五千三十二" do
    compare_kanji_and_integer("五千三十二", 5032)
  end

  it "五千三十三" do
    compare_kanji_and_integer("五千三十三", 5033)
  end

  it "五千三十四" do
    compare_kanji_and_integer("五千三十四", 5034)
  end

  it "五千三十五" do
    compare_kanji_and_integer("五千三十五", 5035)
  end

  it "五千三十六" do
    compare_kanji_and_integer("五千三十六", 5036)
  end

  it "五千三十七" do
    compare_kanji_and_integer("五千三十七", 5037)
  end

  it "五千三十八" do
    compare_kanji_and_integer("五千三十八", 5038)
  end

  it "五千三十九" do
    compare_kanji_and_integer("五千三十九", 5039)
  end

  it "五千四十" do
    compare_kanji_and_integer("五千四十", 5040)
  end

  it "五千四十一" do
    compare_kanji_and_integer("五千四十一", 5041)
  end

  it "五千四十二" do
    compare_kanji_and_integer("五千四十二", 5042)
  end

  it "五千四十三" do
    compare_kanji_and_integer("五千四十三", 5043)
  end

  it "五千四十四" do
    compare_kanji_and_integer("五千四十四", 5044)
  end

  it "五千四十五" do
    compare_kanji_and_integer("五千四十五", 5045)
  end

  it "五千四十六" do
    compare_kanji_and_integer("五千四十六", 5046)
  end

  it "五千四十七" do
    compare_kanji_and_integer("五千四十七", 5047)
  end

  it "五千四十八" do
    compare_kanji_and_integer("五千四十八", 5048)
  end

  it "五千四十九" do
    compare_kanji_and_integer("五千四十九", 5049)
  end

  it "五千五十" do
    compare_kanji_and_integer("五千五十", 5050)
  end

  it "五千五十一" do
    compare_kanji_and_integer("五千五十一", 5051)
  end

  it "五千五十二" do
    compare_kanji_and_integer("五千五十二", 5052)
  end

  it "五千五十三" do
    compare_kanji_and_integer("五千五十三", 5053)
  end

  it "五千五十四" do
    compare_kanji_and_integer("五千五十四", 5054)
  end

  it "五千五十五" do
    compare_kanji_and_integer("五千五十五", 5055)
  end

  it "五千五十六" do
    compare_kanji_and_integer("五千五十六", 5056)
  end

  it "五千五十七" do
    compare_kanji_and_integer("五千五十七", 5057)
  end

  it "五千五十八" do
    compare_kanji_and_integer("五千五十八", 5058)
  end

  it "五千五十九" do
    compare_kanji_and_integer("五千五十九", 5059)
  end

  it "五千六十" do
    compare_kanji_and_integer("五千六十", 5060)
  end

  it "五千六十一" do
    compare_kanji_and_integer("五千六十一", 5061)
  end

  it "五千六十二" do
    compare_kanji_and_integer("五千六十二", 5062)
  end

  it "五千六十三" do
    compare_kanji_and_integer("五千六十三", 5063)
  end

  it "五千六十四" do
    compare_kanji_and_integer("五千六十四", 5064)
  end

  it "五千六十五" do
    compare_kanji_and_integer("五千六十五", 5065)
  end

  it "五千六十六" do
    compare_kanji_and_integer("五千六十六", 5066)
  end

  it "五千六十七" do
    compare_kanji_and_integer("五千六十七", 5067)
  end

  it "五千六十八" do
    compare_kanji_and_integer("五千六十八", 5068)
  end

  it "五千六十九" do
    compare_kanji_and_integer("五千六十九", 5069)
  end

  it "五千七十" do
    compare_kanji_and_integer("五千七十", 5070)
  end

  it "五千七十一" do
    compare_kanji_and_integer("五千七十一", 5071)
  end

  it "五千七十二" do
    compare_kanji_and_integer("五千七十二", 5072)
  end

  it "五千七十三" do
    compare_kanji_and_integer("五千七十三", 5073)
  end

  it "五千七十四" do
    compare_kanji_and_integer("五千七十四", 5074)
  end

  it "五千七十五" do
    compare_kanji_and_integer("五千七十五", 5075)
  end

  it "五千七十六" do
    compare_kanji_and_integer("五千七十六", 5076)
  end

  it "五千七十七" do
    compare_kanji_and_integer("五千七十七", 5077)
  end

  it "五千七十八" do
    compare_kanji_and_integer("五千七十八", 5078)
  end

  it "五千七十九" do
    compare_kanji_and_integer("五千七十九", 5079)
  end

  it "五千八十" do
    compare_kanji_and_integer("五千八十", 5080)
  end

  it "五千八十一" do
    compare_kanji_and_integer("五千八十一", 5081)
  end

  it "五千八十二" do
    compare_kanji_and_integer("五千八十二", 5082)
  end

  it "五千八十三" do
    compare_kanji_and_integer("五千八十三", 5083)
  end

  it "五千八十四" do
    compare_kanji_and_integer("五千八十四", 5084)
  end

  it "五千八十五" do
    compare_kanji_and_integer("五千八十五", 5085)
  end

  it "五千八十六" do
    compare_kanji_and_integer("五千八十六", 5086)
  end

  it "五千八十七" do
    compare_kanji_and_integer("五千八十七", 5087)
  end

  it "五千八十八" do
    compare_kanji_and_integer("五千八十八", 5088)
  end

  it "五千八十九" do
    compare_kanji_and_integer("五千八十九", 5089)
  end

  it "五千九十" do
    compare_kanji_and_integer("五千九十", 5090)
  end

  it "五千九十一" do
    compare_kanji_and_integer("五千九十一", 5091)
  end

  it "五千九十二" do
    compare_kanji_and_integer("五千九十二", 5092)
  end

  it "五千九十三" do
    compare_kanji_and_integer("五千九十三", 5093)
  end

  it "五千九十四" do
    compare_kanji_and_integer("五千九十四", 5094)
  end

  it "五千九十五" do
    compare_kanji_and_integer("五千九十五", 5095)
  end

  it "五千九十六" do
    compare_kanji_and_integer("五千九十六", 5096)
  end

  it "五千九十七" do
    compare_kanji_and_integer("五千九十七", 5097)
  end

  it "五千九十八" do
    compare_kanji_and_integer("五千九十八", 5098)
  end

  it "五千九十九" do
    compare_kanji_and_integer("五千九十九", 5099)
  end

  it "五千百" do
    compare_kanji_and_integer("五千百", 5100)
  end

  it "五千百一" do
    compare_kanji_and_integer("五千百一", 5101)
  end

  it "五千百二" do
    compare_kanji_and_integer("五千百二", 5102)
  end

  it "五千百三" do
    compare_kanji_and_integer("五千百三", 5103)
  end

  it "五千百四" do
    compare_kanji_and_integer("五千百四", 5104)
  end

  it "五千百五" do
    compare_kanji_and_integer("五千百五", 5105)
  end

  it "五千百六" do
    compare_kanji_and_integer("五千百六", 5106)
  end

  it "五千百七" do
    compare_kanji_and_integer("五千百七", 5107)
  end

  it "五千百八" do
    compare_kanji_and_integer("五千百八", 5108)
  end

  it "五千百九" do
    compare_kanji_and_integer("五千百九", 5109)
  end

  it "五千百十" do
    compare_kanji_and_integer("五千百十", 5110)
  end

  it "五千百十一" do
    compare_kanji_and_integer("五千百十一", 5111)
  end

  it "五千百十二" do
    compare_kanji_and_integer("五千百十二", 5112)
  end

  it "五千百十三" do
    compare_kanji_and_integer("五千百十三", 5113)
  end

  it "五千百十四" do
    compare_kanji_and_integer("五千百十四", 5114)
  end

  it "五千百十五" do
    compare_kanji_and_integer("五千百十五", 5115)
  end

  it "五千百十六" do
    compare_kanji_and_integer("五千百十六", 5116)
  end

  it "五千百十七" do
    compare_kanji_and_integer("五千百十七", 5117)
  end

  it "五千百十八" do
    compare_kanji_and_integer("五千百十八", 5118)
  end

  it "五千百十九" do
    compare_kanji_and_integer("五千百十九", 5119)
  end

  it "五千百二十" do
    compare_kanji_and_integer("五千百二十", 5120)
  end

  it "五千百二十一" do
    compare_kanji_and_integer("五千百二十一", 5121)
  end

  it "五千百二十二" do
    compare_kanji_and_integer("五千百二十二", 5122)
  end

  it "五千百二十三" do
    compare_kanji_and_integer("五千百二十三", 5123)
  end

  it "五千百二十四" do
    compare_kanji_and_integer("五千百二十四", 5124)
  end

  it "五千百二十五" do
    compare_kanji_and_integer("五千百二十五", 5125)
  end

  it "五千百二十六" do
    compare_kanji_and_integer("五千百二十六", 5126)
  end

  it "五千百二十七" do
    compare_kanji_and_integer("五千百二十七", 5127)
  end

  it "五千百二十八" do
    compare_kanji_and_integer("五千百二十八", 5128)
  end

  it "五千百二十九" do
    compare_kanji_and_integer("五千百二十九", 5129)
  end

  it "五千百三十" do
    compare_kanji_and_integer("五千百三十", 5130)
  end

  it "五千百三十一" do
    compare_kanji_and_integer("五千百三十一", 5131)
  end

  it "五千百三十二" do
    compare_kanji_and_integer("五千百三十二", 5132)
  end

  it "五千百三十三" do
    compare_kanji_and_integer("五千百三十三", 5133)
  end

  it "五千百三十四" do
    compare_kanji_and_integer("五千百三十四", 5134)
  end

  it "五千百三十五" do
    compare_kanji_and_integer("五千百三十五", 5135)
  end

  it "五千百三十六" do
    compare_kanji_and_integer("五千百三十六", 5136)
  end

  it "五千百三十七" do
    compare_kanji_and_integer("五千百三十七", 5137)
  end

  it "五千百三十八" do
    compare_kanji_and_integer("五千百三十八", 5138)
  end

  it "五千百三十九" do
    compare_kanji_and_integer("五千百三十九", 5139)
  end

  it "五千百四十" do
    compare_kanji_and_integer("五千百四十", 5140)
  end

  it "五千百四十一" do
    compare_kanji_and_integer("五千百四十一", 5141)
  end

  it "五千百四十二" do
    compare_kanji_and_integer("五千百四十二", 5142)
  end

  it "五千百四十三" do
    compare_kanji_and_integer("五千百四十三", 5143)
  end

  it "五千百四十四" do
    compare_kanji_and_integer("五千百四十四", 5144)
  end

  it "五千百四十五" do
    compare_kanji_and_integer("五千百四十五", 5145)
  end

  it "五千百四十六" do
    compare_kanji_and_integer("五千百四十六", 5146)
  end

  it "五千百四十七" do
    compare_kanji_and_integer("五千百四十七", 5147)
  end

  it "五千百四十八" do
    compare_kanji_and_integer("五千百四十八", 5148)
  end

  it "五千百四十九" do
    compare_kanji_and_integer("五千百四十九", 5149)
  end

  it "五千百五十" do
    compare_kanji_and_integer("五千百五十", 5150)
  end

  it "五千百五十一" do
    compare_kanji_and_integer("五千百五十一", 5151)
  end

  it "五千百五十二" do
    compare_kanji_and_integer("五千百五十二", 5152)
  end

  it "五千百五十三" do
    compare_kanji_and_integer("五千百五十三", 5153)
  end

  it "五千百五十四" do
    compare_kanji_and_integer("五千百五十四", 5154)
  end

  it "五千百五十五" do
    compare_kanji_and_integer("五千百五十五", 5155)
  end

  it "五千百五十六" do
    compare_kanji_and_integer("五千百五十六", 5156)
  end

  it "五千百五十七" do
    compare_kanji_and_integer("五千百五十七", 5157)
  end

  it "五千百五十八" do
    compare_kanji_and_integer("五千百五十八", 5158)
  end

  it "五千百五十九" do
    compare_kanji_and_integer("五千百五十九", 5159)
  end

  it "五千百六十" do
    compare_kanji_and_integer("五千百六十", 5160)
  end

  it "五千百六十一" do
    compare_kanji_and_integer("五千百六十一", 5161)
  end

  it "五千百六十二" do
    compare_kanji_and_integer("五千百六十二", 5162)
  end

  it "五千百六十三" do
    compare_kanji_and_integer("五千百六十三", 5163)
  end

  it "五千百六十四" do
    compare_kanji_and_integer("五千百六十四", 5164)
  end

  it "五千百六十五" do
    compare_kanji_and_integer("五千百六十五", 5165)
  end

  it "五千百六十六" do
    compare_kanji_and_integer("五千百六十六", 5166)
  end

  it "五千百六十七" do
    compare_kanji_and_integer("五千百六十七", 5167)
  end

  it "五千百六十八" do
    compare_kanji_and_integer("五千百六十八", 5168)
  end

  it "五千百六十九" do
    compare_kanji_and_integer("五千百六十九", 5169)
  end

  it "五千百七十" do
    compare_kanji_and_integer("五千百七十", 5170)
  end

  it "五千百七十一" do
    compare_kanji_and_integer("五千百七十一", 5171)
  end

  it "五千百七十二" do
    compare_kanji_and_integer("五千百七十二", 5172)
  end

  it "五千百七十三" do
    compare_kanji_and_integer("五千百七十三", 5173)
  end

  it "五千百七十四" do
    compare_kanji_and_integer("五千百七十四", 5174)
  end

  it "五千百七十五" do
    compare_kanji_and_integer("五千百七十五", 5175)
  end

  it "五千百七十六" do
    compare_kanji_and_integer("五千百七十六", 5176)
  end

  it "五千百七十七" do
    compare_kanji_and_integer("五千百七十七", 5177)
  end

  it "五千百七十八" do
    compare_kanji_and_integer("五千百七十八", 5178)
  end

  it "五千百七十九" do
    compare_kanji_and_integer("五千百七十九", 5179)
  end

  it "五千百八十" do
    compare_kanji_and_integer("五千百八十", 5180)
  end

  it "五千百八十一" do
    compare_kanji_and_integer("五千百八十一", 5181)
  end

  it "五千百八十二" do
    compare_kanji_and_integer("五千百八十二", 5182)
  end

  it "五千百八十三" do
    compare_kanji_and_integer("五千百八十三", 5183)
  end

  it "五千百八十四" do
    compare_kanji_and_integer("五千百八十四", 5184)
  end

  it "五千百八十五" do
    compare_kanji_and_integer("五千百八十五", 5185)
  end

  it "五千百八十六" do
    compare_kanji_and_integer("五千百八十六", 5186)
  end

  it "五千百八十七" do
    compare_kanji_and_integer("五千百八十七", 5187)
  end

  it "五千百八十八" do
    compare_kanji_and_integer("五千百八十八", 5188)
  end

  it "五千百八十九" do
    compare_kanji_and_integer("五千百八十九", 5189)
  end

  it "五千百九十" do
    compare_kanji_and_integer("五千百九十", 5190)
  end

  it "五千百九十一" do
    compare_kanji_and_integer("五千百九十一", 5191)
  end

  it "五千百九十二" do
    compare_kanji_and_integer("五千百九十二", 5192)
  end

  it "五千百九十三" do
    compare_kanji_and_integer("五千百九十三", 5193)
  end

  it "五千百九十四" do
    compare_kanji_and_integer("五千百九十四", 5194)
  end

  it "五千百九十五" do
    compare_kanji_and_integer("五千百九十五", 5195)
  end

  it "五千百九十六" do
    compare_kanji_and_integer("五千百九十六", 5196)
  end

  it "五千百九十七" do
    compare_kanji_and_integer("五千百九十七", 5197)
  end

  it "五千百九十八" do
    compare_kanji_and_integer("五千百九十八", 5198)
  end

  it "五千百九十九" do
    compare_kanji_and_integer("五千百九十九", 5199)
  end

  it "五千二百" do
    compare_kanji_and_integer("五千二百", 5200)
  end

  it "五千二百一" do
    compare_kanji_and_integer("五千二百一", 5201)
  end

  it "五千二百二" do
    compare_kanji_and_integer("五千二百二", 5202)
  end

  it "五千二百三" do
    compare_kanji_and_integer("五千二百三", 5203)
  end

  it "五千二百四" do
    compare_kanji_and_integer("五千二百四", 5204)
  end

  it "五千二百五" do
    compare_kanji_and_integer("五千二百五", 5205)
  end

  it "五千二百六" do
    compare_kanji_and_integer("五千二百六", 5206)
  end

  it "五千二百七" do
    compare_kanji_and_integer("五千二百七", 5207)
  end

  it "五千二百八" do
    compare_kanji_and_integer("五千二百八", 5208)
  end

  it "五千二百九" do
    compare_kanji_and_integer("五千二百九", 5209)
  end

  it "五千二百十" do
    compare_kanji_and_integer("五千二百十", 5210)
  end

  it "五千二百十一" do
    compare_kanji_and_integer("五千二百十一", 5211)
  end

  it "五千二百十二" do
    compare_kanji_and_integer("五千二百十二", 5212)
  end

  it "五千二百十三" do
    compare_kanji_and_integer("五千二百十三", 5213)
  end

  it "五千二百十四" do
    compare_kanji_and_integer("五千二百十四", 5214)
  end

  it "五千二百十五" do
    compare_kanji_and_integer("五千二百十五", 5215)
  end

  it "五千二百十六" do
    compare_kanji_and_integer("五千二百十六", 5216)
  end

  it "五千二百十七" do
    compare_kanji_and_integer("五千二百十七", 5217)
  end

  it "五千二百十八" do
    compare_kanji_and_integer("五千二百十八", 5218)
  end

  it "五千二百十九" do
    compare_kanji_and_integer("五千二百十九", 5219)
  end

  it "五千二百二十" do
    compare_kanji_and_integer("五千二百二十", 5220)
  end

  it "五千二百二十一" do
    compare_kanji_and_integer("五千二百二十一", 5221)
  end

  it "五千二百二十二" do
    compare_kanji_and_integer("五千二百二十二", 5222)
  end

  it "五千二百二十三" do
    compare_kanji_and_integer("五千二百二十三", 5223)
  end

  it "五千二百二十四" do
    compare_kanji_and_integer("五千二百二十四", 5224)
  end

  it "五千二百二十五" do
    compare_kanji_and_integer("五千二百二十五", 5225)
  end

  it "五千二百二十六" do
    compare_kanji_and_integer("五千二百二十六", 5226)
  end

  it "五千二百二十七" do
    compare_kanji_and_integer("五千二百二十七", 5227)
  end

  it "五千二百二十八" do
    compare_kanji_and_integer("五千二百二十八", 5228)
  end

  it "五千二百二十九" do
    compare_kanji_and_integer("五千二百二十九", 5229)
  end

  it "五千二百三十" do
    compare_kanji_and_integer("五千二百三十", 5230)
  end

  it "五千二百三十一" do
    compare_kanji_and_integer("五千二百三十一", 5231)
  end

  it "五千二百三十二" do
    compare_kanji_and_integer("五千二百三十二", 5232)
  end

  it "五千二百三十三" do
    compare_kanji_and_integer("五千二百三十三", 5233)
  end

  it "五千二百三十四" do
    compare_kanji_and_integer("五千二百三十四", 5234)
  end

  it "五千二百三十五" do
    compare_kanji_and_integer("五千二百三十五", 5235)
  end

  it "五千二百三十六" do
    compare_kanji_and_integer("五千二百三十六", 5236)
  end

  it "五千二百三十七" do
    compare_kanji_and_integer("五千二百三十七", 5237)
  end

  it "五千二百三十八" do
    compare_kanji_and_integer("五千二百三十八", 5238)
  end

  it "五千二百三十九" do
    compare_kanji_and_integer("五千二百三十九", 5239)
  end

  it "五千二百四十" do
    compare_kanji_and_integer("五千二百四十", 5240)
  end

  it "五千二百四十一" do
    compare_kanji_and_integer("五千二百四十一", 5241)
  end

  it "五千二百四十二" do
    compare_kanji_and_integer("五千二百四十二", 5242)
  end

  it "五千二百四十三" do
    compare_kanji_and_integer("五千二百四十三", 5243)
  end

  it "五千二百四十四" do
    compare_kanji_and_integer("五千二百四十四", 5244)
  end

  it "五千二百四十五" do
    compare_kanji_and_integer("五千二百四十五", 5245)
  end

  it "五千二百四十六" do
    compare_kanji_and_integer("五千二百四十六", 5246)
  end

  it "五千二百四十七" do
    compare_kanji_and_integer("五千二百四十七", 5247)
  end

  it "五千二百四十八" do
    compare_kanji_and_integer("五千二百四十八", 5248)
  end

  it "五千二百四十九" do
    compare_kanji_and_integer("五千二百四十九", 5249)
  end

  it "五千二百五十" do
    compare_kanji_and_integer("五千二百五十", 5250)
  end

  it "五千二百五十一" do
    compare_kanji_and_integer("五千二百五十一", 5251)
  end

  it "五千二百五十二" do
    compare_kanji_and_integer("五千二百五十二", 5252)
  end

  it "五千二百五十三" do
    compare_kanji_and_integer("五千二百五十三", 5253)
  end

  it "五千二百五十四" do
    compare_kanji_and_integer("五千二百五十四", 5254)
  end

  it "五千二百五十五" do
    compare_kanji_and_integer("五千二百五十五", 5255)
  end

  it "五千二百五十六" do
    compare_kanji_and_integer("五千二百五十六", 5256)
  end

  it "五千二百五十七" do
    compare_kanji_and_integer("五千二百五十七", 5257)
  end

  it "五千二百五十八" do
    compare_kanji_and_integer("五千二百五十八", 5258)
  end

  it "五千二百五十九" do
    compare_kanji_and_integer("五千二百五十九", 5259)
  end

  it "五千二百六十" do
    compare_kanji_and_integer("五千二百六十", 5260)
  end

  it "五千二百六十一" do
    compare_kanji_and_integer("五千二百六十一", 5261)
  end

  it "五千二百六十二" do
    compare_kanji_and_integer("五千二百六十二", 5262)
  end

  it "五千二百六十三" do
    compare_kanji_and_integer("五千二百六十三", 5263)
  end

  it "五千二百六十四" do
    compare_kanji_and_integer("五千二百六十四", 5264)
  end

  it "五千二百六十五" do
    compare_kanji_and_integer("五千二百六十五", 5265)
  end

  it "五千二百六十六" do
    compare_kanji_and_integer("五千二百六十六", 5266)
  end

  it "五千二百六十七" do
    compare_kanji_and_integer("五千二百六十七", 5267)
  end

  it "五千二百六十八" do
    compare_kanji_and_integer("五千二百六十八", 5268)
  end

  it "五千二百六十九" do
    compare_kanji_and_integer("五千二百六十九", 5269)
  end

  it "五千二百七十" do
    compare_kanji_and_integer("五千二百七十", 5270)
  end

  it "五千二百七十一" do
    compare_kanji_and_integer("五千二百七十一", 5271)
  end

  it "五千二百七十二" do
    compare_kanji_and_integer("五千二百七十二", 5272)
  end

  it "五千二百七十三" do
    compare_kanji_and_integer("五千二百七十三", 5273)
  end

  it "五千二百七十四" do
    compare_kanji_and_integer("五千二百七十四", 5274)
  end

  it "五千二百七十五" do
    compare_kanji_and_integer("五千二百七十五", 5275)
  end

  it "五千二百七十六" do
    compare_kanji_and_integer("五千二百七十六", 5276)
  end

  it "五千二百七十七" do
    compare_kanji_and_integer("五千二百七十七", 5277)
  end

  it "五千二百七十八" do
    compare_kanji_and_integer("五千二百七十八", 5278)
  end

  it "五千二百七十九" do
    compare_kanji_and_integer("五千二百七十九", 5279)
  end

  it "五千二百八十" do
    compare_kanji_and_integer("五千二百八十", 5280)
  end

  it "五千二百八十一" do
    compare_kanji_and_integer("五千二百八十一", 5281)
  end

  it "五千二百八十二" do
    compare_kanji_and_integer("五千二百八十二", 5282)
  end

  it "五千二百八十三" do
    compare_kanji_and_integer("五千二百八十三", 5283)
  end

  it "五千二百八十四" do
    compare_kanji_and_integer("五千二百八十四", 5284)
  end

  it "五千二百八十五" do
    compare_kanji_and_integer("五千二百八十五", 5285)
  end

  it "五千二百八十六" do
    compare_kanji_and_integer("五千二百八十六", 5286)
  end

  it "五千二百八十七" do
    compare_kanji_and_integer("五千二百八十七", 5287)
  end

  it "五千二百八十八" do
    compare_kanji_and_integer("五千二百八十八", 5288)
  end

  it "五千二百八十九" do
    compare_kanji_and_integer("五千二百八十九", 5289)
  end

  it "五千二百九十" do
    compare_kanji_and_integer("五千二百九十", 5290)
  end

  it "五千二百九十一" do
    compare_kanji_and_integer("五千二百九十一", 5291)
  end

  it "五千二百九十二" do
    compare_kanji_and_integer("五千二百九十二", 5292)
  end

  it "五千二百九十三" do
    compare_kanji_and_integer("五千二百九十三", 5293)
  end

  it "五千二百九十四" do
    compare_kanji_and_integer("五千二百九十四", 5294)
  end

  it "五千二百九十五" do
    compare_kanji_and_integer("五千二百九十五", 5295)
  end

  it "五千二百九十六" do
    compare_kanji_and_integer("五千二百九十六", 5296)
  end

  it "五千二百九十七" do
    compare_kanji_and_integer("五千二百九十七", 5297)
  end

  it "五千二百九十八" do
    compare_kanji_and_integer("五千二百九十八", 5298)
  end

  it "五千二百九十九" do
    compare_kanji_and_integer("五千二百九十九", 5299)
  end

  it "五千三百" do
    compare_kanji_and_integer("五千三百", 5300)
  end

  it "五千三百一" do
    compare_kanji_and_integer("五千三百一", 5301)
  end

  it "五千三百二" do
    compare_kanji_and_integer("五千三百二", 5302)
  end

  it "五千三百三" do
    compare_kanji_and_integer("五千三百三", 5303)
  end

  it "五千三百四" do
    compare_kanji_and_integer("五千三百四", 5304)
  end

  it "五千三百五" do
    compare_kanji_and_integer("五千三百五", 5305)
  end

  it "五千三百六" do
    compare_kanji_and_integer("五千三百六", 5306)
  end

  it "五千三百七" do
    compare_kanji_and_integer("五千三百七", 5307)
  end

  it "五千三百八" do
    compare_kanji_and_integer("五千三百八", 5308)
  end

  it "五千三百九" do
    compare_kanji_and_integer("五千三百九", 5309)
  end

  it "五千三百十" do
    compare_kanji_and_integer("五千三百十", 5310)
  end

  it "五千三百十一" do
    compare_kanji_and_integer("五千三百十一", 5311)
  end

  it "五千三百十二" do
    compare_kanji_and_integer("五千三百十二", 5312)
  end

  it "五千三百十三" do
    compare_kanji_and_integer("五千三百十三", 5313)
  end

  it "五千三百十四" do
    compare_kanji_and_integer("五千三百十四", 5314)
  end

  it "五千三百十五" do
    compare_kanji_and_integer("五千三百十五", 5315)
  end

  it "五千三百十六" do
    compare_kanji_and_integer("五千三百十六", 5316)
  end

  it "五千三百十七" do
    compare_kanji_and_integer("五千三百十七", 5317)
  end

  it "五千三百十八" do
    compare_kanji_and_integer("五千三百十八", 5318)
  end

  it "五千三百十九" do
    compare_kanji_and_integer("五千三百十九", 5319)
  end

  it "五千三百二十" do
    compare_kanji_and_integer("五千三百二十", 5320)
  end

  it "五千三百二十一" do
    compare_kanji_and_integer("五千三百二十一", 5321)
  end

  it "五千三百二十二" do
    compare_kanji_and_integer("五千三百二十二", 5322)
  end

  it "五千三百二十三" do
    compare_kanji_and_integer("五千三百二十三", 5323)
  end

  it "五千三百二十四" do
    compare_kanji_and_integer("五千三百二十四", 5324)
  end

  it "五千三百二十五" do
    compare_kanji_and_integer("五千三百二十五", 5325)
  end

  it "五千三百二十六" do
    compare_kanji_and_integer("五千三百二十六", 5326)
  end

  it "五千三百二十七" do
    compare_kanji_and_integer("五千三百二十七", 5327)
  end

  it "五千三百二十八" do
    compare_kanji_and_integer("五千三百二十八", 5328)
  end

  it "五千三百二十九" do
    compare_kanji_and_integer("五千三百二十九", 5329)
  end

  it "五千三百三十" do
    compare_kanji_and_integer("五千三百三十", 5330)
  end

  it "五千三百三十一" do
    compare_kanji_and_integer("五千三百三十一", 5331)
  end

  it "五千三百三十二" do
    compare_kanji_and_integer("五千三百三十二", 5332)
  end

  it "五千三百三十三" do
    compare_kanji_and_integer("五千三百三十三", 5333)
  end

  it "五千三百三十四" do
    compare_kanji_and_integer("五千三百三十四", 5334)
  end

  it "五千三百三十五" do
    compare_kanji_and_integer("五千三百三十五", 5335)
  end

  it "五千三百三十六" do
    compare_kanji_and_integer("五千三百三十六", 5336)
  end

  it "五千三百三十七" do
    compare_kanji_and_integer("五千三百三十七", 5337)
  end

  it "五千三百三十八" do
    compare_kanji_and_integer("五千三百三十八", 5338)
  end

  it "五千三百三十九" do
    compare_kanji_and_integer("五千三百三十九", 5339)
  end

  it "五千三百四十" do
    compare_kanji_and_integer("五千三百四十", 5340)
  end

  it "五千三百四十一" do
    compare_kanji_and_integer("五千三百四十一", 5341)
  end

  it "五千三百四十二" do
    compare_kanji_and_integer("五千三百四十二", 5342)
  end

  it "五千三百四十三" do
    compare_kanji_and_integer("五千三百四十三", 5343)
  end

  it "五千三百四十四" do
    compare_kanji_and_integer("五千三百四十四", 5344)
  end

  it "五千三百四十五" do
    compare_kanji_and_integer("五千三百四十五", 5345)
  end

  it "五千三百四十六" do
    compare_kanji_and_integer("五千三百四十六", 5346)
  end

  it "五千三百四十七" do
    compare_kanji_and_integer("五千三百四十七", 5347)
  end

  it "五千三百四十八" do
    compare_kanji_and_integer("五千三百四十八", 5348)
  end

  it "五千三百四十九" do
    compare_kanji_and_integer("五千三百四十九", 5349)
  end

  it "五千三百五十" do
    compare_kanji_and_integer("五千三百五十", 5350)
  end

  it "五千三百五十一" do
    compare_kanji_and_integer("五千三百五十一", 5351)
  end

  it "五千三百五十二" do
    compare_kanji_and_integer("五千三百五十二", 5352)
  end

  it "五千三百五十三" do
    compare_kanji_and_integer("五千三百五十三", 5353)
  end

  it "五千三百五十四" do
    compare_kanji_and_integer("五千三百五十四", 5354)
  end

  it "五千三百五十五" do
    compare_kanji_and_integer("五千三百五十五", 5355)
  end

  it "五千三百五十六" do
    compare_kanji_and_integer("五千三百五十六", 5356)
  end

  it "五千三百五十七" do
    compare_kanji_and_integer("五千三百五十七", 5357)
  end

  it "五千三百五十八" do
    compare_kanji_and_integer("五千三百五十八", 5358)
  end

  it "五千三百五十九" do
    compare_kanji_and_integer("五千三百五十九", 5359)
  end

  it "五千三百六十" do
    compare_kanji_and_integer("五千三百六十", 5360)
  end

  it "五千三百六十一" do
    compare_kanji_and_integer("五千三百六十一", 5361)
  end

  it "五千三百六十二" do
    compare_kanji_and_integer("五千三百六十二", 5362)
  end

  it "五千三百六十三" do
    compare_kanji_and_integer("五千三百六十三", 5363)
  end

  it "五千三百六十四" do
    compare_kanji_and_integer("五千三百六十四", 5364)
  end

  it "五千三百六十五" do
    compare_kanji_and_integer("五千三百六十五", 5365)
  end

  it "五千三百六十六" do
    compare_kanji_and_integer("五千三百六十六", 5366)
  end

  it "五千三百六十七" do
    compare_kanji_and_integer("五千三百六十七", 5367)
  end

  it "五千三百六十八" do
    compare_kanji_and_integer("五千三百六十八", 5368)
  end

  it "五千三百六十九" do
    compare_kanji_and_integer("五千三百六十九", 5369)
  end

  it "五千三百七十" do
    compare_kanji_and_integer("五千三百七十", 5370)
  end

  it "五千三百七十一" do
    compare_kanji_and_integer("五千三百七十一", 5371)
  end

  it "五千三百七十二" do
    compare_kanji_and_integer("五千三百七十二", 5372)
  end

  it "五千三百七十三" do
    compare_kanji_and_integer("五千三百七十三", 5373)
  end

  it "五千三百七十四" do
    compare_kanji_and_integer("五千三百七十四", 5374)
  end

  it "五千三百七十五" do
    compare_kanji_and_integer("五千三百七十五", 5375)
  end

  it "五千三百七十六" do
    compare_kanji_and_integer("五千三百七十六", 5376)
  end

  it "五千三百七十七" do
    compare_kanji_and_integer("五千三百七十七", 5377)
  end

  it "五千三百七十八" do
    compare_kanji_and_integer("五千三百七十八", 5378)
  end

  it "五千三百七十九" do
    compare_kanji_and_integer("五千三百七十九", 5379)
  end

  it "五千三百八十" do
    compare_kanji_and_integer("五千三百八十", 5380)
  end

  it "五千三百八十一" do
    compare_kanji_and_integer("五千三百八十一", 5381)
  end

  it "五千三百八十二" do
    compare_kanji_and_integer("五千三百八十二", 5382)
  end

  it "五千三百八十三" do
    compare_kanji_and_integer("五千三百八十三", 5383)
  end

  it "五千三百八十四" do
    compare_kanji_and_integer("五千三百八十四", 5384)
  end

  it "五千三百八十五" do
    compare_kanji_and_integer("五千三百八十五", 5385)
  end

  it "五千三百八十六" do
    compare_kanji_and_integer("五千三百八十六", 5386)
  end

  it "五千三百八十七" do
    compare_kanji_and_integer("五千三百八十七", 5387)
  end

  it "五千三百八十八" do
    compare_kanji_and_integer("五千三百八十八", 5388)
  end

  it "五千三百八十九" do
    compare_kanji_and_integer("五千三百八十九", 5389)
  end

  it "五千三百九十" do
    compare_kanji_and_integer("五千三百九十", 5390)
  end

  it "五千三百九十一" do
    compare_kanji_and_integer("五千三百九十一", 5391)
  end

  it "五千三百九十二" do
    compare_kanji_and_integer("五千三百九十二", 5392)
  end

  it "五千三百九十三" do
    compare_kanji_and_integer("五千三百九十三", 5393)
  end

  it "五千三百九十四" do
    compare_kanji_and_integer("五千三百九十四", 5394)
  end

  it "五千三百九十五" do
    compare_kanji_and_integer("五千三百九十五", 5395)
  end

  it "五千三百九十六" do
    compare_kanji_and_integer("五千三百九十六", 5396)
  end

  it "五千三百九十七" do
    compare_kanji_and_integer("五千三百九十七", 5397)
  end

  it "五千三百九十八" do
    compare_kanji_and_integer("五千三百九十八", 5398)
  end

  it "五千三百九十九" do
    compare_kanji_and_integer("五千三百九十九", 5399)
  end

  it "五千四百" do
    compare_kanji_and_integer("五千四百", 5400)
  end

  it "五千四百一" do
    compare_kanji_and_integer("五千四百一", 5401)
  end

  it "五千四百二" do
    compare_kanji_and_integer("五千四百二", 5402)
  end

  it "五千四百三" do
    compare_kanji_and_integer("五千四百三", 5403)
  end

  it "五千四百四" do
    compare_kanji_and_integer("五千四百四", 5404)
  end

  it "五千四百五" do
    compare_kanji_and_integer("五千四百五", 5405)
  end

  it "五千四百六" do
    compare_kanji_and_integer("五千四百六", 5406)
  end

  it "五千四百七" do
    compare_kanji_and_integer("五千四百七", 5407)
  end

  it "五千四百八" do
    compare_kanji_and_integer("五千四百八", 5408)
  end

  it "五千四百九" do
    compare_kanji_and_integer("五千四百九", 5409)
  end

  it "五千四百十" do
    compare_kanji_and_integer("五千四百十", 5410)
  end

  it "五千四百十一" do
    compare_kanji_and_integer("五千四百十一", 5411)
  end

  it "五千四百十二" do
    compare_kanji_and_integer("五千四百十二", 5412)
  end

  it "五千四百十三" do
    compare_kanji_and_integer("五千四百十三", 5413)
  end

  it "五千四百十四" do
    compare_kanji_and_integer("五千四百十四", 5414)
  end

  it "五千四百十五" do
    compare_kanji_and_integer("五千四百十五", 5415)
  end

  it "五千四百十六" do
    compare_kanji_and_integer("五千四百十六", 5416)
  end

  it "五千四百十七" do
    compare_kanji_and_integer("五千四百十七", 5417)
  end

  it "五千四百十八" do
    compare_kanji_and_integer("五千四百十八", 5418)
  end

  it "五千四百十九" do
    compare_kanji_and_integer("五千四百十九", 5419)
  end

  it "五千四百二十" do
    compare_kanji_and_integer("五千四百二十", 5420)
  end

  it "五千四百二十一" do
    compare_kanji_and_integer("五千四百二十一", 5421)
  end

  it "五千四百二十二" do
    compare_kanji_and_integer("五千四百二十二", 5422)
  end

  it "五千四百二十三" do
    compare_kanji_and_integer("五千四百二十三", 5423)
  end

  it "五千四百二十四" do
    compare_kanji_and_integer("五千四百二十四", 5424)
  end

  it "五千四百二十五" do
    compare_kanji_and_integer("五千四百二十五", 5425)
  end

  it "五千四百二十六" do
    compare_kanji_and_integer("五千四百二十六", 5426)
  end

  it "五千四百二十七" do
    compare_kanji_and_integer("五千四百二十七", 5427)
  end

  it "五千四百二十八" do
    compare_kanji_and_integer("五千四百二十八", 5428)
  end

  it "五千四百二十九" do
    compare_kanji_and_integer("五千四百二十九", 5429)
  end

  it "五千四百三十" do
    compare_kanji_and_integer("五千四百三十", 5430)
  end

  it "五千四百三十一" do
    compare_kanji_and_integer("五千四百三十一", 5431)
  end

  it "五千四百三十二" do
    compare_kanji_and_integer("五千四百三十二", 5432)
  end

  it "五千四百三十三" do
    compare_kanji_and_integer("五千四百三十三", 5433)
  end

  it "五千四百三十四" do
    compare_kanji_and_integer("五千四百三十四", 5434)
  end

  it "五千四百三十五" do
    compare_kanji_and_integer("五千四百三十五", 5435)
  end

  it "五千四百三十六" do
    compare_kanji_and_integer("五千四百三十六", 5436)
  end

  it "五千四百三十七" do
    compare_kanji_and_integer("五千四百三十七", 5437)
  end

  it "五千四百三十八" do
    compare_kanji_and_integer("五千四百三十八", 5438)
  end

  it "五千四百三十九" do
    compare_kanji_and_integer("五千四百三十九", 5439)
  end

  it "五千四百四十" do
    compare_kanji_and_integer("五千四百四十", 5440)
  end

  it "五千四百四十一" do
    compare_kanji_and_integer("五千四百四十一", 5441)
  end

  it "五千四百四十二" do
    compare_kanji_and_integer("五千四百四十二", 5442)
  end

  it "五千四百四十三" do
    compare_kanji_and_integer("五千四百四十三", 5443)
  end

  it "五千四百四十四" do
    compare_kanji_and_integer("五千四百四十四", 5444)
  end

  it "五千四百四十五" do
    compare_kanji_and_integer("五千四百四十五", 5445)
  end

  it "五千四百四十六" do
    compare_kanji_and_integer("五千四百四十六", 5446)
  end

  it "五千四百四十七" do
    compare_kanji_and_integer("五千四百四十七", 5447)
  end

  it "五千四百四十八" do
    compare_kanji_and_integer("五千四百四十八", 5448)
  end

  it "五千四百四十九" do
    compare_kanji_and_integer("五千四百四十九", 5449)
  end

  it "五千四百五十" do
    compare_kanji_and_integer("五千四百五十", 5450)
  end

  it "五千四百五十一" do
    compare_kanji_and_integer("五千四百五十一", 5451)
  end

  it "五千四百五十二" do
    compare_kanji_and_integer("五千四百五十二", 5452)
  end

  it "五千四百五十三" do
    compare_kanji_and_integer("五千四百五十三", 5453)
  end

  it "五千四百五十四" do
    compare_kanji_and_integer("五千四百五十四", 5454)
  end

  it "五千四百五十五" do
    compare_kanji_and_integer("五千四百五十五", 5455)
  end

  it "五千四百五十六" do
    compare_kanji_and_integer("五千四百五十六", 5456)
  end

  it "五千四百五十七" do
    compare_kanji_and_integer("五千四百五十七", 5457)
  end

  it "五千四百五十八" do
    compare_kanji_and_integer("五千四百五十八", 5458)
  end

  it "五千四百五十九" do
    compare_kanji_and_integer("五千四百五十九", 5459)
  end

  it "五千四百六十" do
    compare_kanji_and_integer("五千四百六十", 5460)
  end

  it "五千四百六十一" do
    compare_kanji_and_integer("五千四百六十一", 5461)
  end

  it "五千四百六十二" do
    compare_kanji_and_integer("五千四百六十二", 5462)
  end

  it "五千四百六十三" do
    compare_kanji_and_integer("五千四百六十三", 5463)
  end

  it "五千四百六十四" do
    compare_kanji_and_integer("五千四百六十四", 5464)
  end

  it "五千四百六十五" do
    compare_kanji_and_integer("五千四百六十五", 5465)
  end

  it "五千四百六十六" do
    compare_kanji_and_integer("五千四百六十六", 5466)
  end

  it "五千四百六十七" do
    compare_kanji_and_integer("五千四百六十七", 5467)
  end

  it "五千四百六十八" do
    compare_kanji_and_integer("五千四百六十八", 5468)
  end

  it "五千四百六十九" do
    compare_kanji_and_integer("五千四百六十九", 5469)
  end

  it "五千四百七十" do
    compare_kanji_and_integer("五千四百七十", 5470)
  end

  it "五千四百七十一" do
    compare_kanji_and_integer("五千四百七十一", 5471)
  end

  it "五千四百七十二" do
    compare_kanji_and_integer("五千四百七十二", 5472)
  end

  it "五千四百七十三" do
    compare_kanji_and_integer("五千四百七十三", 5473)
  end

  it "五千四百七十四" do
    compare_kanji_and_integer("五千四百七十四", 5474)
  end

  it "五千四百七十五" do
    compare_kanji_and_integer("五千四百七十五", 5475)
  end

  it "五千四百七十六" do
    compare_kanji_and_integer("五千四百七十六", 5476)
  end

  it "五千四百七十七" do
    compare_kanji_and_integer("五千四百七十七", 5477)
  end

  it "五千四百七十八" do
    compare_kanji_and_integer("五千四百七十八", 5478)
  end

  it "五千四百七十九" do
    compare_kanji_and_integer("五千四百七十九", 5479)
  end

  it "五千四百八十" do
    compare_kanji_and_integer("五千四百八十", 5480)
  end

  it "五千四百八十一" do
    compare_kanji_and_integer("五千四百八十一", 5481)
  end

  it "五千四百八十二" do
    compare_kanji_and_integer("五千四百八十二", 5482)
  end

  it "五千四百八十三" do
    compare_kanji_and_integer("五千四百八十三", 5483)
  end

  it "五千四百八十四" do
    compare_kanji_and_integer("五千四百八十四", 5484)
  end

  it "五千四百八十五" do
    compare_kanji_and_integer("五千四百八十五", 5485)
  end

  it "五千四百八十六" do
    compare_kanji_and_integer("五千四百八十六", 5486)
  end

  it "五千四百八十七" do
    compare_kanji_and_integer("五千四百八十七", 5487)
  end

  it "五千四百八十八" do
    compare_kanji_and_integer("五千四百八十八", 5488)
  end

  it "五千四百八十九" do
    compare_kanji_and_integer("五千四百八十九", 5489)
  end

  it "五千四百九十" do
    compare_kanji_and_integer("五千四百九十", 5490)
  end

  it "五千四百九十一" do
    compare_kanji_and_integer("五千四百九十一", 5491)
  end

  it "五千四百九十二" do
    compare_kanji_and_integer("五千四百九十二", 5492)
  end

  it "五千四百九十三" do
    compare_kanji_and_integer("五千四百九十三", 5493)
  end

  it "五千四百九十四" do
    compare_kanji_and_integer("五千四百九十四", 5494)
  end

  it "五千四百九十五" do
    compare_kanji_and_integer("五千四百九十五", 5495)
  end

  it "五千四百九十六" do
    compare_kanji_and_integer("五千四百九十六", 5496)
  end

  it "五千四百九十七" do
    compare_kanji_and_integer("五千四百九十七", 5497)
  end

  it "五千四百九十八" do
    compare_kanji_and_integer("五千四百九十八", 5498)
  end

  it "五千四百九十九" do
    compare_kanji_and_integer("五千四百九十九", 5499)
  end

  it "五千五百" do
    compare_kanji_and_integer("五千五百", 5500)
  end

  it "五千五百一" do
    compare_kanji_and_integer("五千五百一", 5501)
  end

  it "五千五百二" do
    compare_kanji_and_integer("五千五百二", 5502)
  end

  it "五千五百三" do
    compare_kanji_and_integer("五千五百三", 5503)
  end

  it "五千五百四" do
    compare_kanji_and_integer("五千五百四", 5504)
  end

  it "五千五百五" do
    compare_kanji_and_integer("五千五百五", 5505)
  end

  it "五千五百六" do
    compare_kanji_and_integer("五千五百六", 5506)
  end

  it "五千五百七" do
    compare_kanji_and_integer("五千五百七", 5507)
  end

  it "五千五百八" do
    compare_kanji_and_integer("五千五百八", 5508)
  end

  it "五千五百九" do
    compare_kanji_and_integer("五千五百九", 5509)
  end

  it "五千五百十" do
    compare_kanji_and_integer("五千五百十", 5510)
  end

  it "五千五百十一" do
    compare_kanji_and_integer("五千五百十一", 5511)
  end

  it "五千五百十二" do
    compare_kanji_and_integer("五千五百十二", 5512)
  end

  it "五千五百十三" do
    compare_kanji_and_integer("五千五百十三", 5513)
  end

  it "五千五百十四" do
    compare_kanji_and_integer("五千五百十四", 5514)
  end

  it "五千五百十五" do
    compare_kanji_and_integer("五千五百十五", 5515)
  end

  it "五千五百十六" do
    compare_kanji_and_integer("五千五百十六", 5516)
  end

  it "五千五百十七" do
    compare_kanji_and_integer("五千五百十七", 5517)
  end

  it "五千五百十八" do
    compare_kanji_and_integer("五千五百十八", 5518)
  end

  it "五千五百十九" do
    compare_kanji_and_integer("五千五百十九", 5519)
  end

  it "五千五百二十" do
    compare_kanji_and_integer("五千五百二十", 5520)
  end

  it "五千五百二十一" do
    compare_kanji_and_integer("五千五百二十一", 5521)
  end

  it "五千五百二十二" do
    compare_kanji_and_integer("五千五百二十二", 5522)
  end

  it "五千五百二十三" do
    compare_kanji_and_integer("五千五百二十三", 5523)
  end

  it "五千五百二十四" do
    compare_kanji_and_integer("五千五百二十四", 5524)
  end

  it "五千五百二十五" do
    compare_kanji_and_integer("五千五百二十五", 5525)
  end

  it "五千五百二十六" do
    compare_kanji_and_integer("五千五百二十六", 5526)
  end

  it "五千五百二十七" do
    compare_kanji_and_integer("五千五百二十七", 5527)
  end

  it "五千五百二十八" do
    compare_kanji_and_integer("五千五百二十八", 5528)
  end

  it "五千五百二十九" do
    compare_kanji_and_integer("五千五百二十九", 5529)
  end

  it "五千五百三十" do
    compare_kanji_and_integer("五千五百三十", 5530)
  end

  it "五千五百三十一" do
    compare_kanji_and_integer("五千五百三十一", 5531)
  end

  it "五千五百三十二" do
    compare_kanji_and_integer("五千五百三十二", 5532)
  end

  it "五千五百三十三" do
    compare_kanji_and_integer("五千五百三十三", 5533)
  end

  it "五千五百三十四" do
    compare_kanji_and_integer("五千五百三十四", 5534)
  end

  it "五千五百三十五" do
    compare_kanji_and_integer("五千五百三十五", 5535)
  end

  it "五千五百三十六" do
    compare_kanji_and_integer("五千五百三十六", 5536)
  end

  it "五千五百三十七" do
    compare_kanji_and_integer("五千五百三十七", 5537)
  end

  it "五千五百三十八" do
    compare_kanji_and_integer("五千五百三十八", 5538)
  end

  it "五千五百三十九" do
    compare_kanji_and_integer("五千五百三十九", 5539)
  end

  it "五千五百四十" do
    compare_kanji_and_integer("五千五百四十", 5540)
  end

  it "五千五百四十一" do
    compare_kanji_and_integer("五千五百四十一", 5541)
  end

  it "五千五百四十二" do
    compare_kanji_and_integer("五千五百四十二", 5542)
  end

  it "五千五百四十三" do
    compare_kanji_and_integer("五千五百四十三", 5543)
  end

  it "五千五百四十四" do
    compare_kanji_and_integer("五千五百四十四", 5544)
  end

  it "五千五百四十五" do
    compare_kanji_and_integer("五千五百四十五", 5545)
  end

  it "五千五百四十六" do
    compare_kanji_and_integer("五千五百四十六", 5546)
  end

  it "五千五百四十七" do
    compare_kanji_and_integer("五千五百四十七", 5547)
  end

  it "五千五百四十八" do
    compare_kanji_and_integer("五千五百四十八", 5548)
  end

  it "五千五百四十九" do
    compare_kanji_and_integer("五千五百四十九", 5549)
  end

  it "五千五百五十" do
    compare_kanji_and_integer("五千五百五十", 5550)
  end

  it "五千五百五十一" do
    compare_kanji_and_integer("五千五百五十一", 5551)
  end

  it "五千五百五十二" do
    compare_kanji_and_integer("五千五百五十二", 5552)
  end

  it "五千五百五十三" do
    compare_kanji_and_integer("五千五百五十三", 5553)
  end

  it "五千五百五十四" do
    compare_kanji_and_integer("五千五百五十四", 5554)
  end

  it "五千五百五十五" do
    compare_kanji_and_integer("五千五百五十五", 5555)
  end

  it "五千五百五十六" do
    compare_kanji_and_integer("五千五百五十六", 5556)
  end

  it "五千五百五十七" do
    compare_kanji_and_integer("五千五百五十七", 5557)
  end

  it "五千五百五十八" do
    compare_kanji_and_integer("五千五百五十八", 5558)
  end

  it "五千五百五十九" do
    compare_kanji_and_integer("五千五百五十九", 5559)
  end

  it "五千五百六十" do
    compare_kanji_and_integer("五千五百六十", 5560)
  end

  it "五千五百六十一" do
    compare_kanji_and_integer("五千五百六十一", 5561)
  end

  it "五千五百六十二" do
    compare_kanji_and_integer("五千五百六十二", 5562)
  end

  it "五千五百六十三" do
    compare_kanji_and_integer("五千五百六十三", 5563)
  end

  it "五千五百六十四" do
    compare_kanji_and_integer("五千五百六十四", 5564)
  end

  it "五千五百六十五" do
    compare_kanji_and_integer("五千五百六十五", 5565)
  end

  it "五千五百六十六" do
    compare_kanji_and_integer("五千五百六十六", 5566)
  end

  it "五千五百六十七" do
    compare_kanji_and_integer("五千五百六十七", 5567)
  end

  it "五千五百六十八" do
    compare_kanji_and_integer("五千五百六十八", 5568)
  end

  it "五千五百六十九" do
    compare_kanji_and_integer("五千五百六十九", 5569)
  end

  it "五千五百七十" do
    compare_kanji_and_integer("五千五百七十", 5570)
  end

  it "五千五百七十一" do
    compare_kanji_and_integer("五千五百七十一", 5571)
  end

  it "五千五百七十二" do
    compare_kanji_and_integer("五千五百七十二", 5572)
  end

  it "五千五百七十三" do
    compare_kanji_and_integer("五千五百七十三", 5573)
  end

  it "五千五百七十四" do
    compare_kanji_and_integer("五千五百七十四", 5574)
  end

  it "五千五百七十五" do
    compare_kanji_and_integer("五千五百七十五", 5575)
  end

  it "五千五百七十六" do
    compare_kanji_and_integer("五千五百七十六", 5576)
  end

  it "五千五百七十七" do
    compare_kanji_and_integer("五千五百七十七", 5577)
  end

  it "五千五百七十八" do
    compare_kanji_and_integer("五千五百七十八", 5578)
  end

  it "五千五百七十九" do
    compare_kanji_and_integer("五千五百七十九", 5579)
  end

  it "五千五百八十" do
    compare_kanji_and_integer("五千五百八十", 5580)
  end

  it "五千五百八十一" do
    compare_kanji_and_integer("五千五百八十一", 5581)
  end

  it "五千五百八十二" do
    compare_kanji_and_integer("五千五百八十二", 5582)
  end

  it "五千五百八十三" do
    compare_kanji_and_integer("五千五百八十三", 5583)
  end

  it "五千五百八十四" do
    compare_kanji_and_integer("五千五百八十四", 5584)
  end

  it "五千五百八十五" do
    compare_kanji_and_integer("五千五百八十五", 5585)
  end

  it "五千五百八十六" do
    compare_kanji_and_integer("五千五百八十六", 5586)
  end

  it "五千五百八十七" do
    compare_kanji_and_integer("五千五百八十七", 5587)
  end

  it "五千五百八十八" do
    compare_kanji_and_integer("五千五百八十八", 5588)
  end

  it "五千五百八十九" do
    compare_kanji_and_integer("五千五百八十九", 5589)
  end

  it "五千五百九十" do
    compare_kanji_and_integer("五千五百九十", 5590)
  end

  it "五千五百九十一" do
    compare_kanji_and_integer("五千五百九十一", 5591)
  end

  it "五千五百九十二" do
    compare_kanji_and_integer("五千五百九十二", 5592)
  end

  it "五千五百九十三" do
    compare_kanji_and_integer("五千五百九十三", 5593)
  end

  it "五千五百九十四" do
    compare_kanji_and_integer("五千五百九十四", 5594)
  end

  it "五千五百九十五" do
    compare_kanji_and_integer("五千五百九十五", 5595)
  end

  it "五千五百九十六" do
    compare_kanji_and_integer("五千五百九十六", 5596)
  end

  it "五千五百九十七" do
    compare_kanji_and_integer("五千五百九十七", 5597)
  end

  it "五千五百九十八" do
    compare_kanji_and_integer("五千五百九十八", 5598)
  end

  it "五千五百九十九" do
    compare_kanji_and_integer("五千五百九十九", 5599)
  end

  it "五千六百" do
    compare_kanji_and_integer("五千六百", 5600)
  end

  it "五千六百一" do
    compare_kanji_and_integer("五千六百一", 5601)
  end

  it "五千六百二" do
    compare_kanji_and_integer("五千六百二", 5602)
  end

  it "五千六百三" do
    compare_kanji_and_integer("五千六百三", 5603)
  end

  it "五千六百四" do
    compare_kanji_and_integer("五千六百四", 5604)
  end

  it "五千六百五" do
    compare_kanji_and_integer("五千六百五", 5605)
  end

  it "五千六百六" do
    compare_kanji_and_integer("五千六百六", 5606)
  end

  it "五千六百七" do
    compare_kanji_and_integer("五千六百七", 5607)
  end

  it "五千六百八" do
    compare_kanji_and_integer("五千六百八", 5608)
  end

  it "五千六百九" do
    compare_kanji_and_integer("五千六百九", 5609)
  end

  it "五千六百十" do
    compare_kanji_and_integer("五千六百十", 5610)
  end

  it "五千六百十一" do
    compare_kanji_and_integer("五千六百十一", 5611)
  end

  it "五千六百十二" do
    compare_kanji_and_integer("五千六百十二", 5612)
  end

  it "五千六百十三" do
    compare_kanji_and_integer("五千六百十三", 5613)
  end

  it "五千六百十四" do
    compare_kanji_and_integer("五千六百十四", 5614)
  end

  it "五千六百十五" do
    compare_kanji_and_integer("五千六百十五", 5615)
  end

  it "五千六百十六" do
    compare_kanji_and_integer("五千六百十六", 5616)
  end

  it "五千六百十七" do
    compare_kanji_and_integer("五千六百十七", 5617)
  end

  it "五千六百十八" do
    compare_kanji_and_integer("五千六百十八", 5618)
  end

  it "五千六百十九" do
    compare_kanji_and_integer("五千六百十九", 5619)
  end

  it "五千六百二十" do
    compare_kanji_and_integer("五千六百二十", 5620)
  end

  it "五千六百二十一" do
    compare_kanji_and_integer("五千六百二十一", 5621)
  end

  it "五千六百二十二" do
    compare_kanji_and_integer("五千六百二十二", 5622)
  end

  it "五千六百二十三" do
    compare_kanji_and_integer("五千六百二十三", 5623)
  end

  it "五千六百二十四" do
    compare_kanji_and_integer("五千六百二十四", 5624)
  end

  it "五千六百二十五" do
    compare_kanji_and_integer("五千六百二十五", 5625)
  end

  it "五千六百二十六" do
    compare_kanji_and_integer("五千六百二十六", 5626)
  end

  it "五千六百二十七" do
    compare_kanji_and_integer("五千六百二十七", 5627)
  end

  it "五千六百二十八" do
    compare_kanji_and_integer("五千六百二十八", 5628)
  end

  it "五千六百二十九" do
    compare_kanji_and_integer("五千六百二十九", 5629)
  end

  it "五千六百三十" do
    compare_kanji_and_integer("五千六百三十", 5630)
  end

  it "五千六百三十一" do
    compare_kanji_and_integer("五千六百三十一", 5631)
  end

  it "五千六百三十二" do
    compare_kanji_and_integer("五千六百三十二", 5632)
  end

  it "五千六百三十三" do
    compare_kanji_and_integer("五千六百三十三", 5633)
  end

  it "五千六百三十四" do
    compare_kanji_and_integer("五千六百三十四", 5634)
  end

  it "五千六百三十五" do
    compare_kanji_and_integer("五千六百三十五", 5635)
  end

  it "五千六百三十六" do
    compare_kanji_and_integer("五千六百三十六", 5636)
  end

  it "五千六百三十七" do
    compare_kanji_and_integer("五千六百三十七", 5637)
  end

  it "五千六百三十八" do
    compare_kanji_and_integer("五千六百三十八", 5638)
  end

  it "五千六百三十九" do
    compare_kanji_and_integer("五千六百三十九", 5639)
  end

  it "五千六百四十" do
    compare_kanji_and_integer("五千六百四十", 5640)
  end

  it "五千六百四十一" do
    compare_kanji_and_integer("五千六百四十一", 5641)
  end

  it "五千六百四十二" do
    compare_kanji_and_integer("五千六百四十二", 5642)
  end

  it "五千六百四十三" do
    compare_kanji_and_integer("五千六百四十三", 5643)
  end

  it "五千六百四十四" do
    compare_kanji_and_integer("五千六百四十四", 5644)
  end

  it "五千六百四十五" do
    compare_kanji_and_integer("五千六百四十五", 5645)
  end

  it "五千六百四十六" do
    compare_kanji_and_integer("五千六百四十六", 5646)
  end

  it "五千六百四十七" do
    compare_kanji_and_integer("五千六百四十七", 5647)
  end

  it "五千六百四十八" do
    compare_kanji_and_integer("五千六百四十八", 5648)
  end

  it "五千六百四十九" do
    compare_kanji_and_integer("五千六百四十九", 5649)
  end

  it "五千六百五十" do
    compare_kanji_and_integer("五千六百五十", 5650)
  end

  it "五千六百五十一" do
    compare_kanji_and_integer("五千六百五十一", 5651)
  end

  it "五千六百五十二" do
    compare_kanji_and_integer("五千六百五十二", 5652)
  end

  it "五千六百五十三" do
    compare_kanji_and_integer("五千六百五十三", 5653)
  end

  it "五千六百五十四" do
    compare_kanji_and_integer("五千六百五十四", 5654)
  end

  it "五千六百五十五" do
    compare_kanji_and_integer("五千六百五十五", 5655)
  end

  it "五千六百五十六" do
    compare_kanji_and_integer("五千六百五十六", 5656)
  end

  it "五千六百五十七" do
    compare_kanji_and_integer("五千六百五十七", 5657)
  end

  it "五千六百五十八" do
    compare_kanji_and_integer("五千六百五十八", 5658)
  end

  it "五千六百五十九" do
    compare_kanji_and_integer("五千六百五十九", 5659)
  end

  it "五千六百六十" do
    compare_kanji_and_integer("五千六百六十", 5660)
  end

  it "五千六百六十一" do
    compare_kanji_and_integer("五千六百六十一", 5661)
  end

  it "五千六百六十二" do
    compare_kanji_and_integer("五千六百六十二", 5662)
  end

  it "五千六百六十三" do
    compare_kanji_and_integer("五千六百六十三", 5663)
  end

  it "五千六百六十四" do
    compare_kanji_and_integer("五千六百六十四", 5664)
  end

  it "五千六百六十五" do
    compare_kanji_and_integer("五千六百六十五", 5665)
  end

  it "五千六百六十六" do
    compare_kanji_and_integer("五千六百六十六", 5666)
  end

  it "五千六百六十七" do
    compare_kanji_and_integer("五千六百六十七", 5667)
  end

  it "五千六百六十八" do
    compare_kanji_and_integer("五千六百六十八", 5668)
  end

  it "五千六百六十九" do
    compare_kanji_and_integer("五千六百六十九", 5669)
  end

  it "五千六百七十" do
    compare_kanji_and_integer("五千六百七十", 5670)
  end

  it "五千六百七十一" do
    compare_kanji_and_integer("五千六百七十一", 5671)
  end

  it "五千六百七十二" do
    compare_kanji_and_integer("五千六百七十二", 5672)
  end

  it "五千六百七十三" do
    compare_kanji_and_integer("五千六百七十三", 5673)
  end

  it "五千六百七十四" do
    compare_kanji_and_integer("五千六百七十四", 5674)
  end

  it "五千六百七十五" do
    compare_kanji_and_integer("五千六百七十五", 5675)
  end

  it "五千六百七十六" do
    compare_kanji_and_integer("五千六百七十六", 5676)
  end

  it "五千六百七十七" do
    compare_kanji_and_integer("五千六百七十七", 5677)
  end

  it "五千六百七十八" do
    compare_kanji_and_integer("五千六百七十八", 5678)
  end

  it "五千六百七十九" do
    compare_kanji_and_integer("五千六百七十九", 5679)
  end

  it "五千六百八十" do
    compare_kanji_and_integer("五千六百八十", 5680)
  end

  it "五千六百八十一" do
    compare_kanji_and_integer("五千六百八十一", 5681)
  end

  it "五千六百八十二" do
    compare_kanji_and_integer("五千六百八十二", 5682)
  end

  it "五千六百八十三" do
    compare_kanji_and_integer("五千六百八十三", 5683)
  end

  it "五千六百八十四" do
    compare_kanji_and_integer("五千六百八十四", 5684)
  end

  it "五千六百八十五" do
    compare_kanji_and_integer("五千六百八十五", 5685)
  end

  it "五千六百八十六" do
    compare_kanji_and_integer("五千六百八十六", 5686)
  end

  it "五千六百八十七" do
    compare_kanji_and_integer("五千六百八十七", 5687)
  end

  it "五千六百八十八" do
    compare_kanji_and_integer("五千六百八十八", 5688)
  end

  it "五千六百八十九" do
    compare_kanji_and_integer("五千六百八十九", 5689)
  end

  it "五千六百九十" do
    compare_kanji_and_integer("五千六百九十", 5690)
  end

  it "五千六百九十一" do
    compare_kanji_and_integer("五千六百九十一", 5691)
  end

  it "五千六百九十二" do
    compare_kanji_and_integer("五千六百九十二", 5692)
  end

  it "五千六百九十三" do
    compare_kanji_and_integer("五千六百九十三", 5693)
  end

  it "五千六百九十四" do
    compare_kanji_and_integer("五千六百九十四", 5694)
  end

  it "五千六百九十五" do
    compare_kanji_and_integer("五千六百九十五", 5695)
  end

  it "五千六百九十六" do
    compare_kanji_and_integer("五千六百九十六", 5696)
  end

  it "五千六百九十七" do
    compare_kanji_and_integer("五千六百九十七", 5697)
  end

  it "五千六百九十八" do
    compare_kanji_and_integer("五千六百九十八", 5698)
  end

  it "五千六百九十九" do
    compare_kanji_and_integer("五千六百九十九", 5699)
  end

  it "五千七百" do
    compare_kanji_and_integer("五千七百", 5700)
  end

  it "五千七百一" do
    compare_kanji_and_integer("五千七百一", 5701)
  end

  it "五千七百二" do
    compare_kanji_and_integer("五千七百二", 5702)
  end

  it "五千七百三" do
    compare_kanji_and_integer("五千七百三", 5703)
  end

  it "五千七百四" do
    compare_kanji_and_integer("五千七百四", 5704)
  end

  it "五千七百五" do
    compare_kanji_and_integer("五千七百五", 5705)
  end

  it "五千七百六" do
    compare_kanji_and_integer("五千七百六", 5706)
  end

  it "五千七百七" do
    compare_kanji_and_integer("五千七百七", 5707)
  end

  it "五千七百八" do
    compare_kanji_and_integer("五千七百八", 5708)
  end

  it "五千七百九" do
    compare_kanji_and_integer("五千七百九", 5709)
  end

  it "五千七百十" do
    compare_kanji_and_integer("五千七百十", 5710)
  end

  it "五千七百十一" do
    compare_kanji_and_integer("五千七百十一", 5711)
  end

  it "五千七百十二" do
    compare_kanji_and_integer("五千七百十二", 5712)
  end

  it "五千七百十三" do
    compare_kanji_and_integer("五千七百十三", 5713)
  end

  it "五千七百十四" do
    compare_kanji_and_integer("五千七百十四", 5714)
  end

  it "五千七百十五" do
    compare_kanji_and_integer("五千七百十五", 5715)
  end

  it "五千七百十六" do
    compare_kanji_and_integer("五千七百十六", 5716)
  end

  it "五千七百十七" do
    compare_kanji_and_integer("五千七百十七", 5717)
  end

  it "五千七百十八" do
    compare_kanji_and_integer("五千七百十八", 5718)
  end

  it "五千七百十九" do
    compare_kanji_and_integer("五千七百十九", 5719)
  end

  it "五千七百二十" do
    compare_kanji_and_integer("五千七百二十", 5720)
  end

  it "五千七百二十一" do
    compare_kanji_and_integer("五千七百二十一", 5721)
  end

  it "五千七百二十二" do
    compare_kanji_and_integer("五千七百二十二", 5722)
  end

  it "五千七百二十三" do
    compare_kanji_and_integer("五千七百二十三", 5723)
  end

  it "五千七百二十四" do
    compare_kanji_and_integer("五千七百二十四", 5724)
  end

  it "五千七百二十五" do
    compare_kanji_and_integer("五千七百二十五", 5725)
  end

  it "五千七百二十六" do
    compare_kanji_and_integer("五千七百二十六", 5726)
  end

  it "五千七百二十七" do
    compare_kanji_and_integer("五千七百二十七", 5727)
  end

  it "五千七百二十八" do
    compare_kanji_and_integer("五千七百二十八", 5728)
  end

  it "五千七百二十九" do
    compare_kanji_and_integer("五千七百二十九", 5729)
  end

  it "五千七百三十" do
    compare_kanji_and_integer("五千七百三十", 5730)
  end

  it "五千七百三十一" do
    compare_kanji_and_integer("五千七百三十一", 5731)
  end

  it "五千七百三十二" do
    compare_kanji_and_integer("五千七百三十二", 5732)
  end

  it "五千七百三十三" do
    compare_kanji_and_integer("五千七百三十三", 5733)
  end

  it "五千七百三十四" do
    compare_kanji_and_integer("五千七百三十四", 5734)
  end

  it "五千七百三十五" do
    compare_kanji_and_integer("五千七百三十五", 5735)
  end

  it "五千七百三十六" do
    compare_kanji_and_integer("五千七百三十六", 5736)
  end

  it "五千七百三十七" do
    compare_kanji_and_integer("五千七百三十七", 5737)
  end

  it "五千七百三十八" do
    compare_kanji_and_integer("五千七百三十八", 5738)
  end

  it "五千七百三十九" do
    compare_kanji_and_integer("五千七百三十九", 5739)
  end

  it "五千七百四十" do
    compare_kanji_and_integer("五千七百四十", 5740)
  end

  it "五千七百四十一" do
    compare_kanji_and_integer("五千七百四十一", 5741)
  end

  it "五千七百四十二" do
    compare_kanji_and_integer("五千七百四十二", 5742)
  end

  it "五千七百四十三" do
    compare_kanji_and_integer("五千七百四十三", 5743)
  end

  it "五千七百四十四" do
    compare_kanji_and_integer("五千七百四十四", 5744)
  end

  it "五千七百四十五" do
    compare_kanji_and_integer("五千七百四十五", 5745)
  end

  it "五千七百四十六" do
    compare_kanji_and_integer("五千七百四十六", 5746)
  end

  it "五千七百四十七" do
    compare_kanji_and_integer("五千七百四十七", 5747)
  end

  it "五千七百四十八" do
    compare_kanji_and_integer("五千七百四十八", 5748)
  end

  it "五千七百四十九" do
    compare_kanji_and_integer("五千七百四十九", 5749)
  end

  it "五千七百五十" do
    compare_kanji_and_integer("五千七百五十", 5750)
  end

  it "五千七百五十一" do
    compare_kanji_and_integer("五千七百五十一", 5751)
  end

  it "五千七百五十二" do
    compare_kanji_and_integer("五千七百五十二", 5752)
  end

  it "五千七百五十三" do
    compare_kanji_and_integer("五千七百五十三", 5753)
  end

  it "五千七百五十四" do
    compare_kanji_and_integer("五千七百五十四", 5754)
  end

  it "五千七百五十五" do
    compare_kanji_and_integer("五千七百五十五", 5755)
  end

  it "五千七百五十六" do
    compare_kanji_and_integer("五千七百五十六", 5756)
  end

  it "五千七百五十七" do
    compare_kanji_and_integer("五千七百五十七", 5757)
  end

  it "五千七百五十八" do
    compare_kanji_and_integer("五千七百五十八", 5758)
  end

  it "五千七百五十九" do
    compare_kanji_and_integer("五千七百五十九", 5759)
  end

  it "五千七百六十" do
    compare_kanji_and_integer("五千七百六十", 5760)
  end

  it "五千七百六十一" do
    compare_kanji_and_integer("五千七百六十一", 5761)
  end

  it "五千七百六十二" do
    compare_kanji_and_integer("五千七百六十二", 5762)
  end

  it "五千七百六十三" do
    compare_kanji_and_integer("五千七百六十三", 5763)
  end

  it "五千七百六十四" do
    compare_kanji_and_integer("五千七百六十四", 5764)
  end

  it "五千七百六十五" do
    compare_kanji_and_integer("五千七百六十五", 5765)
  end

  it "五千七百六十六" do
    compare_kanji_and_integer("五千七百六十六", 5766)
  end

  it "五千七百六十七" do
    compare_kanji_and_integer("五千七百六十七", 5767)
  end

  it "五千七百六十八" do
    compare_kanji_and_integer("五千七百六十八", 5768)
  end

  it "五千七百六十九" do
    compare_kanji_and_integer("五千七百六十九", 5769)
  end

  it "五千七百七十" do
    compare_kanji_and_integer("五千七百七十", 5770)
  end

  it "五千七百七十一" do
    compare_kanji_and_integer("五千七百七十一", 5771)
  end

  it "五千七百七十二" do
    compare_kanji_and_integer("五千七百七十二", 5772)
  end

  it "五千七百七十三" do
    compare_kanji_and_integer("五千七百七十三", 5773)
  end

  it "五千七百七十四" do
    compare_kanji_and_integer("五千七百七十四", 5774)
  end

  it "五千七百七十五" do
    compare_kanji_and_integer("五千七百七十五", 5775)
  end

  it "五千七百七十六" do
    compare_kanji_and_integer("五千七百七十六", 5776)
  end

  it "五千七百七十七" do
    compare_kanji_and_integer("五千七百七十七", 5777)
  end

  it "五千七百七十八" do
    compare_kanji_and_integer("五千七百七十八", 5778)
  end

  it "五千七百七十九" do
    compare_kanji_and_integer("五千七百七十九", 5779)
  end

  it "五千七百八十" do
    compare_kanji_and_integer("五千七百八十", 5780)
  end

  it "五千七百八十一" do
    compare_kanji_and_integer("五千七百八十一", 5781)
  end

  it "五千七百八十二" do
    compare_kanji_and_integer("五千七百八十二", 5782)
  end

  it "五千七百八十三" do
    compare_kanji_and_integer("五千七百八十三", 5783)
  end

  it "五千七百八十四" do
    compare_kanji_and_integer("五千七百八十四", 5784)
  end

  it "五千七百八十五" do
    compare_kanji_and_integer("五千七百八十五", 5785)
  end

  it "五千七百八十六" do
    compare_kanji_and_integer("五千七百八十六", 5786)
  end

  it "五千七百八十七" do
    compare_kanji_and_integer("五千七百八十七", 5787)
  end

  it "五千七百八十八" do
    compare_kanji_and_integer("五千七百八十八", 5788)
  end

  it "五千七百八十九" do
    compare_kanji_and_integer("五千七百八十九", 5789)
  end

  it "五千七百九十" do
    compare_kanji_and_integer("五千七百九十", 5790)
  end

  it "五千七百九十一" do
    compare_kanji_and_integer("五千七百九十一", 5791)
  end

  it "五千七百九十二" do
    compare_kanji_and_integer("五千七百九十二", 5792)
  end

  it "五千七百九十三" do
    compare_kanji_and_integer("五千七百九十三", 5793)
  end

  it "五千七百九十四" do
    compare_kanji_and_integer("五千七百九十四", 5794)
  end

  it "五千七百九十五" do
    compare_kanji_and_integer("五千七百九十五", 5795)
  end

  it "五千七百九十六" do
    compare_kanji_and_integer("五千七百九十六", 5796)
  end

  it "五千七百九十七" do
    compare_kanji_and_integer("五千七百九十七", 5797)
  end

  it "五千七百九十八" do
    compare_kanji_and_integer("五千七百九十八", 5798)
  end

  it "五千七百九十九" do
    compare_kanji_and_integer("五千七百九十九", 5799)
  end

  it "五千八百" do
    compare_kanji_and_integer("五千八百", 5800)
  end

  it "五千八百一" do
    compare_kanji_and_integer("五千八百一", 5801)
  end

  it "五千八百二" do
    compare_kanji_and_integer("五千八百二", 5802)
  end

  it "五千八百三" do
    compare_kanji_and_integer("五千八百三", 5803)
  end

  it "五千八百四" do
    compare_kanji_and_integer("五千八百四", 5804)
  end

  it "五千八百五" do
    compare_kanji_and_integer("五千八百五", 5805)
  end

  it "五千八百六" do
    compare_kanji_and_integer("五千八百六", 5806)
  end

  it "五千八百七" do
    compare_kanji_and_integer("五千八百七", 5807)
  end

  it "五千八百八" do
    compare_kanji_and_integer("五千八百八", 5808)
  end

  it "五千八百九" do
    compare_kanji_and_integer("五千八百九", 5809)
  end

  it "五千八百十" do
    compare_kanji_and_integer("五千八百十", 5810)
  end

  it "五千八百十一" do
    compare_kanji_and_integer("五千八百十一", 5811)
  end

  it "五千八百十二" do
    compare_kanji_and_integer("五千八百十二", 5812)
  end

  it "五千八百十三" do
    compare_kanji_and_integer("五千八百十三", 5813)
  end

  it "五千八百十四" do
    compare_kanji_and_integer("五千八百十四", 5814)
  end

  it "五千八百十五" do
    compare_kanji_and_integer("五千八百十五", 5815)
  end

  it "五千八百十六" do
    compare_kanji_and_integer("五千八百十六", 5816)
  end

  it "五千八百十七" do
    compare_kanji_and_integer("五千八百十七", 5817)
  end

  it "五千八百十八" do
    compare_kanji_and_integer("五千八百十八", 5818)
  end

  it "五千八百十九" do
    compare_kanji_and_integer("五千八百十九", 5819)
  end

  it "五千八百二十" do
    compare_kanji_and_integer("五千八百二十", 5820)
  end

  it "五千八百二十一" do
    compare_kanji_and_integer("五千八百二十一", 5821)
  end

  it "五千八百二十二" do
    compare_kanji_and_integer("五千八百二十二", 5822)
  end

  it "五千八百二十三" do
    compare_kanji_and_integer("五千八百二十三", 5823)
  end

  it "五千八百二十四" do
    compare_kanji_and_integer("五千八百二十四", 5824)
  end

  it "五千八百二十五" do
    compare_kanji_and_integer("五千八百二十五", 5825)
  end

  it "五千八百二十六" do
    compare_kanji_and_integer("五千八百二十六", 5826)
  end

  it "五千八百二十七" do
    compare_kanji_and_integer("五千八百二十七", 5827)
  end

  it "五千八百二十八" do
    compare_kanji_and_integer("五千八百二十八", 5828)
  end

  it "五千八百二十九" do
    compare_kanji_and_integer("五千八百二十九", 5829)
  end

  it "五千八百三十" do
    compare_kanji_and_integer("五千八百三十", 5830)
  end

  it "五千八百三十一" do
    compare_kanji_and_integer("五千八百三十一", 5831)
  end

  it "五千八百三十二" do
    compare_kanji_and_integer("五千八百三十二", 5832)
  end

  it "五千八百三十三" do
    compare_kanji_and_integer("五千八百三十三", 5833)
  end

  it "五千八百三十四" do
    compare_kanji_and_integer("五千八百三十四", 5834)
  end

  it "五千八百三十五" do
    compare_kanji_and_integer("五千八百三十五", 5835)
  end

  it "五千八百三十六" do
    compare_kanji_and_integer("五千八百三十六", 5836)
  end

  it "五千八百三十七" do
    compare_kanji_and_integer("五千八百三十七", 5837)
  end

  it "五千八百三十八" do
    compare_kanji_and_integer("五千八百三十八", 5838)
  end

  it "五千八百三十九" do
    compare_kanji_and_integer("五千八百三十九", 5839)
  end

  it "五千八百四十" do
    compare_kanji_and_integer("五千八百四十", 5840)
  end

  it "五千八百四十一" do
    compare_kanji_and_integer("五千八百四十一", 5841)
  end

  it "五千八百四十二" do
    compare_kanji_and_integer("五千八百四十二", 5842)
  end

  it "五千八百四十三" do
    compare_kanji_and_integer("五千八百四十三", 5843)
  end

  it "五千八百四十四" do
    compare_kanji_and_integer("五千八百四十四", 5844)
  end

  it "五千八百四十五" do
    compare_kanji_and_integer("五千八百四十五", 5845)
  end

  it "五千八百四十六" do
    compare_kanji_and_integer("五千八百四十六", 5846)
  end

  it "五千八百四十七" do
    compare_kanji_and_integer("五千八百四十七", 5847)
  end

  it "五千八百四十八" do
    compare_kanji_and_integer("五千八百四十八", 5848)
  end

  it "五千八百四十九" do
    compare_kanji_and_integer("五千八百四十九", 5849)
  end

  it "五千八百五十" do
    compare_kanji_and_integer("五千八百五十", 5850)
  end

  it "五千八百五十一" do
    compare_kanji_and_integer("五千八百五十一", 5851)
  end

  it "五千八百五十二" do
    compare_kanji_and_integer("五千八百五十二", 5852)
  end

  it "五千八百五十三" do
    compare_kanji_and_integer("五千八百五十三", 5853)
  end

  it "五千八百五十四" do
    compare_kanji_and_integer("五千八百五十四", 5854)
  end

  it "五千八百五十五" do
    compare_kanji_and_integer("五千八百五十五", 5855)
  end

  it "五千八百五十六" do
    compare_kanji_and_integer("五千八百五十六", 5856)
  end

  it "五千八百五十七" do
    compare_kanji_and_integer("五千八百五十七", 5857)
  end

  it "五千八百五十八" do
    compare_kanji_and_integer("五千八百五十八", 5858)
  end

  it "五千八百五十九" do
    compare_kanji_and_integer("五千八百五十九", 5859)
  end

  it "五千八百六十" do
    compare_kanji_and_integer("五千八百六十", 5860)
  end

  it "五千八百六十一" do
    compare_kanji_and_integer("五千八百六十一", 5861)
  end

  it "五千八百六十二" do
    compare_kanji_and_integer("五千八百六十二", 5862)
  end

  it "五千八百六十三" do
    compare_kanji_and_integer("五千八百六十三", 5863)
  end

  it "五千八百六十四" do
    compare_kanji_and_integer("五千八百六十四", 5864)
  end

  it "五千八百六十五" do
    compare_kanji_and_integer("五千八百六十五", 5865)
  end

  it "五千八百六十六" do
    compare_kanji_and_integer("五千八百六十六", 5866)
  end

  it "五千八百六十七" do
    compare_kanji_and_integer("五千八百六十七", 5867)
  end

  it "五千八百六十八" do
    compare_kanji_and_integer("五千八百六十八", 5868)
  end

  it "五千八百六十九" do
    compare_kanji_and_integer("五千八百六十九", 5869)
  end

  it "五千八百七十" do
    compare_kanji_and_integer("五千八百七十", 5870)
  end

  it "五千八百七十一" do
    compare_kanji_and_integer("五千八百七十一", 5871)
  end

  it "五千八百七十二" do
    compare_kanji_and_integer("五千八百七十二", 5872)
  end

  it "五千八百七十三" do
    compare_kanji_and_integer("五千八百七十三", 5873)
  end

  it "五千八百七十四" do
    compare_kanji_and_integer("五千八百七十四", 5874)
  end

  it "五千八百七十五" do
    compare_kanji_and_integer("五千八百七十五", 5875)
  end

  it "五千八百七十六" do
    compare_kanji_and_integer("五千八百七十六", 5876)
  end

  it "五千八百七十七" do
    compare_kanji_and_integer("五千八百七十七", 5877)
  end

  it "五千八百七十八" do
    compare_kanji_and_integer("五千八百七十八", 5878)
  end

  it "五千八百七十九" do
    compare_kanji_and_integer("五千八百七十九", 5879)
  end

  it "五千八百八十" do
    compare_kanji_and_integer("五千八百八十", 5880)
  end

  it "五千八百八十一" do
    compare_kanji_and_integer("五千八百八十一", 5881)
  end

  it "五千八百八十二" do
    compare_kanji_and_integer("五千八百八十二", 5882)
  end

  it "五千八百八十三" do
    compare_kanji_and_integer("五千八百八十三", 5883)
  end

  it "五千八百八十四" do
    compare_kanji_and_integer("五千八百八十四", 5884)
  end

  it "五千八百八十五" do
    compare_kanji_and_integer("五千八百八十五", 5885)
  end

  it "五千八百八十六" do
    compare_kanji_and_integer("五千八百八十六", 5886)
  end

  it "五千八百八十七" do
    compare_kanji_and_integer("五千八百八十七", 5887)
  end

  it "五千八百八十八" do
    compare_kanji_and_integer("五千八百八十八", 5888)
  end

  it "五千八百八十九" do
    compare_kanji_and_integer("五千八百八十九", 5889)
  end

  it "五千八百九十" do
    compare_kanji_and_integer("五千八百九十", 5890)
  end

  it "五千八百九十一" do
    compare_kanji_and_integer("五千八百九十一", 5891)
  end

  it "五千八百九十二" do
    compare_kanji_and_integer("五千八百九十二", 5892)
  end

  it "五千八百九十三" do
    compare_kanji_and_integer("五千八百九十三", 5893)
  end

  it "五千八百九十四" do
    compare_kanji_and_integer("五千八百九十四", 5894)
  end

  it "五千八百九十五" do
    compare_kanji_and_integer("五千八百九十五", 5895)
  end

  it "五千八百九十六" do
    compare_kanji_and_integer("五千八百九十六", 5896)
  end

  it "五千八百九十七" do
    compare_kanji_and_integer("五千八百九十七", 5897)
  end

  it "五千八百九十八" do
    compare_kanji_and_integer("五千八百九十八", 5898)
  end

  it "五千八百九十九" do
    compare_kanji_and_integer("五千八百九十九", 5899)
  end

  it "五千九百" do
    compare_kanji_and_integer("五千九百", 5900)
  end

  it "五千九百一" do
    compare_kanji_and_integer("五千九百一", 5901)
  end

  it "五千九百二" do
    compare_kanji_and_integer("五千九百二", 5902)
  end

  it "五千九百三" do
    compare_kanji_and_integer("五千九百三", 5903)
  end

  it "五千九百四" do
    compare_kanji_and_integer("五千九百四", 5904)
  end

  it "五千九百五" do
    compare_kanji_and_integer("五千九百五", 5905)
  end

  it "五千九百六" do
    compare_kanji_and_integer("五千九百六", 5906)
  end

  it "五千九百七" do
    compare_kanji_and_integer("五千九百七", 5907)
  end

  it "五千九百八" do
    compare_kanji_and_integer("五千九百八", 5908)
  end

  it "五千九百九" do
    compare_kanji_and_integer("五千九百九", 5909)
  end

  it "五千九百十" do
    compare_kanji_and_integer("五千九百十", 5910)
  end

  it "五千九百十一" do
    compare_kanji_and_integer("五千九百十一", 5911)
  end

  it "五千九百十二" do
    compare_kanji_and_integer("五千九百十二", 5912)
  end

  it "五千九百十三" do
    compare_kanji_and_integer("五千九百十三", 5913)
  end

  it "五千九百十四" do
    compare_kanji_and_integer("五千九百十四", 5914)
  end

  it "五千九百十五" do
    compare_kanji_and_integer("五千九百十五", 5915)
  end

  it "五千九百十六" do
    compare_kanji_and_integer("五千九百十六", 5916)
  end

  it "五千九百十七" do
    compare_kanji_and_integer("五千九百十七", 5917)
  end

  it "五千九百十八" do
    compare_kanji_and_integer("五千九百十八", 5918)
  end

  it "五千九百十九" do
    compare_kanji_and_integer("五千九百十九", 5919)
  end

  it "五千九百二十" do
    compare_kanji_and_integer("五千九百二十", 5920)
  end

  it "五千九百二十一" do
    compare_kanji_and_integer("五千九百二十一", 5921)
  end

  it "五千九百二十二" do
    compare_kanji_and_integer("五千九百二十二", 5922)
  end

  it "五千九百二十三" do
    compare_kanji_and_integer("五千九百二十三", 5923)
  end

  it "五千九百二十四" do
    compare_kanji_and_integer("五千九百二十四", 5924)
  end

  it "五千九百二十五" do
    compare_kanji_and_integer("五千九百二十五", 5925)
  end

  it "五千九百二十六" do
    compare_kanji_and_integer("五千九百二十六", 5926)
  end

  it "五千九百二十七" do
    compare_kanji_and_integer("五千九百二十七", 5927)
  end

  it "五千九百二十八" do
    compare_kanji_and_integer("五千九百二十八", 5928)
  end

  it "五千九百二十九" do
    compare_kanji_and_integer("五千九百二十九", 5929)
  end

  it "五千九百三十" do
    compare_kanji_and_integer("五千九百三十", 5930)
  end

  it "五千九百三十一" do
    compare_kanji_and_integer("五千九百三十一", 5931)
  end

  it "五千九百三十二" do
    compare_kanji_and_integer("五千九百三十二", 5932)
  end

  it "五千九百三十三" do
    compare_kanji_and_integer("五千九百三十三", 5933)
  end

  it "五千九百三十四" do
    compare_kanji_and_integer("五千九百三十四", 5934)
  end

  it "五千九百三十五" do
    compare_kanji_and_integer("五千九百三十五", 5935)
  end

  it "五千九百三十六" do
    compare_kanji_and_integer("五千九百三十六", 5936)
  end

  it "五千九百三十七" do
    compare_kanji_and_integer("五千九百三十七", 5937)
  end

  it "五千九百三十八" do
    compare_kanji_and_integer("五千九百三十八", 5938)
  end

  it "五千九百三十九" do
    compare_kanji_and_integer("五千九百三十九", 5939)
  end

  it "五千九百四十" do
    compare_kanji_and_integer("五千九百四十", 5940)
  end

  it "五千九百四十一" do
    compare_kanji_and_integer("五千九百四十一", 5941)
  end

  it "五千九百四十二" do
    compare_kanji_and_integer("五千九百四十二", 5942)
  end

  it "五千九百四十三" do
    compare_kanji_and_integer("五千九百四十三", 5943)
  end

  it "五千九百四十四" do
    compare_kanji_and_integer("五千九百四十四", 5944)
  end

  it "五千九百四十五" do
    compare_kanji_and_integer("五千九百四十五", 5945)
  end

  it "五千九百四十六" do
    compare_kanji_and_integer("五千九百四十六", 5946)
  end

  it "五千九百四十七" do
    compare_kanji_and_integer("五千九百四十七", 5947)
  end

  it "五千九百四十八" do
    compare_kanji_and_integer("五千九百四十八", 5948)
  end

  it "五千九百四十九" do
    compare_kanji_and_integer("五千九百四十九", 5949)
  end

  it "五千九百五十" do
    compare_kanji_and_integer("五千九百五十", 5950)
  end

  it "五千九百五十一" do
    compare_kanji_and_integer("五千九百五十一", 5951)
  end

  it "五千九百五十二" do
    compare_kanji_and_integer("五千九百五十二", 5952)
  end

  it "五千九百五十三" do
    compare_kanji_and_integer("五千九百五十三", 5953)
  end

  it "五千九百五十四" do
    compare_kanji_and_integer("五千九百五十四", 5954)
  end

  it "五千九百五十五" do
    compare_kanji_and_integer("五千九百五十五", 5955)
  end

  it "五千九百五十六" do
    compare_kanji_and_integer("五千九百五十六", 5956)
  end

  it "五千九百五十七" do
    compare_kanji_and_integer("五千九百五十七", 5957)
  end

  it "五千九百五十八" do
    compare_kanji_and_integer("五千九百五十八", 5958)
  end

  it "五千九百五十九" do
    compare_kanji_and_integer("五千九百五十九", 5959)
  end

  it "五千九百六十" do
    compare_kanji_and_integer("五千九百六十", 5960)
  end

  it "五千九百六十一" do
    compare_kanji_and_integer("五千九百六十一", 5961)
  end

  it "五千九百六十二" do
    compare_kanji_and_integer("五千九百六十二", 5962)
  end

  it "五千九百六十三" do
    compare_kanji_and_integer("五千九百六十三", 5963)
  end

  it "五千九百六十四" do
    compare_kanji_and_integer("五千九百六十四", 5964)
  end

  it "五千九百六十五" do
    compare_kanji_and_integer("五千九百六十五", 5965)
  end

  it "五千九百六十六" do
    compare_kanji_and_integer("五千九百六十六", 5966)
  end

  it "五千九百六十七" do
    compare_kanji_and_integer("五千九百六十七", 5967)
  end

  it "五千九百六十八" do
    compare_kanji_and_integer("五千九百六十八", 5968)
  end

  it "五千九百六十九" do
    compare_kanji_and_integer("五千九百六十九", 5969)
  end

  it "五千九百七十" do
    compare_kanji_and_integer("五千九百七十", 5970)
  end

  it "五千九百七十一" do
    compare_kanji_and_integer("五千九百七十一", 5971)
  end

  it "五千九百七十二" do
    compare_kanji_and_integer("五千九百七十二", 5972)
  end

  it "五千九百七十三" do
    compare_kanji_and_integer("五千九百七十三", 5973)
  end

  it "五千九百七十四" do
    compare_kanji_and_integer("五千九百七十四", 5974)
  end

  it "五千九百七十五" do
    compare_kanji_and_integer("五千九百七十五", 5975)
  end

  it "五千九百七十六" do
    compare_kanji_and_integer("五千九百七十六", 5976)
  end

  it "五千九百七十七" do
    compare_kanji_and_integer("五千九百七十七", 5977)
  end

  it "五千九百七十八" do
    compare_kanji_and_integer("五千九百七十八", 5978)
  end

  it "五千九百七十九" do
    compare_kanji_and_integer("五千九百七十九", 5979)
  end

  it "五千九百八十" do
    compare_kanji_and_integer("五千九百八十", 5980)
  end

  it "五千九百八十一" do
    compare_kanji_and_integer("五千九百八十一", 5981)
  end

  it "五千九百八十二" do
    compare_kanji_and_integer("五千九百八十二", 5982)
  end

  it "五千九百八十三" do
    compare_kanji_and_integer("五千九百八十三", 5983)
  end

  it "五千九百八十四" do
    compare_kanji_and_integer("五千九百八十四", 5984)
  end

  it "五千九百八十五" do
    compare_kanji_and_integer("五千九百八十五", 5985)
  end

  it "五千九百八十六" do
    compare_kanji_and_integer("五千九百八十六", 5986)
  end

  it "五千九百八十七" do
    compare_kanji_and_integer("五千九百八十七", 5987)
  end

  it "五千九百八十八" do
    compare_kanji_and_integer("五千九百八十八", 5988)
  end

  it "五千九百八十九" do
    compare_kanji_and_integer("五千九百八十九", 5989)
  end

  it "五千九百九十" do
    compare_kanji_and_integer("五千九百九十", 5990)
  end

  it "五千九百九十一" do
    compare_kanji_and_integer("五千九百九十一", 5991)
  end

  it "五千九百九十二" do
    compare_kanji_and_integer("五千九百九十二", 5992)
  end

  it "五千九百九十三" do
    compare_kanji_and_integer("五千九百九十三", 5993)
  end

  it "五千九百九十四" do
    compare_kanji_and_integer("五千九百九十四", 5994)
  end

  it "五千九百九十五" do
    compare_kanji_and_integer("五千九百九十五", 5995)
  end

  it "五千九百九十六" do
    compare_kanji_and_integer("五千九百九十六", 5996)
  end

  it "五千九百九十七" do
    compare_kanji_and_integer("五千九百九十七", 5997)
  end

  it "五千九百九十八" do
    compare_kanji_and_integer("五千九百九十八", 5998)
  end

  it "五千九百九十九" do
    compare_kanji_and_integer("五千九百九十九", 5999)
  end

  it "六千" do
    compare_kanji_and_integer("六千", 6000)
  end

  it "六千一" do
    compare_kanji_and_integer("六千一", 6001)
  end

  it "六千二" do
    compare_kanji_and_integer("六千二", 6002)
  end

  it "六千三" do
    compare_kanji_and_integer("六千三", 6003)
  end

  it "六千四" do
    compare_kanji_and_integer("六千四", 6004)
  end

  it "六千五" do
    compare_kanji_and_integer("六千五", 6005)
  end

  it "六千六" do
    compare_kanji_and_integer("六千六", 6006)
  end

  it "六千七" do
    compare_kanji_and_integer("六千七", 6007)
  end

  it "六千八" do
    compare_kanji_and_integer("六千八", 6008)
  end

  it "六千九" do
    compare_kanji_and_integer("六千九", 6009)
  end

  it "六千十" do
    compare_kanji_and_integer("六千十", 6010)
  end

  it "六千十一" do
    compare_kanji_and_integer("六千十一", 6011)
  end

  it "六千十二" do
    compare_kanji_and_integer("六千十二", 6012)
  end

  it "六千十三" do
    compare_kanji_and_integer("六千十三", 6013)
  end

  it "六千十四" do
    compare_kanji_and_integer("六千十四", 6014)
  end

  it "六千十五" do
    compare_kanji_and_integer("六千十五", 6015)
  end

  it "六千十六" do
    compare_kanji_and_integer("六千十六", 6016)
  end

  it "六千十七" do
    compare_kanji_and_integer("六千十七", 6017)
  end

  it "六千十八" do
    compare_kanji_and_integer("六千十八", 6018)
  end

  it "六千十九" do
    compare_kanji_and_integer("六千十九", 6019)
  end

  it "六千二十" do
    compare_kanji_and_integer("六千二十", 6020)
  end

  it "六千二十一" do
    compare_kanji_and_integer("六千二十一", 6021)
  end

  it "六千二十二" do
    compare_kanji_and_integer("六千二十二", 6022)
  end

  it "六千二十三" do
    compare_kanji_and_integer("六千二十三", 6023)
  end

  it "六千二十四" do
    compare_kanji_and_integer("六千二十四", 6024)
  end

  it "六千二十五" do
    compare_kanji_and_integer("六千二十五", 6025)
  end

  it "六千二十六" do
    compare_kanji_and_integer("六千二十六", 6026)
  end

  it "六千二十七" do
    compare_kanji_and_integer("六千二十七", 6027)
  end

  it "六千二十八" do
    compare_kanji_and_integer("六千二十八", 6028)
  end

  it "六千二十九" do
    compare_kanji_and_integer("六千二十九", 6029)
  end

  it "六千三十" do
    compare_kanji_and_integer("六千三十", 6030)
  end

  it "六千三十一" do
    compare_kanji_and_integer("六千三十一", 6031)
  end

  it "六千三十二" do
    compare_kanji_and_integer("六千三十二", 6032)
  end

  it "六千三十三" do
    compare_kanji_and_integer("六千三十三", 6033)
  end

  it "六千三十四" do
    compare_kanji_and_integer("六千三十四", 6034)
  end

  it "六千三十五" do
    compare_kanji_and_integer("六千三十五", 6035)
  end

  it "六千三十六" do
    compare_kanji_and_integer("六千三十六", 6036)
  end

  it "六千三十七" do
    compare_kanji_and_integer("六千三十七", 6037)
  end

  it "六千三十八" do
    compare_kanji_and_integer("六千三十八", 6038)
  end

  it "六千三十九" do
    compare_kanji_and_integer("六千三十九", 6039)
  end

  it "六千四十" do
    compare_kanji_and_integer("六千四十", 6040)
  end

  it "六千四十一" do
    compare_kanji_and_integer("六千四十一", 6041)
  end

  it "六千四十二" do
    compare_kanji_and_integer("六千四十二", 6042)
  end

  it "六千四十三" do
    compare_kanji_and_integer("六千四十三", 6043)
  end

  it "六千四十四" do
    compare_kanji_and_integer("六千四十四", 6044)
  end

  it "六千四十五" do
    compare_kanji_and_integer("六千四十五", 6045)
  end

  it "六千四十六" do
    compare_kanji_and_integer("六千四十六", 6046)
  end

  it "六千四十七" do
    compare_kanji_and_integer("六千四十七", 6047)
  end

  it "六千四十八" do
    compare_kanji_and_integer("六千四十八", 6048)
  end

  it "六千四十九" do
    compare_kanji_and_integer("六千四十九", 6049)
  end

  it "六千五十" do
    compare_kanji_and_integer("六千五十", 6050)
  end

  it "六千五十一" do
    compare_kanji_and_integer("六千五十一", 6051)
  end

  it "六千五十二" do
    compare_kanji_and_integer("六千五十二", 6052)
  end

  it "六千五十三" do
    compare_kanji_and_integer("六千五十三", 6053)
  end

  it "六千五十四" do
    compare_kanji_and_integer("六千五十四", 6054)
  end

  it "六千五十五" do
    compare_kanji_and_integer("六千五十五", 6055)
  end

  it "六千五十六" do
    compare_kanji_and_integer("六千五十六", 6056)
  end

  it "六千五十七" do
    compare_kanji_and_integer("六千五十七", 6057)
  end

  it "六千五十八" do
    compare_kanji_and_integer("六千五十八", 6058)
  end

  it "六千五十九" do
    compare_kanji_and_integer("六千五十九", 6059)
  end

  it "六千六十" do
    compare_kanji_and_integer("六千六十", 6060)
  end

  it "六千六十一" do
    compare_kanji_and_integer("六千六十一", 6061)
  end

  it "六千六十二" do
    compare_kanji_and_integer("六千六十二", 6062)
  end

  it "六千六十三" do
    compare_kanji_and_integer("六千六十三", 6063)
  end

  it "六千六十四" do
    compare_kanji_and_integer("六千六十四", 6064)
  end

  it "六千六十五" do
    compare_kanji_and_integer("六千六十五", 6065)
  end

  it "六千六十六" do
    compare_kanji_and_integer("六千六十六", 6066)
  end

  it "六千六十七" do
    compare_kanji_and_integer("六千六十七", 6067)
  end

  it "六千六十八" do
    compare_kanji_and_integer("六千六十八", 6068)
  end

  it "六千六十九" do
    compare_kanji_and_integer("六千六十九", 6069)
  end

  it "六千七十" do
    compare_kanji_and_integer("六千七十", 6070)
  end

  it "六千七十一" do
    compare_kanji_and_integer("六千七十一", 6071)
  end

  it "六千七十二" do
    compare_kanji_and_integer("六千七十二", 6072)
  end

  it "六千七十三" do
    compare_kanji_and_integer("六千七十三", 6073)
  end

  it "六千七十四" do
    compare_kanji_and_integer("六千七十四", 6074)
  end

  it "六千七十五" do
    compare_kanji_and_integer("六千七十五", 6075)
  end

  it "六千七十六" do
    compare_kanji_and_integer("六千七十六", 6076)
  end

  it "六千七十七" do
    compare_kanji_and_integer("六千七十七", 6077)
  end

  it "六千七十八" do
    compare_kanji_and_integer("六千七十八", 6078)
  end

  it "六千七十九" do
    compare_kanji_and_integer("六千七十九", 6079)
  end

  it "六千八十" do
    compare_kanji_and_integer("六千八十", 6080)
  end

  it "六千八十一" do
    compare_kanji_and_integer("六千八十一", 6081)
  end

  it "六千八十二" do
    compare_kanji_and_integer("六千八十二", 6082)
  end

  it "六千八十三" do
    compare_kanji_and_integer("六千八十三", 6083)
  end

  it "六千八十四" do
    compare_kanji_and_integer("六千八十四", 6084)
  end

  it "六千八十五" do
    compare_kanji_and_integer("六千八十五", 6085)
  end

  it "六千八十六" do
    compare_kanji_and_integer("六千八十六", 6086)
  end

  it "六千八十七" do
    compare_kanji_and_integer("六千八十七", 6087)
  end

  it "六千八十八" do
    compare_kanji_and_integer("六千八十八", 6088)
  end

  it "六千八十九" do
    compare_kanji_and_integer("六千八十九", 6089)
  end

  it "六千九十" do
    compare_kanji_and_integer("六千九十", 6090)
  end

  it "六千九十一" do
    compare_kanji_and_integer("六千九十一", 6091)
  end

  it "六千九十二" do
    compare_kanji_and_integer("六千九十二", 6092)
  end

  it "六千九十三" do
    compare_kanji_and_integer("六千九十三", 6093)
  end

  it "六千九十四" do
    compare_kanji_and_integer("六千九十四", 6094)
  end

  it "六千九十五" do
    compare_kanji_and_integer("六千九十五", 6095)
  end

  it "六千九十六" do
    compare_kanji_and_integer("六千九十六", 6096)
  end

  it "六千九十七" do
    compare_kanji_and_integer("六千九十七", 6097)
  end

  it "六千九十八" do
    compare_kanji_and_integer("六千九十八", 6098)
  end

  it "六千九十九" do
    compare_kanji_and_integer("六千九十九", 6099)
  end

  it "六千百" do
    compare_kanji_and_integer("六千百", 6100)
  end

  it "六千百一" do
    compare_kanji_and_integer("六千百一", 6101)
  end

  it "六千百二" do
    compare_kanji_and_integer("六千百二", 6102)
  end

  it "六千百三" do
    compare_kanji_and_integer("六千百三", 6103)
  end

  it "六千百四" do
    compare_kanji_and_integer("六千百四", 6104)
  end

  it "六千百五" do
    compare_kanji_and_integer("六千百五", 6105)
  end

  it "六千百六" do
    compare_kanji_and_integer("六千百六", 6106)
  end

  it "六千百七" do
    compare_kanji_and_integer("六千百七", 6107)
  end

  it "六千百八" do
    compare_kanji_and_integer("六千百八", 6108)
  end

  it "六千百九" do
    compare_kanji_and_integer("六千百九", 6109)
  end

  it "六千百十" do
    compare_kanji_and_integer("六千百十", 6110)
  end

  it "六千百十一" do
    compare_kanji_and_integer("六千百十一", 6111)
  end

  it "六千百十二" do
    compare_kanji_and_integer("六千百十二", 6112)
  end

  it "六千百十三" do
    compare_kanji_and_integer("六千百十三", 6113)
  end

  it "六千百十四" do
    compare_kanji_and_integer("六千百十四", 6114)
  end

  it "六千百十五" do
    compare_kanji_and_integer("六千百十五", 6115)
  end

  it "六千百十六" do
    compare_kanji_and_integer("六千百十六", 6116)
  end

  it "六千百十七" do
    compare_kanji_and_integer("六千百十七", 6117)
  end

  it "六千百十八" do
    compare_kanji_and_integer("六千百十八", 6118)
  end

  it "六千百十九" do
    compare_kanji_and_integer("六千百十九", 6119)
  end

  it "六千百二十" do
    compare_kanji_and_integer("六千百二十", 6120)
  end

  it "六千百二十一" do
    compare_kanji_and_integer("六千百二十一", 6121)
  end

  it "六千百二十二" do
    compare_kanji_and_integer("六千百二十二", 6122)
  end

  it "六千百二十三" do
    compare_kanji_and_integer("六千百二十三", 6123)
  end

  it "六千百二十四" do
    compare_kanji_and_integer("六千百二十四", 6124)
  end

  it "六千百二十五" do
    compare_kanji_and_integer("六千百二十五", 6125)
  end

  it "六千百二十六" do
    compare_kanji_and_integer("六千百二十六", 6126)
  end

  it "六千百二十七" do
    compare_kanji_and_integer("六千百二十七", 6127)
  end

  it "六千百二十八" do
    compare_kanji_and_integer("六千百二十八", 6128)
  end

  it "六千百二十九" do
    compare_kanji_and_integer("六千百二十九", 6129)
  end

  it "六千百三十" do
    compare_kanji_and_integer("六千百三十", 6130)
  end

  it "六千百三十一" do
    compare_kanji_and_integer("六千百三十一", 6131)
  end

  it "六千百三十二" do
    compare_kanji_and_integer("六千百三十二", 6132)
  end

  it "六千百三十三" do
    compare_kanji_and_integer("六千百三十三", 6133)
  end

  it "六千百三十四" do
    compare_kanji_and_integer("六千百三十四", 6134)
  end

  it "六千百三十五" do
    compare_kanji_and_integer("六千百三十五", 6135)
  end

  it "六千百三十六" do
    compare_kanji_and_integer("六千百三十六", 6136)
  end

  it "六千百三十七" do
    compare_kanji_and_integer("六千百三十七", 6137)
  end

  it "六千百三十八" do
    compare_kanji_and_integer("六千百三十八", 6138)
  end

  it "六千百三十九" do
    compare_kanji_and_integer("六千百三十九", 6139)
  end

  it "六千百四十" do
    compare_kanji_and_integer("六千百四十", 6140)
  end

  it "六千百四十一" do
    compare_kanji_and_integer("六千百四十一", 6141)
  end

  it "六千百四十二" do
    compare_kanji_and_integer("六千百四十二", 6142)
  end

  it "六千百四十三" do
    compare_kanji_and_integer("六千百四十三", 6143)
  end

  it "六千百四十四" do
    compare_kanji_and_integer("六千百四十四", 6144)
  end

  it "六千百四十五" do
    compare_kanji_and_integer("六千百四十五", 6145)
  end

  it "六千百四十六" do
    compare_kanji_and_integer("六千百四十六", 6146)
  end

  it "六千百四十七" do
    compare_kanji_and_integer("六千百四十七", 6147)
  end

  it "六千百四十八" do
    compare_kanji_and_integer("六千百四十八", 6148)
  end

  it "六千百四十九" do
    compare_kanji_and_integer("六千百四十九", 6149)
  end

  it "六千百五十" do
    compare_kanji_and_integer("六千百五十", 6150)
  end

  it "六千百五十一" do
    compare_kanji_and_integer("六千百五十一", 6151)
  end

  it "六千百五十二" do
    compare_kanji_and_integer("六千百五十二", 6152)
  end

  it "六千百五十三" do
    compare_kanji_and_integer("六千百五十三", 6153)
  end

  it "六千百五十四" do
    compare_kanji_and_integer("六千百五十四", 6154)
  end

  it "六千百五十五" do
    compare_kanji_and_integer("六千百五十五", 6155)
  end

  it "六千百五十六" do
    compare_kanji_and_integer("六千百五十六", 6156)
  end

  it "六千百五十七" do
    compare_kanji_and_integer("六千百五十七", 6157)
  end

  it "六千百五十八" do
    compare_kanji_and_integer("六千百五十八", 6158)
  end

  it "六千百五十九" do
    compare_kanji_and_integer("六千百五十九", 6159)
  end

  it "六千百六十" do
    compare_kanji_and_integer("六千百六十", 6160)
  end

  it "六千百六十一" do
    compare_kanji_and_integer("六千百六十一", 6161)
  end

  it "六千百六十二" do
    compare_kanji_and_integer("六千百六十二", 6162)
  end

  it "六千百六十三" do
    compare_kanji_and_integer("六千百六十三", 6163)
  end

  it "六千百六十四" do
    compare_kanji_and_integer("六千百六十四", 6164)
  end

  it "六千百六十五" do
    compare_kanji_and_integer("六千百六十五", 6165)
  end

  it "六千百六十六" do
    compare_kanji_and_integer("六千百六十六", 6166)
  end

  it "六千百六十七" do
    compare_kanji_and_integer("六千百六十七", 6167)
  end

  it "六千百六十八" do
    compare_kanji_and_integer("六千百六十八", 6168)
  end

  it "六千百六十九" do
    compare_kanji_and_integer("六千百六十九", 6169)
  end

  it "六千百七十" do
    compare_kanji_and_integer("六千百七十", 6170)
  end

  it "六千百七十一" do
    compare_kanji_and_integer("六千百七十一", 6171)
  end

  it "六千百七十二" do
    compare_kanji_and_integer("六千百七十二", 6172)
  end

  it "六千百七十三" do
    compare_kanji_and_integer("六千百七十三", 6173)
  end

  it "六千百七十四" do
    compare_kanji_and_integer("六千百七十四", 6174)
  end

  it "六千百七十五" do
    compare_kanji_and_integer("六千百七十五", 6175)
  end

  it "六千百七十六" do
    compare_kanji_and_integer("六千百七十六", 6176)
  end

  it "六千百七十七" do
    compare_kanji_and_integer("六千百七十七", 6177)
  end

  it "六千百七十八" do
    compare_kanji_and_integer("六千百七十八", 6178)
  end

  it "六千百七十九" do
    compare_kanji_and_integer("六千百七十九", 6179)
  end

  it "六千百八十" do
    compare_kanji_and_integer("六千百八十", 6180)
  end

  it "六千百八十一" do
    compare_kanji_and_integer("六千百八十一", 6181)
  end

  it "六千百八十二" do
    compare_kanji_and_integer("六千百八十二", 6182)
  end

  it "六千百八十三" do
    compare_kanji_and_integer("六千百八十三", 6183)
  end

  it "六千百八十四" do
    compare_kanji_and_integer("六千百八十四", 6184)
  end

  it "六千百八十五" do
    compare_kanji_and_integer("六千百八十五", 6185)
  end

  it "六千百八十六" do
    compare_kanji_and_integer("六千百八十六", 6186)
  end

  it "六千百八十七" do
    compare_kanji_and_integer("六千百八十七", 6187)
  end

  it "六千百八十八" do
    compare_kanji_and_integer("六千百八十八", 6188)
  end

  it "六千百八十九" do
    compare_kanji_and_integer("六千百八十九", 6189)
  end

  it "六千百九十" do
    compare_kanji_and_integer("六千百九十", 6190)
  end

  it "六千百九十一" do
    compare_kanji_and_integer("六千百九十一", 6191)
  end

  it "六千百九十二" do
    compare_kanji_and_integer("六千百九十二", 6192)
  end

  it "六千百九十三" do
    compare_kanji_and_integer("六千百九十三", 6193)
  end

  it "六千百九十四" do
    compare_kanji_and_integer("六千百九十四", 6194)
  end

  it "六千百九十五" do
    compare_kanji_and_integer("六千百九十五", 6195)
  end

  it "六千百九十六" do
    compare_kanji_and_integer("六千百九十六", 6196)
  end

  it "六千百九十七" do
    compare_kanji_and_integer("六千百九十七", 6197)
  end

  it "六千百九十八" do
    compare_kanji_and_integer("六千百九十八", 6198)
  end

  it "六千百九十九" do
    compare_kanji_and_integer("六千百九十九", 6199)
  end

  it "六千二百" do
    compare_kanji_and_integer("六千二百", 6200)
  end

  it "六千二百一" do
    compare_kanji_and_integer("六千二百一", 6201)
  end

  it "六千二百二" do
    compare_kanji_and_integer("六千二百二", 6202)
  end

  it "六千二百三" do
    compare_kanji_and_integer("六千二百三", 6203)
  end

  it "六千二百四" do
    compare_kanji_and_integer("六千二百四", 6204)
  end

  it "六千二百五" do
    compare_kanji_and_integer("六千二百五", 6205)
  end

  it "六千二百六" do
    compare_kanji_and_integer("六千二百六", 6206)
  end

  it "六千二百七" do
    compare_kanji_and_integer("六千二百七", 6207)
  end

  it "六千二百八" do
    compare_kanji_and_integer("六千二百八", 6208)
  end

  it "六千二百九" do
    compare_kanji_and_integer("六千二百九", 6209)
  end

  it "六千二百十" do
    compare_kanji_and_integer("六千二百十", 6210)
  end

  it "六千二百十一" do
    compare_kanji_and_integer("六千二百十一", 6211)
  end

  it "六千二百十二" do
    compare_kanji_and_integer("六千二百十二", 6212)
  end

  it "六千二百十三" do
    compare_kanji_and_integer("六千二百十三", 6213)
  end

  it "六千二百十四" do
    compare_kanji_and_integer("六千二百十四", 6214)
  end

  it "六千二百十五" do
    compare_kanji_and_integer("六千二百十五", 6215)
  end

  it "六千二百十六" do
    compare_kanji_and_integer("六千二百十六", 6216)
  end

  it "六千二百十七" do
    compare_kanji_and_integer("六千二百十七", 6217)
  end

  it "六千二百十八" do
    compare_kanji_and_integer("六千二百十八", 6218)
  end

  it "六千二百十九" do
    compare_kanji_and_integer("六千二百十九", 6219)
  end

  it "六千二百二十" do
    compare_kanji_and_integer("六千二百二十", 6220)
  end

  it "六千二百二十一" do
    compare_kanji_and_integer("六千二百二十一", 6221)
  end

  it "六千二百二十二" do
    compare_kanji_and_integer("六千二百二十二", 6222)
  end

  it "六千二百二十三" do
    compare_kanji_and_integer("六千二百二十三", 6223)
  end

  it "六千二百二十四" do
    compare_kanji_and_integer("六千二百二十四", 6224)
  end

  it "六千二百二十五" do
    compare_kanji_and_integer("六千二百二十五", 6225)
  end

  it "六千二百二十六" do
    compare_kanji_and_integer("六千二百二十六", 6226)
  end

  it "六千二百二十七" do
    compare_kanji_and_integer("六千二百二十七", 6227)
  end

  it "六千二百二十八" do
    compare_kanji_and_integer("六千二百二十八", 6228)
  end

  it "六千二百二十九" do
    compare_kanji_and_integer("六千二百二十九", 6229)
  end

  it "六千二百三十" do
    compare_kanji_and_integer("六千二百三十", 6230)
  end

  it "六千二百三十一" do
    compare_kanji_and_integer("六千二百三十一", 6231)
  end

  it "六千二百三十二" do
    compare_kanji_and_integer("六千二百三十二", 6232)
  end

  it "六千二百三十三" do
    compare_kanji_and_integer("六千二百三十三", 6233)
  end

  it "六千二百三十四" do
    compare_kanji_and_integer("六千二百三十四", 6234)
  end

  it "六千二百三十五" do
    compare_kanji_and_integer("六千二百三十五", 6235)
  end

  it "六千二百三十六" do
    compare_kanji_and_integer("六千二百三十六", 6236)
  end

  it "六千二百三十七" do
    compare_kanji_and_integer("六千二百三十七", 6237)
  end

  it "六千二百三十八" do
    compare_kanji_and_integer("六千二百三十八", 6238)
  end

  it "六千二百三十九" do
    compare_kanji_and_integer("六千二百三十九", 6239)
  end

  it "六千二百四十" do
    compare_kanji_and_integer("六千二百四十", 6240)
  end

  it "六千二百四十一" do
    compare_kanji_and_integer("六千二百四十一", 6241)
  end

  it "六千二百四十二" do
    compare_kanji_and_integer("六千二百四十二", 6242)
  end

  it "六千二百四十三" do
    compare_kanji_and_integer("六千二百四十三", 6243)
  end

  it "六千二百四十四" do
    compare_kanji_and_integer("六千二百四十四", 6244)
  end

  it "六千二百四十五" do
    compare_kanji_and_integer("六千二百四十五", 6245)
  end

  it "六千二百四十六" do
    compare_kanji_and_integer("六千二百四十六", 6246)
  end

  it "六千二百四十七" do
    compare_kanji_and_integer("六千二百四十七", 6247)
  end

  it "六千二百四十八" do
    compare_kanji_and_integer("六千二百四十八", 6248)
  end

  it "六千二百四十九" do
    compare_kanji_and_integer("六千二百四十九", 6249)
  end

  it "六千二百五十" do
    compare_kanji_and_integer("六千二百五十", 6250)
  end

  it "六千二百五十一" do
    compare_kanji_and_integer("六千二百五十一", 6251)
  end

  it "六千二百五十二" do
    compare_kanji_and_integer("六千二百五十二", 6252)
  end

  it "六千二百五十三" do
    compare_kanji_and_integer("六千二百五十三", 6253)
  end

  it "六千二百五十四" do
    compare_kanji_and_integer("六千二百五十四", 6254)
  end

  it "六千二百五十五" do
    compare_kanji_and_integer("六千二百五十五", 6255)
  end

  it "六千二百五十六" do
    compare_kanji_and_integer("六千二百五十六", 6256)
  end

  it "六千二百五十七" do
    compare_kanji_and_integer("六千二百五十七", 6257)
  end

  it "六千二百五十八" do
    compare_kanji_and_integer("六千二百五十八", 6258)
  end

  it "六千二百五十九" do
    compare_kanji_and_integer("六千二百五十九", 6259)
  end

  it "六千二百六十" do
    compare_kanji_and_integer("六千二百六十", 6260)
  end

  it "六千二百六十一" do
    compare_kanji_and_integer("六千二百六十一", 6261)
  end

  it "六千二百六十二" do
    compare_kanji_and_integer("六千二百六十二", 6262)
  end

  it "六千二百六十三" do
    compare_kanji_and_integer("六千二百六十三", 6263)
  end

  it "六千二百六十四" do
    compare_kanji_and_integer("六千二百六十四", 6264)
  end

  it "六千二百六十五" do
    compare_kanji_and_integer("六千二百六十五", 6265)
  end

  it "六千二百六十六" do
    compare_kanji_and_integer("六千二百六十六", 6266)
  end

  it "六千二百六十七" do
    compare_kanji_and_integer("六千二百六十七", 6267)
  end

  it "六千二百六十八" do
    compare_kanji_and_integer("六千二百六十八", 6268)
  end

  it "六千二百六十九" do
    compare_kanji_and_integer("六千二百六十九", 6269)
  end

  it "六千二百七十" do
    compare_kanji_and_integer("六千二百七十", 6270)
  end

  it "六千二百七十一" do
    compare_kanji_and_integer("六千二百七十一", 6271)
  end

  it "六千二百七十二" do
    compare_kanji_and_integer("六千二百七十二", 6272)
  end

  it "六千二百七十三" do
    compare_kanji_and_integer("六千二百七十三", 6273)
  end

  it "六千二百七十四" do
    compare_kanji_and_integer("六千二百七十四", 6274)
  end

  it "六千二百七十五" do
    compare_kanji_and_integer("六千二百七十五", 6275)
  end

  it "六千二百七十六" do
    compare_kanji_and_integer("六千二百七十六", 6276)
  end

  it "六千二百七十七" do
    compare_kanji_and_integer("六千二百七十七", 6277)
  end

  it "六千二百七十八" do
    compare_kanji_and_integer("六千二百七十八", 6278)
  end

  it "六千二百七十九" do
    compare_kanji_and_integer("六千二百七十九", 6279)
  end

  it "六千二百八十" do
    compare_kanji_and_integer("六千二百八十", 6280)
  end

  it "六千二百八十一" do
    compare_kanji_and_integer("六千二百八十一", 6281)
  end

  it "六千二百八十二" do
    compare_kanji_and_integer("六千二百八十二", 6282)
  end

  it "六千二百八十三" do
    compare_kanji_and_integer("六千二百八十三", 6283)
  end

  it "六千二百八十四" do
    compare_kanji_and_integer("六千二百八十四", 6284)
  end

  it "六千二百八十五" do
    compare_kanji_and_integer("六千二百八十五", 6285)
  end

  it "六千二百八十六" do
    compare_kanji_and_integer("六千二百八十六", 6286)
  end

  it "六千二百八十七" do
    compare_kanji_and_integer("六千二百八十七", 6287)
  end

  it "六千二百八十八" do
    compare_kanji_and_integer("六千二百八十八", 6288)
  end

  it "六千二百八十九" do
    compare_kanji_and_integer("六千二百八十九", 6289)
  end

  it "六千二百九十" do
    compare_kanji_and_integer("六千二百九十", 6290)
  end

  it "六千二百九十一" do
    compare_kanji_and_integer("六千二百九十一", 6291)
  end

  it "六千二百九十二" do
    compare_kanji_and_integer("六千二百九十二", 6292)
  end

  it "六千二百九十三" do
    compare_kanji_and_integer("六千二百九十三", 6293)
  end

  it "六千二百九十四" do
    compare_kanji_and_integer("六千二百九十四", 6294)
  end

  it "六千二百九十五" do
    compare_kanji_and_integer("六千二百九十五", 6295)
  end

  it "六千二百九十六" do
    compare_kanji_and_integer("六千二百九十六", 6296)
  end

  it "六千二百九十七" do
    compare_kanji_and_integer("六千二百九十七", 6297)
  end

  it "六千二百九十八" do
    compare_kanji_and_integer("六千二百九十八", 6298)
  end

  it "六千二百九十九" do
    compare_kanji_and_integer("六千二百九十九", 6299)
  end

  it "六千三百" do
    compare_kanji_and_integer("六千三百", 6300)
  end

  it "六千三百一" do
    compare_kanji_and_integer("六千三百一", 6301)
  end

  it "六千三百二" do
    compare_kanji_and_integer("六千三百二", 6302)
  end

  it "六千三百三" do
    compare_kanji_and_integer("六千三百三", 6303)
  end

  it "六千三百四" do
    compare_kanji_and_integer("六千三百四", 6304)
  end

  it "六千三百五" do
    compare_kanji_and_integer("六千三百五", 6305)
  end

  it "六千三百六" do
    compare_kanji_and_integer("六千三百六", 6306)
  end

  it "六千三百七" do
    compare_kanji_and_integer("六千三百七", 6307)
  end

  it "六千三百八" do
    compare_kanji_and_integer("六千三百八", 6308)
  end

  it "六千三百九" do
    compare_kanji_and_integer("六千三百九", 6309)
  end

  it "六千三百十" do
    compare_kanji_and_integer("六千三百十", 6310)
  end

  it "六千三百十一" do
    compare_kanji_and_integer("六千三百十一", 6311)
  end

  it "六千三百十二" do
    compare_kanji_and_integer("六千三百十二", 6312)
  end

  it "六千三百十三" do
    compare_kanji_and_integer("六千三百十三", 6313)
  end

  it "六千三百十四" do
    compare_kanji_and_integer("六千三百十四", 6314)
  end

  it "六千三百十五" do
    compare_kanji_and_integer("六千三百十五", 6315)
  end

  it "六千三百十六" do
    compare_kanji_and_integer("六千三百十六", 6316)
  end

  it "六千三百十七" do
    compare_kanji_and_integer("六千三百十七", 6317)
  end

  it "六千三百十八" do
    compare_kanji_and_integer("六千三百十八", 6318)
  end

  it "六千三百十九" do
    compare_kanji_and_integer("六千三百十九", 6319)
  end

  it "六千三百二十" do
    compare_kanji_and_integer("六千三百二十", 6320)
  end

  it "六千三百二十一" do
    compare_kanji_and_integer("六千三百二十一", 6321)
  end

  it "六千三百二十二" do
    compare_kanji_and_integer("六千三百二十二", 6322)
  end

  it "六千三百二十三" do
    compare_kanji_and_integer("六千三百二十三", 6323)
  end

  it "六千三百二十四" do
    compare_kanji_and_integer("六千三百二十四", 6324)
  end

  it "六千三百二十五" do
    compare_kanji_and_integer("六千三百二十五", 6325)
  end

  it "六千三百二十六" do
    compare_kanji_and_integer("六千三百二十六", 6326)
  end

  it "六千三百二十七" do
    compare_kanji_and_integer("六千三百二十七", 6327)
  end

  it "六千三百二十八" do
    compare_kanji_and_integer("六千三百二十八", 6328)
  end

  it "六千三百二十九" do
    compare_kanji_and_integer("六千三百二十九", 6329)
  end

  it "六千三百三十" do
    compare_kanji_and_integer("六千三百三十", 6330)
  end

  it "六千三百三十一" do
    compare_kanji_and_integer("六千三百三十一", 6331)
  end

  it "六千三百三十二" do
    compare_kanji_and_integer("六千三百三十二", 6332)
  end

  it "六千三百三十三" do
    compare_kanji_and_integer("六千三百三十三", 6333)
  end

  it "六千三百三十四" do
    compare_kanji_and_integer("六千三百三十四", 6334)
  end

  it "六千三百三十五" do
    compare_kanji_and_integer("六千三百三十五", 6335)
  end

  it "六千三百三十六" do
    compare_kanji_and_integer("六千三百三十六", 6336)
  end

  it "六千三百三十七" do
    compare_kanji_and_integer("六千三百三十七", 6337)
  end

  it "六千三百三十八" do
    compare_kanji_and_integer("六千三百三十八", 6338)
  end

  it "六千三百三十九" do
    compare_kanji_and_integer("六千三百三十九", 6339)
  end

  it "六千三百四十" do
    compare_kanji_and_integer("六千三百四十", 6340)
  end

  it "六千三百四十一" do
    compare_kanji_and_integer("六千三百四十一", 6341)
  end

  it "六千三百四十二" do
    compare_kanji_and_integer("六千三百四十二", 6342)
  end

  it "六千三百四十三" do
    compare_kanji_and_integer("六千三百四十三", 6343)
  end

  it "六千三百四十四" do
    compare_kanji_and_integer("六千三百四十四", 6344)
  end

  it "六千三百四十五" do
    compare_kanji_and_integer("六千三百四十五", 6345)
  end

  it "六千三百四十六" do
    compare_kanji_and_integer("六千三百四十六", 6346)
  end

  it "六千三百四十七" do
    compare_kanji_and_integer("六千三百四十七", 6347)
  end

  it "六千三百四十八" do
    compare_kanji_and_integer("六千三百四十八", 6348)
  end

  it "六千三百四十九" do
    compare_kanji_and_integer("六千三百四十九", 6349)
  end

  it "六千三百五十" do
    compare_kanji_and_integer("六千三百五十", 6350)
  end

  it "六千三百五十一" do
    compare_kanji_and_integer("六千三百五十一", 6351)
  end

  it "六千三百五十二" do
    compare_kanji_and_integer("六千三百五十二", 6352)
  end

  it "六千三百五十三" do
    compare_kanji_and_integer("六千三百五十三", 6353)
  end

  it "六千三百五十四" do
    compare_kanji_and_integer("六千三百五十四", 6354)
  end

  it "六千三百五十五" do
    compare_kanji_and_integer("六千三百五十五", 6355)
  end

  it "六千三百五十六" do
    compare_kanji_and_integer("六千三百五十六", 6356)
  end

  it "六千三百五十七" do
    compare_kanji_and_integer("六千三百五十七", 6357)
  end

  it "六千三百五十八" do
    compare_kanji_and_integer("六千三百五十八", 6358)
  end

  it "六千三百五十九" do
    compare_kanji_and_integer("六千三百五十九", 6359)
  end

  it "六千三百六十" do
    compare_kanji_and_integer("六千三百六十", 6360)
  end

  it "六千三百六十一" do
    compare_kanji_and_integer("六千三百六十一", 6361)
  end

  it "六千三百六十二" do
    compare_kanji_and_integer("六千三百六十二", 6362)
  end

  it "六千三百六十三" do
    compare_kanji_and_integer("六千三百六十三", 6363)
  end

  it "六千三百六十四" do
    compare_kanji_and_integer("六千三百六十四", 6364)
  end

  it "六千三百六十五" do
    compare_kanji_and_integer("六千三百六十五", 6365)
  end

  it "六千三百六十六" do
    compare_kanji_and_integer("六千三百六十六", 6366)
  end

  it "六千三百六十七" do
    compare_kanji_and_integer("六千三百六十七", 6367)
  end

  it "六千三百六十八" do
    compare_kanji_and_integer("六千三百六十八", 6368)
  end

  it "六千三百六十九" do
    compare_kanji_and_integer("六千三百六十九", 6369)
  end

  it "六千三百七十" do
    compare_kanji_and_integer("六千三百七十", 6370)
  end

  it "六千三百七十一" do
    compare_kanji_and_integer("六千三百七十一", 6371)
  end

  it "六千三百七十二" do
    compare_kanji_and_integer("六千三百七十二", 6372)
  end

  it "六千三百七十三" do
    compare_kanji_and_integer("六千三百七十三", 6373)
  end

  it "六千三百七十四" do
    compare_kanji_and_integer("六千三百七十四", 6374)
  end

  it "六千三百七十五" do
    compare_kanji_and_integer("六千三百七十五", 6375)
  end

  it "六千三百七十六" do
    compare_kanji_and_integer("六千三百七十六", 6376)
  end

  it "六千三百七十七" do
    compare_kanji_and_integer("六千三百七十七", 6377)
  end

  it "六千三百七十八" do
    compare_kanji_and_integer("六千三百七十八", 6378)
  end

  it "六千三百七十九" do
    compare_kanji_and_integer("六千三百七十九", 6379)
  end

  it "六千三百八十" do
    compare_kanji_and_integer("六千三百八十", 6380)
  end

  it "六千三百八十一" do
    compare_kanji_and_integer("六千三百八十一", 6381)
  end

  it "六千三百八十二" do
    compare_kanji_and_integer("六千三百八十二", 6382)
  end

  it "六千三百八十三" do
    compare_kanji_and_integer("六千三百八十三", 6383)
  end

  it "六千三百八十四" do
    compare_kanji_and_integer("六千三百八十四", 6384)
  end

  it "六千三百八十五" do
    compare_kanji_and_integer("六千三百八十五", 6385)
  end

  it "六千三百八十六" do
    compare_kanji_and_integer("六千三百八十六", 6386)
  end

  it "六千三百八十七" do
    compare_kanji_and_integer("六千三百八十七", 6387)
  end

  it "六千三百八十八" do
    compare_kanji_and_integer("六千三百八十八", 6388)
  end

  it "六千三百八十九" do
    compare_kanji_and_integer("六千三百八十九", 6389)
  end

  it "六千三百九十" do
    compare_kanji_and_integer("六千三百九十", 6390)
  end

  it "六千三百九十一" do
    compare_kanji_and_integer("六千三百九十一", 6391)
  end

  it "六千三百九十二" do
    compare_kanji_and_integer("六千三百九十二", 6392)
  end

  it "六千三百九十三" do
    compare_kanji_and_integer("六千三百九十三", 6393)
  end

  it "六千三百九十四" do
    compare_kanji_and_integer("六千三百九十四", 6394)
  end

  it "六千三百九十五" do
    compare_kanji_and_integer("六千三百九十五", 6395)
  end

  it "六千三百九十六" do
    compare_kanji_and_integer("六千三百九十六", 6396)
  end

  it "六千三百九十七" do
    compare_kanji_and_integer("六千三百九十七", 6397)
  end

  it "六千三百九十八" do
    compare_kanji_and_integer("六千三百九十八", 6398)
  end

  it "六千三百九十九" do
    compare_kanji_and_integer("六千三百九十九", 6399)
  end

  it "六千四百" do
    compare_kanji_and_integer("六千四百", 6400)
  end

  it "六千四百一" do
    compare_kanji_and_integer("六千四百一", 6401)
  end

  it "六千四百二" do
    compare_kanji_and_integer("六千四百二", 6402)
  end

  it "六千四百三" do
    compare_kanji_and_integer("六千四百三", 6403)
  end

  it "六千四百四" do
    compare_kanji_and_integer("六千四百四", 6404)
  end

  it "六千四百五" do
    compare_kanji_and_integer("六千四百五", 6405)
  end

  it "六千四百六" do
    compare_kanji_and_integer("六千四百六", 6406)
  end

  it "六千四百七" do
    compare_kanji_and_integer("六千四百七", 6407)
  end

  it "六千四百八" do
    compare_kanji_and_integer("六千四百八", 6408)
  end

  it "六千四百九" do
    compare_kanji_and_integer("六千四百九", 6409)
  end

  it "六千四百十" do
    compare_kanji_and_integer("六千四百十", 6410)
  end

  it "六千四百十一" do
    compare_kanji_and_integer("六千四百十一", 6411)
  end

  it "六千四百十二" do
    compare_kanji_and_integer("六千四百十二", 6412)
  end

  it "六千四百十三" do
    compare_kanji_and_integer("六千四百十三", 6413)
  end

  it "六千四百十四" do
    compare_kanji_and_integer("六千四百十四", 6414)
  end

  it "六千四百十五" do
    compare_kanji_and_integer("六千四百十五", 6415)
  end

  it "六千四百十六" do
    compare_kanji_and_integer("六千四百十六", 6416)
  end

  it "六千四百十七" do
    compare_kanji_and_integer("六千四百十七", 6417)
  end

  it "六千四百十八" do
    compare_kanji_and_integer("六千四百十八", 6418)
  end

  it "六千四百十九" do
    compare_kanji_and_integer("六千四百十九", 6419)
  end

  it "六千四百二十" do
    compare_kanji_and_integer("六千四百二十", 6420)
  end

  it "六千四百二十一" do
    compare_kanji_and_integer("六千四百二十一", 6421)
  end

  it "六千四百二十二" do
    compare_kanji_and_integer("六千四百二十二", 6422)
  end

  it "六千四百二十三" do
    compare_kanji_and_integer("六千四百二十三", 6423)
  end

  it "六千四百二十四" do
    compare_kanji_and_integer("六千四百二十四", 6424)
  end

  it "六千四百二十五" do
    compare_kanji_and_integer("六千四百二十五", 6425)
  end

  it "六千四百二十六" do
    compare_kanji_and_integer("六千四百二十六", 6426)
  end

  it "六千四百二十七" do
    compare_kanji_and_integer("六千四百二十七", 6427)
  end

  it "六千四百二十八" do
    compare_kanji_and_integer("六千四百二十八", 6428)
  end

  it "六千四百二十九" do
    compare_kanji_and_integer("六千四百二十九", 6429)
  end

  it "六千四百三十" do
    compare_kanji_and_integer("六千四百三十", 6430)
  end

  it "六千四百三十一" do
    compare_kanji_and_integer("六千四百三十一", 6431)
  end

  it "六千四百三十二" do
    compare_kanji_and_integer("六千四百三十二", 6432)
  end

  it "六千四百三十三" do
    compare_kanji_and_integer("六千四百三十三", 6433)
  end

  it "六千四百三十四" do
    compare_kanji_and_integer("六千四百三十四", 6434)
  end

  it "六千四百三十五" do
    compare_kanji_and_integer("六千四百三十五", 6435)
  end

  it "六千四百三十六" do
    compare_kanji_and_integer("六千四百三十六", 6436)
  end

  it "六千四百三十七" do
    compare_kanji_and_integer("六千四百三十七", 6437)
  end

  it "六千四百三十八" do
    compare_kanji_and_integer("六千四百三十八", 6438)
  end

  it "六千四百三十九" do
    compare_kanji_and_integer("六千四百三十九", 6439)
  end

  it "六千四百四十" do
    compare_kanji_and_integer("六千四百四十", 6440)
  end

  it "六千四百四十一" do
    compare_kanji_and_integer("六千四百四十一", 6441)
  end

  it "六千四百四十二" do
    compare_kanji_and_integer("六千四百四十二", 6442)
  end

  it "六千四百四十三" do
    compare_kanji_and_integer("六千四百四十三", 6443)
  end

  it "六千四百四十四" do
    compare_kanji_and_integer("六千四百四十四", 6444)
  end

  it "六千四百四十五" do
    compare_kanji_and_integer("六千四百四十五", 6445)
  end

  it "六千四百四十六" do
    compare_kanji_and_integer("六千四百四十六", 6446)
  end

  it "六千四百四十七" do
    compare_kanji_and_integer("六千四百四十七", 6447)
  end

  it "六千四百四十八" do
    compare_kanji_and_integer("六千四百四十八", 6448)
  end

  it "六千四百四十九" do
    compare_kanji_and_integer("六千四百四十九", 6449)
  end

  it "六千四百五十" do
    compare_kanji_and_integer("六千四百五十", 6450)
  end

  it "六千四百五十一" do
    compare_kanji_and_integer("六千四百五十一", 6451)
  end

  it "六千四百五十二" do
    compare_kanji_and_integer("六千四百五十二", 6452)
  end

  it "六千四百五十三" do
    compare_kanji_and_integer("六千四百五十三", 6453)
  end

  it "六千四百五十四" do
    compare_kanji_and_integer("六千四百五十四", 6454)
  end

  it "六千四百五十五" do
    compare_kanji_and_integer("六千四百五十五", 6455)
  end

  it "六千四百五十六" do
    compare_kanji_and_integer("六千四百五十六", 6456)
  end

  it "六千四百五十七" do
    compare_kanji_and_integer("六千四百五十七", 6457)
  end

  it "六千四百五十八" do
    compare_kanji_and_integer("六千四百五十八", 6458)
  end

  it "六千四百五十九" do
    compare_kanji_and_integer("六千四百五十九", 6459)
  end

  it "六千四百六十" do
    compare_kanji_and_integer("六千四百六十", 6460)
  end

  it "六千四百六十一" do
    compare_kanji_and_integer("六千四百六十一", 6461)
  end

  it "六千四百六十二" do
    compare_kanji_and_integer("六千四百六十二", 6462)
  end

  it "六千四百六十三" do
    compare_kanji_and_integer("六千四百六十三", 6463)
  end

  it "六千四百六十四" do
    compare_kanji_and_integer("六千四百六十四", 6464)
  end

  it "六千四百六十五" do
    compare_kanji_and_integer("六千四百六十五", 6465)
  end

  it "六千四百六十六" do
    compare_kanji_and_integer("六千四百六十六", 6466)
  end

  it "六千四百六十七" do
    compare_kanji_and_integer("六千四百六十七", 6467)
  end

  it "六千四百六十八" do
    compare_kanji_and_integer("六千四百六十八", 6468)
  end

  it "六千四百六十九" do
    compare_kanji_and_integer("六千四百六十九", 6469)
  end

  it "六千四百七十" do
    compare_kanji_and_integer("六千四百七十", 6470)
  end

  it "六千四百七十一" do
    compare_kanji_and_integer("六千四百七十一", 6471)
  end

  it "六千四百七十二" do
    compare_kanji_and_integer("六千四百七十二", 6472)
  end

  it "六千四百七十三" do
    compare_kanji_and_integer("六千四百七十三", 6473)
  end

  it "六千四百七十四" do
    compare_kanji_and_integer("六千四百七十四", 6474)
  end

  it "六千四百七十五" do
    compare_kanji_and_integer("六千四百七十五", 6475)
  end

  it "六千四百七十六" do
    compare_kanji_and_integer("六千四百七十六", 6476)
  end

  it "六千四百七十七" do
    compare_kanji_and_integer("六千四百七十七", 6477)
  end

  it "六千四百七十八" do
    compare_kanji_and_integer("六千四百七十八", 6478)
  end

  it "六千四百七十九" do
    compare_kanji_and_integer("六千四百七十九", 6479)
  end

  it "六千四百八十" do
    compare_kanji_and_integer("六千四百八十", 6480)
  end

  it "六千四百八十一" do
    compare_kanji_and_integer("六千四百八十一", 6481)
  end

  it "六千四百八十二" do
    compare_kanji_and_integer("六千四百八十二", 6482)
  end

  it "六千四百八十三" do
    compare_kanji_and_integer("六千四百八十三", 6483)
  end

  it "六千四百八十四" do
    compare_kanji_and_integer("六千四百八十四", 6484)
  end

  it "六千四百八十五" do
    compare_kanji_and_integer("六千四百八十五", 6485)
  end

  it "六千四百八十六" do
    compare_kanji_and_integer("六千四百八十六", 6486)
  end

  it "六千四百八十七" do
    compare_kanji_and_integer("六千四百八十七", 6487)
  end

  it "六千四百八十八" do
    compare_kanji_and_integer("六千四百八十八", 6488)
  end

  it "六千四百八十九" do
    compare_kanji_and_integer("六千四百八十九", 6489)
  end

  it "六千四百九十" do
    compare_kanji_and_integer("六千四百九十", 6490)
  end

  it "六千四百九十一" do
    compare_kanji_and_integer("六千四百九十一", 6491)
  end

  it "六千四百九十二" do
    compare_kanji_and_integer("六千四百九十二", 6492)
  end

  it "六千四百九十三" do
    compare_kanji_and_integer("六千四百九十三", 6493)
  end

  it "六千四百九十四" do
    compare_kanji_and_integer("六千四百九十四", 6494)
  end

  it "六千四百九十五" do
    compare_kanji_and_integer("六千四百九十五", 6495)
  end

  it "六千四百九十六" do
    compare_kanji_and_integer("六千四百九十六", 6496)
  end

  it "六千四百九十七" do
    compare_kanji_and_integer("六千四百九十七", 6497)
  end

  it "六千四百九十八" do
    compare_kanji_and_integer("六千四百九十八", 6498)
  end

  it "六千四百九十九" do
    compare_kanji_and_integer("六千四百九十九", 6499)
  end

  it "六千五百" do
    compare_kanji_and_integer("六千五百", 6500)
  end

  it "六千五百一" do
    compare_kanji_and_integer("六千五百一", 6501)
  end

  it "六千五百二" do
    compare_kanji_and_integer("六千五百二", 6502)
  end

  it "六千五百三" do
    compare_kanji_and_integer("六千五百三", 6503)
  end

  it "六千五百四" do
    compare_kanji_and_integer("六千五百四", 6504)
  end

  it "六千五百五" do
    compare_kanji_and_integer("六千五百五", 6505)
  end

  it "六千五百六" do
    compare_kanji_and_integer("六千五百六", 6506)
  end

  it "六千五百七" do
    compare_kanji_and_integer("六千五百七", 6507)
  end

  it "六千五百八" do
    compare_kanji_and_integer("六千五百八", 6508)
  end

  it "六千五百九" do
    compare_kanji_and_integer("六千五百九", 6509)
  end

  it "六千五百十" do
    compare_kanji_and_integer("六千五百十", 6510)
  end

  it "六千五百十一" do
    compare_kanji_and_integer("六千五百十一", 6511)
  end

  it "六千五百十二" do
    compare_kanji_and_integer("六千五百十二", 6512)
  end

  it "六千五百十三" do
    compare_kanji_and_integer("六千五百十三", 6513)
  end

  it "六千五百十四" do
    compare_kanji_and_integer("六千五百十四", 6514)
  end

  it "六千五百十五" do
    compare_kanji_and_integer("六千五百十五", 6515)
  end

  it "六千五百十六" do
    compare_kanji_and_integer("六千五百十六", 6516)
  end

  it "六千五百十七" do
    compare_kanji_and_integer("六千五百十七", 6517)
  end

  it "六千五百十八" do
    compare_kanji_and_integer("六千五百十八", 6518)
  end

  it "六千五百十九" do
    compare_kanji_and_integer("六千五百十九", 6519)
  end

  it "六千五百二十" do
    compare_kanji_and_integer("六千五百二十", 6520)
  end

  it "六千五百二十一" do
    compare_kanji_and_integer("六千五百二十一", 6521)
  end

  it "六千五百二十二" do
    compare_kanji_and_integer("六千五百二十二", 6522)
  end

  it "六千五百二十三" do
    compare_kanji_and_integer("六千五百二十三", 6523)
  end

  it "六千五百二十四" do
    compare_kanji_and_integer("六千五百二十四", 6524)
  end

  it "六千五百二十五" do
    compare_kanji_and_integer("六千五百二十五", 6525)
  end

  it "六千五百二十六" do
    compare_kanji_and_integer("六千五百二十六", 6526)
  end

  it "六千五百二十七" do
    compare_kanji_and_integer("六千五百二十七", 6527)
  end

  it "六千五百二十八" do
    compare_kanji_and_integer("六千五百二十八", 6528)
  end

  it "六千五百二十九" do
    compare_kanji_and_integer("六千五百二十九", 6529)
  end

  it "六千五百三十" do
    compare_kanji_and_integer("六千五百三十", 6530)
  end

  it "六千五百三十一" do
    compare_kanji_and_integer("六千五百三十一", 6531)
  end

  it "六千五百三十二" do
    compare_kanji_and_integer("六千五百三十二", 6532)
  end

  it "六千五百三十三" do
    compare_kanji_and_integer("六千五百三十三", 6533)
  end

  it "六千五百三十四" do
    compare_kanji_and_integer("六千五百三十四", 6534)
  end

  it "六千五百三十五" do
    compare_kanji_and_integer("六千五百三十五", 6535)
  end

  it "六千五百三十六" do
    compare_kanji_and_integer("六千五百三十六", 6536)
  end

  it "六千五百三十七" do
    compare_kanji_and_integer("六千五百三十七", 6537)
  end

  it "六千五百三十八" do
    compare_kanji_and_integer("六千五百三十八", 6538)
  end

  it "六千五百三十九" do
    compare_kanji_and_integer("六千五百三十九", 6539)
  end

  it "六千五百四十" do
    compare_kanji_and_integer("六千五百四十", 6540)
  end

  it "六千五百四十一" do
    compare_kanji_and_integer("六千五百四十一", 6541)
  end

  it "六千五百四十二" do
    compare_kanji_and_integer("六千五百四十二", 6542)
  end

  it "六千五百四十三" do
    compare_kanji_and_integer("六千五百四十三", 6543)
  end

  it "六千五百四十四" do
    compare_kanji_and_integer("六千五百四十四", 6544)
  end

  it "六千五百四十五" do
    compare_kanji_and_integer("六千五百四十五", 6545)
  end

  it "六千五百四十六" do
    compare_kanji_and_integer("六千五百四十六", 6546)
  end

  it "六千五百四十七" do
    compare_kanji_and_integer("六千五百四十七", 6547)
  end

  it "六千五百四十八" do
    compare_kanji_and_integer("六千五百四十八", 6548)
  end

  it "六千五百四十九" do
    compare_kanji_and_integer("六千五百四十九", 6549)
  end

  it "六千五百五十" do
    compare_kanji_and_integer("六千五百五十", 6550)
  end

  it "六千五百五十一" do
    compare_kanji_and_integer("六千五百五十一", 6551)
  end

  it "六千五百五十二" do
    compare_kanji_and_integer("六千五百五十二", 6552)
  end

  it "六千五百五十三" do
    compare_kanji_and_integer("六千五百五十三", 6553)
  end

  it "六千五百五十四" do
    compare_kanji_and_integer("六千五百五十四", 6554)
  end

  it "六千五百五十五" do
    compare_kanji_and_integer("六千五百五十五", 6555)
  end

  it "六千五百五十六" do
    compare_kanji_and_integer("六千五百五十六", 6556)
  end

  it "六千五百五十七" do
    compare_kanji_and_integer("六千五百五十七", 6557)
  end

  it "六千五百五十八" do
    compare_kanji_and_integer("六千五百五十八", 6558)
  end

  it "六千五百五十九" do
    compare_kanji_and_integer("六千五百五十九", 6559)
  end

  it "六千五百六十" do
    compare_kanji_and_integer("六千五百六十", 6560)
  end

  it "六千五百六十一" do
    compare_kanji_and_integer("六千五百六十一", 6561)
  end

  it "六千五百六十二" do
    compare_kanji_and_integer("六千五百六十二", 6562)
  end

  it "六千五百六十三" do
    compare_kanji_and_integer("六千五百六十三", 6563)
  end

  it "六千五百六十四" do
    compare_kanji_and_integer("六千五百六十四", 6564)
  end

  it "六千五百六十五" do
    compare_kanji_and_integer("六千五百六十五", 6565)
  end

  it "六千五百六十六" do
    compare_kanji_and_integer("六千五百六十六", 6566)
  end

  it "六千五百六十七" do
    compare_kanji_and_integer("六千五百六十七", 6567)
  end

  it "六千五百六十八" do
    compare_kanji_and_integer("六千五百六十八", 6568)
  end

  it "六千五百六十九" do
    compare_kanji_and_integer("六千五百六十九", 6569)
  end

  it "六千五百七十" do
    compare_kanji_and_integer("六千五百七十", 6570)
  end

  it "六千五百七十一" do
    compare_kanji_and_integer("六千五百七十一", 6571)
  end

  it "六千五百七十二" do
    compare_kanji_and_integer("六千五百七十二", 6572)
  end

  it "六千五百七十三" do
    compare_kanji_and_integer("六千五百七十三", 6573)
  end

  it "六千五百七十四" do
    compare_kanji_and_integer("六千五百七十四", 6574)
  end

  it "六千五百七十五" do
    compare_kanji_and_integer("六千五百七十五", 6575)
  end

  it "六千五百七十六" do
    compare_kanji_and_integer("六千五百七十六", 6576)
  end

  it "六千五百七十七" do
    compare_kanji_and_integer("六千五百七十七", 6577)
  end

  it "六千五百七十八" do
    compare_kanji_and_integer("六千五百七十八", 6578)
  end

  it "六千五百七十九" do
    compare_kanji_and_integer("六千五百七十九", 6579)
  end

  it "六千五百八十" do
    compare_kanji_and_integer("六千五百八十", 6580)
  end

  it "六千五百八十一" do
    compare_kanji_and_integer("六千五百八十一", 6581)
  end

  it "六千五百八十二" do
    compare_kanji_and_integer("六千五百八十二", 6582)
  end

  it "六千五百八十三" do
    compare_kanji_and_integer("六千五百八十三", 6583)
  end

  it "六千五百八十四" do
    compare_kanji_and_integer("六千五百八十四", 6584)
  end

  it "六千五百八十五" do
    compare_kanji_and_integer("六千五百八十五", 6585)
  end

  it "六千五百八十六" do
    compare_kanji_and_integer("六千五百八十六", 6586)
  end

  it "六千五百八十七" do
    compare_kanji_and_integer("六千五百八十七", 6587)
  end

  it "六千五百八十八" do
    compare_kanji_and_integer("六千五百八十八", 6588)
  end

  it "六千五百八十九" do
    compare_kanji_and_integer("六千五百八十九", 6589)
  end

  it "六千五百九十" do
    compare_kanji_and_integer("六千五百九十", 6590)
  end

  it "六千五百九十一" do
    compare_kanji_and_integer("六千五百九十一", 6591)
  end

  it "六千五百九十二" do
    compare_kanji_and_integer("六千五百九十二", 6592)
  end

  it "六千五百九十三" do
    compare_kanji_and_integer("六千五百九十三", 6593)
  end

  it "六千五百九十四" do
    compare_kanji_and_integer("六千五百九十四", 6594)
  end

  it "六千五百九十五" do
    compare_kanji_and_integer("六千五百九十五", 6595)
  end

  it "六千五百九十六" do
    compare_kanji_and_integer("六千五百九十六", 6596)
  end

  it "六千五百九十七" do
    compare_kanji_and_integer("六千五百九十七", 6597)
  end

  it "六千五百九十八" do
    compare_kanji_and_integer("六千五百九十八", 6598)
  end

  it "六千五百九十九" do
    compare_kanji_and_integer("六千五百九十九", 6599)
  end

  it "六千六百" do
    compare_kanji_and_integer("六千六百", 6600)
  end

  it "六千六百一" do
    compare_kanji_and_integer("六千六百一", 6601)
  end

  it "六千六百二" do
    compare_kanji_and_integer("六千六百二", 6602)
  end

  it "六千六百三" do
    compare_kanji_and_integer("六千六百三", 6603)
  end

  it "六千六百四" do
    compare_kanji_and_integer("六千六百四", 6604)
  end

  it "六千六百五" do
    compare_kanji_and_integer("六千六百五", 6605)
  end

  it "六千六百六" do
    compare_kanji_and_integer("六千六百六", 6606)
  end

  it "六千六百七" do
    compare_kanji_and_integer("六千六百七", 6607)
  end

  it "六千六百八" do
    compare_kanji_and_integer("六千六百八", 6608)
  end

  it "六千六百九" do
    compare_kanji_and_integer("六千六百九", 6609)
  end

  it "六千六百十" do
    compare_kanji_and_integer("六千六百十", 6610)
  end

  it "六千六百十一" do
    compare_kanji_and_integer("六千六百十一", 6611)
  end

  it "六千六百十二" do
    compare_kanji_and_integer("六千六百十二", 6612)
  end

  it "六千六百十三" do
    compare_kanji_and_integer("六千六百十三", 6613)
  end

  it "六千六百十四" do
    compare_kanji_and_integer("六千六百十四", 6614)
  end

  it "六千六百十五" do
    compare_kanji_and_integer("六千六百十五", 6615)
  end

  it "六千六百十六" do
    compare_kanji_and_integer("六千六百十六", 6616)
  end

  it "六千六百十七" do
    compare_kanji_and_integer("六千六百十七", 6617)
  end

  it "六千六百十八" do
    compare_kanji_and_integer("六千六百十八", 6618)
  end

  it "六千六百十九" do
    compare_kanji_and_integer("六千六百十九", 6619)
  end

  it "六千六百二十" do
    compare_kanji_and_integer("六千六百二十", 6620)
  end

  it "六千六百二十一" do
    compare_kanji_and_integer("六千六百二十一", 6621)
  end

  it "六千六百二十二" do
    compare_kanji_and_integer("六千六百二十二", 6622)
  end

  it "六千六百二十三" do
    compare_kanji_and_integer("六千六百二十三", 6623)
  end

  it "六千六百二十四" do
    compare_kanji_and_integer("六千六百二十四", 6624)
  end

  it "六千六百二十五" do
    compare_kanji_and_integer("六千六百二十五", 6625)
  end

  it "六千六百二十六" do
    compare_kanji_and_integer("六千六百二十六", 6626)
  end

  it "六千六百二十七" do
    compare_kanji_and_integer("六千六百二十七", 6627)
  end

  it "六千六百二十八" do
    compare_kanji_and_integer("六千六百二十八", 6628)
  end

  it "六千六百二十九" do
    compare_kanji_and_integer("六千六百二十九", 6629)
  end

  it "六千六百三十" do
    compare_kanji_and_integer("六千六百三十", 6630)
  end

  it "六千六百三十一" do
    compare_kanji_and_integer("六千六百三十一", 6631)
  end

  it "六千六百三十二" do
    compare_kanji_and_integer("六千六百三十二", 6632)
  end

  it "六千六百三十三" do
    compare_kanji_and_integer("六千六百三十三", 6633)
  end

  it "六千六百三十四" do
    compare_kanji_and_integer("六千六百三十四", 6634)
  end

  it "六千六百三十五" do
    compare_kanji_and_integer("六千六百三十五", 6635)
  end

  it "六千六百三十六" do
    compare_kanji_and_integer("六千六百三十六", 6636)
  end

  it "六千六百三十七" do
    compare_kanji_and_integer("六千六百三十七", 6637)
  end

  it "六千六百三十八" do
    compare_kanji_and_integer("六千六百三十八", 6638)
  end

  it "六千六百三十九" do
    compare_kanji_and_integer("六千六百三十九", 6639)
  end

  it "六千六百四十" do
    compare_kanji_and_integer("六千六百四十", 6640)
  end

  it "六千六百四十一" do
    compare_kanji_and_integer("六千六百四十一", 6641)
  end

  it "六千六百四十二" do
    compare_kanji_and_integer("六千六百四十二", 6642)
  end

  it "六千六百四十三" do
    compare_kanji_and_integer("六千六百四十三", 6643)
  end

  it "六千六百四十四" do
    compare_kanji_and_integer("六千六百四十四", 6644)
  end

  it "六千六百四十五" do
    compare_kanji_and_integer("六千六百四十五", 6645)
  end

  it "六千六百四十六" do
    compare_kanji_and_integer("六千六百四十六", 6646)
  end

  it "六千六百四十七" do
    compare_kanji_and_integer("六千六百四十七", 6647)
  end

  it "六千六百四十八" do
    compare_kanji_and_integer("六千六百四十八", 6648)
  end

  it "六千六百四十九" do
    compare_kanji_and_integer("六千六百四十九", 6649)
  end

  it "六千六百五十" do
    compare_kanji_and_integer("六千六百五十", 6650)
  end

  it "六千六百五十一" do
    compare_kanji_and_integer("六千六百五十一", 6651)
  end

  it "六千六百五十二" do
    compare_kanji_and_integer("六千六百五十二", 6652)
  end

  it "六千六百五十三" do
    compare_kanji_and_integer("六千六百五十三", 6653)
  end

  it "六千六百五十四" do
    compare_kanji_and_integer("六千六百五十四", 6654)
  end

  it "六千六百五十五" do
    compare_kanji_and_integer("六千六百五十五", 6655)
  end

  it "六千六百五十六" do
    compare_kanji_and_integer("六千六百五十六", 6656)
  end

  it "六千六百五十七" do
    compare_kanji_and_integer("六千六百五十七", 6657)
  end

  it "六千六百五十八" do
    compare_kanji_and_integer("六千六百五十八", 6658)
  end

  it "六千六百五十九" do
    compare_kanji_and_integer("六千六百五十九", 6659)
  end

  it "六千六百六十" do
    compare_kanji_and_integer("六千六百六十", 6660)
  end

  it "六千六百六十一" do
    compare_kanji_and_integer("六千六百六十一", 6661)
  end

  it "六千六百六十二" do
    compare_kanji_and_integer("六千六百六十二", 6662)
  end

  it "六千六百六十三" do
    compare_kanji_and_integer("六千六百六十三", 6663)
  end

  it "六千六百六十四" do
    compare_kanji_and_integer("六千六百六十四", 6664)
  end

  it "六千六百六十五" do
    compare_kanji_and_integer("六千六百六十五", 6665)
  end

  it "六千六百六十六" do
    compare_kanji_and_integer("六千六百六十六", 6666)
  end

  it "六千六百六十七" do
    compare_kanji_and_integer("六千六百六十七", 6667)
  end

  it "六千六百六十八" do
    compare_kanji_and_integer("六千六百六十八", 6668)
  end

  it "六千六百六十九" do
    compare_kanji_and_integer("六千六百六十九", 6669)
  end

  it "六千六百七十" do
    compare_kanji_and_integer("六千六百七十", 6670)
  end

  it "六千六百七十一" do
    compare_kanji_and_integer("六千六百七十一", 6671)
  end

  it "六千六百七十二" do
    compare_kanji_and_integer("六千六百七十二", 6672)
  end

  it "六千六百七十三" do
    compare_kanji_and_integer("六千六百七十三", 6673)
  end

  it "六千六百七十四" do
    compare_kanji_and_integer("六千六百七十四", 6674)
  end

  it "六千六百七十五" do
    compare_kanji_and_integer("六千六百七十五", 6675)
  end

  it "六千六百七十六" do
    compare_kanji_and_integer("六千六百七十六", 6676)
  end

  it "六千六百七十七" do
    compare_kanji_and_integer("六千六百七十七", 6677)
  end

  it "六千六百七十八" do
    compare_kanji_and_integer("六千六百七十八", 6678)
  end

  it "六千六百七十九" do
    compare_kanji_and_integer("六千六百七十九", 6679)
  end

  it "六千六百八十" do
    compare_kanji_and_integer("六千六百八十", 6680)
  end

  it "六千六百八十一" do
    compare_kanji_and_integer("六千六百八十一", 6681)
  end

  it "六千六百八十二" do
    compare_kanji_and_integer("六千六百八十二", 6682)
  end

  it "六千六百八十三" do
    compare_kanji_and_integer("六千六百八十三", 6683)
  end

  it "六千六百八十四" do
    compare_kanji_and_integer("六千六百八十四", 6684)
  end

  it "六千六百八十五" do
    compare_kanji_and_integer("六千六百八十五", 6685)
  end

  it "六千六百八十六" do
    compare_kanji_and_integer("六千六百八十六", 6686)
  end

  it "六千六百八十七" do
    compare_kanji_and_integer("六千六百八十七", 6687)
  end

  it "六千六百八十八" do
    compare_kanji_and_integer("六千六百八十八", 6688)
  end

  it "六千六百八十九" do
    compare_kanji_and_integer("六千六百八十九", 6689)
  end

  it "六千六百九十" do
    compare_kanji_and_integer("六千六百九十", 6690)
  end

  it "六千六百九十一" do
    compare_kanji_and_integer("六千六百九十一", 6691)
  end

  it "六千六百九十二" do
    compare_kanji_and_integer("六千六百九十二", 6692)
  end

  it "六千六百九十三" do
    compare_kanji_and_integer("六千六百九十三", 6693)
  end

  it "六千六百九十四" do
    compare_kanji_and_integer("六千六百九十四", 6694)
  end

  it "六千六百九十五" do
    compare_kanji_and_integer("六千六百九十五", 6695)
  end

  it "六千六百九十六" do
    compare_kanji_and_integer("六千六百九十六", 6696)
  end

  it "六千六百九十七" do
    compare_kanji_and_integer("六千六百九十七", 6697)
  end

  it "六千六百九十八" do
    compare_kanji_and_integer("六千六百九十八", 6698)
  end

  it "六千六百九十九" do
    compare_kanji_and_integer("六千六百九十九", 6699)
  end

  it "六千七百" do
    compare_kanji_and_integer("六千七百", 6700)
  end

  it "六千七百一" do
    compare_kanji_and_integer("六千七百一", 6701)
  end

  it "六千七百二" do
    compare_kanji_and_integer("六千七百二", 6702)
  end

  it "六千七百三" do
    compare_kanji_and_integer("六千七百三", 6703)
  end

  it "六千七百四" do
    compare_kanji_and_integer("六千七百四", 6704)
  end

  it "六千七百五" do
    compare_kanji_and_integer("六千七百五", 6705)
  end

  it "六千七百六" do
    compare_kanji_and_integer("六千七百六", 6706)
  end

  it "六千七百七" do
    compare_kanji_and_integer("六千七百七", 6707)
  end

  it "六千七百八" do
    compare_kanji_and_integer("六千七百八", 6708)
  end

  it "六千七百九" do
    compare_kanji_and_integer("六千七百九", 6709)
  end

  it "六千七百十" do
    compare_kanji_and_integer("六千七百十", 6710)
  end

  it "六千七百十一" do
    compare_kanji_and_integer("六千七百十一", 6711)
  end

  it "六千七百十二" do
    compare_kanji_and_integer("六千七百十二", 6712)
  end

  it "六千七百十三" do
    compare_kanji_and_integer("六千七百十三", 6713)
  end

  it "六千七百十四" do
    compare_kanji_and_integer("六千七百十四", 6714)
  end

  it "六千七百十五" do
    compare_kanji_and_integer("六千七百十五", 6715)
  end

  it "六千七百十六" do
    compare_kanji_and_integer("六千七百十六", 6716)
  end

  it "六千七百十七" do
    compare_kanji_and_integer("六千七百十七", 6717)
  end

  it "六千七百十八" do
    compare_kanji_and_integer("六千七百十八", 6718)
  end

  it "六千七百十九" do
    compare_kanji_and_integer("六千七百十九", 6719)
  end

  it "六千七百二十" do
    compare_kanji_and_integer("六千七百二十", 6720)
  end

  it "六千七百二十一" do
    compare_kanji_and_integer("六千七百二十一", 6721)
  end

  it "六千七百二十二" do
    compare_kanji_and_integer("六千七百二十二", 6722)
  end

  it "六千七百二十三" do
    compare_kanji_and_integer("六千七百二十三", 6723)
  end

  it "六千七百二十四" do
    compare_kanji_and_integer("六千七百二十四", 6724)
  end

  it "六千七百二十五" do
    compare_kanji_and_integer("六千七百二十五", 6725)
  end

  it "六千七百二十六" do
    compare_kanji_and_integer("六千七百二十六", 6726)
  end

  it "六千七百二十七" do
    compare_kanji_and_integer("六千七百二十七", 6727)
  end

  it "六千七百二十八" do
    compare_kanji_and_integer("六千七百二十八", 6728)
  end

  it "六千七百二十九" do
    compare_kanji_and_integer("六千七百二十九", 6729)
  end

  it "六千七百三十" do
    compare_kanji_and_integer("六千七百三十", 6730)
  end

  it "六千七百三十一" do
    compare_kanji_and_integer("六千七百三十一", 6731)
  end

  it "六千七百三十二" do
    compare_kanji_and_integer("六千七百三十二", 6732)
  end

  it "六千七百三十三" do
    compare_kanji_and_integer("六千七百三十三", 6733)
  end

  it "六千七百三十四" do
    compare_kanji_and_integer("六千七百三十四", 6734)
  end

  it "六千七百三十五" do
    compare_kanji_and_integer("六千七百三十五", 6735)
  end

  it "六千七百三十六" do
    compare_kanji_and_integer("六千七百三十六", 6736)
  end

  it "六千七百三十七" do
    compare_kanji_and_integer("六千七百三十七", 6737)
  end

  it "六千七百三十八" do
    compare_kanji_and_integer("六千七百三十八", 6738)
  end

  it "六千七百三十九" do
    compare_kanji_and_integer("六千七百三十九", 6739)
  end

  it "六千七百四十" do
    compare_kanji_and_integer("六千七百四十", 6740)
  end

  it "六千七百四十一" do
    compare_kanji_and_integer("六千七百四十一", 6741)
  end

  it "六千七百四十二" do
    compare_kanji_and_integer("六千七百四十二", 6742)
  end

  it "六千七百四十三" do
    compare_kanji_and_integer("六千七百四十三", 6743)
  end

  it "六千七百四十四" do
    compare_kanji_and_integer("六千七百四十四", 6744)
  end

  it "六千七百四十五" do
    compare_kanji_and_integer("六千七百四十五", 6745)
  end

  it "六千七百四十六" do
    compare_kanji_and_integer("六千七百四十六", 6746)
  end

  it "六千七百四十七" do
    compare_kanji_and_integer("六千七百四十七", 6747)
  end

  it "六千七百四十八" do
    compare_kanji_and_integer("六千七百四十八", 6748)
  end

  it "六千七百四十九" do
    compare_kanji_and_integer("六千七百四十九", 6749)
  end

  it "六千七百五十" do
    compare_kanji_and_integer("六千七百五十", 6750)
  end

  it "六千七百五十一" do
    compare_kanji_and_integer("六千七百五十一", 6751)
  end

  it "六千七百五十二" do
    compare_kanji_and_integer("六千七百五十二", 6752)
  end

  it "六千七百五十三" do
    compare_kanji_and_integer("六千七百五十三", 6753)
  end

  it "六千七百五十四" do
    compare_kanji_and_integer("六千七百五十四", 6754)
  end

  it "六千七百五十五" do
    compare_kanji_and_integer("六千七百五十五", 6755)
  end

  it "六千七百五十六" do
    compare_kanji_and_integer("六千七百五十六", 6756)
  end

  it "六千七百五十七" do
    compare_kanji_and_integer("六千七百五十七", 6757)
  end

  it "六千七百五十八" do
    compare_kanji_and_integer("六千七百五十八", 6758)
  end

  it "六千七百五十九" do
    compare_kanji_and_integer("六千七百五十九", 6759)
  end

  it "六千七百六十" do
    compare_kanji_and_integer("六千七百六十", 6760)
  end

  it "六千七百六十一" do
    compare_kanji_and_integer("六千七百六十一", 6761)
  end

  it "六千七百六十二" do
    compare_kanji_and_integer("六千七百六十二", 6762)
  end

  it "六千七百六十三" do
    compare_kanji_and_integer("六千七百六十三", 6763)
  end

  it "六千七百六十四" do
    compare_kanji_and_integer("六千七百六十四", 6764)
  end

  it "六千七百六十五" do
    compare_kanji_and_integer("六千七百六十五", 6765)
  end

  it "六千七百六十六" do
    compare_kanji_and_integer("六千七百六十六", 6766)
  end

  it "六千七百六十七" do
    compare_kanji_and_integer("六千七百六十七", 6767)
  end

  it "六千七百六十八" do
    compare_kanji_and_integer("六千七百六十八", 6768)
  end

  it "六千七百六十九" do
    compare_kanji_and_integer("六千七百六十九", 6769)
  end

  it "六千七百七十" do
    compare_kanji_and_integer("六千七百七十", 6770)
  end

  it "六千七百七十一" do
    compare_kanji_and_integer("六千七百七十一", 6771)
  end

  it "六千七百七十二" do
    compare_kanji_and_integer("六千七百七十二", 6772)
  end

  it "六千七百七十三" do
    compare_kanji_and_integer("六千七百七十三", 6773)
  end

  it "六千七百七十四" do
    compare_kanji_and_integer("六千七百七十四", 6774)
  end

  it "六千七百七十五" do
    compare_kanji_and_integer("六千七百七十五", 6775)
  end

  it "六千七百七十六" do
    compare_kanji_and_integer("六千七百七十六", 6776)
  end

  it "六千七百七十七" do
    compare_kanji_and_integer("六千七百七十七", 6777)
  end

  it "六千七百七十八" do
    compare_kanji_and_integer("六千七百七十八", 6778)
  end

  it "六千七百七十九" do
    compare_kanji_and_integer("六千七百七十九", 6779)
  end

  it "六千七百八十" do
    compare_kanji_and_integer("六千七百八十", 6780)
  end

  it "六千七百八十一" do
    compare_kanji_and_integer("六千七百八十一", 6781)
  end

  it "六千七百八十二" do
    compare_kanji_and_integer("六千七百八十二", 6782)
  end

  it "六千七百八十三" do
    compare_kanji_and_integer("六千七百八十三", 6783)
  end

  it "六千七百八十四" do
    compare_kanji_and_integer("六千七百八十四", 6784)
  end

  it "六千七百八十五" do
    compare_kanji_and_integer("六千七百八十五", 6785)
  end

  it "六千七百八十六" do
    compare_kanji_and_integer("六千七百八十六", 6786)
  end

  it "六千七百八十七" do
    compare_kanji_and_integer("六千七百八十七", 6787)
  end

  it "六千七百八十八" do
    compare_kanji_and_integer("六千七百八十八", 6788)
  end

  it "六千七百八十九" do
    compare_kanji_and_integer("六千七百八十九", 6789)
  end

  it "六千七百九十" do
    compare_kanji_and_integer("六千七百九十", 6790)
  end

  it "六千七百九十一" do
    compare_kanji_and_integer("六千七百九十一", 6791)
  end

  it "六千七百九十二" do
    compare_kanji_and_integer("六千七百九十二", 6792)
  end

  it "六千七百九十三" do
    compare_kanji_and_integer("六千七百九十三", 6793)
  end

  it "六千七百九十四" do
    compare_kanji_and_integer("六千七百九十四", 6794)
  end

  it "六千七百九十五" do
    compare_kanji_and_integer("六千七百九十五", 6795)
  end

  it "六千七百九十六" do
    compare_kanji_and_integer("六千七百九十六", 6796)
  end

  it "六千七百九十七" do
    compare_kanji_and_integer("六千七百九十七", 6797)
  end

  it "六千七百九十八" do
    compare_kanji_and_integer("六千七百九十八", 6798)
  end

  it "六千七百九十九" do
    compare_kanji_and_integer("六千七百九十九", 6799)
  end

  it "六千八百" do
    compare_kanji_and_integer("六千八百", 6800)
  end

  it "六千八百一" do
    compare_kanji_and_integer("六千八百一", 6801)
  end

  it "六千八百二" do
    compare_kanji_and_integer("六千八百二", 6802)
  end

  it "六千八百三" do
    compare_kanji_and_integer("六千八百三", 6803)
  end

  it "六千八百四" do
    compare_kanji_and_integer("六千八百四", 6804)
  end

  it "六千八百五" do
    compare_kanji_and_integer("六千八百五", 6805)
  end

  it "六千八百六" do
    compare_kanji_and_integer("六千八百六", 6806)
  end

  it "六千八百七" do
    compare_kanji_and_integer("六千八百七", 6807)
  end

  it "六千八百八" do
    compare_kanji_and_integer("六千八百八", 6808)
  end

  it "六千八百九" do
    compare_kanji_and_integer("六千八百九", 6809)
  end

  it "六千八百十" do
    compare_kanji_and_integer("六千八百十", 6810)
  end

  it "六千八百十一" do
    compare_kanji_and_integer("六千八百十一", 6811)
  end

  it "六千八百十二" do
    compare_kanji_and_integer("六千八百十二", 6812)
  end

  it "六千八百十三" do
    compare_kanji_and_integer("六千八百十三", 6813)
  end

  it "六千八百十四" do
    compare_kanji_and_integer("六千八百十四", 6814)
  end

  it "六千八百十五" do
    compare_kanji_and_integer("六千八百十五", 6815)
  end

  it "六千八百十六" do
    compare_kanji_and_integer("六千八百十六", 6816)
  end

  it "六千八百十七" do
    compare_kanji_and_integer("六千八百十七", 6817)
  end

  it "六千八百十八" do
    compare_kanji_and_integer("六千八百十八", 6818)
  end

  it "六千八百十九" do
    compare_kanji_and_integer("六千八百十九", 6819)
  end

  it "六千八百二十" do
    compare_kanji_and_integer("六千八百二十", 6820)
  end

  it "六千八百二十一" do
    compare_kanji_and_integer("六千八百二十一", 6821)
  end

  it "六千八百二十二" do
    compare_kanji_and_integer("六千八百二十二", 6822)
  end

  it "六千八百二十三" do
    compare_kanji_and_integer("六千八百二十三", 6823)
  end

  it "六千八百二十四" do
    compare_kanji_and_integer("六千八百二十四", 6824)
  end

  it "六千八百二十五" do
    compare_kanji_and_integer("六千八百二十五", 6825)
  end

  it "六千八百二十六" do
    compare_kanji_and_integer("六千八百二十六", 6826)
  end

  it "六千八百二十七" do
    compare_kanji_and_integer("六千八百二十七", 6827)
  end

  it "六千八百二十八" do
    compare_kanji_and_integer("六千八百二十八", 6828)
  end

  it "六千八百二十九" do
    compare_kanji_and_integer("六千八百二十九", 6829)
  end

  it "六千八百三十" do
    compare_kanji_and_integer("六千八百三十", 6830)
  end

  it "六千八百三十一" do
    compare_kanji_and_integer("六千八百三十一", 6831)
  end

  it "六千八百三十二" do
    compare_kanji_and_integer("六千八百三十二", 6832)
  end

  it "六千八百三十三" do
    compare_kanji_and_integer("六千八百三十三", 6833)
  end

  it "六千八百三十四" do
    compare_kanji_and_integer("六千八百三十四", 6834)
  end

  it "六千八百三十五" do
    compare_kanji_and_integer("六千八百三十五", 6835)
  end

  it "六千八百三十六" do
    compare_kanji_and_integer("六千八百三十六", 6836)
  end

  it "六千八百三十七" do
    compare_kanji_and_integer("六千八百三十七", 6837)
  end

  it "六千八百三十八" do
    compare_kanji_and_integer("六千八百三十八", 6838)
  end

  it "六千八百三十九" do
    compare_kanji_and_integer("六千八百三十九", 6839)
  end

  it "六千八百四十" do
    compare_kanji_and_integer("六千八百四十", 6840)
  end

  it "六千八百四十一" do
    compare_kanji_and_integer("六千八百四十一", 6841)
  end

  it "六千八百四十二" do
    compare_kanji_and_integer("六千八百四十二", 6842)
  end

  it "六千八百四十三" do
    compare_kanji_and_integer("六千八百四十三", 6843)
  end

  it "六千八百四十四" do
    compare_kanji_and_integer("六千八百四十四", 6844)
  end

  it "六千八百四十五" do
    compare_kanji_and_integer("六千八百四十五", 6845)
  end

  it "六千八百四十六" do
    compare_kanji_and_integer("六千八百四十六", 6846)
  end

  it "六千八百四十七" do
    compare_kanji_and_integer("六千八百四十七", 6847)
  end

  it "六千八百四十八" do
    compare_kanji_and_integer("六千八百四十八", 6848)
  end

  it "六千八百四十九" do
    compare_kanji_and_integer("六千八百四十九", 6849)
  end

  it "六千八百五十" do
    compare_kanji_and_integer("六千八百五十", 6850)
  end

  it "六千八百五十一" do
    compare_kanji_and_integer("六千八百五十一", 6851)
  end

  it "六千八百五十二" do
    compare_kanji_and_integer("六千八百五十二", 6852)
  end

  it "六千八百五十三" do
    compare_kanji_and_integer("六千八百五十三", 6853)
  end

  it "六千八百五十四" do
    compare_kanji_and_integer("六千八百五十四", 6854)
  end

  it "六千八百五十五" do
    compare_kanji_and_integer("六千八百五十五", 6855)
  end

  it "六千八百五十六" do
    compare_kanji_and_integer("六千八百五十六", 6856)
  end

  it "六千八百五十七" do
    compare_kanji_and_integer("六千八百五十七", 6857)
  end

  it "六千八百五十八" do
    compare_kanji_and_integer("六千八百五十八", 6858)
  end

  it "六千八百五十九" do
    compare_kanji_and_integer("六千八百五十九", 6859)
  end

  it "六千八百六十" do
    compare_kanji_and_integer("六千八百六十", 6860)
  end

  it "六千八百六十一" do
    compare_kanji_and_integer("六千八百六十一", 6861)
  end

  it "六千八百六十二" do
    compare_kanji_and_integer("六千八百六十二", 6862)
  end

  it "六千八百六十三" do
    compare_kanji_and_integer("六千八百六十三", 6863)
  end

  it "六千八百六十四" do
    compare_kanji_and_integer("六千八百六十四", 6864)
  end

  it "六千八百六十五" do
    compare_kanji_and_integer("六千八百六十五", 6865)
  end

  it "六千八百六十六" do
    compare_kanji_and_integer("六千八百六十六", 6866)
  end

  it "六千八百六十七" do
    compare_kanji_and_integer("六千八百六十七", 6867)
  end

  it "六千八百六十八" do
    compare_kanji_and_integer("六千八百六十八", 6868)
  end

  it "六千八百六十九" do
    compare_kanji_and_integer("六千八百六十九", 6869)
  end

  it "六千八百七十" do
    compare_kanji_and_integer("六千八百七十", 6870)
  end

  it "六千八百七十一" do
    compare_kanji_and_integer("六千八百七十一", 6871)
  end

  it "六千八百七十二" do
    compare_kanji_and_integer("六千八百七十二", 6872)
  end

  it "六千八百七十三" do
    compare_kanji_and_integer("六千八百七十三", 6873)
  end

  it "六千八百七十四" do
    compare_kanji_and_integer("六千八百七十四", 6874)
  end

  it "六千八百七十五" do
    compare_kanji_and_integer("六千八百七十五", 6875)
  end

  it "六千八百七十六" do
    compare_kanji_and_integer("六千八百七十六", 6876)
  end

  it "六千八百七十七" do
    compare_kanji_and_integer("六千八百七十七", 6877)
  end

  it "六千八百七十八" do
    compare_kanji_and_integer("六千八百七十八", 6878)
  end

  it "六千八百七十九" do
    compare_kanji_and_integer("六千八百七十九", 6879)
  end

  it "六千八百八十" do
    compare_kanji_and_integer("六千八百八十", 6880)
  end

  it "六千八百八十一" do
    compare_kanji_and_integer("六千八百八十一", 6881)
  end

  it "六千八百八十二" do
    compare_kanji_and_integer("六千八百八十二", 6882)
  end

  it "六千八百八十三" do
    compare_kanji_and_integer("六千八百八十三", 6883)
  end

  it "六千八百八十四" do
    compare_kanji_and_integer("六千八百八十四", 6884)
  end

  it "六千八百八十五" do
    compare_kanji_and_integer("六千八百八十五", 6885)
  end

  it "六千八百八十六" do
    compare_kanji_and_integer("六千八百八十六", 6886)
  end

  it "六千八百八十七" do
    compare_kanji_and_integer("六千八百八十七", 6887)
  end

  it "六千八百八十八" do
    compare_kanji_and_integer("六千八百八十八", 6888)
  end

  it "六千八百八十九" do
    compare_kanji_and_integer("六千八百八十九", 6889)
  end

  it "六千八百九十" do
    compare_kanji_and_integer("六千八百九十", 6890)
  end

  it "六千八百九十一" do
    compare_kanji_and_integer("六千八百九十一", 6891)
  end

  it "六千八百九十二" do
    compare_kanji_and_integer("六千八百九十二", 6892)
  end

  it "六千八百九十三" do
    compare_kanji_and_integer("六千八百九十三", 6893)
  end

  it "六千八百九十四" do
    compare_kanji_and_integer("六千八百九十四", 6894)
  end

  it "六千八百九十五" do
    compare_kanji_and_integer("六千八百九十五", 6895)
  end

  it "六千八百九十六" do
    compare_kanji_and_integer("六千八百九十六", 6896)
  end

  it "六千八百九十七" do
    compare_kanji_and_integer("六千八百九十七", 6897)
  end

  it "六千八百九十八" do
    compare_kanji_and_integer("六千八百九十八", 6898)
  end

  it "六千八百九十九" do
    compare_kanji_and_integer("六千八百九十九", 6899)
  end

  it "六千九百" do
    compare_kanji_and_integer("六千九百", 6900)
  end

  it "六千九百一" do
    compare_kanji_and_integer("六千九百一", 6901)
  end

  it "六千九百二" do
    compare_kanji_and_integer("六千九百二", 6902)
  end

  it "六千九百三" do
    compare_kanji_and_integer("六千九百三", 6903)
  end

  it "六千九百四" do
    compare_kanji_and_integer("六千九百四", 6904)
  end

  it "六千九百五" do
    compare_kanji_and_integer("六千九百五", 6905)
  end

  it "六千九百六" do
    compare_kanji_and_integer("六千九百六", 6906)
  end

  it "六千九百七" do
    compare_kanji_and_integer("六千九百七", 6907)
  end

  it "六千九百八" do
    compare_kanji_and_integer("六千九百八", 6908)
  end

  it "六千九百九" do
    compare_kanji_and_integer("六千九百九", 6909)
  end

  it "六千九百十" do
    compare_kanji_and_integer("六千九百十", 6910)
  end

  it "六千九百十一" do
    compare_kanji_and_integer("六千九百十一", 6911)
  end

  it "六千九百十二" do
    compare_kanji_and_integer("六千九百十二", 6912)
  end

  it "六千九百十三" do
    compare_kanji_and_integer("六千九百十三", 6913)
  end

  it "六千九百十四" do
    compare_kanji_and_integer("六千九百十四", 6914)
  end

  it "六千九百十五" do
    compare_kanji_and_integer("六千九百十五", 6915)
  end

  it "六千九百十六" do
    compare_kanji_and_integer("六千九百十六", 6916)
  end

  it "六千九百十七" do
    compare_kanji_and_integer("六千九百十七", 6917)
  end

  it "六千九百十八" do
    compare_kanji_and_integer("六千九百十八", 6918)
  end

  it "六千九百十九" do
    compare_kanji_and_integer("六千九百十九", 6919)
  end

  it "六千九百二十" do
    compare_kanji_and_integer("六千九百二十", 6920)
  end

  it "六千九百二十一" do
    compare_kanji_and_integer("六千九百二十一", 6921)
  end

  it "六千九百二十二" do
    compare_kanji_and_integer("六千九百二十二", 6922)
  end

  it "六千九百二十三" do
    compare_kanji_and_integer("六千九百二十三", 6923)
  end

  it "六千九百二十四" do
    compare_kanji_and_integer("六千九百二十四", 6924)
  end

  it "六千九百二十五" do
    compare_kanji_and_integer("六千九百二十五", 6925)
  end

  it "六千九百二十六" do
    compare_kanji_and_integer("六千九百二十六", 6926)
  end

  it "六千九百二十七" do
    compare_kanji_and_integer("六千九百二十七", 6927)
  end

  it "六千九百二十八" do
    compare_kanji_and_integer("六千九百二十八", 6928)
  end

  it "六千九百二十九" do
    compare_kanji_and_integer("六千九百二十九", 6929)
  end

  it "六千九百三十" do
    compare_kanji_and_integer("六千九百三十", 6930)
  end

  it "六千九百三十一" do
    compare_kanji_and_integer("六千九百三十一", 6931)
  end

  it "六千九百三十二" do
    compare_kanji_and_integer("六千九百三十二", 6932)
  end

  it "六千九百三十三" do
    compare_kanji_and_integer("六千九百三十三", 6933)
  end

  it "六千九百三十四" do
    compare_kanji_and_integer("六千九百三十四", 6934)
  end

  it "六千九百三十五" do
    compare_kanji_and_integer("六千九百三十五", 6935)
  end

  it "六千九百三十六" do
    compare_kanji_and_integer("六千九百三十六", 6936)
  end

  it "六千九百三十七" do
    compare_kanji_and_integer("六千九百三十七", 6937)
  end

  it "六千九百三十八" do
    compare_kanji_and_integer("六千九百三十八", 6938)
  end

  it "六千九百三十九" do
    compare_kanji_and_integer("六千九百三十九", 6939)
  end

  it "六千九百四十" do
    compare_kanji_and_integer("六千九百四十", 6940)
  end

  it "六千九百四十一" do
    compare_kanji_and_integer("六千九百四十一", 6941)
  end

  it "六千九百四十二" do
    compare_kanji_and_integer("六千九百四十二", 6942)
  end

  it "六千九百四十三" do
    compare_kanji_and_integer("六千九百四十三", 6943)
  end

  it "六千九百四十四" do
    compare_kanji_and_integer("六千九百四十四", 6944)
  end

  it "六千九百四十五" do
    compare_kanji_and_integer("六千九百四十五", 6945)
  end

  it "六千九百四十六" do
    compare_kanji_and_integer("六千九百四十六", 6946)
  end

  it "六千九百四十七" do
    compare_kanji_and_integer("六千九百四十七", 6947)
  end

  it "六千九百四十八" do
    compare_kanji_and_integer("六千九百四十八", 6948)
  end

  it "六千九百四十九" do
    compare_kanji_and_integer("六千九百四十九", 6949)
  end

  it "六千九百五十" do
    compare_kanji_and_integer("六千九百五十", 6950)
  end

  it "六千九百五十一" do
    compare_kanji_and_integer("六千九百五十一", 6951)
  end

  it "六千九百五十二" do
    compare_kanji_and_integer("六千九百五十二", 6952)
  end

  it "六千九百五十三" do
    compare_kanji_and_integer("六千九百五十三", 6953)
  end

  it "六千九百五十四" do
    compare_kanji_and_integer("六千九百五十四", 6954)
  end

  it "六千九百五十五" do
    compare_kanji_and_integer("六千九百五十五", 6955)
  end

  it "六千九百五十六" do
    compare_kanji_and_integer("六千九百五十六", 6956)
  end

  it "六千九百五十七" do
    compare_kanji_and_integer("六千九百五十七", 6957)
  end

  it "六千九百五十八" do
    compare_kanji_and_integer("六千九百五十八", 6958)
  end

  it "六千九百五十九" do
    compare_kanji_and_integer("六千九百五十九", 6959)
  end

  it "六千九百六十" do
    compare_kanji_and_integer("六千九百六十", 6960)
  end

  it "六千九百六十一" do
    compare_kanji_and_integer("六千九百六十一", 6961)
  end

  it "六千九百六十二" do
    compare_kanji_and_integer("六千九百六十二", 6962)
  end

  it "六千九百六十三" do
    compare_kanji_and_integer("六千九百六十三", 6963)
  end

  it "六千九百六十四" do
    compare_kanji_and_integer("六千九百六十四", 6964)
  end

  it "六千九百六十五" do
    compare_kanji_and_integer("六千九百六十五", 6965)
  end

  it "六千九百六十六" do
    compare_kanji_and_integer("六千九百六十六", 6966)
  end

  it "六千九百六十七" do
    compare_kanji_and_integer("六千九百六十七", 6967)
  end

  it "六千九百六十八" do
    compare_kanji_and_integer("六千九百六十八", 6968)
  end

  it "六千九百六十九" do
    compare_kanji_and_integer("六千九百六十九", 6969)
  end

  it "六千九百七十" do
    compare_kanji_and_integer("六千九百七十", 6970)
  end

  it "六千九百七十一" do
    compare_kanji_and_integer("六千九百七十一", 6971)
  end

  it "六千九百七十二" do
    compare_kanji_and_integer("六千九百七十二", 6972)
  end

  it "六千九百七十三" do
    compare_kanji_and_integer("六千九百七十三", 6973)
  end

  it "六千九百七十四" do
    compare_kanji_and_integer("六千九百七十四", 6974)
  end

  it "六千九百七十五" do
    compare_kanji_and_integer("六千九百七十五", 6975)
  end

  it "六千九百七十六" do
    compare_kanji_and_integer("六千九百七十六", 6976)
  end

  it "六千九百七十七" do
    compare_kanji_and_integer("六千九百七十七", 6977)
  end

  it "六千九百七十八" do
    compare_kanji_and_integer("六千九百七十八", 6978)
  end

  it "六千九百七十九" do
    compare_kanji_and_integer("六千九百七十九", 6979)
  end

  it "六千九百八十" do
    compare_kanji_and_integer("六千九百八十", 6980)
  end

  it "六千九百八十一" do
    compare_kanji_and_integer("六千九百八十一", 6981)
  end

  it "六千九百八十二" do
    compare_kanji_and_integer("六千九百八十二", 6982)
  end

  it "六千九百八十三" do
    compare_kanji_and_integer("六千九百八十三", 6983)
  end

  it "六千九百八十四" do
    compare_kanji_and_integer("六千九百八十四", 6984)
  end

  it "六千九百八十五" do
    compare_kanji_and_integer("六千九百八十五", 6985)
  end

  it "六千九百八十六" do
    compare_kanji_and_integer("六千九百八十六", 6986)
  end

  it "六千九百八十七" do
    compare_kanji_and_integer("六千九百八十七", 6987)
  end

  it "六千九百八十八" do
    compare_kanji_and_integer("六千九百八十八", 6988)
  end

  it "六千九百八十九" do
    compare_kanji_and_integer("六千九百八十九", 6989)
  end

  it "六千九百九十" do
    compare_kanji_and_integer("六千九百九十", 6990)
  end

  it "六千九百九十一" do
    compare_kanji_and_integer("六千九百九十一", 6991)
  end

  it "六千九百九十二" do
    compare_kanji_and_integer("六千九百九十二", 6992)
  end

  it "六千九百九十三" do
    compare_kanji_and_integer("六千九百九十三", 6993)
  end

  it "六千九百九十四" do
    compare_kanji_and_integer("六千九百九十四", 6994)
  end

  it "六千九百九十五" do
    compare_kanji_and_integer("六千九百九十五", 6995)
  end

  it "六千九百九十六" do
    compare_kanji_and_integer("六千九百九十六", 6996)
  end

  it "六千九百九十七" do
    compare_kanji_and_integer("六千九百九十七", 6997)
  end

  it "六千九百九十八" do
    compare_kanji_and_integer("六千九百九十八", 6998)
  end

  it "六千九百九十九" do
    compare_kanji_and_integer("六千九百九十九", 6999)
  end

  it "七千" do
    compare_kanji_and_integer("七千", 7000)
  end

  it "七千一" do
    compare_kanji_and_integer("七千一", 7001)
  end

  it "七千二" do
    compare_kanji_and_integer("七千二", 7002)
  end

  it "七千三" do
    compare_kanji_and_integer("七千三", 7003)
  end

  it "七千四" do
    compare_kanji_and_integer("七千四", 7004)
  end

  it "七千五" do
    compare_kanji_and_integer("七千五", 7005)
  end

  it "七千六" do
    compare_kanji_and_integer("七千六", 7006)
  end

  it "七千七" do
    compare_kanji_and_integer("七千七", 7007)
  end

  it "七千八" do
    compare_kanji_and_integer("七千八", 7008)
  end

  it "七千九" do
    compare_kanji_and_integer("七千九", 7009)
  end

  it "七千十" do
    compare_kanji_and_integer("七千十", 7010)
  end

  it "七千十一" do
    compare_kanji_and_integer("七千十一", 7011)
  end

  it "七千十二" do
    compare_kanji_and_integer("七千十二", 7012)
  end

  it "七千十三" do
    compare_kanji_and_integer("七千十三", 7013)
  end

  it "七千十四" do
    compare_kanji_and_integer("七千十四", 7014)
  end

  it "七千十五" do
    compare_kanji_and_integer("七千十五", 7015)
  end

  it "七千十六" do
    compare_kanji_and_integer("七千十六", 7016)
  end

  it "七千十七" do
    compare_kanji_and_integer("七千十七", 7017)
  end

  it "七千十八" do
    compare_kanji_and_integer("七千十八", 7018)
  end

  it "七千十九" do
    compare_kanji_and_integer("七千十九", 7019)
  end

  it "七千二十" do
    compare_kanji_and_integer("七千二十", 7020)
  end

  it "七千二十一" do
    compare_kanji_and_integer("七千二十一", 7021)
  end

  it "七千二十二" do
    compare_kanji_and_integer("七千二十二", 7022)
  end

  it "七千二十三" do
    compare_kanji_and_integer("七千二十三", 7023)
  end

  it "七千二十四" do
    compare_kanji_and_integer("七千二十四", 7024)
  end

  it "七千二十五" do
    compare_kanji_and_integer("七千二十五", 7025)
  end

  it "七千二十六" do
    compare_kanji_and_integer("七千二十六", 7026)
  end

  it "七千二十七" do
    compare_kanji_and_integer("七千二十七", 7027)
  end

  it "七千二十八" do
    compare_kanji_and_integer("七千二十八", 7028)
  end

  it "七千二十九" do
    compare_kanji_and_integer("七千二十九", 7029)
  end

  it "七千三十" do
    compare_kanji_and_integer("七千三十", 7030)
  end

  it "七千三十一" do
    compare_kanji_and_integer("七千三十一", 7031)
  end

  it "七千三十二" do
    compare_kanji_and_integer("七千三十二", 7032)
  end

  it "七千三十三" do
    compare_kanji_and_integer("七千三十三", 7033)
  end

  it "七千三十四" do
    compare_kanji_and_integer("七千三十四", 7034)
  end

  it "七千三十五" do
    compare_kanji_and_integer("七千三十五", 7035)
  end

  it "七千三十六" do
    compare_kanji_and_integer("七千三十六", 7036)
  end

  it "七千三十七" do
    compare_kanji_and_integer("七千三十七", 7037)
  end

  it "七千三十八" do
    compare_kanji_and_integer("七千三十八", 7038)
  end

  it "七千三十九" do
    compare_kanji_and_integer("七千三十九", 7039)
  end

  it "七千四十" do
    compare_kanji_and_integer("七千四十", 7040)
  end

  it "七千四十一" do
    compare_kanji_and_integer("七千四十一", 7041)
  end

  it "七千四十二" do
    compare_kanji_and_integer("七千四十二", 7042)
  end

  it "七千四十三" do
    compare_kanji_and_integer("七千四十三", 7043)
  end

  it "七千四十四" do
    compare_kanji_and_integer("七千四十四", 7044)
  end

  it "七千四十五" do
    compare_kanji_and_integer("七千四十五", 7045)
  end

  it "七千四十六" do
    compare_kanji_and_integer("七千四十六", 7046)
  end

  it "七千四十七" do
    compare_kanji_and_integer("七千四十七", 7047)
  end

  it "七千四十八" do
    compare_kanji_and_integer("七千四十八", 7048)
  end

  it "七千四十九" do
    compare_kanji_and_integer("七千四十九", 7049)
  end

  it "七千五十" do
    compare_kanji_and_integer("七千五十", 7050)
  end

  it "七千五十一" do
    compare_kanji_and_integer("七千五十一", 7051)
  end

  it "七千五十二" do
    compare_kanji_and_integer("七千五十二", 7052)
  end

  it "七千五十三" do
    compare_kanji_and_integer("七千五十三", 7053)
  end

  it "七千五十四" do
    compare_kanji_and_integer("七千五十四", 7054)
  end

  it "七千五十五" do
    compare_kanji_and_integer("七千五十五", 7055)
  end

  it "七千五十六" do
    compare_kanji_and_integer("七千五十六", 7056)
  end

  it "七千五十七" do
    compare_kanji_and_integer("七千五十七", 7057)
  end

  it "七千五十八" do
    compare_kanji_and_integer("七千五十八", 7058)
  end

  it "七千五十九" do
    compare_kanji_and_integer("七千五十九", 7059)
  end

  it "七千六十" do
    compare_kanji_and_integer("七千六十", 7060)
  end

  it "七千六十一" do
    compare_kanji_and_integer("七千六十一", 7061)
  end

  it "七千六十二" do
    compare_kanji_and_integer("七千六十二", 7062)
  end

  it "七千六十三" do
    compare_kanji_and_integer("七千六十三", 7063)
  end

  it "七千六十四" do
    compare_kanji_and_integer("七千六十四", 7064)
  end

  it "七千六十五" do
    compare_kanji_and_integer("七千六十五", 7065)
  end

  it "七千六十六" do
    compare_kanji_and_integer("七千六十六", 7066)
  end

  it "七千六十七" do
    compare_kanji_and_integer("七千六十七", 7067)
  end

  it "七千六十八" do
    compare_kanji_and_integer("七千六十八", 7068)
  end

  it "七千六十九" do
    compare_kanji_and_integer("七千六十九", 7069)
  end

  it "七千七十" do
    compare_kanji_and_integer("七千七十", 7070)
  end

  it "七千七十一" do
    compare_kanji_and_integer("七千七十一", 7071)
  end

  it "七千七十二" do
    compare_kanji_and_integer("七千七十二", 7072)
  end

  it "七千七十三" do
    compare_kanji_and_integer("七千七十三", 7073)
  end

  it "七千七十四" do
    compare_kanji_and_integer("七千七十四", 7074)
  end

  it "七千七十五" do
    compare_kanji_and_integer("七千七十五", 7075)
  end

  it "七千七十六" do
    compare_kanji_and_integer("七千七十六", 7076)
  end

  it "七千七十七" do
    compare_kanji_and_integer("七千七十七", 7077)
  end

  it "七千七十八" do
    compare_kanji_and_integer("七千七十八", 7078)
  end

  it "七千七十九" do
    compare_kanji_and_integer("七千七十九", 7079)
  end

  it "七千八十" do
    compare_kanji_and_integer("七千八十", 7080)
  end

  it "七千八十一" do
    compare_kanji_and_integer("七千八十一", 7081)
  end

  it "七千八十二" do
    compare_kanji_and_integer("七千八十二", 7082)
  end

  it "七千八十三" do
    compare_kanji_and_integer("七千八十三", 7083)
  end

  it "七千八十四" do
    compare_kanji_and_integer("七千八十四", 7084)
  end

  it "七千八十五" do
    compare_kanji_and_integer("七千八十五", 7085)
  end

  it "七千八十六" do
    compare_kanji_and_integer("七千八十六", 7086)
  end

  it "七千八十七" do
    compare_kanji_and_integer("七千八十七", 7087)
  end

  it "七千八十八" do
    compare_kanji_and_integer("七千八十八", 7088)
  end

  it "七千八十九" do
    compare_kanji_and_integer("七千八十九", 7089)
  end

  it "七千九十" do
    compare_kanji_and_integer("七千九十", 7090)
  end

  it "七千九十一" do
    compare_kanji_and_integer("七千九十一", 7091)
  end

  it "七千九十二" do
    compare_kanji_and_integer("七千九十二", 7092)
  end

  it "七千九十三" do
    compare_kanji_and_integer("七千九十三", 7093)
  end

  it "七千九十四" do
    compare_kanji_and_integer("七千九十四", 7094)
  end

  it "七千九十五" do
    compare_kanji_and_integer("七千九十五", 7095)
  end

  it "七千九十六" do
    compare_kanji_and_integer("七千九十六", 7096)
  end

  it "七千九十七" do
    compare_kanji_and_integer("七千九十七", 7097)
  end

  it "七千九十八" do
    compare_kanji_and_integer("七千九十八", 7098)
  end

  it "七千九十九" do
    compare_kanji_and_integer("七千九十九", 7099)
  end

  it "七千百" do
    compare_kanji_and_integer("七千百", 7100)
  end

  it "七千百一" do
    compare_kanji_and_integer("七千百一", 7101)
  end

  it "七千百二" do
    compare_kanji_and_integer("七千百二", 7102)
  end

  it "七千百三" do
    compare_kanji_and_integer("七千百三", 7103)
  end

  it "七千百四" do
    compare_kanji_and_integer("七千百四", 7104)
  end

  it "七千百五" do
    compare_kanji_and_integer("七千百五", 7105)
  end

  it "七千百六" do
    compare_kanji_and_integer("七千百六", 7106)
  end

  it "七千百七" do
    compare_kanji_and_integer("七千百七", 7107)
  end

  it "七千百八" do
    compare_kanji_and_integer("七千百八", 7108)
  end

  it "七千百九" do
    compare_kanji_and_integer("七千百九", 7109)
  end

  it "七千百十" do
    compare_kanji_and_integer("七千百十", 7110)
  end

  it "七千百十一" do
    compare_kanji_and_integer("七千百十一", 7111)
  end

  it "七千百十二" do
    compare_kanji_and_integer("七千百十二", 7112)
  end

  it "七千百十三" do
    compare_kanji_and_integer("七千百十三", 7113)
  end

  it "七千百十四" do
    compare_kanji_and_integer("七千百十四", 7114)
  end

  it "七千百十五" do
    compare_kanji_and_integer("七千百十五", 7115)
  end

  it "七千百十六" do
    compare_kanji_and_integer("七千百十六", 7116)
  end

  it "七千百十七" do
    compare_kanji_and_integer("七千百十七", 7117)
  end

  it "七千百十八" do
    compare_kanji_and_integer("七千百十八", 7118)
  end

  it "七千百十九" do
    compare_kanji_and_integer("七千百十九", 7119)
  end

  it "七千百二十" do
    compare_kanji_and_integer("七千百二十", 7120)
  end

  it "七千百二十一" do
    compare_kanji_and_integer("七千百二十一", 7121)
  end

  it "七千百二十二" do
    compare_kanji_and_integer("七千百二十二", 7122)
  end

  it "七千百二十三" do
    compare_kanji_and_integer("七千百二十三", 7123)
  end

  it "七千百二十四" do
    compare_kanji_and_integer("七千百二十四", 7124)
  end

  it "七千百二十五" do
    compare_kanji_and_integer("七千百二十五", 7125)
  end

  it "七千百二十六" do
    compare_kanji_and_integer("七千百二十六", 7126)
  end

  it "七千百二十七" do
    compare_kanji_and_integer("七千百二十七", 7127)
  end

  it "七千百二十八" do
    compare_kanji_and_integer("七千百二十八", 7128)
  end

  it "七千百二十九" do
    compare_kanji_and_integer("七千百二十九", 7129)
  end

  it "七千百三十" do
    compare_kanji_and_integer("七千百三十", 7130)
  end

  it "七千百三十一" do
    compare_kanji_and_integer("七千百三十一", 7131)
  end

  it "七千百三十二" do
    compare_kanji_and_integer("七千百三十二", 7132)
  end

  it "七千百三十三" do
    compare_kanji_and_integer("七千百三十三", 7133)
  end

  it "七千百三十四" do
    compare_kanji_and_integer("七千百三十四", 7134)
  end

  it "七千百三十五" do
    compare_kanji_and_integer("七千百三十五", 7135)
  end

  it "七千百三十六" do
    compare_kanji_and_integer("七千百三十六", 7136)
  end

  it "七千百三十七" do
    compare_kanji_and_integer("七千百三十七", 7137)
  end

  it "七千百三十八" do
    compare_kanji_and_integer("七千百三十八", 7138)
  end

  it "七千百三十九" do
    compare_kanji_and_integer("七千百三十九", 7139)
  end

  it "七千百四十" do
    compare_kanji_and_integer("七千百四十", 7140)
  end

  it "七千百四十一" do
    compare_kanji_and_integer("七千百四十一", 7141)
  end

  it "七千百四十二" do
    compare_kanji_and_integer("七千百四十二", 7142)
  end

  it "七千百四十三" do
    compare_kanji_and_integer("七千百四十三", 7143)
  end

  it "七千百四十四" do
    compare_kanji_and_integer("七千百四十四", 7144)
  end

  it "七千百四十五" do
    compare_kanji_and_integer("七千百四十五", 7145)
  end

  it "七千百四十六" do
    compare_kanji_and_integer("七千百四十六", 7146)
  end

  it "七千百四十七" do
    compare_kanji_and_integer("七千百四十七", 7147)
  end

  it "七千百四十八" do
    compare_kanji_and_integer("七千百四十八", 7148)
  end

  it "七千百四十九" do
    compare_kanji_and_integer("七千百四十九", 7149)
  end

  it "七千百五十" do
    compare_kanji_and_integer("七千百五十", 7150)
  end

  it "七千百五十一" do
    compare_kanji_and_integer("七千百五十一", 7151)
  end

  it "七千百五十二" do
    compare_kanji_and_integer("七千百五十二", 7152)
  end

  it "七千百五十三" do
    compare_kanji_and_integer("七千百五十三", 7153)
  end

  it "七千百五十四" do
    compare_kanji_and_integer("七千百五十四", 7154)
  end

  it "七千百五十五" do
    compare_kanji_and_integer("七千百五十五", 7155)
  end

  it "七千百五十六" do
    compare_kanji_and_integer("七千百五十六", 7156)
  end

  it "七千百五十七" do
    compare_kanji_and_integer("七千百五十七", 7157)
  end

  it "七千百五十八" do
    compare_kanji_and_integer("七千百五十八", 7158)
  end

  it "七千百五十九" do
    compare_kanji_and_integer("七千百五十九", 7159)
  end

  it "七千百六十" do
    compare_kanji_and_integer("七千百六十", 7160)
  end

  it "七千百六十一" do
    compare_kanji_and_integer("七千百六十一", 7161)
  end

  it "七千百六十二" do
    compare_kanji_and_integer("七千百六十二", 7162)
  end

  it "七千百六十三" do
    compare_kanji_and_integer("七千百六十三", 7163)
  end

  it "七千百六十四" do
    compare_kanji_and_integer("七千百六十四", 7164)
  end

  it "七千百六十五" do
    compare_kanji_and_integer("七千百六十五", 7165)
  end

  it "七千百六十六" do
    compare_kanji_and_integer("七千百六十六", 7166)
  end

  it "七千百六十七" do
    compare_kanji_and_integer("七千百六十七", 7167)
  end

  it "七千百六十八" do
    compare_kanji_and_integer("七千百六十八", 7168)
  end

  it "七千百六十九" do
    compare_kanji_and_integer("七千百六十九", 7169)
  end

  it "七千百七十" do
    compare_kanji_and_integer("七千百七十", 7170)
  end

  it "七千百七十一" do
    compare_kanji_and_integer("七千百七十一", 7171)
  end

  it "七千百七十二" do
    compare_kanji_and_integer("七千百七十二", 7172)
  end

  it "七千百七十三" do
    compare_kanji_and_integer("七千百七十三", 7173)
  end

  it "七千百七十四" do
    compare_kanji_and_integer("七千百七十四", 7174)
  end

  it "七千百七十五" do
    compare_kanji_and_integer("七千百七十五", 7175)
  end

  it "七千百七十六" do
    compare_kanji_and_integer("七千百七十六", 7176)
  end

  it "七千百七十七" do
    compare_kanji_and_integer("七千百七十七", 7177)
  end

  it "七千百七十八" do
    compare_kanji_and_integer("七千百七十八", 7178)
  end

  it "七千百七十九" do
    compare_kanji_and_integer("七千百七十九", 7179)
  end

  it "七千百八十" do
    compare_kanji_and_integer("七千百八十", 7180)
  end

  it "七千百八十一" do
    compare_kanji_and_integer("七千百八十一", 7181)
  end

  it "七千百八十二" do
    compare_kanji_and_integer("七千百八十二", 7182)
  end

  it "七千百八十三" do
    compare_kanji_and_integer("七千百八十三", 7183)
  end

  it "七千百八十四" do
    compare_kanji_and_integer("七千百八十四", 7184)
  end

  it "七千百八十五" do
    compare_kanji_and_integer("七千百八十五", 7185)
  end

  it "七千百八十六" do
    compare_kanji_and_integer("七千百八十六", 7186)
  end

  it "七千百八十七" do
    compare_kanji_and_integer("七千百八十七", 7187)
  end

  it "七千百八十八" do
    compare_kanji_and_integer("七千百八十八", 7188)
  end

  it "七千百八十九" do
    compare_kanji_and_integer("七千百八十九", 7189)
  end

  it "七千百九十" do
    compare_kanji_and_integer("七千百九十", 7190)
  end

  it "七千百九十一" do
    compare_kanji_and_integer("七千百九十一", 7191)
  end

  it "七千百九十二" do
    compare_kanji_and_integer("七千百九十二", 7192)
  end

  it "七千百九十三" do
    compare_kanji_and_integer("七千百九十三", 7193)
  end

  it "七千百九十四" do
    compare_kanji_and_integer("七千百九十四", 7194)
  end

  it "七千百九十五" do
    compare_kanji_and_integer("七千百九十五", 7195)
  end

  it "七千百九十六" do
    compare_kanji_and_integer("七千百九十六", 7196)
  end

  it "七千百九十七" do
    compare_kanji_and_integer("七千百九十七", 7197)
  end

  it "七千百九十八" do
    compare_kanji_and_integer("七千百九十八", 7198)
  end

  it "七千百九十九" do
    compare_kanji_and_integer("七千百九十九", 7199)
  end

  it "七千二百" do
    compare_kanji_and_integer("七千二百", 7200)
  end

  it "七千二百一" do
    compare_kanji_and_integer("七千二百一", 7201)
  end

  it "七千二百二" do
    compare_kanji_and_integer("七千二百二", 7202)
  end

  it "七千二百三" do
    compare_kanji_and_integer("七千二百三", 7203)
  end

  it "七千二百四" do
    compare_kanji_and_integer("七千二百四", 7204)
  end

  it "七千二百五" do
    compare_kanji_and_integer("七千二百五", 7205)
  end

  it "七千二百六" do
    compare_kanji_and_integer("七千二百六", 7206)
  end

  it "七千二百七" do
    compare_kanji_and_integer("七千二百七", 7207)
  end

  it "七千二百八" do
    compare_kanji_and_integer("七千二百八", 7208)
  end

  it "七千二百九" do
    compare_kanji_and_integer("七千二百九", 7209)
  end

  it "七千二百十" do
    compare_kanji_and_integer("七千二百十", 7210)
  end

  it "七千二百十一" do
    compare_kanji_and_integer("七千二百十一", 7211)
  end

  it "七千二百十二" do
    compare_kanji_and_integer("七千二百十二", 7212)
  end

  it "七千二百十三" do
    compare_kanji_and_integer("七千二百十三", 7213)
  end

  it "七千二百十四" do
    compare_kanji_and_integer("七千二百十四", 7214)
  end

  it "七千二百十五" do
    compare_kanji_and_integer("七千二百十五", 7215)
  end

  it "七千二百十六" do
    compare_kanji_and_integer("七千二百十六", 7216)
  end

  it "七千二百十七" do
    compare_kanji_and_integer("七千二百十七", 7217)
  end

  it "七千二百十八" do
    compare_kanji_and_integer("七千二百十八", 7218)
  end

  it "七千二百十九" do
    compare_kanji_and_integer("七千二百十九", 7219)
  end

  it "七千二百二十" do
    compare_kanji_and_integer("七千二百二十", 7220)
  end

  it "七千二百二十一" do
    compare_kanji_and_integer("七千二百二十一", 7221)
  end

  it "七千二百二十二" do
    compare_kanji_and_integer("七千二百二十二", 7222)
  end

  it "七千二百二十三" do
    compare_kanji_and_integer("七千二百二十三", 7223)
  end

  it "七千二百二十四" do
    compare_kanji_and_integer("七千二百二十四", 7224)
  end

  it "七千二百二十五" do
    compare_kanji_and_integer("七千二百二十五", 7225)
  end

  it "七千二百二十六" do
    compare_kanji_and_integer("七千二百二十六", 7226)
  end

  it "七千二百二十七" do
    compare_kanji_and_integer("七千二百二十七", 7227)
  end

  it "七千二百二十八" do
    compare_kanji_and_integer("七千二百二十八", 7228)
  end

  it "七千二百二十九" do
    compare_kanji_and_integer("七千二百二十九", 7229)
  end

  it "七千二百三十" do
    compare_kanji_and_integer("七千二百三十", 7230)
  end

  it "七千二百三十一" do
    compare_kanji_and_integer("七千二百三十一", 7231)
  end

  it "七千二百三十二" do
    compare_kanji_and_integer("七千二百三十二", 7232)
  end

  it "七千二百三十三" do
    compare_kanji_and_integer("七千二百三十三", 7233)
  end

  it "七千二百三十四" do
    compare_kanji_and_integer("七千二百三十四", 7234)
  end

  it "七千二百三十五" do
    compare_kanji_and_integer("七千二百三十五", 7235)
  end

  it "七千二百三十六" do
    compare_kanji_and_integer("七千二百三十六", 7236)
  end

  it "七千二百三十七" do
    compare_kanji_and_integer("七千二百三十七", 7237)
  end

  it "七千二百三十八" do
    compare_kanji_and_integer("七千二百三十八", 7238)
  end

  it "七千二百三十九" do
    compare_kanji_and_integer("七千二百三十九", 7239)
  end

  it "七千二百四十" do
    compare_kanji_and_integer("七千二百四十", 7240)
  end

  it "七千二百四十一" do
    compare_kanji_and_integer("七千二百四十一", 7241)
  end

  it "七千二百四十二" do
    compare_kanji_and_integer("七千二百四十二", 7242)
  end

  it "七千二百四十三" do
    compare_kanji_and_integer("七千二百四十三", 7243)
  end

  it "七千二百四十四" do
    compare_kanji_and_integer("七千二百四十四", 7244)
  end

  it "七千二百四十五" do
    compare_kanji_and_integer("七千二百四十五", 7245)
  end

  it "七千二百四十六" do
    compare_kanji_and_integer("七千二百四十六", 7246)
  end

  it "七千二百四十七" do
    compare_kanji_and_integer("七千二百四十七", 7247)
  end

  it "七千二百四十八" do
    compare_kanji_and_integer("七千二百四十八", 7248)
  end

  it "七千二百四十九" do
    compare_kanji_and_integer("七千二百四十九", 7249)
  end

  it "七千二百五十" do
    compare_kanji_and_integer("七千二百五十", 7250)
  end

  it "七千二百五十一" do
    compare_kanji_and_integer("七千二百五十一", 7251)
  end

  it "七千二百五十二" do
    compare_kanji_and_integer("七千二百五十二", 7252)
  end

  it "七千二百五十三" do
    compare_kanji_and_integer("七千二百五十三", 7253)
  end

  it "七千二百五十四" do
    compare_kanji_and_integer("七千二百五十四", 7254)
  end

  it "七千二百五十五" do
    compare_kanji_and_integer("七千二百五十五", 7255)
  end

  it "七千二百五十六" do
    compare_kanji_and_integer("七千二百五十六", 7256)
  end

  it "七千二百五十七" do
    compare_kanji_and_integer("七千二百五十七", 7257)
  end

  it "七千二百五十八" do
    compare_kanji_and_integer("七千二百五十八", 7258)
  end

  it "七千二百五十九" do
    compare_kanji_and_integer("七千二百五十九", 7259)
  end

  it "七千二百六十" do
    compare_kanji_and_integer("七千二百六十", 7260)
  end

  it "七千二百六十一" do
    compare_kanji_and_integer("七千二百六十一", 7261)
  end

  it "七千二百六十二" do
    compare_kanji_and_integer("七千二百六十二", 7262)
  end

  it "七千二百六十三" do
    compare_kanji_and_integer("七千二百六十三", 7263)
  end

  it "七千二百六十四" do
    compare_kanji_and_integer("七千二百六十四", 7264)
  end

  it "七千二百六十五" do
    compare_kanji_and_integer("七千二百六十五", 7265)
  end

  it "七千二百六十六" do
    compare_kanji_and_integer("七千二百六十六", 7266)
  end

  it "七千二百六十七" do
    compare_kanji_and_integer("七千二百六十七", 7267)
  end

  it "七千二百六十八" do
    compare_kanji_and_integer("七千二百六十八", 7268)
  end

  it "七千二百六十九" do
    compare_kanji_and_integer("七千二百六十九", 7269)
  end

  it "七千二百七十" do
    compare_kanji_and_integer("七千二百七十", 7270)
  end

  it "七千二百七十一" do
    compare_kanji_and_integer("七千二百七十一", 7271)
  end

  it "七千二百七十二" do
    compare_kanji_and_integer("七千二百七十二", 7272)
  end

  it "七千二百七十三" do
    compare_kanji_and_integer("七千二百七十三", 7273)
  end

  it "七千二百七十四" do
    compare_kanji_and_integer("七千二百七十四", 7274)
  end

  it "七千二百七十五" do
    compare_kanji_and_integer("七千二百七十五", 7275)
  end

  it "七千二百七十六" do
    compare_kanji_and_integer("七千二百七十六", 7276)
  end

  it "七千二百七十七" do
    compare_kanji_and_integer("七千二百七十七", 7277)
  end

  it "七千二百七十八" do
    compare_kanji_and_integer("七千二百七十八", 7278)
  end

  it "七千二百七十九" do
    compare_kanji_and_integer("七千二百七十九", 7279)
  end

  it "七千二百八十" do
    compare_kanji_and_integer("七千二百八十", 7280)
  end

  it "七千二百八十一" do
    compare_kanji_and_integer("七千二百八十一", 7281)
  end

  it "七千二百八十二" do
    compare_kanji_and_integer("七千二百八十二", 7282)
  end

  it "七千二百八十三" do
    compare_kanji_and_integer("七千二百八十三", 7283)
  end

  it "七千二百八十四" do
    compare_kanji_and_integer("七千二百八十四", 7284)
  end

  it "七千二百八十五" do
    compare_kanji_and_integer("七千二百八十五", 7285)
  end

  it "七千二百八十六" do
    compare_kanji_and_integer("七千二百八十六", 7286)
  end

  it "七千二百八十七" do
    compare_kanji_and_integer("七千二百八十七", 7287)
  end

  it "七千二百八十八" do
    compare_kanji_and_integer("七千二百八十八", 7288)
  end

  it "七千二百八十九" do
    compare_kanji_and_integer("七千二百八十九", 7289)
  end

  it "七千二百九十" do
    compare_kanji_and_integer("七千二百九十", 7290)
  end

  it "七千二百九十一" do
    compare_kanji_and_integer("七千二百九十一", 7291)
  end

  it "七千二百九十二" do
    compare_kanji_and_integer("七千二百九十二", 7292)
  end

  it "七千二百九十三" do
    compare_kanji_and_integer("七千二百九十三", 7293)
  end

  it "七千二百九十四" do
    compare_kanji_and_integer("七千二百九十四", 7294)
  end

  it "七千二百九十五" do
    compare_kanji_and_integer("七千二百九十五", 7295)
  end

  it "七千二百九十六" do
    compare_kanji_and_integer("七千二百九十六", 7296)
  end

  it "七千二百九十七" do
    compare_kanji_and_integer("七千二百九十七", 7297)
  end

  it "七千二百九十八" do
    compare_kanji_and_integer("七千二百九十八", 7298)
  end

  it "七千二百九十九" do
    compare_kanji_and_integer("七千二百九十九", 7299)
  end

  it "七千三百" do
    compare_kanji_and_integer("七千三百", 7300)
  end

  it "七千三百一" do
    compare_kanji_and_integer("七千三百一", 7301)
  end

  it "七千三百二" do
    compare_kanji_and_integer("七千三百二", 7302)
  end

  it "七千三百三" do
    compare_kanji_and_integer("七千三百三", 7303)
  end

  it "七千三百四" do
    compare_kanji_and_integer("七千三百四", 7304)
  end

  it "七千三百五" do
    compare_kanji_and_integer("七千三百五", 7305)
  end

  it "七千三百六" do
    compare_kanji_and_integer("七千三百六", 7306)
  end

  it "七千三百七" do
    compare_kanji_and_integer("七千三百七", 7307)
  end

  it "七千三百八" do
    compare_kanji_and_integer("七千三百八", 7308)
  end

  it "七千三百九" do
    compare_kanji_and_integer("七千三百九", 7309)
  end

  it "七千三百十" do
    compare_kanji_and_integer("七千三百十", 7310)
  end

  it "七千三百十一" do
    compare_kanji_and_integer("七千三百十一", 7311)
  end

  it "七千三百十二" do
    compare_kanji_and_integer("七千三百十二", 7312)
  end

  it "七千三百十三" do
    compare_kanji_and_integer("七千三百十三", 7313)
  end

  it "七千三百十四" do
    compare_kanji_and_integer("七千三百十四", 7314)
  end

  it "七千三百十五" do
    compare_kanji_and_integer("七千三百十五", 7315)
  end

  it "七千三百十六" do
    compare_kanji_and_integer("七千三百十六", 7316)
  end

  it "七千三百十七" do
    compare_kanji_and_integer("七千三百十七", 7317)
  end

  it "七千三百十八" do
    compare_kanji_and_integer("七千三百十八", 7318)
  end

  it "七千三百十九" do
    compare_kanji_and_integer("七千三百十九", 7319)
  end

  it "七千三百二十" do
    compare_kanji_and_integer("七千三百二十", 7320)
  end

  it "七千三百二十一" do
    compare_kanji_and_integer("七千三百二十一", 7321)
  end

  it "七千三百二十二" do
    compare_kanji_and_integer("七千三百二十二", 7322)
  end

  it "七千三百二十三" do
    compare_kanji_and_integer("七千三百二十三", 7323)
  end

  it "七千三百二十四" do
    compare_kanji_and_integer("七千三百二十四", 7324)
  end

  it "七千三百二十五" do
    compare_kanji_and_integer("七千三百二十五", 7325)
  end

  it "七千三百二十六" do
    compare_kanji_and_integer("七千三百二十六", 7326)
  end

  it "七千三百二十七" do
    compare_kanji_and_integer("七千三百二十七", 7327)
  end

  it "七千三百二十八" do
    compare_kanji_and_integer("七千三百二十八", 7328)
  end

  it "七千三百二十九" do
    compare_kanji_and_integer("七千三百二十九", 7329)
  end

  it "七千三百三十" do
    compare_kanji_and_integer("七千三百三十", 7330)
  end

  it "七千三百三十一" do
    compare_kanji_and_integer("七千三百三十一", 7331)
  end

  it "七千三百三十二" do
    compare_kanji_and_integer("七千三百三十二", 7332)
  end

  it "七千三百三十三" do
    compare_kanji_and_integer("七千三百三十三", 7333)
  end

  it "七千三百三十四" do
    compare_kanji_and_integer("七千三百三十四", 7334)
  end

  it "七千三百三十五" do
    compare_kanji_and_integer("七千三百三十五", 7335)
  end

  it "七千三百三十六" do
    compare_kanji_and_integer("七千三百三十六", 7336)
  end

  it "七千三百三十七" do
    compare_kanji_and_integer("七千三百三十七", 7337)
  end

  it "七千三百三十八" do
    compare_kanji_and_integer("七千三百三十八", 7338)
  end

  it "七千三百三十九" do
    compare_kanji_and_integer("七千三百三十九", 7339)
  end

  it "七千三百四十" do
    compare_kanji_and_integer("七千三百四十", 7340)
  end

  it "七千三百四十一" do
    compare_kanji_and_integer("七千三百四十一", 7341)
  end

  it "七千三百四十二" do
    compare_kanji_and_integer("七千三百四十二", 7342)
  end

  it "七千三百四十三" do
    compare_kanji_and_integer("七千三百四十三", 7343)
  end

  it "七千三百四十四" do
    compare_kanji_and_integer("七千三百四十四", 7344)
  end

  it "七千三百四十五" do
    compare_kanji_and_integer("七千三百四十五", 7345)
  end

  it "七千三百四十六" do
    compare_kanji_and_integer("七千三百四十六", 7346)
  end

  it "七千三百四十七" do
    compare_kanji_and_integer("七千三百四十七", 7347)
  end

  it "七千三百四十八" do
    compare_kanji_and_integer("七千三百四十八", 7348)
  end

  it "七千三百四十九" do
    compare_kanji_and_integer("七千三百四十九", 7349)
  end

  it "七千三百五十" do
    compare_kanji_and_integer("七千三百五十", 7350)
  end

  it "七千三百五十一" do
    compare_kanji_and_integer("七千三百五十一", 7351)
  end

  it "七千三百五十二" do
    compare_kanji_and_integer("七千三百五十二", 7352)
  end

  it "七千三百五十三" do
    compare_kanji_and_integer("七千三百五十三", 7353)
  end

  it "七千三百五十四" do
    compare_kanji_and_integer("七千三百五十四", 7354)
  end

  it "七千三百五十五" do
    compare_kanji_and_integer("七千三百五十五", 7355)
  end

  it "七千三百五十六" do
    compare_kanji_and_integer("七千三百五十六", 7356)
  end

  it "七千三百五十七" do
    compare_kanji_and_integer("七千三百五十七", 7357)
  end

  it "七千三百五十八" do
    compare_kanji_and_integer("七千三百五十八", 7358)
  end

  it "七千三百五十九" do
    compare_kanji_and_integer("七千三百五十九", 7359)
  end

  it "七千三百六十" do
    compare_kanji_and_integer("七千三百六十", 7360)
  end

  it "七千三百六十一" do
    compare_kanji_and_integer("七千三百六十一", 7361)
  end

  it "七千三百六十二" do
    compare_kanji_and_integer("七千三百六十二", 7362)
  end

  it "七千三百六十三" do
    compare_kanji_and_integer("七千三百六十三", 7363)
  end

  it "七千三百六十四" do
    compare_kanji_and_integer("七千三百六十四", 7364)
  end

  it "七千三百六十五" do
    compare_kanji_and_integer("七千三百六十五", 7365)
  end

  it "七千三百六十六" do
    compare_kanji_and_integer("七千三百六十六", 7366)
  end

  it "七千三百六十七" do
    compare_kanji_and_integer("七千三百六十七", 7367)
  end

  it "七千三百六十八" do
    compare_kanji_and_integer("七千三百六十八", 7368)
  end

  it "七千三百六十九" do
    compare_kanji_and_integer("七千三百六十九", 7369)
  end

  it "七千三百七十" do
    compare_kanji_and_integer("七千三百七十", 7370)
  end

  it "七千三百七十一" do
    compare_kanji_and_integer("七千三百七十一", 7371)
  end

  it "七千三百七十二" do
    compare_kanji_and_integer("七千三百七十二", 7372)
  end

  it "七千三百七十三" do
    compare_kanji_and_integer("七千三百七十三", 7373)
  end

  it "七千三百七十四" do
    compare_kanji_and_integer("七千三百七十四", 7374)
  end

  it "七千三百七十五" do
    compare_kanji_and_integer("七千三百七十五", 7375)
  end

  it "七千三百七十六" do
    compare_kanji_and_integer("七千三百七十六", 7376)
  end

  it "七千三百七十七" do
    compare_kanji_and_integer("七千三百七十七", 7377)
  end

  it "七千三百七十八" do
    compare_kanji_and_integer("七千三百七十八", 7378)
  end

  it "七千三百七十九" do
    compare_kanji_and_integer("七千三百七十九", 7379)
  end

  it "七千三百八十" do
    compare_kanji_and_integer("七千三百八十", 7380)
  end

  it "七千三百八十一" do
    compare_kanji_and_integer("七千三百八十一", 7381)
  end

  it "七千三百八十二" do
    compare_kanji_and_integer("七千三百八十二", 7382)
  end

  it "七千三百八十三" do
    compare_kanji_and_integer("七千三百八十三", 7383)
  end

  it "七千三百八十四" do
    compare_kanji_and_integer("七千三百八十四", 7384)
  end

  it "七千三百八十五" do
    compare_kanji_and_integer("七千三百八十五", 7385)
  end

  it "七千三百八十六" do
    compare_kanji_and_integer("七千三百八十六", 7386)
  end

  it "七千三百八十七" do
    compare_kanji_and_integer("七千三百八十七", 7387)
  end

  it "七千三百八十八" do
    compare_kanji_and_integer("七千三百八十八", 7388)
  end

  it "七千三百八十九" do
    compare_kanji_and_integer("七千三百八十九", 7389)
  end

  it "七千三百九十" do
    compare_kanji_and_integer("七千三百九十", 7390)
  end

  it "七千三百九十一" do
    compare_kanji_and_integer("七千三百九十一", 7391)
  end

  it "七千三百九十二" do
    compare_kanji_and_integer("七千三百九十二", 7392)
  end

  it "七千三百九十三" do
    compare_kanji_and_integer("七千三百九十三", 7393)
  end

  it "七千三百九十四" do
    compare_kanji_and_integer("七千三百九十四", 7394)
  end

  it "七千三百九十五" do
    compare_kanji_and_integer("七千三百九十五", 7395)
  end

  it "七千三百九十六" do
    compare_kanji_and_integer("七千三百九十六", 7396)
  end

  it "七千三百九十七" do
    compare_kanji_and_integer("七千三百九十七", 7397)
  end

  it "七千三百九十八" do
    compare_kanji_and_integer("七千三百九十八", 7398)
  end

  it "七千三百九十九" do
    compare_kanji_and_integer("七千三百九十九", 7399)
  end

  it "七千四百" do
    compare_kanji_and_integer("七千四百", 7400)
  end

  it "七千四百一" do
    compare_kanji_and_integer("七千四百一", 7401)
  end

  it "七千四百二" do
    compare_kanji_and_integer("七千四百二", 7402)
  end

  it "七千四百三" do
    compare_kanji_and_integer("七千四百三", 7403)
  end

  it "七千四百四" do
    compare_kanji_and_integer("七千四百四", 7404)
  end

  it "七千四百五" do
    compare_kanji_and_integer("七千四百五", 7405)
  end

  it "七千四百六" do
    compare_kanji_and_integer("七千四百六", 7406)
  end

  it "七千四百七" do
    compare_kanji_and_integer("七千四百七", 7407)
  end

  it "七千四百八" do
    compare_kanji_and_integer("七千四百八", 7408)
  end

  it "七千四百九" do
    compare_kanji_and_integer("七千四百九", 7409)
  end

  it "七千四百十" do
    compare_kanji_and_integer("七千四百十", 7410)
  end

  it "七千四百十一" do
    compare_kanji_and_integer("七千四百十一", 7411)
  end

  it "七千四百十二" do
    compare_kanji_and_integer("七千四百十二", 7412)
  end

  it "七千四百十三" do
    compare_kanji_and_integer("七千四百十三", 7413)
  end

  it "七千四百十四" do
    compare_kanji_and_integer("七千四百十四", 7414)
  end

  it "七千四百十五" do
    compare_kanji_and_integer("七千四百十五", 7415)
  end

  it "七千四百十六" do
    compare_kanji_and_integer("七千四百十六", 7416)
  end

  it "七千四百十七" do
    compare_kanji_and_integer("七千四百十七", 7417)
  end

  it "七千四百十八" do
    compare_kanji_and_integer("七千四百十八", 7418)
  end

  it "七千四百十九" do
    compare_kanji_and_integer("七千四百十九", 7419)
  end

  it "七千四百二十" do
    compare_kanji_and_integer("七千四百二十", 7420)
  end

  it "七千四百二十一" do
    compare_kanji_and_integer("七千四百二十一", 7421)
  end

  it "七千四百二十二" do
    compare_kanji_and_integer("七千四百二十二", 7422)
  end

  it "七千四百二十三" do
    compare_kanji_and_integer("七千四百二十三", 7423)
  end

  it "七千四百二十四" do
    compare_kanji_and_integer("七千四百二十四", 7424)
  end

  it "七千四百二十五" do
    compare_kanji_and_integer("七千四百二十五", 7425)
  end

  it "七千四百二十六" do
    compare_kanji_and_integer("七千四百二十六", 7426)
  end

  it "七千四百二十七" do
    compare_kanji_and_integer("七千四百二十七", 7427)
  end

  it "七千四百二十八" do
    compare_kanji_and_integer("七千四百二十八", 7428)
  end

  it "七千四百二十九" do
    compare_kanji_and_integer("七千四百二十九", 7429)
  end

  it "七千四百三十" do
    compare_kanji_and_integer("七千四百三十", 7430)
  end

  it "七千四百三十一" do
    compare_kanji_and_integer("七千四百三十一", 7431)
  end

  it "七千四百三十二" do
    compare_kanji_and_integer("七千四百三十二", 7432)
  end

  it "七千四百三十三" do
    compare_kanji_and_integer("七千四百三十三", 7433)
  end

  it "七千四百三十四" do
    compare_kanji_and_integer("七千四百三十四", 7434)
  end

  it "七千四百三十五" do
    compare_kanji_and_integer("七千四百三十五", 7435)
  end

  it "七千四百三十六" do
    compare_kanji_and_integer("七千四百三十六", 7436)
  end

  it "七千四百三十七" do
    compare_kanji_and_integer("七千四百三十七", 7437)
  end

  it "七千四百三十八" do
    compare_kanji_and_integer("七千四百三十八", 7438)
  end

  it "七千四百三十九" do
    compare_kanji_and_integer("七千四百三十九", 7439)
  end

  it "七千四百四十" do
    compare_kanji_and_integer("七千四百四十", 7440)
  end

  it "七千四百四十一" do
    compare_kanji_and_integer("七千四百四十一", 7441)
  end

  it "七千四百四十二" do
    compare_kanji_and_integer("七千四百四十二", 7442)
  end

  it "七千四百四十三" do
    compare_kanji_and_integer("七千四百四十三", 7443)
  end

  it "七千四百四十四" do
    compare_kanji_and_integer("七千四百四十四", 7444)
  end

  it "七千四百四十五" do
    compare_kanji_and_integer("七千四百四十五", 7445)
  end

  it "七千四百四十六" do
    compare_kanji_and_integer("七千四百四十六", 7446)
  end

  it "七千四百四十七" do
    compare_kanji_and_integer("七千四百四十七", 7447)
  end

  it "七千四百四十八" do
    compare_kanji_and_integer("七千四百四十八", 7448)
  end

  it "七千四百四十九" do
    compare_kanji_and_integer("七千四百四十九", 7449)
  end

  it "七千四百五十" do
    compare_kanji_and_integer("七千四百五十", 7450)
  end

  it "七千四百五十一" do
    compare_kanji_and_integer("七千四百五十一", 7451)
  end

  it "七千四百五十二" do
    compare_kanji_and_integer("七千四百五十二", 7452)
  end

  it "七千四百五十三" do
    compare_kanji_and_integer("七千四百五十三", 7453)
  end

  it "七千四百五十四" do
    compare_kanji_and_integer("七千四百五十四", 7454)
  end

  it "七千四百五十五" do
    compare_kanji_and_integer("七千四百五十五", 7455)
  end

  it "七千四百五十六" do
    compare_kanji_and_integer("七千四百五十六", 7456)
  end

  it "七千四百五十七" do
    compare_kanji_and_integer("七千四百五十七", 7457)
  end

  it "七千四百五十八" do
    compare_kanji_and_integer("七千四百五十八", 7458)
  end

  it "七千四百五十九" do
    compare_kanji_and_integer("七千四百五十九", 7459)
  end

  it "七千四百六十" do
    compare_kanji_and_integer("七千四百六十", 7460)
  end

  it "七千四百六十一" do
    compare_kanji_and_integer("七千四百六十一", 7461)
  end

  it "七千四百六十二" do
    compare_kanji_and_integer("七千四百六十二", 7462)
  end

  it "七千四百六十三" do
    compare_kanji_and_integer("七千四百六十三", 7463)
  end

  it "七千四百六十四" do
    compare_kanji_and_integer("七千四百六十四", 7464)
  end

  it "七千四百六十五" do
    compare_kanji_and_integer("七千四百六十五", 7465)
  end

  it "七千四百六十六" do
    compare_kanji_and_integer("七千四百六十六", 7466)
  end

  it "七千四百六十七" do
    compare_kanji_and_integer("七千四百六十七", 7467)
  end

  it "七千四百六十八" do
    compare_kanji_and_integer("七千四百六十八", 7468)
  end

  it "七千四百六十九" do
    compare_kanji_and_integer("七千四百六十九", 7469)
  end

  it "七千四百七十" do
    compare_kanji_and_integer("七千四百七十", 7470)
  end

  it "七千四百七十一" do
    compare_kanji_and_integer("七千四百七十一", 7471)
  end

  it "七千四百七十二" do
    compare_kanji_and_integer("七千四百七十二", 7472)
  end

  it "七千四百七十三" do
    compare_kanji_and_integer("七千四百七十三", 7473)
  end

  it "七千四百七十四" do
    compare_kanji_and_integer("七千四百七十四", 7474)
  end

  it "七千四百七十五" do
    compare_kanji_and_integer("七千四百七十五", 7475)
  end

  it "七千四百七十六" do
    compare_kanji_and_integer("七千四百七十六", 7476)
  end

  it "七千四百七十七" do
    compare_kanji_and_integer("七千四百七十七", 7477)
  end

  it "七千四百七十八" do
    compare_kanji_and_integer("七千四百七十八", 7478)
  end

  it "七千四百七十九" do
    compare_kanji_and_integer("七千四百七十九", 7479)
  end

  it "七千四百八十" do
    compare_kanji_and_integer("七千四百八十", 7480)
  end

  it "七千四百八十一" do
    compare_kanji_and_integer("七千四百八十一", 7481)
  end

  it "七千四百八十二" do
    compare_kanji_and_integer("七千四百八十二", 7482)
  end

  it "七千四百八十三" do
    compare_kanji_and_integer("七千四百八十三", 7483)
  end

  it "七千四百八十四" do
    compare_kanji_and_integer("七千四百八十四", 7484)
  end

  it "七千四百八十五" do
    compare_kanji_and_integer("七千四百八十五", 7485)
  end

  it "七千四百八十六" do
    compare_kanji_and_integer("七千四百八十六", 7486)
  end

  it "七千四百八十七" do
    compare_kanji_and_integer("七千四百八十七", 7487)
  end

  it "七千四百八十八" do
    compare_kanji_and_integer("七千四百八十八", 7488)
  end

  it "七千四百八十九" do
    compare_kanji_and_integer("七千四百八十九", 7489)
  end

  it "七千四百九十" do
    compare_kanji_and_integer("七千四百九十", 7490)
  end

  it "七千四百九十一" do
    compare_kanji_and_integer("七千四百九十一", 7491)
  end

  it "七千四百九十二" do
    compare_kanji_and_integer("七千四百九十二", 7492)
  end

  it "七千四百九十三" do
    compare_kanji_and_integer("七千四百九十三", 7493)
  end

  it "七千四百九十四" do
    compare_kanji_and_integer("七千四百九十四", 7494)
  end

  it "七千四百九十五" do
    compare_kanji_and_integer("七千四百九十五", 7495)
  end

  it "七千四百九十六" do
    compare_kanji_and_integer("七千四百九十六", 7496)
  end

  it "七千四百九十七" do
    compare_kanji_and_integer("七千四百九十七", 7497)
  end

  it "七千四百九十八" do
    compare_kanji_and_integer("七千四百九十八", 7498)
  end

  it "七千四百九十九" do
    compare_kanji_and_integer("七千四百九十九", 7499)
  end

  it "七千五百" do
    compare_kanji_and_integer("七千五百", 7500)
  end

  it "七千五百一" do
    compare_kanji_and_integer("七千五百一", 7501)
  end

  it "七千五百二" do
    compare_kanji_and_integer("七千五百二", 7502)
  end

  it "七千五百三" do
    compare_kanji_and_integer("七千五百三", 7503)
  end

  it "七千五百四" do
    compare_kanji_and_integer("七千五百四", 7504)
  end

  it "七千五百五" do
    compare_kanji_and_integer("七千五百五", 7505)
  end

  it "七千五百六" do
    compare_kanji_and_integer("七千五百六", 7506)
  end

  it "七千五百七" do
    compare_kanji_and_integer("七千五百七", 7507)
  end

  it "七千五百八" do
    compare_kanji_and_integer("七千五百八", 7508)
  end

  it "七千五百九" do
    compare_kanji_and_integer("七千五百九", 7509)
  end

  it "七千五百十" do
    compare_kanji_and_integer("七千五百十", 7510)
  end

  it "七千五百十一" do
    compare_kanji_and_integer("七千五百十一", 7511)
  end

  it "七千五百十二" do
    compare_kanji_and_integer("七千五百十二", 7512)
  end

  it "七千五百十三" do
    compare_kanji_and_integer("七千五百十三", 7513)
  end

  it "七千五百十四" do
    compare_kanji_and_integer("七千五百十四", 7514)
  end

  it "七千五百十五" do
    compare_kanji_and_integer("七千五百十五", 7515)
  end

  it "七千五百十六" do
    compare_kanji_and_integer("七千五百十六", 7516)
  end

  it "七千五百十七" do
    compare_kanji_and_integer("七千五百十七", 7517)
  end

  it "七千五百十八" do
    compare_kanji_and_integer("七千五百十八", 7518)
  end

  it "七千五百十九" do
    compare_kanji_and_integer("七千五百十九", 7519)
  end

  it "七千五百二十" do
    compare_kanji_and_integer("七千五百二十", 7520)
  end

  it "七千五百二十一" do
    compare_kanji_and_integer("七千五百二十一", 7521)
  end

  it "七千五百二十二" do
    compare_kanji_and_integer("七千五百二十二", 7522)
  end

  it "七千五百二十三" do
    compare_kanji_and_integer("七千五百二十三", 7523)
  end

  it "七千五百二十四" do
    compare_kanji_and_integer("七千五百二十四", 7524)
  end

  it "七千五百二十五" do
    compare_kanji_and_integer("七千五百二十五", 7525)
  end

  it "七千五百二十六" do
    compare_kanji_and_integer("七千五百二十六", 7526)
  end

  it "七千五百二十七" do
    compare_kanji_and_integer("七千五百二十七", 7527)
  end

  it "七千五百二十八" do
    compare_kanji_and_integer("七千五百二十八", 7528)
  end

  it "七千五百二十九" do
    compare_kanji_and_integer("七千五百二十九", 7529)
  end

  it "七千五百三十" do
    compare_kanji_and_integer("七千五百三十", 7530)
  end

  it "七千五百三十一" do
    compare_kanji_and_integer("七千五百三十一", 7531)
  end

  it "七千五百三十二" do
    compare_kanji_and_integer("七千五百三十二", 7532)
  end

  it "七千五百三十三" do
    compare_kanji_and_integer("七千五百三十三", 7533)
  end

  it "七千五百三十四" do
    compare_kanji_and_integer("七千五百三十四", 7534)
  end

  it "七千五百三十五" do
    compare_kanji_and_integer("七千五百三十五", 7535)
  end

  it "七千五百三十六" do
    compare_kanji_and_integer("七千五百三十六", 7536)
  end

  it "七千五百三十七" do
    compare_kanji_and_integer("七千五百三十七", 7537)
  end

  it "七千五百三十八" do
    compare_kanji_and_integer("七千五百三十八", 7538)
  end

  it "七千五百三十九" do
    compare_kanji_and_integer("七千五百三十九", 7539)
  end

  it "七千五百四十" do
    compare_kanji_and_integer("七千五百四十", 7540)
  end

  it "七千五百四十一" do
    compare_kanji_and_integer("七千五百四十一", 7541)
  end

  it "七千五百四十二" do
    compare_kanji_and_integer("七千五百四十二", 7542)
  end

  it "七千五百四十三" do
    compare_kanji_and_integer("七千五百四十三", 7543)
  end

  it "七千五百四十四" do
    compare_kanji_and_integer("七千五百四十四", 7544)
  end

  it "七千五百四十五" do
    compare_kanji_and_integer("七千五百四十五", 7545)
  end

  it "七千五百四十六" do
    compare_kanji_and_integer("七千五百四十六", 7546)
  end

  it "七千五百四十七" do
    compare_kanji_and_integer("七千五百四十七", 7547)
  end

  it "七千五百四十八" do
    compare_kanji_and_integer("七千五百四十八", 7548)
  end

  it "七千五百四十九" do
    compare_kanji_and_integer("七千五百四十九", 7549)
  end

  it "七千五百五十" do
    compare_kanji_and_integer("七千五百五十", 7550)
  end

  it "七千五百五十一" do
    compare_kanji_and_integer("七千五百五十一", 7551)
  end

  it "七千五百五十二" do
    compare_kanji_and_integer("七千五百五十二", 7552)
  end

  it "七千五百五十三" do
    compare_kanji_and_integer("七千五百五十三", 7553)
  end

  it "七千五百五十四" do
    compare_kanji_and_integer("七千五百五十四", 7554)
  end

  it "七千五百五十五" do
    compare_kanji_and_integer("七千五百五十五", 7555)
  end

  it "七千五百五十六" do
    compare_kanji_and_integer("七千五百五十六", 7556)
  end

  it "七千五百五十七" do
    compare_kanji_and_integer("七千五百五十七", 7557)
  end

  it "七千五百五十八" do
    compare_kanji_and_integer("七千五百五十八", 7558)
  end

  it "七千五百五十九" do
    compare_kanji_and_integer("七千五百五十九", 7559)
  end

  it "七千五百六十" do
    compare_kanji_and_integer("七千五百六十", 7560)
  end

  it "七千五百六十一" do
    compare_kanji_and_integer("七千五百六十一", 7561)
  end

  it "七千五百六十二" do
    compare_kanji_and_integer("七千五百六十二", 7562)
  end

  it "七千五百六十三" do
    compare_kanji_and_integer("七千五百六十三", 7563)
  end

  it "七千五百六十四" do
    compare_kanji_and_integer("七千五百六十四", 7564)
  end

  it "七千五百六十五" do
    compare_kanji_and_integer("七千五百六十五", 7565)
  end

  it "七千五百六十六" do
    compare_kanji_and_integer("七千五百六十六", 7566)
  end

  it "七千五百六十七" do
    compare_kanji_and_integer("七千五百六十七", 7567)
  end

  it "七千五百六十八" do
    compare_kanji_and_integer("七千五百六十八", 7568)
  end

  it "七千五百六十九" do
    compare_kanji_and_integer("七千五百六十九", 7569)
  end

  it "七千五百七十" do
    compare_kanji_and_integer("七千五百七十", 7570)
  end

  it "七千五百七十一" do
    compare_kanji_and_integer("七千五百七十一", 7571)
  end

  it "七千五百七十二" do
    compare_kanji_and_integer("七千五百七十二", 7572)
  end

  it "七千五百七十三" do
    compare_kanji_and_integer("七千五百七十三", 7573)
  end

  it "七千五百七十四" do
    compare_kanji_and_integer("七千五百七十四", 7574)
  end

  it "七千五百七十五" do
    compare_kanji_and_integer("七千五百七十五", 7575)
  end

  it "七千五百七十六" do
    compare_kanji_and_integer("七千五百七十六", 7576)
  end

  it "七千五百七十七" do
    compare_kanji_and_integer("七千五百七十七", 7577)
  end

  it "七千五百七十八" do
    compare_kanji_and_integer("七千五百七十八", 7578)
  end

  it "七千五百七十九" do
    compare_kanji_and_integer("七千五百七十九", 7579)
  end

  it "七千五百八十" do
    compare_kanji_and_integer("七千五百八十", 7580)
  end

  it "七千五百八十一" do
    compare_kanji_and_integer("七千五百八十一", 7581)
  end

  it "七千五百八十二" do
    compare_kanji_and_integer("七千五百八十二", 7582)
  end

  it "七千五百八十三" do
    compare_kanji_and_integer("七千五百八十三", 7583)
  end

  it "七千五百八十四" do
    compare_kanji_and_integer("七千五百八十四", 7584)
  end

  it "七千五百八十五" do
    compare_kanji_and_integer("七千五百八十五", 7585)
  end

  it "七千五百八十六" do
    compare_kanji_and_integer("七千五百八十六", 7586)
  end

  it "七千五百八十七" do
    compare_kanji_and_integer("七千五百八十七", 7587)
  end

  it "七千五百八十八" do
    compare_kanji_and_integer("七千五百八十八", 7588)
  end

  it "七千五百八十九" do
    compare_kanji_and_integer("七千五百八十九", 7589)
  end

  it "七千五百九十" do
    compare_kanji_and_integer("七千五百九十", 7590)
  end

  it "七千五百九十一" do
    compare_kanji_and_integer("七千五百九十一", 7591)
  end

  it "七千五百九十二" do
    compare_kanji_and_integer("七千五百九十二", 7592)
  end

  it "七千五百九十三" do
    compare_kanji_and_integer("七千五百九十三", 7593)
  end

  it "七千五百九十四" do
    compare_kanji_and_integer("七千五百九十四", 7594)
  end

  it "七千五百九十五" do
    compare_kanji_and_integer("七千五百九十五", 7595)
  end

  it "七千五百九十六" do
    compare_kanji_and_integer("七千五百九十六", 7596)
  end

  it "七千五百九十七" do
    compare_kanji_and_integer("七千五百九十七", 7597)
  end

  it "七千五百九十八" do
    compare_kanji_and_integer("七千五百九十八", 7598)
  end

  it "七千五百九十九" do
    compare_kanji_and_integer("七千五百九十九", 7599)
  end

  it "七千六百" do
    compare_kanji_and_integer("七千六百", 7600)
  end

  it "七千六百一" do
    compare_kanji_and_integer("七千六百一", 7601)
  end

  it "七千六百二" do
    compare_kanji_and_integer("七千六百二", 7602)
  end

  it "七千六百三" do
    compare_kanji_and_integer("七千六百三", 7603)
  end

  it "七千六百四" do
    compare_kanji_and_integer("七千六百四", 7604)
  end

  it "七千六百五" do
    compare_kanji_and_integer("七千六百五", 7605)
  end

  it "七千六百六" do
    compare_kanji_and_integer("七千六百六", 7606)
  end

  it "七千六百七" do
    compare_kanji_and_integer("七千六百七", 7607)
  end

  it "七千六百八" do
    compare_kanji_and_integer("七千六百八", 7608)
  end

  it "七千六百九" do
    compare_kanji_and_integer("七千六百九", 7609)
  end

  it "七千六百十" do
    compare_kanji_and_integer("七千六百十", 7610)
  end

  it "七千六百十一" do
    compare_kanji_and_integer("七千六百十一", 7611)
  end

  it "七千六百十二" do
    compare_kanji_and_integer("七千六百十二", 7612)
  end

  it "七千六百十三" do
    compare_kanji_and_integer("七千六百十三", 7613)
  end

  it "七千六百十四" do
    compare_kanji_and_integer("七千六百十四", 7614)
  end

  it "七千六百十五" do
    compare_kanji_and_integer("七千六百十五", 7615)
  end

  it "七千六百十六" do
    compare_kanji_and_integer("七千六百十六", 7616)
  end

  it "七千六百十七" do
    compare_kanji_and_integer("七千六百十七", 7617)
  end

  it "七千六百十八" do
    compare_kanji_and_integer("七千六百十八", 7618)
  end

  it "七千六百十九" do
    compare_kanji_and_integer("七千六百十九", 7619)
  end

  it "七千六百二十" do
    compare_kanji_and_integer("七千六百二十", 7620)
  end

  it "七千六百二十一" do
    compare_kanji_and_integer("七千六百二十一", 7621)
  end

  it "七千六百二十二" do
    compare_kanji_and_integer("七千六百二十二", 7622)
  end

  it "七千六百二十三" do
    compare_kanji_and_integer("七千六百二十三", 7623)
  end

  it "七千六百二十四" do
    compare_kanji_and_integer("七千六百二十四", 7624)
  end

  it "七千六百二十五" do
    compare_kanji_and_integer("七千六百二十五", 7625)
  end

  it "七千六百二十六" do
    compare_kanji_and_integer("七千六百二十六", 7626)
  end

  it "七千六百二十七" do
    compare_kanji_and_integer("七千六百二十七", 7627)
  end

  it "七千六百二十八" do
    compare_kanji_and_integer("七千六百二十八", 7628)
  end

  it "七千六百二十九" do
    compare_kanji_and_integer("七千六百二十九", 7629)
  end

  it "七千六百三十" do
    compare_kanji_and_integer("七千六百三十", 7630)
  end

  it "七千六百三十一" do
    compare_kanji_and_integer("七千六百三十一", 7631)
  end

  it "七千六百三十二" do
    compare_kanji_and_integer("七千六百三十二", 7632)
  end

  it "七千六百三十三" do
    compare_kanji_and_integer("七千六百三十三", 7633)
  end

  it "七千六百三十四" do
    compare_kanji_and_integer("七千六百三十四", 7634)
  end

  it "七千六百三十五" do
    compare_kanji_and_integer("七千六百三十五", 7635)
  end

  it "七千六百三十六" do
    compare_kanji_and_integer("七千六百三十六", 7636)
  end

  it "七千六百三十七" do
    compare_kanji_and_integer("七千六百三十七", 7637)
  end

  it "七千六百三十八" do
    compare_kanji_and_integer("七千六百三十八", 7638)
  end

  it "七千六百三十九" do
    compare_kanji_and_integer("七千六百三十九", 7639)
  end

  it "七千六百四十" do
    compare_kanji_and_integer("七千六百四十", 7640)
  end

  it "七千六百四十一" do
    compare_kanji_and_integer("七千六百四十一", 7641)
  end

  it "七千六百四十二" do
    compare_kanji_and_integer("七千六百四十二", 7642)
  end

  it "七千六百四十三" do
    compare_kanji_and_integer("七千六百四十三", 7643)
  end

  it "七千六百四十四" do
    compare_kanji_and_integer("七千六百四十四", 7644)
  end

  it "七千六百四十五" do
    compare_kanji_and_integer("七千六百四十五", 7645)
  end

  it "七千六百四十六" do
    compare_kanji_and_integer("七千六百四十六", 7646)
  end

  it "七千六百四十七" do
    compare_kanji_and_integer("七千六百四十七", 7647)
  end

  it "七千六百四十八" do
    compare_kanji_and_integer("七千六百四十八", 7648)
  end

  it "七千六百四十九" do
    compare_kanji_and_integer("七千六百四十九", 7649)
  end

  it "七千六百五十" do
    compare_kanji_and_integer("七千六百五十", 7650)
  end

  it "七千六百五十一" do
    compare_kanji_and_integer("七千六百五十一", 7651)
  end

  it "七千六百五十二" do
    compare_kanji_and_integer("七千六百五十二", 7652)
  end

  it "七千六百五十三" do
    compare_kanji_and_integer("七千六百五十三", 7653)
  end

  it "七千六百五十四" do
    compare_kanji_and_integer("七千六百五十四", 7654)
  end

  it "七千六百五十五" do
    compare_kanji_and_integer("七千六百五十五", 7655)
  end

  it "七千六百五十六" do
    compare_kanji_and_integer("七千六百五十六", 7656)
  end

  it "七千六百五十七" do
    compare_kanji_and_integer("七千六百五十七", 7657)
  end

  it "七千六百五十八" do
    compare_kanji_and_integer("七千六百五十八", 7658)
  end

  it "七千六百五十九" do
    compare_kanji_and_integer("七千六百五十九", 7659)
  end

  it "七千六百六十" do
    compare_kanji_and_integer("七千六百六十", 7660)
  end

  it "七千六百六十一" do
    compare_kanji_and_integer("七千六百六十一", 7661)
  end

  it "七千六百六十二" do
    compare_kanji_and_integer("七千六百六十二", 7662)
  end

  it "七千六百六十三" do
    compare_kanji_and_integer("七千六百六十三", 7663)
  end

  it "七千六百六十四" do
    compare_kanji_and_integer("七千六百六十四", 7664)
  end

  it "七千六百六十五" do
    compare_kanji_and_integer("七千六百六十五", 7665)
  end

  it "七千六百六十六" do
    compare_kanji_and_integer("七千六百六十六", 7666)
  end

  it "七千六百六十七" do
    compare_kanji_and_integer("七千六百六十七", 7667)
  end

  it "七千六百六十八" do
    compare_kanji_and_integer("七千六百六十八", 7668)
  end

  it "七千六百六十九" do
    compare_kanji_and_integer("七千六百六十九", 7669)
  end

  it "七千六百七十" do
    compare_kanji_and_integer("七千六百七十", 7670)
  end

  it "七千六百七十一" do
    compare_kanji_and_integer("七千六百七十一", 7671)
  end

  it "七千六百七十二" do
    compare_kanji_and_integer("七千六百七十二", 7672)
  end

  it "七千六百七十三" do
    compare_kanji_and_integer("七千六百七十三", 7673)
  end

  it "七千六百七十四" do
    compare_kanji_and_integer("七千六百七十四", 7674)
  end

  it "七千六百七十五" do
    compare_kanji_and_integer("七千六百七十五", 7675)
  end

  it "七千六百七十六" do
    compare_kanji_and_integer("七千六百七十六", 7676)
  end

  it "七千六百七十七" do
    compare_kanji_and_integer("七千六百七十七", 7677)
  end

  it "七千六百七十八" do
    compare_kanji_and_integer("七千六百七十八", 7678)
  end

  it "七千六百七十九" do
    compare_kanji_and_integer("七千六百七十九", 7679)
  end

  it "七千六百八十" do
    compare_kanji_and_integer("七千六百八十", 7680)
  end

  it "七千六百八十一" do
    compare_kanji_and_integer("七千六百八十一", 7681)
  end

  it "七千六百八十二" do
    compare_kanji_and_integer("七千六百八十二", 7682)
  end

  it "七千六百八十三" do
    compare_kanji_and_integer("七千六百八十三", 7683)
  end

  it "七千六百八十四" do
    compare_kanji_and_integer("七千六百八十四", 7684)
  end

  it "七千六百八十五" do
    compare_kanji_and_integer("七千六百八十五", 7685)
  end

  it "七千六百八十六" do
    compare_kanji_and_integer("七千六百八十六", 7686)
  end

  it "七千六百八十七" do
    compare_kanji_and_integer("七千六百八十七", 7687)
  end

  it "七千六百八十八" do
    compare_kanji_and_integer("七千六百八十八", 7688)
  end

  it "七千六百八十九" do
    compare_kanji_and_integer("七千六百八十九", 7689)
  end

  it "七千六百九十" do
    compare_kanji_and_integer("七千六百九十", 7690)
  end

  it "七千六百九十一" do
    compare_kanji_and_integer("七千六百九十一", 7691)
  end

  it "七千六百九十二" do
    compare_kanji_and_integer("七千六百九十二", 7692)
  end

  it "七千六百九十三" do
    compare_kanji_and_integer("七千六百九十三", 7693)
  end

  it "七千六百九十四" do
    compare_kanji_and_integer("七千六百九十四", 7694)
  end

  it "七千六百九十五" do
    compare_kanji_and_integer("七千六百九十五", 7695)
  end

  it "七千六百九十六" do
    compare_kanji_and_integer("七千六百九十六", 7696)
  end

  it "七千六百九十七" do
    compare_kanji_and_integer("七千六百九十七", 7697)
  end

  it "七千六百九十八" do
    compare_kanji_and_integer("七千六百九十八", 7698)
  end

  it "七千六百九十九" do
    compare_kanji_and_integer("七千六百九十九", 7699)
  end

  it "七千七百" do
    compare_kanji_and_integer("七千七百", 7700)
  end

  it "七千七百一" do
    compare_kanji_and_integer("七千七百一", 7701)
  end

  it "七千七百二" do
    compare_kanji_and_integer("七千七百二", 7702)
  end

  it "七千七百三" do
    compare_kanji_and_integer("七千七百三", 7703)
  end

  it "七千七百四" do
    compare_kanji_and_integer("七千七百四", 7704)
  end

  it "七千七百五" do
    compare_kanji_and_integer("七千七百五", 7705)
  end

  it "七千七百六" do
    compare_kanji_and_integer("七千七百六", 7706)
  end

  it "七千七百七" do
    compare_kanji_and_integer("七千七百七", 7707)
  end

  it "七千七百八" do
    compare_kanji_and_integer("七千七百八", 7708)
  end

  it "七千七百九" do
    compare_kanji_and_integer("七千七百九", 7709)
  end

  it "七千七百十" do
    compare_kanji_and_integer("七千七百十", 7710)
  end

  it "七千七百十一" do
    compare_kanji_and_integer("七千七百十一", 7711)
  end

  it "七千七百十二" do
    compare_kanji_and_integer("七千七百十二", 7712)
  end

  it "七千七百十三" do
    compare_kanji_and_integer("七千七百十三", 7713)
  end

  it "七千七百十四" do
    compare_kanji_and_integer("七千七百十四", 7714)
  end

  it "七千七百十五" do
    compare_kanji_and_integer("七千七百十五", 7715)
  end

  it "七千七百十六" do
    compare_kanji_and_integer("七千七百十六", 7716)
  end

  it "七千七百十七" do
    compare_kanji_and_integer("七千七百十七", 7717)
  end

  it "七千七百十八" do
    compare_kanji_and_integer("七千七百十八", 7718)
  end

  it "七千七百十九" do
    compare_kanji_and_integer("七千七百十九", 7719)
  end

  it "七千七百二十" do
    compare_kanji_and_integer("七千七百二十", 7720)
  end

  it "七千七百二十一" do
    compare_kanji_and_integer("七千七百二十一", 7721)
  end

  it "七千七百二十二" do
    compare_kanji_and_integer("七千七百二十二", 7722)
  end

  it "七千七百二十三" do
    compare_kanji_and_integer("七千七百二十三", 7723)
  end

  it "七千七百二十四" do
    compare_kanji_and_integer("七千七百二十四", 7724)
  end

  it "七千七百二十五" do
    compare_kanji_and_integer("七千七百二十五", 7725)
  end

  it "七千七百二十六" do
    compare_kanji_and_integer("七千七百二十六", 7726)
  end

  it "七千七百二十七" do
    compare_kanji_and_integer("七千七百二十七", 7727)
  end

  it "七千七百二十八" do
    compare_kanji_and_integer("七千七百二十八", 7728)
  end

  it "七千七百二十九" do
    compare_kanji_and_integer("七千七百二十九", 7729)
  end

  it "七千七百三十" do
    compare_kanji_and_integer("七千七百三十", 7730)
  end

  it "七千七百三十一" do
    compare_kanji_and_integer("七千七百三十一", 7731)
  end

  it "七千七百三十二" do
    compare_kanji_and_integer("七千七百三十二", 7732)
  end

  it "七千七百三十三" do
    compare_kanji_and_integer("七千七百三十三", 7733)
  end

  it "七千七百三十四" do
    compare_kanji_and_integer("七千七百三十四", 7734)
  end

  it "七千七百三十五" do
    compare_kanji_and_integer("七千七百三十五", 7735)
  end

  it "七千七百三十六" do
    compare_kanji_and_integer("七千七百三十六", 7736)
  end

  it "七千七百三十七" do
    compare_kanji_and_integer("七千七百三十七", 7737)
  end

  it "七千七百三十八" do
    compare_kanji_and_integer("七千七百三十八", 7738)
  end

  it "七千七百三十九" do
    compare_kanji_and_integer("七千七百三十九", 7739)
  end

  it "七千七百四十" do
    compare_kanji_and_integer("七千七百四十", 7740)
  end

  it "七千七百四十一" do
    compare_kanji_and_integer("七千七百四十一", 7741)
  end

  it "七千七百四十二" do
    compare_kanji_and_integer("七千七百四十二", 7742)
  end

  it "七千七百四十三" do
    compare_kanji_and_integer("七千七百四十三", 7743)
  end

  it "七千七百四十四" do
    compare_kanji_and_integer("七千七百四十四", 7744)
  end

  it "七千七百四十五" do
    compare_kanji_and_integer("七千七百四十五", 7745)
  end

  it "七千七百四十六" do
    compare_kanji_and_integer("七千七百四十六", 7746)
  end

  it "七千七百四十七" do
    compare_kanji_and_integer("七千七百四十七", 7747)
  end

  it "七千七百四十八" do
    compare_kanji_and_integer("七千七百四十八", 7748)
  end

  it "七千七百四十九" do
    compare_kanji_and_integer("七千七百四十九", 7749)
  end

  it "七千七百五十" do
    compare_kanji_and_integer("七千七百五十", 7750)
  end

  it "七千七百五十一" do
    compare_kanji_and_integer("七千七百五十一", 7751)
  end

  it "七千七百五十二" do
    compare_kanji_and_integer("七千七百五十二", 7752)
  end

  it "七千七百五十三" do
    compare_kanji_and_integer("七千七百五十三", 7753)
  end

  it "七千七百五十四" do
    compare_kanji_and_integer("七千七百五十四", 7754)
  end

  it "七千七百五十五" do
    compare_kanji_and_integer("七千七百五十五", 7755)
  end

  it "七千七百五十六" do
    compare_kanji_and_integer("七千七百五十六", 7756)
  end

  it "七千七百五十七" do
    compare_kanji_and_integer("七千七百五十七", 7757)
  end

  it "七千七百五十八" do
    compare_kanji_and_integer("七千七百五十八", 7758)
  end

  it "七千七百五十九" do
    compare_kanji_and_integer("七千七百五十九", 7759)
  end

  it "七千七百六十" do
    compare_kanji_and_integer("七千七百六十", 7760)
  end

  it "七千七百六十一" do
    compare_kanji_and_integer("七千七百六十一", 7761)
  end

  it "七千七百六十二" do
    compare_kanji_and_integer("七千七百六十二", 7762)
  end

  it "七千七百六十三" do
    compare_kanji_and_integer("七千七百六十三", 7763)
  end

  it "七千七百六十四" do
    compare_kanji_and_integer("七千七百六十四", 7764)
  end

  it "七千七百六十五" do
    compare_kanji_and_integer("七千七百六十五", 7765)
  end

  it "七千七百六十六" do
    compare_kanji_and_integer("七千七百六十六", 7766)
  end

  it "七千七百六十七" do
    compare_kanji_and_integer("七千七百六十七", 7767)
  end

  it "七千七百六十八" do
    compare_kanji_and_integer("七千七百六十八", 7768)
  end

  it "七千七百六十九" do
    compare_kanji_and_integer("七千七百六十九", 7769)
  end

  it "七千七百七十" do
    compare_kanji_and_integer("七千七百七十", 7770)
  end

  it "七千七百七十一" do
    compare_kanji_and_integer("七千七百七十一", 7771)
  end

  it "七千七百七十二" do
    compare_kanji_and_integer("七千七百七十二", 7772)
  end

  it "七千七百七十三" do
    compare_kanji_and_integer("七千七百七十三", 7773)
  end

  it "七千七百七十四" do
    compare_kanji_and_integer("七千七百七十四", 7774)
  end

  it "七千七百七十五" do
    compare_kanji_and_integer("七千七百七十五", 7775)
  end

  it "七千七百七十六" do
    compare_kanji_and_integer("七千七百七十六", 7776)
  end

  it "七千七百七十七" do
    compare_kanji_and_integer("七千七百七十七", 7777)
  end

  it "七千七百七十八" do
    compare_kanji_and_integer("七千七百七十八", 7778)
  end

  it "七千七百七十九" do
    compare_kanji_and_integer("七千七百七十九", 7779)
  end

  it "七千七百八十" do
    compare_kanji_and_integer("七千七百八十", 7780)
  end

  it "七千七百八十一" do
    compare_kanji_and_integer("七千七百八十一", 7781)
  end

  it "七千七百八十二" do
    compare_kanji_and_integer("七千七百八十二", 7782)
  end

  it "七千七百八十三" do
    compare_kanji_and_integer("七千七百八十三", 7783)
  end

  it "七千七百八十四" do
    compare_kanji_and_integer("七千七百八十四", 7784)
  end

  it "七千七百八十五" do
    compare_kanji_and_integer("七千七百八十五", 7785)
  end

  it "七千七百八十六" do
    compare_kanji_and_integer("七千七百八十六", 7786)
  end

  it "七千七百八十七" do
    compare_kanji_and_integer("七千七百八十七", 7787)
  end

  it "七千七百八十八" do
    compare_kanji_and_integer("七千七百八十八", 7788)
  end

  it "七千七百八十九" do
    compare_kanji_and_integer("七千七百八十九", 7789)
  end

  it "七千七百九十" do
    compare_kanji_and_integer("七千七百九十", 7790)
  end

  it "七千七百九十一" do
    compare_kanji_and_integer("七千七百九十一", 7791)
  end

  it "七千七百九十二" do
    compare_kanji_and_integer("七千七百九十二", 7792)
  end

  it "七千七百九十三" do
    compare_kanji_and_integer("七千七百九十三", 7793)
  end

  it "七千七百九十四" do
    compare_kanji_and_integer("七千七百九十四", 7794)
  end

  it "七千七百九十五" do
    compare_kanji_and_integer("七千七百九十五", 7795)
  end

  it "七千七百九十六" do
    compare_kanji_and_integer("七千七百九十六", 7796)
  end

  it "七千七百九十七" do
    compare_kanji_and_integer("七千七百九十七", 7797)
  end

  it "七千七百九十八" do
    compare_kanji_and_integer("七千七百九十八", 7798)
  end

  it "七千七百九十九" do
    compare_kanji_and_integer("七千七百九十九", 7799)
  end

  it "七千八百" do
    compare_kanji_and_integer("七千八百", 7800)
  end

  it "七千八百一" do
    compare_kanji_and_integer("七千八百一", 7801)
  end

  it "七千八百二" do
    compare_kanji_and_integer("七千八百二", 7802)
  end

  it "七千八百三" do
    compare_kanji_and_integer("七千八百三", 7803)
  end

  it "七千八百四" do
    compare_kanji_and_integer("七千八百四", 7804)
  end

  it "七千八百五" do
    compare_kanji_and_integer("七千八百五", 7805)
  end

  it "七千八百六" do
    compare_kanji_and_integer("七千八百六", 7806)
  end

  it "七千八百七" do
    compare_kanji_and_integer("七千八百七", 7807)
  end

  it "七千八百八" do
    compare_kanji_and_integer("七千八百八", 7808)
  end

  it "七千八百九" do
    compare_kanji_and_integer("七千八百九", 7809)
  end

  it "七千八百十" do
    compare_kanji_and_integer("七千八百十", 7810)
  end

  it "七千八百十一" do
    compare_kanji_and_integer("七千八百十一", 7811)
  end

  it "七千八百十二" do
    compare_kanji_and_integer("七千八百十二", 7812)
  end

  it "七千八百十三" do
    compare_kanji_and_integer("七千八百十三", 7813)
  end

  it "七千八百十四" do
    compare_kanji_and_integer("七千八百十四", 7814)
  end

  it "七千八百十五" do
    compare_kanji_and_integer("七千八百十五", 7815)
  end

  it "七千八百十六" do
    compare_kanji_and_integer("七千八百十六", 7816)
  end

  it "七千八百十七" do
    compare_kanji_and_integer("七千八百十七", 7817)
  end

  it "七千八百十八" do
    compare_kanji_and_integer("七千八百十八", 7818)
  end

  it "七千八百十九" do
    compare_kanji_and_integer("七千八百十九", 7819)
  end

  it "七千八百二十" do
    compare_kanji_and_integer("七千八百二十", 7820)
  end

  it "七千八百二十一" do
    compare_kanji_and_integer("七千八百二十一", 7821)
  end

  it "七千八百二十二" do
    compare_kanji_and_integer("七千八百二十二", 7822)
  end

  it "七千八百二十三" do
    compare_kanji_and_integer("七千八百二十三", 7823)
  end

  it "七千八百二十四" do
    compare_kanji_and_integer("七千八百二十四", 7824)
  end

  it "七千八百二十五" do
    compare_kanji_and_integer("七千八百二十五", 7825)
  end

  it "七千八百二十六" do
    compare_kanji_and_integer("七千八百二十六", 7826)
  end

  it "七千八百二十七" do
    compare_kanji_and_integer("七千八百二十七", 7827)
  end

  it "七千八百二十八" do
    compare_kanji_and_integer("七千八百二十八", 7828)
  end

  it "七千八百二十九" do
    compare_kanji_and_integer("七千八百二十九", 7829)
  end

  it "七千八百三十" do
    compare_kanji_and_integer("七千八百三十", 7830)
  end

  it "七千八百三十一" do
    compare_kanji_and_integer("七千八百三十一", 7831)
  end

  it "七千八百三十二" do
    compare_kanji_and_integer("七千八百三十二", 7832)
  end

  it "七千八百三十三" do
    compare_kanji_and_integer("七千八百三十三", 7833)
  end

  it "七千八百三十四" do
    compare_kanji_and_integer("七千八百三十四", 7834)
  end

  it "七千八百三十五" do
    compare_kanji_and_integer("七千八百三十五", 7835)
  end

  it "七千八百三十六" do
    compare_kanji_and_integer("七千八百三十六", 7836)
  end

  it "七千八百三十七" do
    compare_kanji_and_integer("七千八百三十七", 7837)
  end

  it "七千八百三十八" do
    compare_kanji_and_integer("七千八百三十八", 7838)
  end

  it "七千八百三十九" do
    compare_kanji_and_integer("七千八百三十九", 7839)
  end

  it "七千八百四十" do
    compare_kanji_and_integer("七千八百四十", 7840)
  end

  it "七千八百四十一" do
    compare_kanji_and_integer("七千八百四十一", 7841)
  end

  it "七千八百四十二" do
    compare_kanji_and_integer("七千八百四十二", 7842)
  end

  it "七千八百四十三" do
    compare_kanji_and_integer("七千八百四十三", 7843)
  end

  it "七千八百四十四" do
    compare_kanji_and_integer("七千八百四十四", 7844)
  end

  it "七千八百四十五" do
    compare_kanji_and_integer("七千八百四十五", 7845)
  end

  it "七千八百四十六" do
    compare_kanji_and_integer("七千八百四十六", 7846)
  end

  it "七千八百四十七" do
    compare_kanji_and_integer("七千八百四十七", 7847)
  end

  it "七千八百四十八" do
    compare_kanji_and_integer("七千八百四十八", 7848)
  end

  it "七千八百四十九" do
    compare_kanji_and_integer("七千八百四十九", 7849)
  end

  it "七千八百五十" do
    compare_kanji_and_integer("七千八百五十", 7850)
  end

  it "七千八百五十一" do
    compare_kanji_and_integer("七千八百五十一", 7851)
  end

  it "七千八百五十二" do
    compare_kanji_and_integer("七千八百五十二", 7852)
  end

  it "七千八百五十三" do
    compare_kanji_and_integer("七千八百五十三", 7853)
  end

  it "七千八百五十四" do
    compare_kanji_and_integer("七千八百五十四", 7854)
  end

  it "七千八百五十五" do
    compare_kanji_and_integer("七千八百五十五", 7855)
  end

  it "七千八百五十六" do
    compare_kanji_and_integer("七千八百五十六", 7856)
  end

  it "七千八百五十七" do
    compare_kanji_and_integer("七千八百五十七", 7857)
  end

  it "七千八百五十八" do
    compare_kanji_and_integer("七千八百五十八", 7858)
  end

  it "七千八百五十九" do
    compare_kanji_and_integer("七千八百五十九", 7859)
  end

  it "七千八百六十" do
    compare_kanji_and_integer("七千八百六十", 7860)
  end

  it "七千八百六十一" do
    compare_kanji_and_integer("七千八百六十一", 7861)
  end

  it "七千八百六十二" do
    compare_kanji_and_integer("七千八百六十二", 7862)
  end

  it "七千八百六十三" do
    compare_kanji_and_integer("七千八百六十三", 7863)
  end

  it "七千八百六十四" do
    compare_kanji_and_integer("七千八百六十四", 7864)
  end

  it "七千八百六十五" do
    compare_kanji_and_integer("七千八百六十五", 7865)
  end

  it "七千八百六十六" do
    compare_kanji_and_integer("七千八百六十六", 7866)
  end

  it "七千八百六十七" do
    compare_kanji_and_integer("七千八百六十七", 7867)
  end

  it "七千八百六十八" do
    compare_kanji_and_integer("七千八百六十八", 7868)
  end

  it "七千八百六十九" do
    compare_kanji_and_integer("七千八百六十九", 7869)
  end

  it "七千八百七十" do
    compare_kanji_and_integer("七千八百七十", 7870)
  end

  it "七千八百七十一" do
    compare_kanji_and_integer("七千八百七十一", 7871)
  end

  it "七千八百七十二" do
    compare_kanji_and_integer("七千八百七十二", 7872)
  end

  it "七千八百七十三" do
    compare_kanji_and_integer("七千八百七十三", 7873)
  end

  it "七千八百七十四" do
    compare_kanji_and_integer("七千八百七十四", 7874)
  end

  it "七千八百七十五" do
    compare_kanji_and_integer("七千八百七十五", 7875)
  end

  it "七千八百七十六" do
    compare_kanji_and_integer("七千八百七十六", 7876)
  end

  it "七千八百七十七" do
    compare_kanji_and_integer("七千八百七十七", 7877)
  end

  it "七千八百七十八" do
    compare_kanji_and_integer("七千八百七十八", 7878)
  end

  it "七千八百七十九" do
    compare_kanji_and_integer("七千八百七十九", 7879)
  end

  it "七千八百八十" do
    compare_kanji_and_integer("七千八百八十", 7880)
  end

  it "七千八百八十一" do
    compare_kanji_and_integer("七千八百八十一", 7881)
  end

  it "七千八百八十二" do
    compare_kanji_and_integer("七千八百八十二", 7882)
  end

  it "七千八百八十三" do
    compare_kanji_and_integer("七千八百八十三", 7883)
  end

  it "七千八百八十四" do
    compare_kanji_and_integer("七千八百八十四", 7884)
  end

  it "七千八百八十五" do
    compare_kanji_and_integer("七千八百八十五", 7885)
  end

  it "七千八百八十六" do
    compare_kanji_and_integer("七千八百八十六", 7886)
  end

  it "七千八百八十七" do
    compare_kanji_and_integer("七千八百八十七", 7887)
  end

  it "七千八百八十八" do
    compare_kanji_and_integer("七千八百八十八", 7888)
  end

  it "七千八百八十九" do
    compare_kanji_and_integer("七千八百八十九", 7889)
  end

  it "七千八百九十" do
    compare_kanji_and_integer("七千八百九十", 7890)
  end

  it "七千八百九十一" do
    compare_kanji_and_integer("七千八百九十一", 7891)
  end

  it "七千八百九十二" do
    compare_kanji_and_integer("七千八百九十二", 7892)
  end

  it "七千八百九十三" do
    compare_kanji_and_integer("七千八百九十三", 7893)
  end

  it "七千八百九十四" do
    compare_kanji_and_integer("七千八百九十四", 7894)
  end

  it "七千八百九十五" do
    compare_kanji_and_integer("七千八百九十五", 7895)
  end

  it "七千八百九十六" do
    compare_kanji_and_integer("七千八百九十六", 7896)
  end

  it "七千八百九十七" do
    compare_kanji_and_integer("七千八百九十七", 7897)
  end

  it "七千八百九十八" do
    compare_kanji_and_integer("七千八百九十八", 7898)
  end

  it "七千八百九十九" do
    compare_kanji_and_integer("七千八百九十九", 7899)
  end

  it "七千九百" do
    compare_kanji_and_integer("七千九百", 7900)
  end

  it "七千九百一" do
    compare_kanji_and_integer("七千九百一", 7901)
  end

  it "七千九百二" do
    compare_kanji_and_integer("七千九百二", 7902)
  end

  it "七千九百三" do
    compare_kanji_and_integer("七千九百三", 7903)
  end

  it "七千九百四" do
    compare_kanji_and_integer("七千九百四", 7904)
  end

  it "七千九百五" do
    compare_kanji_and_integer("七千九百五", 7905)
  end

  it "七千九百六" do
    compare_kanji_and_integer("七千九百六", 7906)
  end

  it "七千九百七" do
    compare_kanji_and_integer("七千九百七", 7907)
  end

  it "七千九百八" do
    compare_kanji_and_integer("七千九百八", 7908)
  end

  it "七千九百九" do
    compare_kanji_and_integer("七千九百九", 7909)
  end

  it "七千九百十" do
    compare_kanji_and_integer("七千九百十", 7910)
  end

  it "七千九百十一" do
    compare_kanji_and_integer("七千九百十一", 7911)
  end

  it "七千九百十二" do
    compare_kanji_and_integer("七千九百十二", 7912)
  end

  it "七千九百十三" do
    compare_kanji_and_integer("七千九百十三", 7913)
  end

  it "七千九百十四" do
    compare_kanji_and_integer("七千九百十四", 7914)
  end

  it "七千九百十五" do
    compare_kanji_and_integer("七千九百十五", 7915)
  end

  it "七千九百十六" do
    compare_kanji_and_integer("七千九百十六", 7916)
  end

  it "七千九百十七" do
    compare_kanji_and_integer("七千九百十七", 7917)
  end

  it "七千九百十八" do
    compare_kanji_and_integer("七千九百十八", 7918)
  end

  it "七千九百十九" do
    compare_kanji_and_integer("七千九百十九", 7919)
  end

  it "七千九百二十" do
    compare_kanji_and_integer("七千九百二十", 7920)
  end

  it "七千九百二十一" do
    compare_kanji_and_integer("七千九百二十一", 7921)
  end

  it "七千九百二十二" do
    compare_kanji_and_integer("七千九百二十二", 7922)
  end

  it "七千九百二十三" do
    compare_kanji_and_integer("七千九百二十三", 7923)
  end

  it "七千九百二十四" do
    compare_kanji_and_integer("七千九百二十四", 7924)
  end

  it "七千九百二十五" do
    compare_kanji_and_integer("七千九百二十五", 7925)
  end

  it "七千九百二十六" do
    compare_kanji_and_integer("七千九百二十六", 7926)
  end

  it "七千九百二十七" do
    compare_kanji_and_integer("七千九百二十七", 7927)
  end

  it "七千九百二十八" do
    compare_kanji_and_integer("七千九百二十八", 7928)
  end

  it "七千九百二十九" do
    compare_kanji_and_integer("七千九百二十九", 7929)
  end

  it "七千九百三十" do
    compare_kanji_and_integer("七千九百三十", 7930)
  end

  it "七千九百三十一" do
    compare_kanji_and_integer("七千九百三十一", 7931)
  end

  it "七千九百三十二" do
    compare_kanji_and_integer("七千九百三十二", 7932)
  end

  it "七千九百三十三" do
    compare_kanji_and_integer("七千九百三十三", 7933)
  end

  it "七千九百三十四" do
    compare_kanji_and_integer("七千九百三十四", 7934)
  end

  it "七千九百三十五" do
    compare_kanji_and_integer("七千九百三十五", 7935)
  end

  it "七千九百三十六" do
    compare_kanji_and_integer("七千九百三十六", 7936)
  end

  it "七千九百三十七" do
    compare_kanji_and_integer("七千九百三十七", 7937)
  end

  it "七千九百三十八" do
    compare_kanji_and_integer("七千九百三十八", 7938)
  end

  it "七千九百三十九" do
    compare_kanji_and_integer("七千九百三十九", 7939)
  end

  it "七千九百四十" do
    compare_kanji_and_integer("七千九百四十", 7940)
  end

  it "七千九百四十一" do
    compare_kanji_and_integer("七千九百四十一", 7941)
  end

  it "七千九百四十二" do
    compare_kanji_and_integer("七千九百四十二", 7942)
  end

  it "七千九百四十三" do
    compare_kanji_and_integer("七千九百四十三", 7943)
  end

  it "七千九百四十四" do
    compare_kanji_and_integer("七千九百四十四", 7944)
  end

  it "七千九百四十五" do
    compare_kanji_and_integer("七千九百四十五", 7945)
  end

  it "七千九百四十六" do
    compare_kanji_and_integer("七千九百四十六", 7946)
  end

  it "七千九百四十七" do
    compare_kanji_and_integer("七千九百四十七", 7947)
  end

  it "七千九百四十八" do
    compare_kanji_and_integer("七千九百四十八", 7948)
  end

  it "七千九百四十九" do
    compare_kanji_and_integer("七千九百四十九", 7949)
  end

  it "七千九百五十" do
    compare_kanji_and_integer("七千九百五十", 7950)
  end

  it "七千九百五十一" do
    compare_kanji_and_integer("七千九百五十一", 7951)
  end

  it "七千九百五十二" do
    compare_kanji_and_integer("七千九百五十二", 7952)
  end

  it "七千九百五十三" do
    compare_kanji_and_integer("七千九百五十三", 7953)
  end

  it "七千九百五十四" do
    compare_kanji_and_integer("七千九百五十四", 7954)
  end

  it "七千九百五十五" do
    compare_kanji_and_integer("七千九百五十五", 7955)
  end

  it "七千九百五十六" do
    compare_kanji_and_integer("七千九百五十六", 7956)
  end

  it "七千九百五十七" do
    compare_kanji_and_integer("七千九百五十七", 7957)
  end

  it "七千九百五十八" do
    compare_kanji_and_integer("七千九百五十八", 7958)
  end

  it "七千九百五十九" do
    compare_kanji_and_integer("七千九百五十九", 7959)
  end

  it "七千九百六十" do
    compare_kanji_and_integer("七千九百六十", 7960)
  end

  it "七千九百六十一" do
    compare_kanji_and_integer("七千九百六十一", 7961)
  end

  it "七千九百六十二" do
    compare_kanji_and_integer("七千九百六十二", 7962)
  end

  it "七千九百六十三" do
    compare_kanji_and_integer("七千九百六十三", 7963)
  end

  it "七千九百六十四" do
    compare_kanji_and_integer("七千九百六十四", 7964)
  end

  it "七千九百六十五" do
    compare_kanji_and_integer("七千九百六十五", 7965)
  end

  it "七千九百六十六" do
    compare_kanji_and_integer("七千九百六十六", 7966)
  end

  it "七千九百六十七" do
    compare_kanji_and_integer("七千九百六十七", 7967)
  end

  it "七千九百六十八" do
    compare_kanji_and_integer("七千九百六十八", 7968)
  end

  it "七千九百六十九" do
    compare_kanji_and_integer("七千九百六十九", 7969)
  end

  it "七千九百七十" do
    compare_kanji_and_integer("七千九百七十", 7970)
  end

  it "七千九百七十一" do
    compare_kanji_and_integer("七千九百七十一", 7971)
  end

  it "七千九百七十二" do
    compare_kanji_and_integer("七千九百七十二", 7972)
  end

  it "七千九百七十三" do
    compare_kanji_and_integer("七千九百七十三", 7973)
  end

  it "七千九百七十四" do
    compare_kanji_and_integer("七千九百七十四", 7974)
  end

  it "七千九百七十五" do
    compare_kanji_and_integer("七千九百七十五", 7975)
  end

  it "七千九百七十六" do
    compare_kanji_and_integer("七千九百七十六", 7976)
  end

  it "七千九百七十七" do
    compare_kanji_and_integer("七千九百七十七", 7977)
  end

  it "七千九百七十八" do
    compare_kanji_and_integer("七千九百七十八", 7978)
  end

  it "七千九百七十九" do
    compare_kanji_and_integer("七千九百七十九", 7979)
  end

  it "七千九百八十" do
    compare_kanji_and_integer("七千九百八十", 7980)
  end

  it "七千九百八十一" do
    compare_kanji_and_integer("七千九百八十一", 7981)
  end

  it "七千九百八十二" do
    compare_kanji_and_integer("七千九百八十二", 7982)
  end

  it "七千九百八十三" do
    compare_kanji_and_integer("七千九百八十三", 7983)
  end

  it "七千九百八十四" do
    compare_kanji_and_integer("七千九百八十四", 7984)
  end

  it "七千九百八十五" do
    compare_kanji_and_integer("七千九百八十五", 7985)
  end

  it "七千九百八十六" do
    compare_kanji_and_integer("七千九百八十六", 7986)
  end

  it "七千九百八十七" do
    compare_kanji_and_integer("七千九百八十七", 7987)
  end

  it "七千九百八十八" do
    compare_kanji_and_integer("七千九百八十八", 7988)
  end

  it "七千九百八十九" do
    compare_kanji_and_integer("七千九百八十九", 7989)
  end

  it "七千九百九十" do
    compare_kanji_and_integer("七千九百九十", 7990)
  end

  it "七千九百九十一" do
    compare_kanji_and_integer("七千九百九十一", 7991)
  end

  it "七千九百九十二" do
    compare_kanji_and_integer("七千九百九十二", 7992)
  end

  it "七千九百九十三" do
    compare_kanji_and_integer("七千九百九十三", 7993)
  end

  it "七千九百九十四" do
    compare_kanji_and_integer("七千九百九十四", 7994)
  end

  it "七千九百九十五" do
    compare_kanji_and_integer("七千九百九十五", 7995)
  end

  it "七千九百九十六" do
    compare_kanji_and_integer("七千九百九十六", 7996)
  end

  it "七千九百九十七" do
    compare_kanji_and_integer("七千九百九十七", 7997)
  end

  it "七千九百九十八" do
    compare_kanji_and_integer("七千九百九十八", 7998)
  end

  it "七千九百九十九" do
    compare_kanji_and_integer("七千九百九十九", 7999)
  end

  it "八千" do
    compare_kanji_and_integer("八千", 8000)
  end

  it "八千一" do
    compare_kanji_and_integer("八千一", 8001)
  end

  it "八千二" do
    compare_kanji_and_integer("八千二", 8002)
  end

  it "八千三" do
    compare_kanji_and_integer("八千三", 8003)
  end

  it "八千四" do
    compare_kanji_and_integer("八千四", 8004)
  end

  it "八千五" do
    compare_kanji_and_integer("八千五", 8005)
  end

  it "八千六" do
    compare_kanji_and_integer("八千六", 8006)
  end

  it "八千七" do
    compare_kanji_and_integer("八千七", 8007)
  end

  it "八千八" do
    compare_kanji_and_integer("八千八", 8008)
  end

  it "八千九" do
    compare_kanji_and_integer("八千九", 8009)
  end

  it "八千十" do
    compare_kanji_and_integer("八千十", 8010)
  end

  it "八千十一" do
    compare_kanji_and_integer("八千十一", 8011)
  end

  it "八千十二" do
    compare_kanji_and_integer("八千十二", 8012)
  end

  it "八千十三" do
    compare_kanji_and_integer("八千十三", 8013)
  end

  it "八千十四" do
    compare_kanji_and_integer("八千十四", 8014)
  end

  it "八千十五" do
    compare_kanji_and_integer("八千十五", 8015)
  end

  it "八千十六" do
    compare_kanji_and_integer("八千十六", 8016)
  end

  it "八千十七" do
    compare_kanji_and_integer("八千十七", 8017)
  end

  it "八千十八" do
    compare_kanji_and_integer("八千十八", 8018)
  end

  it "八千十九" do
    compare_kanji_and_integer("八千十九", 8019)
  end

  it "八千二十" do
    compare_kanji_and_integer("八千二十", 8020)
  end

  it "八千二十一" do
    compare_kanji_and_integer("八千二十一", 8021)
  end

  it "八千二十二" do
    compare_kanji_and_integer("八千二十二", 8022)
  end

  it "八千二十三" do
    compare_kanji_and_integer("八千二十三", 8023)
  end

  it "八千二十四" do
    compare_kanji_and_integer("八千二十四", 8024)
  end

  it "八千二十五" do
    compare_kanji_and_integer("八千二十五", 8025)
  end

  it "八千二十六" do
    compare_kanji_and_integer("八千二十六", 8026)
  end

  it "八千二十七" do
    compare_kanji_and_integer("八千二十七", 8027)
  end

  it "八千二十八" do
    compare_kanji_and_integer("八千二十八", 8028)
  end

  it "八千二十九" do
    compare_kanji_and_integer("八千二十九", 8029)
  end

  it "八千三十" do
    compare_kanji_and_integer("八千三十", 8030)
  end

  it "八千三十一" do
    compare_kanji_and_integer("八千三十一", 8031)
  end

  it "八千三十二" do
    compare_kanji_and_integer("八千三十二", 8032)
  end

  it "八千三十三" do
    compare_kanji_and_integer("八千三十三", 8033)
  end

  it "八千三十四" do
    compare_kanji_and_integer("八千三十四", 8034)
  end

  it "八千三十五" do
    compare_kanji_and_integer("八千三十五", 8035)
  end

  it "八千三十六" do
    compare_kanji_and_integer("八千三十六", 8036)
  end

  it "八千三十七" do
    compare_kanji_and_integer("八千三十七", 8037)
  end

  it "八千三十八" do
    compare_kanji_and_integer("八千三十八", 8038)
  end

  it "八千三十九" do
    compare_kanji_and_integer("八千三十九", 8039)
  end

  it "八千四十" do
    compare_kanji_and_integer("八千四十", 8040)
  end

  it "八千四十一" do
    compare_kanji_and_integer("八千四十一", 8041)
  end

  it "八千四十二" do
    compare_kanji_and_integer("八千四十二", 8042)
  end

  it "八千四十三" do
    compare_kanji_and_integer("八千四十三", 8043)
  end

  it "八千四十四" do
    compare_kanji_and_integer("八千四十四", 8044)
  end

  it "八千四十五" do
    compare_kanji_and_integer("八千四十五", 8045)
  end

  it "八千四十六" do
    compare_kanji_and_integer("八千四十六", 8046)
  end

  it "八千四十七" do
    compare_kanji_and_integer("八千四十七", 8047)
  end

  it "八千四十八" do
    compare_kanji_and_integer("八千四十八", 8048)
  end

  it "八千四十九" do
    compare_kanji_and_integer("八千四十九", 8049)
  end

  it "八千五十" do
    compare_kanji_and_integer("八千五十", 8050)
  end

  it "八千五十一" do
    compare_kanji_and_integer("八千五十一", 8051)
  end

  it "八千五十二" do
    compare_kanji_and_integer("八千五十二", 8052)
  end

  it "八千五十三" do
    compare_kanji_and_integer("八千五十三", 8053)
  end

  it "八千五十四" do
    compare_kanji_and_integer("八千五十四", 8054)
  end

  it "八千五十五" do
    compare_kanji_and_integer("八千五十五", 8055)
  end

  it "八千五十六" do
    compare_kanji_and_integer("八千五十六", 8056)
  end

  it "八千五十七" do
    compare_kanji_and_integer("八千五十七", 8057)
  end

  it "八千五十八" do
    compare_kanji_and_integer("八千五十八", 8058)
  end

  it "八千五十九" do
    compare_kanji_and_integer("八千五十九", 8059)
  end

  it "八千六十" do
    compare_kanji_and_integer("八千六十", 8060)
  end

  it "八千六十一" do
    compare_kanji_and_integer("八千六十一", 8061)
  end

  it "八千六十二" do
    compare_kanji_and_integer("八千六十二", 8062)
  end

  it "八千六十三" do
    compare_kanji_and_integer("八千六十三", 8063)
  end

  it "八千六十四" do
    compare_kanji_and_integer("八千六十四", 8064)
  end

  it "八千六十五" do
    compare_kanji_and_integer("八千六十五", 8065)
  end

  it "八千六十六" do
    compare_kanji_and_integer("八千六十六", 8066)
  end

  it "八千六十七" do
    compare_kanji_and_integer("八千六十七", 8067)
  end

  it "八千六十八" do
    compare_kanji_and_integer("八千六十八", 8068)
  end

  it "八千六十九" do
    compare_kanji_and_integer("八千六十九", 8069)
  end

  it "八千七十" do
    compare_kanji_and_integer("八千七十", 8070)
  end

  it "八千七十一" do
    compare_kanji_and_integer("八千七十一", 8071)
  end

  it "八千七十二" do
    compare_kanji_and_integer("八千七十二", 8072)
  end

  it "八千七十三" do
    compare_kanji_and_integer("八千七十三", 8073)
  end

  it "八千七十四" do
    compare_kanji_and_integer("八千七十四", 8074)
  end

  it "八千七十五" do
    compare_kanji_and_integer("八千七十五", 8075)
  end

  it "八千七十六" do
    compare_kanji_and_integer("八千七十六", 8076)
  end

  it "八千七十七" do
    compare_kanji_and_integer("八千七十七", 8077)
  end

  it "八千七十八" do
    compare_kanji_and_integer("八千七十八", 8078)
  end

  it "八千七十九" do
    compare_kanji_and_integer("八千七十九", 8079)
  end

  it "八千八十" do
    compare_kanji_and_integer("八千八十", 8080)
  end

  it "八千八十一" do
    compare_kanji_and_integer("八千八十一", 8081)
  end

  it "八千八十二" do
    compare_kanji_and_integer("八千八十二", 8082)
  end

  it "八千八十三" do
    compare_kanji_and_integer("八千八十三", 8083)
  end

  it "八千八十四" do
    compare_kanji_and_integer("八千八十四", 8084)
  end

  it "八千八十五" do
    compare_kanji_and_integer("八千八十五", 8085)
  end

  it "八千八十六" do
    compare_kanji_and_integer("八千八十六", 8086)
  end

  it "八千八十七" do
    compare_kanji_and_integer("八千八十七", 8087)
  end

  it "八千八十八" do
    compare_kanji_and_integer("八千八十八", 8088)
  end

  it "八千八十九" do
    compare_kanji_and_integer("八千八十九", 8089)
  end

  it "八千九十" do
    compare_kanji_and_integer("八千九十", 8090)
  end

  it "八千九十一" do
    compare_kanji_and_integer("八千九十一", 8091)
  end

  it "八千九十二" do
    compare_kanji_and_integer("八千九十二", 8092)
  end

  it "八千九十三" do
    compare_kanji_and_integer("八千九十三", 8093)
  end

  it "八千九十四" do
    compare_kanji_and_integer("八千九十四", 8094)
  end

  it "八千九十五" do
    compare_kanji_and_integer("八千九十五", 8095)
  end

  it "八千九十六" do
    compare_kanji_and_integer("八千九十六", 8096)
  end

  it "八千九十七" do
    compare_kanji_and_integer("八千九十七", 8097)
  end

  it "八千九十八" do
    compare_kanji_and_integer("八千九十八", 8098)
  end

  it "八千九十九" do
    compare_kanji_and_integer("八千九十九", 8099)
  end

  it "八千百" do
    compare_kanji_and_integer("八千百", 8100)
  end

  it "八千百一" do
    compare_kanji_and_integer("八千百一", 8101)
  end

  it "八千百二" do
    compare_kanji_and_integer("八千百二", 8102)
  end

  it "八千百三" do
    compare_kanji_and_integer("八千百三", 8103)
  end

  it "八千百四" do
    compare_kanji_and_integer("八千百四", 8104)
  end

  it "八千百五" do
    compare_kanji_and_integer("八千百五", 8105)
  end

  it "八千百六" do
    compare_kanji_and_integer("八千百六", 8106)
  end

  it "八千百七" do
    compare_kanji_and_integer("八千百七", 8107)
  end

  it "八千百八" do
    compare_kanji_and_integer("八千百八", 8108)
  end

  it "八千百九" do
    compare_kanji_and_integer("八千百九", 8109)
  end

  it "八千百十" do
    compare_kanji_and_integer("八千百十", 8110)
  end

  it "八千百十一" do
    compare_kanji_and_integer("八千百十一", 8111)
  end

  it "八千百十二" do
    compare_kanji_and_integer("八千百十二", 8112)
  end

  it "八千百十三" do
    compare_kanji_and_integer("八千百十三", 8113)
  end

  it "八千百十四" do
    compare_kanji_and_integer("八千百十四", 8114)
  end

  it "八千百十五" do
    compare_kanji_and_integer("八千百十五", 8115)
  end

  it "八千百十六" do
    compare_kanji_and_integer("八千百十六", 8116)
  end

  it "八千百十七" do
    compare_kanji_and_integer("八千百十七", 8117)
  end

  it "八千百十八" do
    compare_kanji_and_integer("八千百十八", 8118)
  end

  it "八千百十九" do
    compare_kanji_and_integer("八千百十九", 8119)
  end

  it "八千百二十" do
    compare_kanji_and_integer("八千百二十", 8120)
  end

  it "八千百二十一" do
    compare_kanji_and_integer("八千百二十一", 8121)
  end

  it "八千百二十二" do
    compare_kanji_and_integer("八千百二十二", 8122)
  end

  it "八千百二十三" do
    compare_kanji_and_integer("八千百二十三", 8123)
  end

  it "八千百二十四" do
    compare_kanji_and_integer("八千百二十四", 8124)
  end

  it "八千百二十五" do
    compare_kanji_and_integer("八千百二十五", 8125)
  end

  it "八千百二十六" do
    compare_kanji_and_integer("八千百二十六", 8126)
  end

  it "八千百二十七" do
    compare_kanji_and_integer("八千百二十七", 8127)
  end

  it "八千百二十八" do
    compare_kanji_and_integer("八千百二十八", 8128)
  end

  it "八千百二十九" do
    compare_kanji_and_integer("八千百二十九", 8129)
  end

  it "八千百三十" do
    compare_kanji_and_integer("八千百三十", 8130)
  end

  it "八千百三十一" do
    compare_kanji_and_integer("八千百三十一", 8131)
  end

  it "八千百三十二" do
    compare_kanji_and_integer("八千百三十二", 8132)
  end

  it "八千百三十三" do
    compare_kanji_and_integer("八千百三十三", 8133)
  end

  it "八千百三十四" do
    compare_kanji_and_integer("八千百三十四", 8134)
  end

  it "八千百三十五" do
    compare_kanji_and_integer("八千百三十五", 8135)
  end

  it "八千百三十六" do
    compare_kanji_and_integer("八千百三十六", 8136)
  end

  it "八千百三十七" do
    compare_kanji_and_integer("八千百三十七", 8137)
  end

  it "八千百三十八" do
    compare_kanji_and_integer("八千百三十八", 8138)
  end

  it "八千百三十九" do
    compare_kanji_and_integer("八千百三十九", 8139)
  end

  it "八千百四十" do
    compare_kanji_and_integer("八千百四十", 8140)
  end

  it "八千百四十一" do
    compare_kanji_and_integer("八千百四十一", 8141)
  end

  it "八千百四十二" do
    compare_kanji_and_integer("八千百四十二", 8142)
  end

  it "八千百四十三" do
    compare_kanji_and_integer("八千百四十三", 8143)
  end

  it "八千百四十四" do
    compare_kanji_and_integer("八千百四十四", 8144)
  end

  it "八千百四十五" do
    compare_kanji_and_integer("八千百四十五", 8145)
  end

  it "八千百四十六" do
    compare_kanji_and_integer("八千百四十六", 8146)
  end

  it "八千百四十七" do
    compare_kanji_and_integer("八千百四十七", 8147)
  end

  it "八千百四十八" do
    compare_kanji_and_integer("八千百四十八", 8148)
  end

  it "八千百四十九" do
    compare_kanji_and_integer("八千百四十九", 8149)
  end

  it "八千百五十" do
    compare_kanji_and_integer("八千百五十", 8150)
  end

  it "八千百五十一" do
    compare_kanji_and_integer("八千百五十一", 8151)
  end

  it "八千百五十二" do
    compare_kanji_and_integer("八千百五十二", 8152)
  end

  it "八千百五十三" do
    compare_kanji_and_integer("八千百五十三", 8153)
  end

  it "八千百五十四" do
    compare_kanji_and_integer("八千百五十四", 8154)
  end

  it "八千百五十五" do
    compare_kanji_and_integer("八千百五十五", 8155)
  end

  it "八千百五十六" do
    compare_kanji_and_integer("八千百五十六", 8156)
  end

  it "八千百五十七" do
    compare_kanji_and_integer("八千百五十七", 8157)
  end

  it "八千百五十八" do
    compare_kanji_and_integer("八千百五十八", 8158)
  end

  it "八千百五十九" do
    compare_kanji_and_integer("八千百五十九", 8159)
  end

  it "八千百六十" do
    compare_kanji_and_integer("八千百六十", 8160)
  end

  it "八千百六十一" do
    compare_kanji_and_integer("八千百六十一", 8161)
  end

  it "八千百六十二" do
    compare_kanji_and_integer("八千百六十二", 8162)
  end

  it "八千百六十三" do
    compare_kanji_and_integer("八千百六十三", 8163)
  end

  it "八千百六十四" do
    compare_kanji_and_integer("八千百六十四", 8164)
  end

  it "八千百六十五" do
    compare_kanji_and_integer("八千百六十五", 8165)
  end

  it "八千百六十六" do
    compare_kanji_and_integer("八千百六十六", 8166)
  end

  it "八千百六十七" do
    compare_kanji_and_integer("八千百六十七", 8167)
  end

  it "八千百六十八" do
    compare_kanji_and_integer("八千百六十八", 8168)
  end

  it "八千百六十九" do
    compare_kanji_and_integer("八千百六十九", 8169)
  end

  it "八千百七十" do
    compare_kanji_and_integer("八千百七十", 8170)
  end

  it "八千百七十一" do
    compare_kanji_and_integer("八千百七十一", 8171)
  end

  it "八千百七十二" do
    compare_kanji_and_integer("八千百七十二", 8172)
  end

  it "八千百七十三" do
    compare_kanji_and_integer("八千百七十三", 8173)
  end

  it "八千百七十四" do
    compare_kanji_and_integer("八千百七十四", 8174)
  end

  it "八千百七十五" do
    compare_kanji_and_integer("八千百七十五", 8175)
  end

  it "八千百七十六" do
    compare_kanji_and_integer("八千百七十六", 8176)
  end

  it "八千百七十七" do
    compare_kanji_and_integer("八千百七十七", 8177)
  end

  it "八千百七十八" do
    compare_kanji_and_integer("八千百七十八", 8178)
  end

  it "八千百七十九" do
    compare_kanji_and_integer("八千百七十九", 8179)
  end

  it "八千百八十" do
    compare_kanji_and_integer("八千百八十", 8180)
  end

  it "八千百八十一" do
    compare_kanji_and_integer("八千百八十一", 8181)
  end

  it "八千百八十二" do
    compare_kanji_and_integer("八千百八十二", 8182)
  end

  it "八千百八十三" do
    compare_kanji_and_integer("八千百八十三", 8183)
  end

  it "八千百八十四" do
    compare_kanji_and_integer("八千百八十四", 8184)
  end

  it "八千百八十五" do
    compare_kanji_and_integer("八千百八十五", 8185)
  end

  it "八千百八十六" do
    compare_kanji_and_integer("八千百八十六", 8186)
  end

  it "八千百八十七" do
    compare_kanji_and_integer("八千百八十七", 8187)
  end

  it "八千百八十八" do
    compare_kanji_and_integer("八千百八十八", 8188)
  end

  it "八千百八十九" do
    compare_kanji_and_integer("八千百八十九", 8189)
  end

  it "八千百九十" do
    compare_kanji_and_integer("八千百九十", 8190)
  end

  it "八千百九十一" do
    compare_kanji_and_integer("八千百九十一", 8191)
  end

  it "八千百九十二" do
    compare_kanji_and_integer("八千百九十二", 8192)
  end

  it "八千百九十三" do
    compare_kanji_and_integer("八千百九十三", 8193)
  end

  it "八千百九十四" do
    compare_kanji_and_integer("八千百九十四", 8194)
  end

  it "八千百九十五" do
    compare_kanji_and_integer("八千百九十五", 8195)
  end

  it "八千百九十六" do
    compare_kanji_and_integer("八千百九十六", 8196)
  end

  it "八千百九十七" do
    compare_kanji_and_integer("八千百九十七", 8197)
  end

  it "八千百九十八" do
    compare_kanji_and_integer("八千百九十八", 8198)
  end

  it "八千百九十九" do
    compare_kanji_and_integer("八千百九十九", 8199)
  end

  it "八千二百" do
    compare_kanji_and_integer("八千二百", 8200)
  end

  it "八千二百一" do
    compare_kanji_and_integer("八千二百一", 8201)
  end

  it "八千二百二" do
    compare_kanji_and_integer("八千二百二", 8202)
  end

  it "八千二百三" do
    compare_kanji_and_integer("八千二百三", 8203)
  end

  it "八千二百四" do
    compare_kanji_and_integer("八千二百四", 8204)
  end

  it "八千二百五" do
    compare_kanji_and_integer("八千二百五", 8205)
  end

  it "八千二百六" do
    compare_kanji_and_integer("八千二百六", 8206)
  end

  it "八千二百七" do
    compare_kanji_and_integer("八千二百七", 8207)
  end

  it "八千二百八" do
    compare_kanji_and_integer("八千二百八", 8208)
  end

  it "八千二百九" do
    compare_kanji_and_integer("八千二百九", 8209)
  end

  it "八千二百十" do
    compare_kanji_and_integer("八千二百十", 8210)
  end

  it "八千二百十一" do
    compare_kanji_and_integer("八千二百十一", 8211)
  end

  it "八千二百十二" do
    compare_kanji_and_integer("八千二百十二", 8212)
  end

  it "八千二百十三" do
    compare_kanji_and_integer("八千二百十三", 8213)
  end

  it "八千二百十四" do
    compare_kanji_and_integer("八千二百十四", 8214)
  end

  it "八千二百十五" do
    compare_kanji_and_integer("八千二百十五", 8215)
  end

  it "八千二百十六" do
    compare_kanji_and_integer("八千二百十六", 8216)
  end

  it "八千二百十七" do
    compare_kanji_and_integer("八千二百十七", 8217)
  end

  it "八千二百十八" do
    compare_kanji_and_integer("八千二百十八", 8218)
  end

  it "八千二百十九" do
    compare_kanji_and_integer("八千二百十九", 8219)
  end

  it "八千二百二十" do
    compare_kanji_and_integer("八千二百二十", 8220)
  end

  it "八千二百二十一" do
    compare_kanji_and_integer("八千二百二十一", 8221)
  end

  it "八千二百二十二" do
    compare_kanji_and_integer("八千二百二十二", 8222)
  end

  it "八千二百二十三" do
    compare_kanji_and_integer("八千二百二十三", 8223)
  end

  it "八千二百二十四" do
    compare_kanji_and_integer("八千二百二十四", 8224)
  end

  it "八千二百二十五" do
    compare_kanji_and_integer("八千二百二十五", 8225)
  end

  it "八千二百二十六" do
    compare_kanji_and_integer("八千二百二十六", 8226)
  end

  it "八千二百二十七" do
    compare_kanji_and_integer("八千二百二十七", 8227)
  end

  it "八千二百二十八" do
    compare_kanji_and_integer("八千二百二十八", 8228)
  end

  it "八千二百二十九" do
    compare_kanji_and_integer("八千二百二十九", 8229)
  end

  it "八千二百三十" do
    compare_kanji_and_integer("八千二百三十", 8230)
  end

  it "八千二百三十一" do
    compare_kanji_and_integer("八千二百三十一", 8231)
  end

  it "八千二百三十二" do
    compare_kanji_and_integer("八千二百三十二", 8232)
  end

  it "八千二百三十三" do
    compare_kanji_and_integer("八千二百三十三", 8233)
  end

  it "八千二百三十四" do
    compare_kanji_and_integer("八千二百三十四", 8234)
  end

  it "八千二百三十五" do
    compare_kanji_and_integer("八千二百三十五", 8235)
  end

  it "八千二百三十六" do
    compare_kanji_and_integer("八千二百三十六", 8236)
  end

  it "八千二百三十七" do
    compare_kanji_and_integer("八千二百三十七", 8237)
  end

  it "八千二百三十八" do
    compare_kanji_and_integer("八千二百三十八", 8238)
  end

  it "八千二百三十九" do
    compare_kanji_and_integer("八千二百三十九", 8239)
  end

  it "八千二百四十" do
    compare_kanji_and_integer("八千二百四十", 8240)
  end

  it "八千二百四十一" do
    compare_kanji_and_integer("八千二百四十一", 8241)
  end

  it "八千二百四十二" do
    compare_kanji_and_integer("八千二百四十二", 8242)
  end

  it "八千二百四十三" do
    compare_kanji_and_integer("八千二百四十三", 8243)
  end

  it "八千二百四十四" do
    compare_kanji_and_integer("八千二百四十四", 8244)
  end

  it "八千二百四十五" do
    compare_kanji_and_integer("八千二百四十五", 8245)
  end

  it "八千二百四十六" do
    compare_kanji_and_integer("八千二百四十六", 8246)
  end

  it "八千二百四十七" do
    compare_kanji_and_integer("八千二百四十七", 8247)
  end

  it "八千二百四十八" do
    compare_kanji_and_integer("八千二百四十八", 8248)
  end

  it "八千二百四十九" do
    compare_kanji_and_integer("八千二百四十九", 8249)
  end

  it "八千二百五十" do
    compare_kanji_and_integer("八千二百五十", 8250)
  end

  it "八千二百五十一" do
    compare_kanji_and_integer("八千二百五十一", 8251)
  end

  it "八千二百五十二" do
    compare_kanji_and_integer("八千二百五十二", 8252)
  end

  it "八千二百五十三" do
    compare_kanji_and_integer("八千二百五十三", 8253)
  end

  it "八千二百五十四" do
    compare_kanji_and_integer("八千二百五十四", 8254)
  end

  it "八千二百五十五" do
    compare_kanji_and_integer("八千二百五十五", 8255)
  end

  it "八千二百五十六" do
    compare_kanji_and_integer("八千二百五十六", 8256)
  end

  it "八千二百五十七" do
    compare_kanji_and_integer("八千二百五十七", 8257)
  end

  it "八千二百五十八" do
    compare_kanji_and_integer("八千二百五十八", 8258)
  end

  it "八千二百五十九" do
    compare_kanji_and_integer("八千二百五十九", 8259)
  end

  it "八千二百六十" do
    compare_kanji_and_integer("八千二百六十", 8260)
  end

  it "八千二百六十一" do
    compare_kanji_and_integer("八千二百六十一", 8261)
  end

  it "八千二百六十二" do
    compare_kanji_and_integer("八千二百六十二", 8262)
  end

  it "八千二百六十三" do
    compare_kanji_and_integer("八千二百六十三", 8263)
  end

  it "八千二百六十四" do
    compare_kanji_and_integer("八千二百六十四", 8264)
  end

  it "八千二百六十五" do
    compare_kanji_and_integer("八千二百六十五", 8265)
  end

  it "八千二百六十六" do
    compare_kanji_and_integer("八千二百六十六", 8266)
  end

  it "八千二百六十七" do
    compare_kanji_and_integer("八千二百六十七", 8267)
  end

  it "八千二百六十八" do
    compare_kanji_and_integer("八千二百六十八", 8268)
  end

  it "八千二百六十九" do
    compare_kanji_and_integer("八千二百六十九", 8269)
  end

  it "八千二百七十" do
    compare_kanji_and_integer("八千二百七十", 8270)
  end

  it "八千二百七十一" do
    compare_kanji_and_integer("八千二百七十一", 8271)
  end

  it "八千二百七十二" do
    compare_kanji_and_integer("八千二百七十二", 8272)
  end

  it "八千二百七十三" do
    compare_kanji_and_integer("八千二百七十三", 8273)
  end

  it "八千二百七十四" do
    compare_kanji_and_integer("八千二百七十四", 8274)
  end

  it "八千二百七十五" do
    compare_kanji_and_integer("八千二百七十五", 8275)
  end

  it "八千二百七十六" do
    compare_kanji_and_integer("八千二百七十六", 8276)
  end

  it "八千二百七十七" do
    compare_kanji_and_integer("八千二百七十七", 8277)
  end

  it "八千二百七十八" do
    compare_kanji_and_integer("八千二百七十八", 8278)
  end

  it "八千二百七十九" do
    compare_kanji_and_integer("八千二百七十九", 8279)
  end

  it "八千二百八十" do
    compare_kanji_and_integer("八千二百八十", 8280)
  end

  it "八千二百八十一" do
    compare_kanji_and_integer("八千二百八十一", 8281)
  end

  it "八千二百八十二" do
    compare_kanji_and_integer("八千二百八十二", 8282)
  end

  it "八千二百八十三" do
    compare_kanji_and_integer("八千二百八十三", 8283)
  end

  it "八千二百八十四" do
    compare_kanji_and_integer("八千二百八十四", 8284)
  end

  it "八千二百八十五" do
    compare_kanji_and_integer("八千二百八十五", 8285)
  end

  it "八千二百八十六" do
    compare_kanji_and_integer("八千二百八十六", 8286)
  end

  it "八千二百八十七" do
    compare_kanji_and_integer("八千二百八十七", 8287)
  end

  it "八千二百八十八" do
    compare_kanji_and_integer("八千二百八十八", 8288)
  end

  it "八千二百八十九" do
    compare_kanji_and_integer("八千二百八十九", 8289)
  end

  it "八千二百九十" do
    compare_kanji_and_integer("八千二百九十", 8290)
  end

  it "八千二百九十一" do
    compare_kanji_and_integer("八千二百九十一", 8291)
  end

  it "八千二百九十二" do
    compare_kanji_and_integer("八千二百九十二", 8292)
  end

  it "八千二百九十三" do
    compare_kanji_and_integer("八千二百九十三", 8293)
  end

  it "八千二百九十四" do
    compare_kanji_and_integer("八千二百九十四", 8294)
  end

  it "八千二百九十五" do
    compare_kanji_and_integer("八千二百九十五", 8295)
  end

  it "八千二百九十六" do
    compare_kanji_and_integer("八千二百九十六", 8296)
  end

  it "八千二百九十七" do
    compare_kanji_and_integer("八千二百九十七", 8297)
  end

  it "八千二百九十八" do
    compare_kanji_and_integer("八千二百九十八", 8298)
  end

  it "八千二百九十九" do
    compare_kanji_and_integer("八千二百九十九", 8299)
  end

  it "八千三百" do
    compare_kanji_and_integer("八千三百", 8300)
  end

  it "八千三百一" do
    compare_kanji_and_integer("八千三百一", 8301)
  end

  it "八千三百二" do
    compare_kanji_and_integer("八千三百二", 8302)
  end

  it "八千三百三" do
    compare_kanji_and_integer("八千三百三", 8303)
  end

  it "八千三百四" do
    compare_kanji_and_integer("八千三百四", 8304)
  end

  it "八千三百五" do
    compare_kanji_and_integer("八千三百五", 8305)
  end

  it "八千三百六" do
    compare_kanji_and_integer("八千三百六", 8306)
  end

  it "八千三百七" do
    compare_kanji_and_integer("八千三百七", 8307)
  end

  it "八千三百八" do
    compare_kanji_and_integer("八千三百八", 8308)
  end

  it "八千三百九" do
    compare_kanji_and_integer("八千三百九", 8309)
  end

  it "八千三百十" do
    compare_kanji_and_integer("八千三百十", 8310)
  end

  it "八千三百十一" do
    compare_kanji_and_integer("八千三百十一", 8311)
  end

  it "八千三百十二" do
    compare_kanji_and_integer("八千三百十二", 8312)
  end

  it "八千三百十三" do
    compare_kanji_and_integer("八千三百十三", 8313)
  end

  it "八千三百十四" do
    compare_kanji_and_integer("八千三百十四", 8314)
  end

  it "八千三百十五" do
    compare_kanji_and_integer("八千三百十五", 8315)
  end

  it "八千三百十六" do
    compare_kanji_and_integer("八千三百十六", 8316)
  end

  it "八千三百十七" do
    compare_kanji_and_integer("八千三百十七", 8317)
  end

  it "八千三百十八" do
    compare_kanji_and_integer("八千三百十八", 8318)
  end

  it "八千三百十九" do
    compare_kanji_and_integer("八千三百十九", 8319)
  end

  it "八千三百二十" do
    compare_kanji_and_integer("八千三百二十", 8320)
  end

  it "八千三百二十一" do
    compare_kanji_and_integer("八千三百二十一", 8321)
  end

  it "八千三百二十二" do
    compare_kanji_and_integer("八千三百二十二", 8322)
  end

  it "八千三百二十三" do
    compare_kanji_and_integer("八千三百二十三", 8323)
  end

  it "八千三百二十四" do
    compare_kanji_and_integer("八千三百二十四", 8324)
  end

  it "八千三百二十五" do
    compare_kanji_and_integer("八千三百二十五", 8325)
  end

  it "八千三百二十六" do
    compare_kanji_and_integer("八千三百二十六", 8326)
  end

  it "八千三百二十七" do
    compare_kanji_and_integer("八千三百二十七", 8327)
  end

  it "八千三百二十八" do
    compare_kanji_and_integer("八千三百二十八", 8328)
  end

  it "八千三百二十九" do
    compare_kanji_and_integer("八千三百二十九", 8329)
  end

  it "八千三百三十" do
    compare_kanji_and_integer("八千三百三十", 8330)
  end

  it "八千三百三十一" do
    compare_kanji_and_integer("八千三百三十一", 8331)
  end

  it "八千三百三十二" do
    compare_kanji_and_integer("八千三百三十二", 8332)
  end

  it "八千三百三十三" do
    compare_kanji_and_integer("八千三百三十三", 8333)
  end

  it "八千三百三十四" do
    compare_kanji_and_integer("八千三百三十四", 8334)
  end

  it "八千三百三十五" do
    compare_kanji_and_integer("八千三百三十五", 8335)
  end

  it "八千三百三十六" do
    compare_kanji_and_integer("八千三百三十六", 8336)
  end

  it "八千三百三十七" do
    compare_kanji_and_integer("八千三百三十七", 8337)
  end

  it "八千三百三十八" do
    compare_kanji_and_integer("八千三百三十八", 8338)
  end

  it "八千三百三十九" do
    compare_kanji_and_integer("八千三百三十九", 8339)
  end

  it "八千三百四十" do
    compare_kanji_and_integer("八千三百四十", 8340)
  end

  it "八千三百四十一" do
    compare_kanji_and_integer("八千三百四十一", 8341)
  end

  it "八千三百四十二" do
    compare_kanji_and_integer("八千三百四十二", 8342)
  end

  it "八千三百四十三" do
    compare_kanji_and_integer("八千三百四十三", 8343)
  end

  it "八千三百四十四" do
    compare_kanji_and_integer("八千三百四十四", 8344)
  end

  it "八千三百四十五" do
    compare_kanji_and_integer("八千三百四十五", 8345)
  end

  it "八千三百四十六" do
    compare_kanji_and_integer("八千三百四十六", 8346)
  end

  it "八千三百四十七" do
    compare_kanji_and_integer("八千三百四十七", 8347)
  end

  it "八千三百四十八" do
    compare_kanji_and_integer("八千三百四十八", 8348)
  end

  it "八千三百四十九" do
    compare_kanji_and_integer("八千三百四十九", 8349)
  end

  it "八千三百五十" do
    compare_kanji_and_integer("八千三百五十", 8350)
  end

  it "八千三百五十一" do
    compare_kanji_and_integer("八千三百五十一", 8351)
  end

  it "八千三百五十二" do
    compare_kanji_and_integer("八千三百五十二", 8352)
  end

  it "八千三百五十三" do
    compare_kanji_and_integer("八千三百五十三", 8353)
  end

  it "八千三百五十四" do
    compare_kanji_and_integer("八千三百五十四", 8354)
  end

  it "八千三百五十五" do
    compare_kanji_and_integer("八千三百五十五", 8355)
  end

  it "八千三百五十六" do
    compare_kanji_and_integer("八千三百五十六", 8356)
  end

  it "八千三百五十七" do
    compare_kanji_and_integer("八千三百五十七", 8357)
  end

  it "八千三百五十八" do
    compare_kanji_and_integer("八千三百五十八", 8358)
  end

  it "八千三百五十九" do
    compare_kanji_and_integer("八千三百五十九", 8359)
  end

  it "八千三百六十" do
    compare_kanji_and_integer("八千三百六十", 8360)
  end

  it "八千三百六十一" do
    compare_kanji_and_integer("八千三百六十一", 8361)
  end

  it "八千三百六十二" do
    compare_kanji_and_integer("八千三百六十二", 8362)
  end

  it "八千三百六十三" do
    compare_kanji_and_integer("八千三百六十三", 8363)
  end

  it "八千三百六十四" do
    compare_kanji_and_integer("八千三百六十四", 8364)
  end

  it "八千三百六十五" do
    compare_kanji_and_integer("八千三百六十五", 8365)
  end

  it "八千三百六十六" do
    compare_kanji_and_integer("八千三百六十六", 8366)
  end

  it "八千三百六十七" do
    compare_kanji_and_integer("八千三百六十七", 8367)
  end

  it "八千三百六十八" do
    compare_kanji_and_integer("八千三百六十八", 8368)
  end

  it "八千三百六十九" do
    compare_kanji_and_integer("八千三百六十九", 8369)
  end

  it "八千三百七十" do
    compare_kanji_and_integer("八千三百七十", 8370)
  end

  it "八千三百七十一" do
    compare_kanji_and_integer("八千三百七十一", 8371)
  end

  it "八千三百七十二" do
    compare_kanji_and_integer("八千三百七十二", 8372)
  end

  it "八千三百七十三" do
    compare_kanji_and_integer("八千三百七十三", 8373)
  end

  it "八千三百七十四" do
    compare_kanji_and_integer("八千三百七十四", 8374)
  end

  it "八千三百七十五" do
    compare_kanji_and_integer("八千三百七十五", 8375)
  end

  it "八千三百七十六" do
    compare_kanji_and_integer("八千三百七十六", 8376)
  end

  it "八千三百七十七" do
    compare_kanji_and_integer("八千三百七十七", 8377)
  end

  it "八千三百七十八" do
    compare_kanji_and_integer("八千三百七十八", 8378)
  end

  it "八千三百七十九" do
    compare_kanji_and_integer("八千三百七十九", 8379)
  end

  it "八千三百八十" do
    compare_kanji_and_integer("八千三百八十", 8380)
  end

  it "八千三百八十一" do
    compare_kanji_and_integer("八千三百八十一", 8381)
  end

  it "八千三百八十二" do
    compare_kanji_and_integer("八千三百八十二", 8382)
  end

  it "八千三百八十三" do
    compare_kanji_and_integer("八千三百八十三", 8383)
  end

  it "八千三百八十四" do
    compare_kanji_and_integer("八千三百八十四", 8384)
  end

  it "八千三百八十五" do
    compare_kanji_and_integer("八千三百八十五", 8385)
  end

  it "八千三百八十六" do
    compare_kanji_and_integer("八千三百八十六", 8386)
  end

  it "八千三百八十七" do
    compare_kanji_and_integer("八千三百八十七", 8387)
  end

  it "八千三百八十八" do
    compare_kanji_and_integer("八千三百八十八", 8388)
  end

  it "八千三百八十九" do
    compare_kanji_and_integer("八千三百八十九", 8389)
  end

  it "八千三百九十" do
    compare_kanji_and_integer("八千三百九十", 8390)
  end

  it "八千三百九十一" do
    compare_kanji_and_integer("八千三百九十一", 8391)
  end

  it "八千三百九十二" do
    compare_kanji_and_integer("八千三百九十二", 8392)
  end

  it "八千三百九十三" do
    compare_kanji_and_integer("八千三百九十三", 8393)
  end

  it "八千三百九十四" do
    compare_kanji_and_integer("八千三百九十四", 8394)
  end

  it "八千三百九十五" do
    compare_kanji_and_integer("八千三百九十五", 8395)
  end

  it "八千三百九十六" do
    compare_kanji_and_integer("八千三百九十六", 8396)
  end

  it "八千三百九十七" do
    compare_kanji_and_integer("八千三百九十七", 8397)
  end

  it "八千三百九十八" do
    compare_kanji_and_integer("八千三百九十八", 8398)
  end

  it "八千三百九十九" do
    compare_kanji_and_integer("八千三百九十九", 8399)
  end

  it "八千四百" do
    compare_kanji_and_integer("八千四百", 8400)
  end

  it "八千四百一" do
    compare_kanji_and_integer("八千四百一", 8401)
  end

  it "八千四百二" do
    compare_kanji_and_integer("八千四百二", 8402)
  end

  it "八千四百三" do
    compare_kanji_and_integer("八千四百三", 8403)
  end

  it "八千四百四" do
    compare_kanji_and_integer("八千四百四", 8404)
  end

  it "八千四百五" do
    compare_kanji_and_integer("八千四百五", 8405)
  end

  it "八千四百六" do
    compare_kanji_and_integer("八千四百六", 8406)
  end

  it "八千四百七" do
    compare_kanji_and_integer("八千四百七", 8407)
  end

  it "八千四百八" do
    compare_kanji_and_integer("八千四百八", 8408)
  end

  it "八千四百九" do
    compare_kanji_and_integer("八千四百九", 8409)
  end

  it "八千四百十" do
    compare_kanji_and_integer("八千四百十", 8410)
  end

  it "八千四百十一" do
    compare_kanji_and_integer("八千四百十一", 8411)
  end

  it "八千四百十二" do
    compare_kanji_and_integer("八千四百十二", 8412)
  end

  it "八千四百十三" do
    compare_kanji_and_integer("八千四百十三", 8413)
  end

  it "八千四百十四" do
    compare_kanji_and_integer("八千四百十四", 8414)
  end

  it "八千四百十五" do
    compare_kanji_and_integer("八千四百十五", 8415)
  end

  it "八千四百十六" do
    compare_kanji_and_integer("八千四百十六", 8416)
  end

  it "八千四百十七" do
    compare_kanji_and_integer("八千四百十七", 8417)
  end

  it "八千四百十八" do
    compare_kanji_and_integer("八千四百十八", 8418)
  end

  it "八千四百十九" do
    compare_kanji_and_integer("八千四百十九", 8419)
  end

  it "八千四百二十" do
    compare_kanji_and_integer("八千四百二十", 8420)
  end

  it "八千四百二十一" do
    compare_kanji_and_integer("八千四百二十一", 8421)
  end

  it "八千四百二十二" do
    compare_kanji_and_integer("八千四百二十二", 8422)
  end

  it "八千四百二十三" do
    compare_kanji_and_integer("八千四百二十三", 8423)
  end

  it "八千四百二十四" do
    compare_kanji_and_integer("八千四百二十四", 8424)
  end

  it "八千四百二十五" do
    compare_kanji_and_integer("八千四百二十五", 8425)
  end

  it "八千四百二十六" do
    compare_kanji_and_integer("八千四百二十六", 8426)
  end

  it "八千四百二十七" do
    compare_kanji_and_integer("八千四百二十七", 8427)
  end

  it "八千四百二十八" do
    compare_kanji_and_integer("八千四百二十八", 8428)
  end

  it "八千四百二十九" do
    compare_kanji_and_integer("八千四百二十九", 8429)
  end

  it "八千四百三十" do
    compare_kanji_and_integer("八千四百三十", 8430)
  end

  it "八千四百三十一" do
    compare_kanji_and_integer("八千四百三十一", 8431)
  end

  it "八千四百三十二" do
    compare_kanji_and_integer("八千四百三十二", 8432)
  end

  it "八千四百三十三" do
    compare_kanji_and_integer("八千四百三十三", 8433)
  end

  it "八千四百三十四" do
    compare_kanji_and_integer("八千四百三十四", 8434)
  end

  it "八千四百三十五" do
    compare_kanji_and_integer("八千四百三十五", 8435)
  end

  it "八千四百三十六" do
    compare_kanji_and_integer("八千四百三十六", 8436)
  end

  it "八千四百三十七" do
    compare_kanji_and_integer("八千四百三十七", 8437)
  end

  it "八千四百三十八" do
    compare_kanji_and_integer("八千四百三十八", 8438)
  end

  it "八千四百三十九" do
    compare_kanji_and_integer("八千四百三十九", 8439)
  end

  it "八千四百四十" do
    compare_kanji_and_integer("八千四百四十", 8440)
  end

  it "八千四百四十一" do
    compare_kanji_and_integer("八千四百四十一", 8441)
  end

  it "八千四百四十二" do
    compare_kanji_and_integer("八千四百四十二", 8442)
  end

  it "八千四百四十三" do
    compare_kanji_and_integer("八千四百四十三", 8443)
  end

  it "八千四百四十四" do
    compare_kanji_and_integer("八千四百四十四", 8444)
  end

  it "八千四百四十五" do
    compare_kanji_and_integer("八千四百四十五", 8445)
  end

  it "八千四百四十六" do
    compare_kanji_and_integer("八千四百四十六", 8446)
  end

  it "八千四百四十七" do
    compare_kanji_and_integer("八千四百四十七", 8447)
  end

  it "八千四百四十八" do
    compare_kanji_and_integer("八千四百四十八", 8448)
  end

  it "八千四百四十九" do
    compare_kanji_and_integer("八千四百四十九", 8449)
  end

  it "八千四百五十" do
    compare_kanji_and_integer("八千四百五十", 8450)
  end

  it "八千四百五十一" do
    compare_kanji_and_integer("八千四百五十一", 8451)
  end

  it "八千四百五十二" do
    compare_kanji_and_integer("八千四百五十二", 8452)
  end

  it "八千四百五十三" do
    compare_kanji_and_integer("八千四百五十三", 8453)
  end

  it "八千四百五十四" do
    compare_kanji_and_integer("八千四百五十四", 8454)
  end

  it "八千四百五十五" do
    compare_kanji_and_integer("八千四百五十五", 8455)
  end

  it "八千四百五十六" do
    compare_kanji_and_integer("八千四百五十六", 8456)
  end

  it "八千四百五十七" do
    compare_kanji_and_integer("八千四百五十七", 8457)
  end

  it "八千四百五十八" do
    compare_kanji_and_integer("八千四百五十八", 8458)
  end

  it "八千四百五十九" do
    compare_kanji_and_integer("八千四百五十九", 8459)
  end

  it "八千四百六十" do
    compare_kanji_and_integer("八千四百六十", 8460)
  end

  it "八千四百六十一" do
    compare_kanji_and_integer("八千四百六十一", 8461)
  end

  it "八千四百六十二" do
    compare_kanji_and_integer("八千四百六十二", 8462)
  end

  it "八千四百六十三" do
    compare_kanji_and_integer("八千四百六十三", 8463)
  end

  it "八千四百六十四" do
    compare_kanji_and_integer("八千四百六十四", 8464)
  end

  it "八千四百六十五" do
    compare_kanji_and_integer("八千四百六十五", 8465)
  end

  it "八千四百六十六" do
    compare_kanji_and_integer("八千四百六十六", 8466)
  end

  it "八千四百六十七" do
    compare_kanji_and_integer("八千四百六十七", 8467)
  end

  it "八千四百六十八" do
    compare_kanji_and_integer("八千四百六十八", 8468)
  end

  it "八千四百六十九" do
    compare_kanji_and_integer("八千四百六十九", 8469)
  end

  it "八千四百七十" do
    compare_kanji_and_integer("八千四百七十", 8470)
  end

  it "八千四百七十一" do
    compare_kanji_and_integer("八千四百七十一", 8471)
  end

  it "八千四百七十二" do
    compare_kanji_and_integer("八千四百七十二", 8472)
  end

  it "八千四百七十三" do
    compare_kanji_and_integer("八千四百七十三", 8473)
  end

  it "八千四百七十四" do
    compare_kanji_and_integer("八千四百七十四", 8474)
  end

  it "八千四百七十五" do
    compare_kanji_and_integer("八千四百七十五", 8475)
  end

  it "八千四百七十六" do
    compare_kanji_and_integer("八千四百七十六", 8476)
  end

  it "八千四百七十七" do
    compare_kanji_and_integer("八千四百七十七", 8477)
  end

  it "八千四百七十八" do
    compare_kanji_and_integer("八千四百七十八", 8478)
  end

  it "八千四百七十九" do
    compare_kanji_and_integer("八千四百七十九", 8479)
  end

  it "八千四百八十" do
    compare_kanji_and_integer("八千四百八十", 8480)
  end

  it "八千四百八十一" do
    compare_kanji_and_integer("八千四百八十一", 8481)
  end

  it "八千四百八十二" do
    compare_kanji_and_integer("八千四百八十二", 8482)
  end

  it "八千四百八十三" do
    compare_kanji_and_integer("八千四百八十三", 8483)
  end

  it "八千四百八十四" do
    compare_kanji_and_integer("八千四百八十四", 8484)
  end

  it "八千四百八十五" do
    compare_kanji_and_integer("八千四百八十五", 8485)
  end

  it "八千四百八十六" do
    compare_kanji_and_integer("八千四百八十六", 8486)
  end

  it "八千四百八十七" do
    compare_kanji_and_integer("八千四百八十七", 8487)
  end

  it "八千四百八十八" do
    compare_kanji_and_integer("八千四百八十八", 8488)
  end

  it "八千四百八十九" do
    compare_kanji_and_integer("八千四百八十九", 8489)
  end

  it "八千四百九十" do
    compare_kanji_and_integer("八千四百九十", 8490)
  end

  it "八千四百九十一" do
    compare_kanji_and_integer("八千四百九十一", 8491)
  end

  it "八千四百九十二" do
    compare_kanji_and_integer("八千四百九十二", 8492)
  end

  it "八千四百九十三" do
    compare_kanji_and_integer("八千四百九十三", 8493)
  end

  it "八千四百九十四" do
    compare_kanji_and_integer("八千四百九十四", 8494)
  end

  it "八千四百九十五" do
    compare_kanji_and_integer("八千四百九十五", 8495)
  end

  it "八千四百九十六" do
    compare_kanji_and_integer("八千四百九十六", 8496)
  end

  it "八千四百九十七" do
    compare_kanji_and_integer("八千四百九十七", 8497)
  end

  it "八千四百九十八" do
    compare_kanji_and_integer("八千四百九十八", 8498)
  end

  it "八千四百九十九" do
    compare_kanji_and_integer("八千四百九十九", 8499)
  end

  it "八千五百" do
    compare_kanji_and_integer("八千五百", 8500)
  end

  it "八千五百一" do
    compare_kanji_and_integer("八千五百一", 8501)
  end

  it "八千五百二" do
    compare_kanji_and_integer("八千五百二", 8502)
  end

  it "八千五百三" do
    compare_kanji_and_integer("八千五百三", 8503)
  end

  it "八千五百四" do
    compare_kanji_and_integer("八千五百四", 8504)
  end

  it "八千五百五" do
    compare_kanji_and_integer("八千五百五", 8505)
  end

  it "八千五百六" do
    compare_kanji_and_integer("八千五百六", 8506)
  end

  it "八千五百七" do
    compare_kanji_and_integer("八千五百七", 8507)
  end

  it "八千五百八" do
    compare_kanji_and_integer("八千五百八", 8508)
  end

  it "八千五百九" do
    compare_kanji_and_integer("八千五百九", 8509)
  end

  it "八千五百十" do
    compare_kanji_and_integer("八千五百十", 8510)
  end

  it "八千五百十一" do
    compare_kanji_and_integer("八千五百十一", 8511)
  end

  it "八千五百十二" do
    compare_kanji_and_integer("八千五百十二", 8512)
  end

  it "八千五百十三" do
    compare_kanji_and_integer("八千五百十三", 8513)
  end

  it "八千五百十四" do
    compare_kanji_and_integer("八千五百十四", 8514)
  end

  it "八千五百十五" do
    compare_kanji_and_integer("八千五百十五", 8515)
  end

  it "八千五百十六" do
    compare_kanji_and_integer("八千五百十六", 8516)
  end

  it "八千五百十七" do
    compare_kanji_and_integer("八千五百十七", 8517)
  end

  it "八千五百十八" do
    compare_kanji_and_integer("八千五百十八", 8518)
  end

  it "八千五百十九" do
    compare_kanji_and_integer("八千五百十九", 8519)
  end

  it "八千五百二十" do
    compare_kanji_and_integer("八千五百二十", 8520)
  end

  it "八千五百二十一" do
    compare_kanji_and_integer("八千五百二十一", 8521)
  end

  it "八千五百二十二" do
    compare_kanji_and_integer("八千五百二十二", 8522)
  end

  it "八千五百二十三" do
    compare_kanji_and_integer("八千五百二十三", 8523)
  end

  it "八千五百二十四" do
    compare_kanji_and_integer("八千五百二十四", 8524)
  end

  it "八千五百二十五" do
    compare_kanji_and_integer("八千五百二十五", 8525)
  end

  it "八千五百二十六" do
    compare_kanji_and_integer("八千五百二十六", 8526)
  end

  it "八千五百二十七" do
    compare_kanji_and_integer("八千五百二十七", 8527)
  end

  it "八千五百二十八" do
    compare_kanji_and_integer("八千五百二十八", 8528)
  end

  it "八千五百二十九" do
    compare_kanji_and_integer("八千五百二十九", 8529)
  end

  it "八千五百三十" do
    compare_kanji_and_integer("八千五百三十", 8530)
  end

  it "八千五百三十一" do
    compare_kanji_and_integer("八千五百三十一", 8531)
  end

  it "八千五百三十二" do
    compare_kanji_and_integer("八千五百三十二", 8532)
  end

  it "八千五百三十三" do
    compare_kanji_and_integer("八千五百三十三", 8533)
  end

  it "八千五百三十四" do
    compare_kanji_and_integer("八千五百三十四", 8534)
  end

  it "八千五百三十五" do
    compare_kanji_and_integer("八千五百三十五", 8535)
  end

  it "八千五百三十六" do
    compare_kanji_and_integer("八千五百三十六", 8536)
  end

  it "八千五百三十七" do
    compare_kanji_and_integer("八千五百三十七", 8537)
  end

  it "八千五百三十八" do
    compare_kanji_and_integer("八千五百三十八", 8538)
  end

  it "八千五百三十九" do
    compare_kanji_and_integer("八千五百三十九", 8539)
  end

  it "八千五百四十" do
    compare_kanji_and_integer("八千五百四十", 8540)
  end

  it "八千五百四十一" do
    compare_kanji_and_integer("八千五百四十一", 8541)
  end

  it "八千五百四十二" do
    compare_kanji_and_integer("八千五百四十二", 8542)
  end

  it "八千五百四十三" do
    compare_kanji_and_integer("八千五百四十三", 8543)
  end

  it "八千五百四十四" do
    compare_kanji_and_integer("八千五百四十四", 8544)
  end

  it "八千五百四十五" do
    compare_kanji_and_integer("八千五百四十五", 8545)
  end

  it "八千五百四十六" do
    compare_kanji_and_integer("八千五百四十六", 8546)
  end

  it "八千五百四十七" do
    compare_kanji_and_integer("八千五百四十七", 8547)
  end

  it "八千五百四十八" do
    compare_kanji_and_integer("八千五百四十八", 8548)
  end

  it "八千五百四十九" do
    compare_kanji_and_integer("八千五百四十九", 8549)
  end

  it "八千五百五十" do
    compare_kanji_and_integer("八千五百五十", 8550)
  end

  it "八千五百五十一" do
    compare_kanji_and_integer("八千五百五十一", 8551)
  end

  it "八千五百五十二" do
    compare_kanji_and_integer("八千五百五十二", 8552)
  end

  it "八千五百五十三" do
    compare_kanji_and_integer("八千五百五十三", 8553)
  end

  it "八千五百五十四" do
    compare_kanji_and_integer("八千五百五十四", 8554)
  end

  it "八千五百五十五" do
    compare_kanji_and_integer("八千五百五十五", 8555)
  end

  it "八千五百五十六" do
    compare_kanji_and_integer("八千五百五十六", 8556)
  end

  it "八千五百五十七" do
    compare_kanji_and_integer("八千五百五十七", 8557)
  end

  it "八千五百五十八" do
    compare_kanji_and_integer("八千五百五十八", 8558)
  end

  it "八千五百五十九" do
    compare_kanji_and_integer("八千五百五十九", 8559)
  end

  it "八千五百六十" do
    compare_kanji_and_integer("八千五百六十", 8560)
  end

  it "八千五百六十一" do
    compare_kanji_and_integer("八千五百六十一", 8561)
  end

  it "八千五百六十二" do
    compare_kanji_and_integer("八千五百六十二", 8562)
  end

  it "八千五百六十三" do
    compare_kanji_and_integer("八千五百六十三", 8563)
  end

  it "八千五百六十四" do
    compare_kanji_and_integer("八千五百六十四", 8564)
  end

  it "八千五百六十五" do
    compare_kanji_and_integer("八千五百六十五", 8565)
  end

  it "八千五百六十六" do
    compare_kanji_and_integer("八千五百六十六", 8566)
  end

  it "八千五百六十七" do
    compare_kanji_and_integer("八千五百六十七", 8567)
  end

  it "八千五百六十八" do
    compare_kanji_and_integer("八千五百六十八", 8568)
  end

  it "八千五百六十九" do
    compare_kanji_and_integer("八千五百六十九", 8569)
  end

  it "八千五百七十" do
    compare_kanji_and_integer("八千五百七十", 8570)
  end

  it "八千五百七十一" do
    compare_kanji_and_integer("八千五百七十一", 8571)
  end

  it "八千五百七十二" do
    compare_kanji_and_integer("八千五百七十二", 8572)
  end

  it "八千五百七十三" do
    compare_kanji_and_integer("八千五百七十三", 8573)
  end

  it "八千五百七十四" do
    compare_kanji_and_integer("八千五百七十四", 8574)
  end

  it "八千五百七十五" do
    compare_kanji_and_integer("八千五百七十五", 8575)
  end

  it "八千五百七十六" do
    compare_kanji_and_integer("八千五百七十六", 8576)
  end

  it "八千五百七十七" do
    compare_kanji_and_integer("八千五百七十七", 8577)
  end

  it "八千五百七十八" do
    compare_kanji_and_integer("八千五百七十八", 8578)
  end

  it "八千五百七十九" do
    compare_kanji_and_integer("八千五百七十九", 8579)
  end

  it "八千五百八十" do
    compare_kanji_and_integer("八千五百八十", 8580)
  end

  it "八千五百八十一" do
    compare_kanji_and_integer("八千五百八十一", 8581)
  end

  it "八千五百八十二" do
    compare_kanji_and_integer("八千五百八十二", 8582)
  end

  it "八千五百八十三" do
    compare_kanji_and_integer("八千五百八十三", 8583)
  end

  it "八千五百八十四" do
    compare_kanji_and_integer("八千五百八十四", 8584)
  end

  it "八千五百八十五" do
    compare_kanji_and_integer("八千五百八十五", 8585)
  end

  it "八千五百八十六" do
    compare_kanji_and_integer("八千五百八十六", 8586)
  end

  it "八千五百八十七" do
    compare_kanji_and_integer("八千五百八十七", 8587)
  end

  it "八千五百八十八" do
    compare_kanji_and_integer("八千五百八十八", 8588)
  end

  it "八千五百八十九" do
    compare_kanji_and_integer("八千五百八十九", 8589)
  end

  it "八千五百九十" do
    compare_kanji_and_integer("八千五百九十", 8590)
  end

  it "八千五百九十一" do
    compare_kanji_and_integer("八千五百九十一", 8591)
  end

  it "八千五百九十二" do
    compare_kanji_and_integer("八千五百九十二", 8592)
  end

  it "八千五百九十三" do
    compare_kanji_and_integer("八千五百九十三", 8593)
  end

  it "八千五百九十四" do
    compare_kanji_and_integer("八千五百九十四", 8594)
  end

  it "八千五百九十五" do
    compare_kanji_and_integer("八千五百九十五", 8595)
  end

  it "八千五百九十六" do
    compare_kanji_and_integer("八千五百九十六", 8596)
  end

  it "八千五百九十七" do
    compare_kanji_and_integer("八千五百九十七", 8597)
  end

  it "八千五百九十八" do
    compare_kanji_and_integer("八千五百九十八", 8598)
  end

  it "八千五百九十九" do
    compare_kanji_and_integer("八千五百九十九", 8599)
  end

  it "八千六百" do
    compare_kanji_and_integer("八千六百", 8600)
  end

  it "八千六百一" do
    compare_kanji_and_integer("八千六百一", 8601)
  end

  it "八千六百二" do
    compare_kanji_and_integer("八千六百二", 8602)
  end

  it "八千六百三" do
    compare_kanji_and_integer("八千六百三", 8603)
  end

  it "八千六百四" do
    compare_kanji_and_integer("八千六百四", 8604)
  end

  it "八千六百五" do
    compare_kanji_and_integer("八千六百五", 8605)
  end

  it "八千六百六" do
    compare_kanji_and_integer("八千六百六", 8606)
  end

  it "八千六百七" do
    compare_kanji_and_integer("八千六百七", 8607)
  end

  it "八千六百八" do
    compare_kanji_and_integer("八千六百八", 8608)
  end

  it "八千六百九" do
    compare_kanji_and_integer("八千六百九", 8609)
  end

  it "八千六百十" do
    compare_kanji_and_integer("八千六百十", 8610)
  end

  it "八千六百十一" do
    compare_kanji_and_integer("八千六百十一", 8611)
  end

  it "八千六百十二" do
    compare_kanji_and_integer("八千六百十二", 8612)
  end

  it "八千六百十三" do
    compare_kanji_and_integer("八千六百十三", 8613)
  end

  it "八千六百十四" do
    compare_kanji_and_integer("八千六百十四", 8614)
  end

  it "八千六百十五" do
    compare_kanji_and_integer("八千六百十五", 8615)
  end

  it "八千六百十六" do
    compare_kanji_and_integer("八千六百十六", 8616)
  end

  it "八千六百十七" do
    compare_kanji_and_integer("八千六百十七", 8617)
  end

  it "八千六百十八" do
    compare_kanji_and_integer("八千六百十八", 8618)
  end

  it "八千六百十九" do
    compare_kanji_and_integer("八千六百十九", 8619)
  end

  it "八千六百二十" do
    compare_kanji_and_integer("八千六百二十", 8620)
  end

  it "八千六百二十一" do
    compare_kanji_and_integer("八千六百二十一", 8621)
  end

  it "八千六百二十二" do
    compare_kanji_and_integer("八千六百二十二", 8622)
  end

  it "八千六百二十三" do
    compare_kanji_and_integer("八千六百二十三", 8623)
  end

  it "八千六百二十四" do
    compare_kanji_and_integer("八千六百二十四", 8624)
  end

  it "八千六百二十五" do
    compare_kanji_and_integer("八千六百二十五", 8625)
  end

  it "八千六百二十六" do
    compare_kanji_and_integer("八千六百二十六", 8626)
  end

  it "八千六百二十七" do
    compare_kanji_and_integer("八千六百二十七", 8627)
  end

  it "八千六百二十八" do
    compare_kanji_and_integer("八千六百二十八", 8628)
  end

  it "八千六百二十九" do
    compare_kanji_and_integer("八千六百二十九", 8629)
  end

  it "八千六百三十" do
    compare_kanji_and_integer("八千六百三十", 8630)
  end

  it "八千六百三十一" do
    compare_kanji_and_integer("八千六百三十一", 8631)
  end

  it "八千六百三十二" do
    compare_kanji_and_integer("八千六百三十二", 8632)
  end

  it "八千六百三十三" do
    compare_kanji_and_integer("八千六百三十三", 8633)
  end

  it "八千六百三十四" do
    compare_kanji_and_integer("八千六百三十四", 8634)
  end

  it "八千六百三十五" do
    compare_kanji_and_integer("八千六百三十五", 8635)
  end

  it "八千六百三十六" do
    compare_kanji_and_integer("八千六百三十六", 8636)
  end

  it "八千六百三十七" do
    compare_kanji_and_integer("八千六百三十七", 8637)
  end

  it "八千六百三十八" do
    compare_kanji_and_integer("八千六百三十八", 8638)
  end

  it "八千六百三十九" do
    compare_kanji_and_integer("八千六百三十九", 8639)
  end

  it "八千六百四十" do
    compare_kanji_and_integer("八千六百四十", 8640)
  end

  it "八千六百四十一" do
    compare_kanji_and_integer("八千六百四十一", 8641)
  end

  it "八千六百四十二" do
    compare_kanji_and_integer("八千六百四十二", 8642)
  end

  it "八千六百四十三" do
    compare_kanji_and_integer("八千六百四十三", 8643)
  end

  it "八千六百四十四" do
    compare_kanji_and_integer("八千六百四十四", 8644)
  end

  it "八千六百四十五" do
    compare_kanji_and_integer("八千六百四十五", 8645)
  end

  it "八千六百四十六" do
    compare_kanji_and_integer("八千六百四十六", 8646)
  end

  it "八千六百四十七" do
    compare_kanji_and_integer("八千六百四十七", 8647)
  end

  it "八千六百四十八" do
    compare_kanji_and_integer("八千六百四十八", 8648)
  end

  it "八千六百四十九" do
    compare_kanji_and_integer("八千六百四十九", 8649)
  end

  it "八千六百五十" do
    compare_kanji_and_integer("八千六百五十", 8650)
  end

  it "八千六百五十一" do
    compare_kanji_and_integer("八千六百五十一", 8651)
  end

  it "八千六百五十二" do
    compare_kanji_and_integer("八千六百五十二", 8652)
  end

  it "八千六百五十三" do
    compare_kanji_and_integer("八千六百五十三", 8653)
  end

  it "八千六百五十四" do
    compare_kanji_and_integer("八千六百五十四", 8654)
  end

  it "八千六百五十五" do
    compare_kanji_and_integer("八千六百五十五", 8655)
  end

  it "八千六百五十六" do
    compare_kanji_and_integer("八千六百五十六", 8656)
  end

  it "八千六百五十七" do
    compare_kanji_and_integer("八千六百五十七", 8657)
  end

  it "八千六百五十八" do
    compare_kanji_and_integer("八千六百五十八", 8658)
  end

  it "八千六百五十九" do
    compare_kanji_and_integer("八千六百五十九", 8659)
  end

  it "八千六百六十" do
    compare_kanji_and_integer("八千六百六十", 8660)
  end

  it "八千六百六十一" do
    compare_kanji_and_integer("八千六百六十一", 8661)
  end

  it "八千六百六十二" do
    compare_kanji_and_integer("八千六百六十二", 8662)
  end

  it "八千六百六十三" do
    compare_kanji_and_integer("八千六百六十三", 8663)
  end

  it "八千六百六十四" do
    compare_kanji_and_integer("八千六百六十四", 8664)
  end

  it "八千六百六十五" do
    compare_kanji_and_integer("八千六百六十五", 8665)
  end

  it "八千六百六十六" do
    compare_kanji_and_integer("八千六百六十六", 8666)
  end

  it "八千六百六十七" do
    compare_kanji_and_integer("八千六百六十七", 8667)
  end

  it "八千六百六十八" do
    compare_kanji_and_integer("八千六百六十八", 8668)
  end

  it "八千六百六十九" do
    compare_kanji_and_integer("八千六百六十九", 8669)
  end

  it "八千六百七十" do
    compare_kanji_and_integer("八千六百七十", 8670)
  end

  it "八千六百七十一" do
    compare_kanji_and_integer("八千六百七十一", 8671)
  end

  it "八千六百七十二" do
    compare_kanji_and_integer("八千六百七十二", 8672)
  end

  it "八千六百七十三" do
    compare_kanji_and_integer("八千六百七十三", 8673)
  end

  it "八千六百七十四" do
    compare_kanji_and_integer("八千六百七十四", 8674)
  end

  it "八千六百七十五" do
    compare_kanji_and_integer("八千六百七十五", 8675)
  end

  it "八千六百七十六" do
    compare_kanji_and_integer("八千六百七十六", 8676)
  end

  it "八千六百七十七" do
    compare_kanji_and_integer("八千六百七十七", 8677)
  end

  it "八千六百七十八" do
    compare_kanji_and_integer("八千六百七十八", 8678)
  end

  it "八千六百七十九" do
    compare_kanji_and_integer("八千六百七十九", 8679)
  end

  it "八千六百八十" do
    compare_kanji_and_integer("八千六百八十", 8680)
  end

  it "八千六百八十一" do
    compare_kanji_and_integer("八千六百八十一", 8681)
  end

  it "八千六百八十二" do
    compare_kanji_and_integer("八千六百八十二", 8682)
  end

  it "八千六百八十三" do
    compare_kanji_and_integer("八千六百八十三", 8683)
  end

  it "八千六百八十四" do
    compare_kanji_and_integer("八千六百八十四", 8684)
  end

  it "八千六百八十五" do
    compare_kanji_and_integer("八千六百八十五", 8685)
  end

  it "八千六百八十六" do
    compare_kanji_and_integer("八千六百八十六", 8686)
  end

  it "八千六百八十七" do
    compare_kanji_and_integer("八千六百八十七", 8687)
  end

  it "八千六百八十八" do
    compare_kanji_and_integer("八千六百八十八", 8688)
  end

  it "八千六百八十九" do
    compare_kanji_and_integer("八千六百八十九", 8689)
  end

  it "八千六百九十" do
    compare_kanji_and_integer("八千六百九十", 8690)
  end

  it "八千六百九十一" do
    compare_kanji_and_integer("八千六百九十一", 8691)
  end

  it "八千六百九十二" do
    compare_kanji_and_integer("八千六百九十二", 8692)
  end

  it "八千六百九十三" do
    compare_kanji_and_integer("八千六百九十三", 8693)
  end

  it "八千六百九十四" do
    compare_kanji_and_integer("八千六百九十四", 8694)
  end

  it "八千六百九十五" do
    compare_kanji_and_integer("八千六百九十五", 8695)
  end

  it "八千六百九十六" do
    compare_kanji_and_integer("八千六百九十六", 8696)
  end

  it "八千六百九十七" do
    compare_kanji_and_integer("八千六百九十七", 8697)
  end

  it "八千六百九十八" do
    compare_kanji_and_integer("八千六百九十八", 8698)
  end

  it "八千六百九十九" do
    compare_kanji_and_integer("八千六百九十九", 8699)
  end

  it "八千七百" do
    compare_kanji_and_integer("八千七百", 8700)
  end

  it "八千七百一" do
    compare_kanji_and_integer("八千七百一", 8701)
  end

  it "八千七百二" do
    compare_kanji_and_integer("八千七百二", 8702)
  end

  it "八千七百三" do
    compare_kanji_and_integer("八千七百三", 8703)
  end

  it "八千七百四" do
    compare_kanji_and_integer("八千七百四", 8704)
  end

  it "八千七百五" do
    compare_kanji_and_integer("八千七百五", 8705)
  end

  it "八千七百六" do
    compare_kanji_and_integer("八千七百六", 8706)
  end

  it "八千七百七" do
    compare_kanji_and_integer("八千七百七", 8707)
  end

  it "八千七百八" do
    compare_kanji_and_integer("八千七百八", 8708)
  end

  it "八千七百九" do
    compare_kanji_and_integer("八千七百九", 8709)
  end

  it "八千七百十" do
    compare_kanji_and_integer("八千七百十", 8710)
  end

  it "八千七百十一" do
    compare_kanji_and_integer("八千七百十一", 8711)
  end

  it "八千七百十二" do
    compare_kanji_and_integer("八千七百十二", 8712)
  end

  it "八千七百十三" do
    compare_kanji_and_integer("八千七百十三", 8713)
  end

  it "八千七百十四" do
    compare_kanji_and_integer("八千七百十四", 8714)
  end

  it "八千七百十五" do
    compare_kanji_and_integer("八千七百十五", 8715)
  end

  it "八千七百十六" do
    compare_kanji_and_integer("八千七百十六", 8716)
  end

  it "八千七百十七" do
    compare_kanji_and_integer("八千七百十七", 8717)
  end

  it "八千七百十八" do
    compare_kanji_and_integer("八千七百十八", 8718)
  end

  it "八千七百十九" do
    compare_kanji_and_integer("八千七百十九", 8719)
  end

  it "八千七百二十" do
    compare_kanji_and_integer("八千七百二十", 8720)
  end

  it "八千七百二十一" do
    compare_kanji_and_integer("八千七百二十一", 8721)
  end

  it "八千七百二十二" do
    compare_kanji_and_integer("八千七百二十二", 8722)
  end

  it "八千七百二十三" do
    compare_kanji_and_integer("八千七百二十三", 8723)
  end

  it "八千七百二十四" do
    compare_kanji_and_integer("八千七百二十四", 8724)
  end

  it "八千七百二十五" do
    compare_kanji_and_integer("八千七百二十五", 8725)
  end

  it "八千七百二十六" do
    compare_kanji_and_integer("八千七百二十六", 8726)
  end

  it "八千七百二十七" do
    compare_kanji_and_integer("八千七百二十七", 8727)
  end

  it "八千七百二十八" do
    compare_kanji_and_integer("八千七百二十八", 8728)
  end

  it "八千七百二十九" do
    compare_kanji_and_integer("八千七百二十九", 8729)
  end

  it "八千七百三十" do
    compare_kanji_and_integer("八千七百三十", 8730)
  end

  it "八千七百三十一" do
    compare_kanji_and_integer("八千七百三十一", 8731)
  end

  it "八千七百三十二" do
    compare_kanji_and_integer("八千七百三十二", 8732)
  end

  it "八千七百三十三" do
    compare_kanji_and_integer("八千七百三十三", 8733)
  end

  it "八千七百三十四" do
    compare_kanji_and_integer("八千七百三十四", 8734)
  end

  it "八千七百三十五" do
    compare_kanji_and_integer("八千七百三十五", 8735)
  end

  it "八千七百三十六" do
    compare_kanji_and_integer("八千七百三十六", 8736)
  end

  it "八千七百三十七" do
    compare_kanji_and_integer("八千七百三十七", 8737)
  end

  it "八千七百三十八" do
    compare_kanji_and_integer("八千七百三十八", 8738)
  end

  it "八千七百三十九" do
    compare_kanji_and_integer("八千七百三十九", 8739)
  end

  it "八千七百四十" do
    compare_kanji_and_integer("八千七百四十", 8740)
  end

  it "八千七百四十一" do
    compare_kanji_and_integer("八千七百四十一", 8741)
  end

  it "八千七百四十二" do
    compare_kanji_and_integer("八千七百四十二", 8742)
  end

  it "八千七百四十三" do
    compare_kanji_and_integer("八千七百四十三", 8743)
  end

  it "八千七百四十四" do
    compare_kanji_and_integer("八千七百四十四", 8744)
  end

  it "八千七百四十五" do
    compare_kanji_and_integer("八千七百四十五", 8745)
  end

  it "八千七百四十六" do
    compare_kanji_and_integer("八千七百四十六", 8746)
  end

  it "八千七百四十七" do
    compare_kanji_and_integer("八千七百四十七", 8747)
  end

  it "八千七百四十八" do
    compare_kanji_and_integer("八千七百四十八", 8748)
  end

  it "八千七百四十九" do
    compare_kanji_and_integer("八千七百四十九", 8749)
  end

  it "八千七百五十" do
    compare_kanji_and_integer("八千七百五十", 8750)
  end

  it "八千七百五十一" do
    compare_kanji_and_integer("八千七百五十一", 8751)
  end

  it "八千七百五十二" do
    compare_kanji_and_integer("八千七百五十二", 8752)
  end

  it "八千七百五十三" do
    compare_kanji_and_integer("八千七百五十三", 8753)
  end

  it "八千七百五十四" do
    compare_kanji_and_integer("八千七百五十四", 8754)
  end

  it "八千七百五十五" do
    compare_kanji_and_integer("八千七百五十五", 8755)
  end

  it "八千七百五十六" do
    compare_kanji_and_integer("八千七百五十六", 8756)
  end

  it "八千七百五十七" do
    compare_kanji_and_integer("八千七百五十七", 8757)
  end

  it "八千七百五十八" do
    compare_kanji_and_integer("八千七百五十八", 8758)
  end

  it "八千七百五十九" do
    compare_kanji_and_integer("八千七百五十九", 8759)
  end

  it "八千七百六十" do
    compare_kanji_and_integer("八千七百六十", 8760)
  end

  it "八千七百六十一" do
    compare_kanji_and_integer("八千七百六十一", 8761)
  end

  it "八千七百六十二" do
    compare_kanji_and_integer("八千七百六十二", 8762)
  end

  it "八千七百六十三" do
    compare_kanji_and_integer("八千七百六十三", 8763)
  end

  it "八千七百六十四" do
    compare_kanji_and_integer("八千七百六十四", 8764)
  end

  it "八千七百六十五" do
    compare_kanji_and_integer("八千七百六十五", 8765)
  end

  it "八千七百六十六" do
    compare_kanji_and_integer("八千七百六十六", 8766)
  end

  it "八千七百六十七" do
    compare_kanji_and_integer("八千七百六十七", 8767)
  end

  it "八千七百六十八" do
    compare_kanji_and_integer("八千七百六十八", 8768)
  end

  it "八千七百六十九" do
    compare_kanji_and_integer("八千七百六十九", 8769)
  end

  it "八千七百七十" do
    compare_kanji_and_integer("八千七百七十", 8770)
  end

  it "八千七百七十一" do
    compare_kanji_and_integer("八千七百七十一", 8771)
  end

  it "八千七百七十二" do
    compare_kanji_and_integer("八千七百七十二", 8772)
  end

  it "八千七百七十三" do
    compare_kanji_and_integer("八千七百七十三", 8773)
  end

  it "八千七百七十四" do
    compare_kanji_and_integer("八千七百七十四", 8774)
  end

  it "八千七百七十五" do
    compare_kanji_and_integer("八千七百七十五", 8775)
  end

  it "八千七百七十六" do
    compare_kanji_and_integer("八千七百七十六", 8776)
  end

  it "八千七百七十七" do
    compare_kanji_and_integer("八千七百七十七", 8777)
  end

  it "八千七百七十八" do
    compare_kanji_and_integer("八千七百七十八", 8778)
  end

  it "八千七百七十九" do
    compare_kanji_and_integer("八千七百七十九", 8779)
  end

  it "八千七百八十" do
    compare_kanji_and_integer("八千七百八十", 8780)
  end

  it "八千七百八十一" do
    compare_kanji_and_integer("八千七百八十一", 8781)
  end

  it "八千七百八十二" do
    compare_kanji_and_integer("八千七百八十二", 8782)
  end

  it "八千七百八十三" do
    compare_kanji_and_integer("八千七百八十三", 8783)
  end

  it "八千七百八十四" do
    compare_kanji_and_integer("八千七百八十四", 8784)
  end

  it "八千七百八十五" do
    compare_kanji_and_integer("八千七百八十五", 8785)
  end

  it "八千七百八十六" do
    compare_kanji_and_integer("八千七百八十六", 8786)
  end

  it "八千七百八十七" do
    compare_kanji_and_integer("八千七百八十七", 8787)
  end

  it "八千七百八十八" do
    compare_kanji_and_integer("八千七百八十八", 8788)
  end

  it "八千七百八十九" do
    compare_kanji_and_integer("八千七百八十九", 8789)
  end

  it "八千七百九十" do
    compare_kanji_and_integer("八千七百九十", 8790)
  end

  it "八千七百九十一" do
    compare_kanji_and_integer("八千七百九十一", 8791)
  end

  it "八千七百九十二" do
    compare_kanji_and_integer("八千七百九十二", 8792)
  end

  it "八千七百九十三" do
    compare_kanji_and_integer("八千七百九十三", 8793)
  end

  it "八千七百九十四" do
    compare_kanji_and_integer("八千七百九十四", 8794)
  end

  it "八千七百九十五" do
    compare_kanji_and_integer("八千七百九十五", 8795)
  end

  it "八千七百九十六" do
    compare_kanji_and_integer("八千七百九十六", 8796)
  end

  it "八千七百九十七" do
    compare_kanji_and_integer("八千七百九十七", 8797)
  end

  it "八千七百九十八" do
    compare_kanji_and_integer("八千七百九十八", 8798)
  end

  it "八千七百九十九" do
    compare_kanji_and_integer("八千七百九十九", 8799)
  end

  it "八千八百" do
    compare_kanji_and_integer("八千八百", 8800)
  end

  it "八千八百一" do
    compare_kanji_and_integer("八千八百一", 8801)
  end

  it "八千八百二" do
    compare_kanji_and_integer("八千八百二", 8802)
  end

  it "八千八百三" do
    compare_kanji_and_integer("八千八百三", 8803)
  end

  it "八千八百四" do
    compare_kanji_and_integer("八千八百四", 8804)
  end

  it "八千八百五" do
    compare_kanji_and_integer("八千八百五", 8805)
  end

  it "八千八百六" do
    compare_kanji_and_integer("八千八百六", 8806)
  end

  it "八千八百七" do
    compare_kanji_and_integer("八千八百七", 8807)
  end

  it "八千八百八" do
    compare_kanji_and_integer("八千八百八", 8808)
  end

  it "八千八百九" do
    compare_kanji_and_integer("八千八百九", 8809)
  end

  it "八千八百十" do
    compare_kanji_and_integer("八千八百十", 8810)
  end

  it "八千八百十一" do
    compare_kanji_and_integer("八千八百十一", 8811)
  end

  it "八千八百十二" do
    compare_kanji_and_integer("八千八百十二", 8812)
  end

  it "八千八百十三" do
    compare_kanji_and_integer("八千八百十三", 8813)
  end

  it "八千八百十四" do
    compare_kanji_and_integer("八千八百十四", 8814)
  end

  it "八千八百十五" do
    compare_kanji_and_integer("八千八百十五", 8815)
  end

  it "八千八百十六" do
    compare_kanji_and_integer("八千八百十六", 8816)
  end

  it "八千八百十七" do
    compare_kanji_and_integer("八千八百十七", 8817)
  end

  it "八千八百十八" do
    compare_kanji_and_integer("八千八百十八", 8818)
  end

  it "八千八百十九" do
    compare_kanji_and_integer("八千八百十九", 8819)
  end

  it "八千八百二十" do
    compare_kanji_and_integer("八千八百二十", 8820)
  end

  it "八千八百二十一" do
    compare_kanji_and_integer("八千八百二十一", 8821)
  end

  it "八千八百二十二" do
    compare_kanji_and_integer("八千八百二十二", 8822)
  end

  it "八千八百二十三" do
    compare_kanji_and_integer("八千八百二十三", 8823)
  end

  it "八千八百二十四" do
    compare_kanji_and_integer("八千八百二十四", 8824)
  end

  it "八千八百二十五" do
    compare_kanji_and_integer("八千八百二十五", 8825)
  end

  it "八千八百二十六" do
    compare_kanji_and_integer("八千八百二十六", 8826)
  end

  it "八千八百二十七" do
    compare_kanji_and_integer("八千八百二十七", 8827)
  end

  it "八千八百二十八" do
    compare_kanji_and_integer("八千八百二十八", 8828)
  end

  it "八千八百二十九" do
    compare_kanji_and_integer("八千八百二十九", 8829)
  end

  it "八千八百三十" do
    compare_kanji_and_integer("八千八百三十", 8830)
  end

  it "八千八百三十一" do
    compare_kanji_and_integer("八千八百三十一", 8831)
  end

  it "八千八百三十二" do
    compare_kanji_and_integer("八千八百三十二", 8832)
  end

  it "八千八百三十三" do
    compare_kanji_and_integer("八千八百三十三", 8833)
  end

  it "八千八百三十四" do
    compare_kanji_and_integer("八千八百三十四", 8834)
  end

  it "八千八百三十五" do
    compare_kanji_and_integer("八千八百三十五", 8835)
  end

  it "八千八百三十六" do
    compare_kanji_and_integer("八千八百三十六", 8836)
  end

  it "八千八百三十七" do
    compare_kanji_and_integer("八千八百三十七", 8837)
  end

  it "八千八百三十八" do
    compare_kanji_and_integer("八千八百三十八", 8838)
  end

  it "八千八百三十九" do
    compare_kanji_and_integer("八千八百三十九", 8839)
  end

  it "八千八百四十" do
    compare_kanji_and_integer("八千八百四十", 8840)
  end

  it "八千八百四十一" do
    compare_kanji_and_integer("八千八百四十一", 8841)
  end

  it "八千八百四十二" do
    compare_kanji_and_integer("八千八百四十二", 8842)
  end

  it "八千八百四十三" do
    compare_kanji_and_integer("八千八百四十三", 8843)
  end

  it "八千八百四十四" do
    compare_kanji_and_integer("八千八百四十四", 8844)
  end

  it "八千八百四十五" do
    compare_kanji_and_integer("八千八百四十五", 8845)
  end

  it "八千八百四十六" do
    compare_kanji_and_integer("八千八百四十六", 8846)
  end

  it "八千八百四十七" do
    compare_kanji_and_integer("八千八百四十七", 8847)
  end

  it "八千八百四十八" do
    compare_kanji_and_integer("八千八百四十八", 8848)
  end

  it "八千八百四十九" do
    compare_kanji_and_integer("八千八百四十九", 8849)
  end

  it "八千八百五十" do
    compare_kanji_and_integer("八千八百五十", 8850)
  end

  it "八千八百五十一" do
    compare_kanji_and_integer("八千八百五十一", 8851)
  end

  it "八千八百五十二" do
    compare_kanji_and_integer("八千八百五十二", 8852)
  end

  it "八千八百五十三" do
    compare_kanji_and_integer("八千八百五十三", 8853)
  end

  it "八千八百五十四" do
    compare_kanji_and_integer("八千八百五十四", 8854)
  end

  it "八千八百五十五" do
    compare_kanji_and_integer("八千八百五十五", 8855)
  end

  it "八千八百五十六" do
    compare_kanji_and_integer("八千八百五十六", 8856)
  end

  it "八千八百五十七" do
    compare_kanji_and_integer("八千八百五十七", 8857)
  end

  it "八千八百五十八" do
    compare_kanji_and_integer("八千八百五十八", 8858)
  end

  it "八千八百五十九" do
    compare_kanji_and_integer("八千八百五十九", 8859)
  end

  it "八千八百六十" do
    compare_kanji_and_integer("八千八百六十", 8860)
  end

  it "八千八百六十一" do
    compare_kanji_and_integer("八千八百六十一", 8861)
  end

  it "八千八百六十二" do
    compare_kanji_and_integer("八千八百六十二", 8862)
  end

  it "八千八百六十三" do
    compare_kanji_and_integer("八千八百六十三", 8863)
  end

  it "八千八百六十四" do
    compare_kanji_and_integer("八千八百六十四", 8864)
  end

  it "八千八百六十五" do
    compare_kanji_and_integer("八千八百六十五", 8865)
  end

  it "八千八百六十六" do
    compare_kanji_and_integer("八千八百六十六", 8866)
  end

  it "八千八百六十七" do
    compare_kanji_and_integer("八千八百六十七", 8867)
  end

  it "八千八百六十八" do
    compare_kanji_and_integer("八千八百六十八", 8868)
  end

  it "八千八百六十九" do
    compare_kanji_and_integer("八千八百六十九", 8869)
  end

  it "八千八百七十" do
    compare_kanji_and_integer("八千八百七十", 8870)
  end

  it "八千八百七十一" do
    compare_kanji_and_integer("八千八百七十一", 8871)
  end

  it "八千八百七十二" do
    compare_kanji_and_integer("八千八百七十二", 8872)
  end

  it "八千八百七十三" do
    compare_kanji_and_integer("八千八百七十三", 8873)
  end

  it "八千八百七十四" do
    compare_kanji_and_integer("八千八百七十四", 8874)
  end

  it "八千八百七十五" do
    compare_kanji_and_integer("八千八百七十五", 8875)
  end

  it "八千八百七十六" do
    compare_kanji_and_integer("八千八百七十六", 8876)
  end

  it "八千八百七十七" do
    compare_kanji_and_integer("八千八百七十七", 8877)
  end

  it "八千八百七十八" do
    compare_kanji_and_integer("八千八百七十八", 8878)
  end

  it "八千八百七十九" do
    compare_kanji_and_integer("八千八百七十九", 8879)
  end

  it "八千八百八十" do
    compare_kanji_and_integer("八千八百八十", 8880)
  end

  it "八千八百八十一" do
    compare_kanji_and_integer("八千八百八十一", 8881)
  end

  it "八千八百八十二" do
    compare_kanji_and_integer("八千八百八十二", 8882)
  end

  it "八千八百八十三" do
    compare_kanji_and_integer("八千八百八十三", 8883)
  end

  it "八千八百八十四" do
    compare_kanji_and_integer("八千八百八十四", 8884)
  end

  it "八千八百八十五" do
    compare_kanji_and_integer("八千八百八十五", 8885)
  end

  it "八千八百八十六" do
    compare_kanji_and_integer("八千八百八十六", 8886)
  end

  it "八千八百八十七" do
    compare_kanji_and_integer("八千八百八十七", 8887)
  end

  it "八千八百八十八" do
    compare_kanji_and_integer("八千八百八十八", 8888)
  end

  it "八千八百八十九" do
    compare_kanji_and_integer("八千八百八十九", 8889)
  end

  it "八千八百九十" do
    compare_kanji_and_integer("八千八百九十", 8890)
  end

  it "八千八百九十一" do
    compare_kanji_and_integer("八千八百九十一", 8891)
  end

  it "八千八百九十二" do
    compare_kanji_and_integer("八千八百九十二", 8892)
  end

  it "八千八百九十三" do
    compare_kanji_and_integer("八千八百九十三", 8893)
  end

  it "八千八百九十四" do
    compare_kanji_and_integer("八千八百九十四", 8894)
  end

  it "八千八百九十五" do
    compare_kanji_and_integer("八千八百九十五", 8895)
  end

  it "八千八百九十六" do
    compare_kanji_and_integer("八千八百九十六", 8896)
  end

  it "八千八百九十七" do
    compare_kanji_and_integer("八千八百九十七", 8897)
  end

  it "八千八百九十八" do
    compare_kanji_and_integer("八千八百九十八", 8898)
  end

  it "八千八百九十九" do
    compare_kanji_and_integer("八千八百九十九", 8899)
  end

  it "八千九百" do
    compare_kanji_and_integer("八千九百", 8900)
  end

  it "八千九百一" do
    compare_kanji_and_integer("八千九百一", 8901)
  end

  it "八千九百二" do
    compare_kanji_and_integer("八千九百二", 8902)
  end

  it "八千九百三" do
    compare_kanji_and_integer("八千九百三", 8903)
  end

  it "八千九百四" do
    compare_kanji_and_integer("八千九百四", 8904)
  end

  it "八千九百五" do
    compare_kanji_and_integer("八千九百五", 8905)
  end

  it "八千九百六" do
    compare_kanji_and_integer("八千九百六", 8906)
  end

  it "八千九百七" do
    compare_kanji_and_integer("八千九百七", 8907)
  end

  it "八千九百八" do
    compare_kanji_and_integer("八千九百八", 8908)
  end

  it "八千九百九" do
    compare_kanji_and_integer("八千九百九", 8909)
  end

  it "八千九百十" do
    compare_kanji_and_integer("八千九百十", 8910)
  end

  it "八千九百十一" do
    compare_kanji_and_integer("八千九百十一", 8911)
  end

  it "八千九百十二" do
    compare_kanji_and_integer("八千九百十二", 8912)
  end

  it "八千九百十三" do
    compare_kanji_and_integer("八千九百十三", 8913)
  end

  it "八千九百十四" do
    compare_kanji_and_integer("八千九百十四", 8914)
  end

  it "八千九百十五" do
    compare_kanji_and_integer("八千九百十五", 8915)
  end

  it "八千九百十六" do
    compare_kanji_and_integer("八千九百十六", 8916)
  end

  it "八千九百十七" do
    compare_kanji_and_integer("八千九百十七", 8917)
  end

  it "八千九百十八" do
    compare_kanji_and_integer("八千九百十八", 8918)
  end

  it "八千九百十九" do
    compare_kanji_and_integer("八千九百十九", 8919)
  end

  it "八千九百二十" do
    compare_kanji_and_integer("八千九百二十", 8920)
  end

  it "八千九百二十一" do
    compare_kanji_and_integer("八千九百二十一", 8921)
  end

  it "八千九百二十二" do
    compare_kanji_and_integer("八千九百二十二", 8922)
  end

  it "八千九百二十三" do
    compare_kanji_and_integer("八千九百二十三", 8923)
  end

  it "八千九百二十四" do
    compare_kanji_and_integer("八千九百二十四", 8924)
  end

  it "八千九百二十五" do
    compare_kanji_and_integer("八千九百二十五", 8925)
  end

  it "八千九百二十六" do
    compare_kanji_and_integer("八千九百二十六", 8926)
  end

  it "八千九百二十七" do
    compare_kanji_and_integer("八千九百二十七", 8927)
  end

  it "八千九百二十八" do
    compare_kanji_and_integer("八千九百二十八", 8928)
  end

  it "八千九百二十九" do
    compare_kanji_and_integer("八千九百二十九", 8929)
  end

  it "八千九百三十" do
    compare_kanji_and_integer("八千九百三十", 8930)
  end

  it "八千九百三十一" do
    compare_kanji_and_integer("八千九百三十一", 8931)
  end

  it "八千九百三十二" do
    compare_kanji_and_integer("八千九百三十二", 8932)
  end

  it "八千九百三十三" do
    compare_kanji_and_integer("八千九百三十三", 8933)
  end

  it "八千九百三十四" do
    compare_kanji_and_integer("八千九百三十四", 8934)
  end

  it "八千九百三十五" do
    compare_kanji_and_integer("八千九百三十五", 8935)
  end

  it "八千九百三十六" do
    compare_kanji_and_integer("八千九百三十六", 8936)
  end

  it "八千九百三十七" do
    compare_kanji_and_integer("八千九百三十七", 8937)
  end

  it "八千九百三十八" do
    compare_kanji_and_integer("八千九百三十八", 8938)
  end

  it "八千九百三十九" do
    compare_kanji_and_integer("八千九百三十九", 8939)
  end

  it "八千九百四十" do
    compare_kanji_and_integer("八千九百四十", 8940)
  end

  it "八千九百四十一" do
    compare_kanji_and_integer("八千九百四十一", 8941)
  end

  it "八千九百四十二" do
    compare_kanji_and_integer("八千九百四十二", 8942)
  end

  it "八千九百四十三" do
    compare_kanji_and_integer("八千九百四十三", 8943)
  end

  it "八千九百四十四" do
    compare_kanji_and_integer("八千九百四十四", 8944)
  end

  it "八千九百四十五" do
    compare_kanji_and_integer("八千九百四十五", 8945)
  end

  it "八千九百四十六" do
    compare_kanji_and_integer("八千九百四十六", 8946)
  end

  it "八千九百四十七" do
    compare_kanji_and_integer("八千九百四十七", 8947)
  end

  it "八千九百四十八" do
    compare_kanji_and_integer("八千九百四十八", 8948)
  end

  it "八千九百四十九" do
    compare_kanji_and_integer("八千九百四十九", 8949)
  end

  it "八千九百五十" do
    compare_kanji_and_integer("八千九百五十", 8950)
  end

  it "八千九百五十一" do
    compare_kanji_and_integer("八千九百五十一", 8951)
  end

  it "八千九百五十二" do
    compare_kanji_and_integer("八千九百五十二", 8952)
  end

  it "八千九百五十三" do
    compare_kanji_and_integer("八千九百五十三", 8953)
  end

  it "八千九百五十四" do
    compare_kanji_and_integer("八千九百五十四", 8954)
  end

  it "八千九百五十五" do
    compare_kanji_and_integer("八千九百五十五", 8955)
  end

  it "八千九百五十六" do
    compare_kanji_and_integer("八千九百五十六", 8956)
  end

  it "八千九百五十七" do
    compare_kanji_and_integer("八千九百五十七", 8957)
  end

  it "八千九百五十八" do
    compare_kanji_and_integer("八千九百五十八", 8958)
  end

  it "八千九百五十九" do
    compare_kanji_and_integer("八千九百五十九", 8959)
  end

  it "八千九百六十" do
    compare_kanji_and_integer("八千九百六十", 8960)
  end

  it "八千九百六十一" do
    compare_kanji_and_integer("八千九百六十一", 8961)
  end

  it "八千九百六十二" do
    compare_kanji_and_integer("八千九百六十二", 8962)
  end

  it "八千九百六十三" do
    compare_kanji_and_integer("八千九百六十三", 8963)
  end

  it "八千九百六十四" do
    compare_kanji_and_integer("八千九百六十四", 8964)
  end

  it "八千九百六十五" do
    compare_kanji_and_integer("八千九百六十五", 8965)
  end

  it "八千九百六十六" do
    compare_kanji_and_integer("八千九百六十六", 8966)
  end

  it "八千九百六十七" do
    compare_kanji_and_integer("八千九百六十七", 8967)
  end

  it "八千九百六十八" do
    compare_kanji_and_integer("八千九百六十八", 8968)
  end

  it "八千九百六十九" do
    compare_kanji_and_integer("八千九百六十九", 8969)
  end

  it "八千九百七十" do
    compare_kanji_and_integer("八千九百七十", 8970)
  end

  it "八千九百七十一" do
    compare_kanji_and_integer("八千九百七十一", 8971)
  end

  it "八千九百七十二" do
    compare_kanji_and_integer("八千九百七十二", 8972)
  end

  it "八千九百七十三" do
    compare_kanji_and_integer("八千九百七十三", 8973)
  end

  it "八千九百七十四" do
    compare_kanji_and_integer("八千九百七十四", 8974)
  end

  it "八千九百七十五" do
    compare_kanji_and_integer("八千九百七十五", 8975)
  end

  it "八千九百七十六" do
    compare_kanji_and_integer("八千九百七十六", 8976)
  end

  it "八千九百七十七" do
    compare_kanji_and_integer("八千九百七十七", 8977)
  end

  it "八千九百七十八" do
    compare_kanji_and_integer("八千九百七十八", 8978)
  end

  it "八千九百七十九" do
    compare_kanji_and_integer("八千九百七十九", 8979)
  end

  it "八千九百八十" do
    compare_kanji_and_integer("八千九百八十", 8980)
  end

  it "八千九百八十一" do
    compare_kanji_and_integer("八千九百八十一", 8981)
  end

  it "八千九百八十二" do
    compare_kanji_and_integer("八千九百八十二", 8982)
  end

  it "八千九百八十三" do
    compare_kanji_and_integer("八千九百八十三", 8983)
  end

  it "八千九百八十四" do
    compare_kanji_and_integer("八千九百八十四", 8984)
  end

  it "八千九百八十五" do
    compare_kanji_and_integer("八千九百八十五", 8985)
  end

  it "八千九百八十六" do
    compare_kanji_and_integer("八千九百八十六", 8986)
  end

  it "八千九百八十七" do
    compare_kanji_and_integer("八千九百八十七", 8987)
  end

  it "八千九百八十八" do
    compare_kanji_and_integer("八千九百八十八", 8988)
  end

  it "八千九百八十九" do
    compare_kanji_and_integer("八千九百八十九", 8989)
  end

  it "八千九百九十" do
    compare_kanji_and_integer("八千九百九十", 8990)
  end

  it "八千九百九十一" do
    compare_kanji_and_integer("八千九百九十一", 8991)
  end

  it "八千九百九十二" do
    compare_kanji_and_integer("八千九百九十二", 8992)
  end

  it "八千九百九十三" do
    compare_kanji_and_integer("八千九百九十三", 8993)
  end

  it "八千九百九十四" do
    compare_kanji_and_integer("八千九百九十四", 8994)
  end

  it "八千九百九十五" do
    compare_kanji_and_integer("八千九百九十五", 8995)
  end

  it "八千九百九十六" do
    compare_kanji_and_integer("八千九百九十六", 8996)
  end

  it "八千九百九十七" do
    compare_kanji_and_integer("八千九百九十七", 8997)
  end

  it "八千九百九十八" do
    compare_kanji_and_integer("八千九百九十八", 8998)
  end

  it "八千九百九十九" do
    compare_kanji_and_integer("八千九百九十九", 8999)
  end

  it "九千" do
    compare_kanji_and_integer("九千", 9000)
  end

  it "九千一" do
    compare_kanji_and_integer("九千一", 9001)
  end

  it "九千二" do
    compare_kanji_and_integer("九千二", 9002)
  end

  it "九千三" do
    compare_kanji_and_integer("九千三", 9003)
  end

  it "九千四" do
    compare_kanji_and_integer("九千四", 9004)
  end

  it "九千五" do
    compare_kanji_and_integer("九千五", 9005)
  end

  it "九千六" do
    compare_kanji_and_integer("九千六", 9006)
  end

  it "九千七" do
    compare_kanji_and_integer("九千七", 9007)
  end

  it "九千八" do
    compare_kanji_and_integer("九千八", 9008)
  end

  it "九千九" do
    compare_kanji_and_integer("九千九", 9009)
  end

  it "九千十" do
    compare_kanji_and_integer("九千十", 9010)
  end

  it "九千十一" do
    compare_kanji_and_integer("九千十一", 9011)
  end

  it "九千十二" do
    compare_kanji_and_integer("九千十二", 9012)
  end

  it "九千十三" do
    compare_kanji_and_integer("九千十三", 9013)
  end

  it "九千十四" do
    compare_kanji_and_integer("九千十四", 9014)
  end

  it "九千十五" do
    compare_kanji_and_integer("九千十五", 9015)
  end

  it "九千十六" do
    compare_kanji_and_integer("九千十六", 9016)
  end

  it "九千十七" do
    compare_kanji_and_integer("九千十七", 9017)
  end

  it "九千十八" do
    compare_kanji_and_integer("九千十八", 9018)
  end

  it "九千十九" do
    compare_kanji_and_integer("九千十九", 9019)
  end

  it "九千二十" do
    compare_kanji_and_integer("九千二十", 9020)
  end

  it "九千二十一" do
    compare_kanji_and_integer("九千二十一", 9021)
  end

  it "九千二十二" do
    compare_kanji_and_integer("九千二十二", 9022)
  end

  it "九千二十三" do
    compare_kanji_and_integer("九千二十三", 9023)
  end

  it "九千二十四" do
    compare_kanji_and_integer("九千二十四", 9024)
  end

  it "九千二十五" do
    compare_kanji_and_integer("九千二十五", 9025)
  end

  it "九千二十六" do
    compare_kanji_and_integer("九千二十六", 9026)
  end

  it "九千二十七" do
    compare_kanji_and_integer("九千二十七", 9027)
  end

  it "九千二十八" do
    compare_kanji_and_integer("九千二十八", 9028)
  end

  it "九千二十九" do
    compare_kanji_and_integer("九千二十九", 9029)
  end

  it "九千三十" do
    compare_kanji_and_integer("九千三十", 9030)
  end

  it "九千三十一" do
    compare_kanji_and_integer("九千三十一", 9031)
  end

  it "九千三十二" do
    compare_kanji_and_integer("九千三十二", 9032)
  end

  it "九千三十三" do
    compare_kanji_and_integer("九千三十三", 9033)
  end

  it "九千三十四" do
    compare_kanji_and_integer("九千三十四", 9034)
  end

  it "九千三十五" do
    compare_kanji_and_integer("九千三十五", 9035)
  end

  it "九千三十六" do
    compare_kanji_and_integer("九千三十六", 9036)
  end

  it "九千三十七" do
    compare_kanji_and_integer("九千三十七", 9037)
  end

  it "九千三十八" do
    compare_kanji_and_integer("九千三十八", 9038)
  end

  it "九千三十九" do
    compare_kanji_and_integer("九千三十九", 9039)
  end

  it "九千四十" do
    compare_kanji_and_integer("九千四十", 9040)
  end

  it "九千四十一" do
    compare_kanji_and_integer("九千四十一", 9041)
  end

  it "九千四十二" do
    compare_kanji_and_integer("九千四十二", 9042)
  end

  it "九千四十三" do
    compare_kanji_and_integer("九千四十三", 9043)
  end

  it "九千四十四" do
    compare_kanji_and_integer("九千四十四", 9044)
  end

  it "九千四十五" do
    compare_kanji_and_integer("九千四十五", 9045)
  end

  it "九千四十六" do
    compare_kanji_and_integer("九千四十六", 9046)
  end

  it "九千四十七" do
    compare_kanji_and_integer("九千四十七", 9047)
  end

  it "九千四十八" do
    compare_kanji_and_integer("九千四十八", 9048)
  end

  it "九千四十九" do
    compare_kanji_and_integer("九千四十九", 9049)
  end

  it "九千五十" do
    compare_kanji_and_integer("九千五十", 9050)
  end

  it "九千五十一" do
    compare_kanji_and_integer("九千五十一", 9051)
  end

  it "九千五十二" do
    compare_kanji_and_integer("九千五十二", 9052)
  end

  it "九千五十三" do
    compare_kanji_and_integer("九千五十三", 9053)
  end

  it "九千五十四" do
    compare_kanji_and_integer("九千五十四", 9054)
  end

  it "九千五十五" do
    compare_kanji_and_integer("九千五十五", 9055)
  end

  it "九千五十六" do
    compare_kanji_and_integer("九千五十六", 9056)
  end

  it "九千五十七" do
    compare_kanji_and_integer("九千五十七", 9057)
  end

  it "九千五十八" do
    compare_kanji_and_integer("九千五十八", 9058)
  end

  it "九千五十九" do
    compare_kanji_and_integer("九千五十九", 9059)
  end

  it "九千六十" do
    compare_kanji_and_integer("九千六十", 9060)
  end

  it "九千六十一" do
    compare_kanji_and_integer("九千六十一", 9061)
  end

  it "九千六十二" do
    compare_kanji_and_integer("九千六十二", 9062)
  end

  it "九千六十三" do
    compare_kanji_and_integer("九千六十三", 9063)
  end

  it "九千六十四" do
    compare_kanji_and_integer("九千六十四", 9064)
  end

  it "九千六十五" do
    compare_kanji_and_integer("九千六十五", 9065)
  end

  it "九千六十六" do
    compare_kanji_and_integer("九千六十六", 9066)
  end

  it "九千六十七" do
    compare_kanji_and_integer("九千六十七", 9067)
  end

  it "九千六十八" do
    compare_kanji_and_integer("九千六十八", 9068)
  end

  it "九千六十九" do
    compare_kanji_and_integer("九千六十九", 9069)
  end

  it "九千七十" do
    compare_kanji_and_integer("九千七十", 9070)
  end

  it "九千七十一" do
    compare_kanji_and_integer("九千七十一", 9071)
  end

  it "九千七十二" do
    compare_kanji_and_integer("九千七十二", 9072)
  end

  it "九千七十三" do
    compare_kanji_and_integer("九千七十三", 9073)
  end

  it "九千七十四" do
    compare_kanji_and_integer("九千七十四", 9074)
  end

  it "九千七十五" do
    compare_kanji_and_integer("九千七十五", 9075)
  end

  it "九千七十六" do
    compare_kanji_and_integer("九千七十六", 9076)
  end

  it "九千七十七" do
    compare_kanji_and_integer("九千七十七", 9077)
  end

  it "九千七十八" do
    compare_kanji_and_integer("九千七十八", 9078)
  end

  it "九千七十九" do
    compare_kanji_and_integer("九千七十九", 9079)
  end

  it "九千八十" do
    compare_kanji_and_integer("九千八十", 9080)
  end

  it "九千八十一" do
    compare_kanji_and_integer("九千八十一", 9081)
  end

  it "九千八十二" do
    compare_kanji_and_integer("九千八十二", 9082)
  end

  it "九千八十三" do
    compare_kanji_and_integer("九千八十三", 9083)
  end

  it "九千八十四" do
    compare_kanji_and_integer("九千八十四", 9084)
  end

  it "九千八十五" do
    compare_kanji_and_integer("九千八十五", 9085)
  end

  it "九千八十六" do
    compare_kanji_and_integer("九千八十六", 9086)
  end

  it "九千八十七" do
    compare_kanji_and_integer("九千八十七", 9087)
  end

  it "九千八十八" do
    compare_kanji_and_integer("九千八十八", 9088)
  end

  it "九千八十九" do
    compare_kanji_and_integer("九千八十九", 9089)
  end

  it "九千九十" do
    compare_kanji_and_integer("九千九十", 9090)
  end

  it "九千九十一" do
    compare_kanji_and_integer("九千九十一", 9091)
  end

  it "九千九十二" do
    compare_kanji_and_integer("九千九十二", 9092)
  end

  it "九千九十三" do
    compare_kanji_and_integer("九千九十三", 9093)
  end

  it "九千九十四" do
    compare_kanji_and_integer("九千九十四", 9094)
  end

  it "九千九十五" do
    compare_kanji_and_integer("九千九十五", 9095)
  end

  it "九千九十六" do
    compare_kanji_and_integer("九千九十六", 9096)
  end

  it "九千九十七" do
    compare_kanji_and_integer("九千九十七", 9097)
  end

  it "九千九十八" do
    compare_kanji_and_integer("九千九十八", 9098)
  end

  it "九千九十九" do
    compare_kanji_and_integer("九千九十九", 9099)
  end

  it "九千百" do
    compare_kanji_and_integer("九千百", 9100)
  end

  it "九千百一" do
    compare_kanji_and_integer("九千百一", 9101)
  end

  it "九千百二" do
    compare_kanji_and_integer("九千百二", 9102)
  end

  it "九千百三" do
    compare_kanji_and_integer("九千百三", 9103)
  end

  it "九千百四" do
    compare_kanji_and_integer("九千百四", 9104)
  end

  it "九千百五" do
    compare_kanji_and_integer("九千百五", 9105)
  end

  it "九千百六" do
    compare_kanji_and_integer("九千百六", 9106)
  end

  it "九千百七" do
    compare_kanji_and_integer("九千百七", 9107)
  end

  it "九千百八" do
    compare_kanji_and_integer("九千百八", 9108)
  end

  it "九千百九" do
    compare_kanji_and_integer("九千百九", 9109)
  end

  it "九千百十" do
    compare_kanji_and_integer("九千百十", 9110)
  end

  it "九千百十一" do
    compare_kanji_and_integer("九千百十一", 9111)
  end

  it "九千百十二" do
    compare_kanji_and_integer("九千百十二", 9112)
  end

  it "九千百十三" do
    compare_kanji_and_integer("九千百十三", 9113)
  end

  it "九千百十四" do
    compare_kanji_and_integer("九千百十四", 9114)
  end

  it "九千百十五" do
    compare_kanji_and_integer("九千百十五", 9115)
  end

  it "九千百十六" do
    compare_kanji_and_integer("九千百十六", 9116)
  end

  it "九千百十七" do
    compare_kanji_and_integer("九千百十七", 9117)
  end

  it "九千百十八" do
    compare_kanji_and_integer("九千百十八", 9118)
  end

  it "九千百十九" do
    compare_kanji_and_integer("九千百十九", 9119)
  end

  it "九千百二十" do
    compare_kanji_and_integer("九千百二十", 9120)
  end

  it "九千百二十一" do
    compare_kanji_and_integer("九千百二十一", 9121)
  end

  it "九千百二十二" do
    compare_kanji_and_integer("九千百二十二", 9122)
  end

  it "九千百二十三" do
    compare_kanji_and_integer("九千百二十三", 9123)
  end

  it "九千百二十四" do
    compare_kanji_and_integer("九千百二十四", 9124)
  end

  it "九千百二十五" do
    compare_kanji_and_integer("九千百二十五", 9125)
  end

  it "九千百二十六" do
    compare_kanji_and_integer("九千百二十六", 9126)
  end

  it "九千百二十七" do
    compare_kanji_and_integer("九千百二十七", 9127)
  end

  it "九千百二十八" do
    compare_kanji_and_integer("九千百二十八", 9128)
  end

  it "九千百二十九" do
    compare_kanji_and_integer("九千百二十九", 9129)
  end

  it "九千百三十" do
    compare_kanji_and_integer("九千百三十", 9130)
  end

  it "九千百三十一" do
    compare_kanji_and_integer("九千百三十一", 9131)
  end

  it "九千百三十二" do
    compare_kanji_and_integer("九千百三十二", 9132)
  end

  it "九千百三十三" do
    compare_kanji_and_integer("九千百三十三", 9133)
  end

  it "九千百三十四" do
    compare_kanji_and_integer("九千百三十四", 9134)
  end

  it "九千百三十五" do
    compare_kanji_and_integer("九千百三十五", 9135)
  end

  it "九千百三十六" do
    compare_kanji_and_integer("九千百三十六", 9136)
  end

  it "九千百三十七" do
    compare_kanji_and_integer("九千百三十七", 9137)
  end

  it "九千百三十八" do
    compare_kanji_and_integer("九千百三十八", 9138)
  end

  it "九千百三十九" do
    compare_kanji_and_integer("九千百三十九", 9139)
  end

  it "九千百四十" do
    compare_kanji_and_integer("九千百四十", 9140)
  end

  it "九千百四十一" do
    compare_kanji_and_integer("九千百四十一", 9141)
  end

  it "九千百四十二" do
    compare_kanji_and_integer("九千百四十二", 9142)
  end

  it "九千百四十三" do
    compare_kanji_and_integer("九千百四十三", 9143)
  end

  it "九千百四十四" do
    compare_kanji_and_integer("九千百四十四", 9144)
  end

  it "九千百四十五" do
    compare_kanji_and_integer("九千百四十五", 9145)
  end

  it "九千百四十六" do
    compare_kanji_and_integer("九千百四十六", 9146)
  end

  it "九千百四十七" do
    compare_kanji_and_integer("九千百四十七", 9147)
  end

  it "九千百四十八" do
    compare_kanji_and_integer("九千百四十八", 9148)
  end

  it "九千百四十九" do
    compare_kanji_and_integer("九千百四十九", 9149)
  end

  it "九千百五十" do
    compare_kanji_and_integer("九千百五十", 9150)
  end

  it "九千百五十一" do
    compare_kanji_and_integer("九千百五十一", 9151)
  end

  it "九千百五十二" do
    compare_kanji_and_integer("九千百五十二", 9152)
  end

  it "九千百五十三" do
    compare_kanji_and_integer("九千百五十三", 9153)
  end

  it "九千百五十四" do
    compare_kanji_and_integer("九千百五十四", 9154)
  end

  it "九千百五十五" do
    compare_kanji_and_integer("九千百五十五", 9155)
  end

  it "九千百五十六" do
    compare_kanji_and_integer("九千百五十六", 9156)
  end

  it "九千百五十七" do
    compare_kanji_and_integer("九千百五十七", 9157)
  end

  it "九千百五十八" do
    compare_kanji_and_integer("九千百五十八", 9158)
  end

  it "九千百五十九" do
    compare_kanji_and_integer("九千百五十九", 9159)
  end

  it "九千百六十" do
    compare_kanji_and_integer("九千百六十", 9160)
  end

  it "九千百六十一" do
    compare_kanji_and_integer("九千百六十一", 9161)
  end

  it "九千百六十二" do
    compare_kanji_and_integer("九千百六十二", 9162)
  end

  it "九千百六十三" do
    compare_kanji_and_integer("九千百六十三", 9163)
  end

  it "九千百六十四" do
    compare_kanji_and_integer("九千百六十四", 9164)
  end

  it "九千百六十五" do
    compare_kanji_and_integer("九千百六十五", 9165)
  end

  it "九千百六十六" do
    compare_kanji_and_integer("九千百六十六", 9166)
  end

  it "九千百六十七" do
    compare_kanji_and_integer("九千百六十七", 9167)
  end

  it "九千百六十八" do
    compare_kanji_and_integer("九千百六十八", 9168)
  end

  it "九千百六十九" do
    compare_kanji_and_integer("九千百六十九", 9169)
  end

  it "九千百七十" do
    compare_kanji_and_integer("九千百七十", 9170)
  end

  it "九千百七十一" do
    compare_kanji_and_integer("九千百七十一", 9171)
  end

  it "九千百七十二" do
    compare_kanji_and_integer("九千百七十二", 9172)
  end

  it "九千百七十三" do
    compare_kanji_and_integer("九千百七十三", 9173)
  end

  it "九千百七十四" do
    compare_kanji_and_integer("九千百七十四", 9174)
  end

  it "九千百七十五" do
    compare_kanji_and_integer("九千百七十五", 9175)
  end

  it "九千百七十六" do
    compare_kanji_and_integer("九千百七十六", 9176)
  end

  it "九千百七十七" do
    compare_kanji_and_integer("九千百七十七", 9177)
  end

  it "九千百七十八" do
    compare_kanji_and_integer("九千百七十八", 9178)
  end

  it "九千百七十九" do
    compare_kanji_and_integer("九千百七十九", 9179)
  end

  it "九千百八十" do
    compare_kanji_and_integer("九千百八十", 9180)
  end

  it "九千百八十一" do
    compare_kanji_and_integer("九千百八十一", 9181)
  end

  it "九千百八十二" do
    compare_kanji_and_integer("九千百八十二", 9182)
  end

  it "九千百八十三" do
    compare_kanji_and_integer("九千百八十三", 9183)
  end

  it "九千百八十四" do
    compare_kanji_and_integer("九千百八十四", 9184)
  end

  it "九千百八十五" do
    compare_kanji_and_integer("九千百八十五", 9185)
  end

  it "九千百八十六" do
    compare_kanji_and_integer("九千百八十六", 9186)
  end

  it "九千百八十七" do
    compare_kanji_and_integer("九千百八十七", 9187)
  end

  it "九千百八十八" do
    compare_kanji_and_integer("九千百八十八", 9188)
  end

  it "九千百八十九" do
    compare_kanji_and_integer("九千百八十九", 9189)
  end

  it "九千百九十" do
    compare_kanji_and_integer("九千百九十", 9190)
  end

  it "九千百九十一" do
    compare_kanji_and_integer("九千百九十一", 9191)
  end

  it "九千百九十二" do
    compare_kanji_and_integer("九千百九十二", 9192)
  end

  it "九千百九十三" do
    compare_kanji_and_integer("九千百九十三", 9193)
  end

  it "九千百九十四" do
    compare_kanji_and_integer("九千百九十四", 9194)
  end

  it "九千百九十五" do
    compare_kanji_and_integer("九千百九十五", 9195)
  end

  it "九千百九十六" do
    compare_kanji_and_integer("九千百九十六", 9196)
  end

  it "九千百九十七" do
    compare_kanji_and_integer("九千百九十七", 9197)
  end

  it "九千百九十八" do
    compare_kanji_and_integer("九千百九十八", 9198)
  end

  it "九千百九十九" do
    compare_kanji_and_integer("九千百九十九", 9199)
  end

  it "九千二百" do
    compare_kanji_and_integer("九千二百", 9200)
  end

  it "九千二百一" do
    compare_kanji_and_integer("九千二百一", 9201)
  end

  it "九千二百二" do
    compare_kanji_and_integer("九千二百二", 9202)
  end

  it "九千二百三" do
    compare_kanji_and_integer("九千二百三", 9203)
  end

  it "九千二百四" do
    compare_kanji_and_integer("九千二百四", 9204)
  end

  it "九千二百五" do
    compare_kanji_and_integer("九千二百五", 9205)
  end

  it "九千二百六" do
    compare_kanji_and_integer("九千二百六", 9206)
  end

  it "九千二百七" do
    compare_kanji_and_integer("九千二百七", 9207)
  end

  it "九千二百八" do
    compare_kanji_and_integer("九千二百八", 9208)
  end

  it "九千二百九" do
    compare_kanji_and_integer("九千二百九", 9209)
  end

  it "九千二百十" do
    compare_kanji_and_integer("九千二百十", 9210)
  end

  it "九千二百十一" do
    compare_kanji_and_integer("九千二百十一", 9211)
  end

  it "九千二百十二" do
    compare_kanji_and_integer("九千二百十二", 9212)
  end

  it "九千二百十三" do
    compare_kanji_and_integer("九千二百十三", 9213)
  end

  it "九千二百十四" do
    compare_kanji_and_integer("九千二百十四", 9214)
  end

  it "九千二百十五" do
    compare_kanji_and_integer("九千二百十五", 9215)
  end

  it "九千二百十六" do
    compare_kanji_and_integer("九千二百十六", 9216)
  end

  it "九千二百十七" do
    compare_kanji_and_integer("九千二百十七", 9217)
  end

  it "九千二百十八" do
    compare_kanji_and_integer("九千二百十八", 9218)
  end

  it "九千二百十九" do
    compare_kanji_and_integer("九千二百十九", 9219)
  end

  it "九千二百二十" do
    compare_kanji_and_integer("九千二百二十", 9220)
  end

  it "九千二百二十一" do
    compare_kanji_and_integer("九千二百二十一", 9221)
  end

  it "九千二百二十二" do
    compare_kanji_and_integer("九千二百二十二", 9222)
  end

  it "九千二百二十三" do
    compare_kanji_and_integer("九千二百二十三", 9223)
  end

  it "九千二百二十四" do
    compare_kanji_and_integer("九千二百二十四", 9224)
  end

  it "九千二百二十五" do
    compare_kanji_and_integer("九千二百二十五", 9225)
  end

  it "九千二百二十六" do
    compare_kanji_and_integer("九千二百二十六", 9226)
  end

  it "九千二百二十七" do
    compare_kanji_and_integer("九千二百二十七", 9227)
  end

  it "九千二百二十八" do
    compare_kanji_and_integer("九千二百二十八", 9228)
  end

  it "九千二百二十九" do
    compare_kanji_and_integer("九千二百二十九", 9229)
  end

  it "九千二百三十" do
    compare_kanji_and_integer("九千二百三十", 9230)
  end

  it "九千二百三十一" do
    compare_kanji_and_integer("九千二百三十一", 9231)
  end

  it "九千二百三十二" do
    compare_kanji_and_integer("九千二百三十二", 9232)
  end

  it "九千二百三十三" do
    compare_kanji_and_integer("九千二百三十三", 9233)
  end

  it "九千二百三十四" do
    compare_kanji_and_integer("九千二百三十四", 9234)
  end

  it "九千二百三十五" do
    compare_kanji_and_integer("九千二百三十五", 9235)
  end

  it "九千二百三十六" do
    compare_kanji_and_integer("九千二百三十六", 9236)
  end

  it "九千二百三十七" do
    compare_kanji_and_integer("九千二百三十七", 9237)
  end

  it "九千二百三十八" do
    compare_kanji_and_integer("九千二百三十八", 9238)
  end

  it "九千二百三十九" do
    compare_kanji_and_integer("九千二百三十九", 9239)
  end

  it "九千二百四十" do
    compare_kanji_and_integer("九千二百四十", 9240)
  end

  it "九千二百四十一" do
    compare_kanji_and_integer("九千二百四十一", 9241)
  end

  it "九千二百四十二" do
    compare_kanji_and_integer("九千二百四十二", 9242)
  end

  it "九千二百四十三" do
    compare_kanji_and_integer("九千二百四十三", 9243)
  end

  it "九千二百四十四" do
    compare_kanji_and_integer("九千二百四十四", 9244)
  end

  it "九千二百四十五" do
    compare_kanji_and_integer("九千二百四十五", 9245)
  end

  it "九千二百四十六" do
    compare_kanji_and_integer("九千二百四十六", 9246)
  end

  it "九千二百四十七" do
    compare_kanji_and_integer("九千二百四十七", 9247)
  end

  it "九千二百四十八" do
    compare_kanji_and_integer("九千二百四十八", 9248)
  end

  it "九千二百四十九" do
    compare_kanji_and_integer("九千二百四十九", 9249)
  end

  it "九千二百五十" do
    compare_kanji_and_integer("九千二百五十", 9250)
  end

  it "九千二百五十一" do
    compare_kanji_and_integer("九千二百五十一", 9251)
  end

  it "九千二百五十二" do
    compare_kanji_and_integer("九千二百五十二", 9252)
  end

  it "九千二百五十三" do
    compare_kanji_and_integer("九千二百五十三", 9253)
  end

  it "九千二百五十四" do
    compare_kanji_and_integer("九千二百五十四", 9254)
  end

  it "九千二百五十五" do
    compare_kanji_and_integer("九千二百五十五", 9255)
  end

  it "九千二百五十六" do
    compare_kanji_and_integer("九千二百五十六", 9256)
  end

  it "九千二百五十七" do
    compare_kanji_and_integer("九千二百五十七", 9257)
  end

  it "九千二百五十八" do
    compare_kanji_and_integer("九千二百五十八", 9258)
  end

  it "九千二百五十九" do
    compare_kanji_and_integer("九千二百五十九", 9259)
  end

  it "九千二百六十" do
    compare_kanji_and_integer("九千二百六十", 9260)
  end

  it "九千二百六十一" do
    compare_kanji_and_integer("九千二百六十一", 9261)
  end

  it "九千二百六十二" do
    compare_kanji_and_integer("九千二百六十二", 9262)
  end

  it "九千二百六十三" do
    compare_kanji_and_integer("九千二百六十三", 9263)
  end

  it "九千二百六十四" do
    compare_kanji_and_integer("九千二百六十四", 9264)
  end

  it "九千二百六十五" do
    compare_kanji_and_integer("九千二百六十五", 9265)
  end

  it "九千二百六十六" do
    compare_kanji_and_integer("九千二百六十六", 9266)
  end

  it "九千二百六十七" do
    compare_kanji_and_integer("九千二百六十七", 9267)
  end

  it "九千二百六十八" do
    compare_kanji_and_integer("九千二百六十八", 9268)
  end

  it "九千二百六十九" do
    compare_kanji_and_integer("九千二百六十九", 9269)
  end

  it "九千二百七十" do
    compare_kanji_and_integer("九千二百七十", 9270)
  end

  it "九千二百七十一" do
    compare_kanji_and_integer("九千二百七十一", 9271)
  end

  it "九千二百七十二" do
    compare_kanji_and_integer("九千二百七十二", 9272)
  end

  it "九千二百七十三" do
    compare_kanji_and_integer("九千二百七十三", 9273)
  end

  it "九千二百七十四" do
    compare_kanji_and_integer("九千二百七十四", 9274)
  end

  it "九千二百七十五" do
    compare_kanji_and_integer("九千二百七十五", 9275)
  end

  it "九千二百七十六" do
    compare_kanji_and_integer("九千二百七十六", 9276)
  end

  it "九千二百七十七" do
    compare_kanji_and_integer("九千二百七十七", 9277)
  end

  it "九千二百七十八" do
    compare_kanji_and_integer("九千二百七十八", 9278)
  end

  it "九千二百七十九" do
    compare_kanji_and_integer("九千二百七十九", 9279)
  end

  it "九千二百八十" do
    compare_kanji_and_integer("九千二百八十", 9280)
  end

  it "九千二百八十一" do
    compare_kanji_and_integer("九千二百八十一", 9281)
  end

  it "九千二百八十二" do
    compare_kanji_and_integer("九千二百八十二", 9282)
  end

  it "九千二百八十三" do
    compare_kanji_and_integer("九千二百八十三", 9283)
  end

  it "九千二百八十四" do
    compare_kanji_and_integer("九千二百八十四", 9284)
  end

  it "九千二百八十五" do
    compare_kanji_and_integer("九千二百八十五", 9285)
  end

  it "九千二百八十六" do
    compare_kanji_and_integer("九千二百八十六", 9286)
  end

  it "九千二百八十七" do
    compare_kanji_and_integer("九千二百八十七", 9287)
  end

  it "九千二百八十八" do
    compare_kanji_and_integer("九千二百八十八", 9288)
  end

  it "九千二百八十九" do
    compare_kanji_and_integer("九千二百八十九", 9289)
  end

  it "九千二百九十" do
    compare_kanji_and_integer("九千二百九十", 9290)
  end

  it "九千二百九十一" do
    compare_kanji_and_integer("九千二百九十一", 9291)
  end

  it "九千二百九十二" do
    compare_kanji_and_integer("九千二百九十二", 9292)
  end

  it "九千二百九十三" do
    compare_kanji_and_integer("九千二百九十三", 9293)
  end

  it "九千二百九十四" do
    compare_kanji_and_integer("九千二百九十四", 9294)
  end

  it "九千二百九十五" do
    compare_kanji_and_integer("九千二百九十五", 9295)
  end

  it "九千二百九十六" do
    compare_kanji_and_integer("九千二百九十六", 9296)
  end

  it "九千二百九十七" do
    compare_kanji_and_integer("九千二百九十七", 9297)
  end

  it "九千二百九十八" do
    compare_kanji_and_integer("九千二百九十八", 9298)
  end

  it "九千二百九十九" do
    compare_kanji_and_integer("九千二百九十九", 9299)
  end

  it "九千三百" do
    compare_kanji_and_integer("九千三百", 9300)
  end

  it "九千三百一" do
    compare_kanji_and_integer("九千三百一", 9301)
  end

  it "九千三百二" do
    compare_kanji_and_integer("九千三百二", 9302)
  end

  it "九千三百三" do
    compare_kanji_and_integer("九千三百三", 9303)
  end

  it "九千三百四" do
    compare_kanji_and_integer("九千三百四", 9304)
  end

  it "九千三百五" do
    compare_kanji_and_integer("九千三百五", 9305)
  end

  it "九千三百六" do
    compare_kanji_and_integer("九千三百六", 9306)
  end

  it "九千三百七" do
    compare_kanji_and_integer("九千三百七", 9307)
  end

  it "九千三百八" do
    compare_kanji_and_integer("九千三百八", 9308)
  end

  it "九千三百九" do
    compare_kanji_and_integer("九千三百九", 9309)
  end

  it "九千三百十" do
    compare_kanji_and_integer("九千三百十", 9310)
  end

  it "九千三百十一" do
    compare_kanji_and_integer("九千三百十一", 9311)
  end

  it "九千三百十二" do
    compare_kanji_and_integer("九千三百十二", 9312)
  end

  it "九千三百十三" do
    compare_kanji_and_integer("九千三百十三", 9313)
  end

  it "九千三百十四" do
    compare_kanji_and_integer("九千三百十四", 9314)
  end

  it "九千三百十五" do
    compare_kanji_and_integer("九千三百十五", 9315)
  end

  it "九千三百十六" do
    compare_kanji_and_integer("九千三百十六", 9316)
  end

  it "九千三百十七" do
    compare_kanji_and_integer("九千三百十七", 9317)
  end

  it "九千三百十八" do
    compare_kanji_and_integer("九千三百十八", 9318)
  end

  it "九千三百十九" do
    compare_kanji_and_integer("九千三百十九", 9319)
  end

  it "九千三百二十" do
    compare_kanji_and_integer("九千三百二十", 9320)
  end

  it "九千三百二十一" do
    compare_kanji_and_integer("九千三百二十一", 9321)
  end

  it "九千三百二十二" do
    compare_kanji_and_integer("九千三百二十二", 9322)
  end

  it "九千三百二十三" do
    compare_kanji_and_integer("九千三百二十三", 9323)
  end

  it "九千三百二十四" do
    compare_kanji_and_integer("九千三百二十四", 9324)
  end

  it "九千三百二十五" do
    compare_kanji_and_integer("九千三百二十五", 9325)
  end

  it "九千三百二十六" do
    compare_kanji_and_integer("九千三百二十六", 9326)
  end

  it "九千三百二十七" do
    compare_kanji_and_integer("九千三百二十七", 9327)
  end

  it "九千三百二十八" do
    compare_kanji_and_integer("九千三百二十八", 9328)
  end

  it "九千三百二十九" do
    compare_kanji_and_integer("九千三百二十九", 9329)
  end

  it "九千三百三十" do
    compare_kanji_and_integer("九千三百三十", 9330)
  end

  it "九千三百三十一" do
    compare_kanji_and_integer("九千三百三十一", 9331)
  end

  it "九千三百三十二" do
    compare_kanji_and_integer("九千三百三十二", 9332)
  end

  it "九千三百三十三" do
    compare_kanji_and_integer("九千三百三十三", 9333)
  end

  it "九千三百三十四" do
    compare_kanji_and_integer("九千三百三十四", 9334)
  end

  it "九千三百三十五" do
    compare_kanji_and_integer("九千三百三十五", 9335)
  end

  it "九千三百三十六" do
    compare_kanji_and_integer("九千三百三十六", 9336)
  end

  it "九千三百三十七" do
    compare_kanji_and_integer("九千三百三十七", 9337)
  end

  it "九千三百三十八" do
    compare_kanji_and_integer("九千三百三十八", 9338)
  end

  it "九千三百三十九" do
    compare_kanji_and_integer("九千三百三十九", 9339)
  end

  it "九千三百四十" do
    compare_kanji_and_integer("九千三百四十", 9340)
  end

  it "九千三百四十一" do
    compare_kanji_and_integer("九千三百四十一", 9341)
  end

  it "九千三百四十二" do
    compare_kanji_and_integer("九千三百四十二", 9342)
  end

  it "九千三百四十三" do
    compare_kanji_and_integer("九千三百四十三", 9343)
  end

  it "九千三百四十四" do
    compare_kanji_and_integer("九千三百四十四", 9344)
  end

  it "九千三百四十五" do
    compare_kanji_and_integer("九千三百四十五", 9345)
  end

  it "九千三百四十六" do
    compare_kanji_and_integer("九千三百四十六", 9346)
  end

  it "九千三百四十七" do
    compare_kanji_and_integer("九千三百四十七", 9347)
  end

  it "九千三百四十八" do
    compare_kanji_and_integer("九千三百四十八", 9348)
  end

  it "九千三百四十九" do
    compare_kanji_and_integer("九千三百四十九", 9349)
  end

  it "九千三百五十" do
    compare_kanji_and_integer("九千三百五十", 9350)
  end

  it "九千三百五十一" do
    compare_kanji_and_integer("九千三百五十一", 9351)
  end

  it "九千三百五十二" do
    compare_kanji_and_integer("九千三百五十二", 9352)
  end

  it "九千三百五十三" do
    compare_kanji_and_integer("九千三百五十三", 9353)
  end

  it "九千三百五十四" do
    compare_kanji_and_integer("九千三百五十四", 9354)
  end

  it "九千三百五十五" do
    compare_kanji_and_integer("九千三百五十五", 9355)
  end

  it "九千三百五十六" do
    compare_kanji_and_integer("九千三百五十六", 9356)
  end

  it "九千三百五十七" do
    compare_kanji_and_integer("九千三百五十七", 9357)
  end

  it "九千三百五十八" do
    compare_kanji_and_integer("九千三百五十八", 9358)
  end

  it "九千三百五十九" do
    compare_kanji_and_integer("九千三百五十九", 9359)
  end

  it "九千三百六十" do
    compare_kanji_and_integer("九千三百六十", 9360)
  end

  it "九千三百六十一" do
    compare_kanji_and_integer("九千三百六十一", 9361)
  end

  it "九千三百六十二" do
    compare_kanji_and_integer("九千三百六十二", 9362)
  end

  it "九千三百六十三" do
    compare_kanji_and_integer("九千三百六十三", 9363)
  end

  it "九千三百六十四" do
    compare_kanji_and_integer("九千三百六十四", 9364)
  end

  it "九千三百六十五" do
    compare_kanji_and_integer("九千三百六十五", 9365)
  end

  it "九千三百六十六" do
    compare_kanji_and_integer("九千三百六十六", 9366)
  end

  it "九千三百六十七" do
    compare_kanji_and_integer("九千三百六十七", 9367)
  end

  it "九千三百六十八" do
    compare_kanji_and_integer("九千三百六十八", 9368)
  end

  it "九千三百六十九" do
    compare_kanji_and_integer("九千三百六十九", 9369)
  end

  it "九千三百七十" do
    compare_kanji_and_integer("九千三百七十", 9370)
  end

  it "九千三百七十一" do
    compare_kanji_and_integer("九千三百七十一", 9371)
  end

  it "九千三百七十二" do
    compare_kanji_and_integer("九千三百七十二", 9372)
  end

  it "九千三百七十三" do
    compare_kanji_and_integer("九千三百七十三", 9373)
  end

  it "九千三百七十四" do
    compare_kanji_and_integer("九千三百七十四", 9374)
  end

  it "九千三百七十五" do
    compare_kanji_and_integer("九千三百七十五", 9375)
  end

  it "九千三百七十六" do
    compare_kanji_and_integer("九千三百七十六", 9376)
  end

  it "九千三百七十七" do
    compare_kanji_and_integer("九千三百七十七", 9377)
  end

  it "九千三百七十八" do
    compare_kanji_and_integer("九千三百七十八", 9378)
  end

  it "九千三百七十九" do
    compare_kanji_and_integer("九千三百七十九", 9379)
  end

  it "九千三百八十" do
    compare_kanji_and_integer("九千三百八十", 9380)
  end

  it "九千三百八十一" do
    compare_kanji_and_integer("九千三百八十一", 9381)
  end

  it "九千三百八十二" do
    compare_kanji_and_integer("九千三百八十二", 9382)
  end

  it "九千三百八十三" do
    compare_kanji_and_integer("九千三百八十三", 9383)
  end

  it "九千三百八十四" do
    compare_kanji_and_integer("九千三百八十四", 9384)
  end

  it "九千三百八十五" do
    compare_kanji_and_integer("九千三百八十五", 9385)
  end

  it "九千三百八十六" do
    compare_kanji_and_integer("九千三百八十六", 9386)
  end

  it "九千三百八十七" do
    compare_kanji_and_integer("九千三百八十七", 9387)
  end

  it "九千三百八十八" do
    compare_kanji_and_integer("九千三百八十八", 9388)
  end

  it "九千三百八十九" do
    compare_kanji_and_integer("九千三百八十九", 9389)
  end

  it "九千三百九十" do
    compare_kanji_and_integer("九千三百九十", 9390)
  end

  it "九千三百九十一" do
    compare_kanji_and_integer("九千三百九十一", 9391)
  end

  it "九千三百九十二" do
    compare_kanji_and_integer("九千三百九十二", 9392)
  end

  it "九千三百九十三" do
    compare_kanji_and_integer("九千三百九十三", 9393)
  end

  it "九千三百九十四" do
    compare_kanji_and_integer("九千三百九十四", 9394)
  end

  it "九千三百九十五" do
    compare_kanji_and_integer("九千三百九十五", 9395)
  end

  it "九千三百九十六" do
    compare_kanji_and_integer("九千三百九十六", 9396)
  end

  it "九千三百九十七" do
    compare_kanji_and_integer("九千三百九十七", 9397)
  end

  it "九千三百九十八" do
    compare_kanji_and_integer("九千三百九十八", 9398)
  end

  it "九千三百九十九" do
    compare_kanji_and_integer("九千三百九十九", 9399)
  end

  it "九千四百" do
    compare_kanji_and_integer("九千四百", 9400)
  end

  it "九千四百一" do
    compare_kanji_and_integer("九千四百一", 9401)
  end

  it "九千四百二" do
    compare_kanji_and_integer("九千四百二", 9402)
  end

  it "九千四百三" do
    compare_kanji_and_integer("九千四百三", 9403)
  end

  it "九千四百四" do
    compare_kanji_and_integer("九千四百四", 9404)
  end

  it "九千四百五" do
    compare_kanji_and_integer("九千四百五", 9405)
  end

  it "九千四百六" do
    compare_kanji_and_integer("九千四百六", 9406)
  end

  it "九千四百七" do
    compare_kanji_and_integer("九千四百七", 9407)
  end

  it "九千四百八" do
    compare_kanji_and_integer("九千四百八", 9408)
  end

  it "九千四百九" do
    compare_kanji_and_integer("九千四百九", 9409)
  end

  it "九千四百十" do
    compare_kanji_and_integer("九千四百十", 9410)
  end

  it "九千四百十一" do
    compare_kanji_and_integer("九千四百十一", 9411)
  end

  it "九千四百十二" do
    compare_kanji_and_integer("九千四百十二", 9412)
  end

  it "九千四百十三" do
    compare_kanji_and_integer("九千四百十三", 9413)
  end

  it "九千四百十四" do
    compare_kanji_and_integer("九千四百十四", 9414)
  end

  it "九千四百十五" do
    compare_kanji_and_integer("九千四百十五", 9415)
  end

  it "九千四百十六" do
    compare_kanji_and_integer("九千四百十六", 9416)
  end

  it "九千四百十七" do
    compare_kanji_and_integer("九千四百十七", 9417)
  end

  it "九千四百十八" do
    compare_kanji_and_integer("九千四百十八", 9418)
  end

  it "九千四百十九" do
    compare_kanji_and_integer("九千四百十九", 9419)
  end

  it "九千四百二十" do
    compare_kanji_and_integer("九千四百二十", 9420)
  end

  it "九千四百二十一" do
    compare_kanji_and_integer("九千四百二十一", 9421)
  end

  it "九千四百二十二" do
    compare_kanji_and_integer("九千四百二十二", 9422)
  end

  it "九千四百二十三" do
    compare_kanji_and_integer("九千四百二十三", 9423)
  end

  it "九千四百二十四" do
    compare_kanji_and_integer("九千四百二十四", 9424)
  end

  it "九千四百二十五" do
    compare_kanji_and_integer("九千四百二十五", 9425)
  end

  it "九千四百二十六" do
    compare_kanji_and_integer("九千四百二十六", 9426)
  end

  it "九千四百二十七" do
    compare_kanji_and_integer("九千四百二十七", 9427)
  end

  it "九千四百二十八" do
    compare_kanji_and_integer("九千四百二十八", 9428)
  end

  it "九千四百二十九" do
    compare_kanji_and_integer("九千四百二十九", 9429)
  end

  it "九千四百三十" do
    compare_kanji_and_integer("九千四百三十", 9430)
  end

  it "九千四百三十一" do
    compare_kanji_and_integer("九千四百三十一", 9431)
  end

  it "九千四百三十二" do
    compare_kanji_and_integer("九千四百三十二", 9432)
  end

  it "九千四百三十三" do
    compare_kanji_and_integer("九千四百三十三", 9433)
  end

  it "九千四百三十四" do
    compare_kanji_and_integer("九千四百三十四", 9434)
  end

  it "九千四百三十五" do
    compare_kanji_and_integer("九千四百三十五", 9435)
  end

  it "九千四百三十六" do
    compare_kanji_and_integer("九千四百三十六", 9436)
  end

  it "九千四百三十七" do
    compare_kanji_and_integer("九千四百三十七", 9437)
  end

  it "九千四百三十八" do
    compare_kanji_and_integer("九千四百三十八", 9438)
  end

  it "九千四百三十九" do
    compare_kanji_and_integer("九千四百三十九", 9439)
  end

  it "九千四百四十" do
    compare_kanji_and_integer("九千四百四十", 9440)
  end

  it "九千四百四十一" do
    compare_kanji_and_integer("九千四百四十一", 9441)
  end

  it "九千四百四十二" do
    compare_kanji_and_integer("九千四百四十二", 9442)
  end

  it "九千四百四十三" do
    compare_kanji_and_integer("九千四百四十三", 9443)
  end

  it "九千四百四十四" do
    compare_kanji_and_integer("九千四百四十四", 9444)
  end

  it "九千四百四十五" do
    compare_kanji_and_integer("九千四百四十五", 9445)
  end

  it "九千四百四十六" do
    compare_kanji_and_integer("九千四百四十六", 9446)
  end

  it "九千四百四十七" do
    compare_kanji_and_integer("九千四百四十七", 9447)
  end

  it "九千四百四十八" do
    compare_kanji_and_integer("九千四百四十八", 9448)
  end

  it "九千四百四十九" do
    compare_kanji_and_integer("九千四百四十九", 9449)
  end

  it "九千四百五十" do
    compare_kanji_and_integer("九千四百五十", 9450)
  end

  it "九千四百五十一" do
    compare_kanji_and_integer("九千四百五十一", 9451)
  end

  it "九千四百五十二" do
    compare_kanji_and_integer("九千四百五十二", 9452)
  end

  it "九千四百五十三" do
    compare_kanji_and_integer("九千四百五十三", 9453)
  end

  it "九千四百五十四" do
    compare_kanji_and_integer("九千四百五十四", 9454)
  end

  it "九千四百五十五" do
    compare_kanji_and_integer("九千四百五十五", 9455)
  end

  it "九千四百五十六" do
    compare_kanji_and_integer("九千四百五十六", 9456)
  end

  it "九千四百五十七" do
    compare_kanji_and_integer("九千四百五十七", 9457)
  end

  it "九千四百五十八" do
    compare_kanji_and_integer("九千四百五十八", 9458)
  end

  it "九千四百五十九" do
    compare_kanji_and_integer("九千四百五十九", 9459)
  end

  it "九千四百六十" do
    compare_kanji_and_integer("九千四百六十", 9460)
  end

  it "九千四百六十一" do
    compare_kanji_and_integer("九千四百六十一", 9461)
  end

  it "九千四百六十二" do
    compare_kanji_and_integer("九千四百六十二", 9462)
  end

  it "九千四百六十三" do
    compare_kanji_and_integer("九千四百六十三", 9463)
  end

  it "九千四百六十四" do
    compare_kanji_and_integer("九千四百六十四", 9464)
  end

  it "九千四百六十五" do
    compare_kanji_and_integer("九千四百六十五", 9465)
  end

  it "九千四百六十六" do
    compare_kanji_and_integer("九千四百六十六", 9466)
  end

  it "九千四百六十七" do
    compare_kanji_and_integer("九千四百六十七", 9467)
  end

  it "九千四百六十八" do
    compare_kanji_and_integer("九千四百六十八", 9468)
  end

  it "九千四百六十九" do
    compare_kanji_and_integer("九千四百六十九", 9469)
  end

  it "九千四百七十" do
    compare_kanji_and_integer("九千四百七十", 9470)
  end

  it "九千四百七十一" do
    compare_kanji_and_integer("九千四百七十一", 9471)
  end

  it "九千四百七十二" do
    compare_kanji_and_integer("九千四百七十二", 9472)
  end

  it "九千四百七十三" do
    compare_kanji_and_integer("九千四百七十三", 9473)
  end

  it "九千四百七十四" do
    compare_kanji_and_integer("九千四百七十四", 9474)
  end

  it "九千四百七十五" do
    compare_kanji_and_integer("九千四百七十五", 9475)
  end

  it "九千四百七十六" do
    compare_kanji_and_integer("九千四百七十六", 9476)
  end

  it "九千四百七十七" do
    compare_kanji_and_integer("九千四百七十七", 9477)
  end

  it "九千四百七十八" do
    compare_kanji_and_integer("九千四百七十八", 9478)
  end

  it "九千四百七十九" do
    compare_kanji_and_integer("九千四百七十九", 9479)
  end

  it "九千四百八十" do
    compare_kanji_and_integer("九千四百八十", 9480)
  end

  it "九千四百八十一" do
    compare_kanji_and_integer("九千四百八十一", 9481)
  end

  it "九千四百八十二" do
    compare_kanji_and_integer("九千四百八十二", 9482)
  end

  it "九千四百八十三" do
    compare_kanji_and_integer("九千四百八十三", 9483)
  end

  it "九千四百八十四" do
    compare_kanji_and_integer("九千四百八十四", 9484)
  end

  it "九千四百八十五" do
    compare_kanji_and_integer("九千四百八十五", 9485)
  end

  it "九千四百八十六" do
    compare_kanji_and_integer("九千四百八十六", 9486)
  end

  it "九千四百八十七" do
    compare_kanji_and_integer("九千四百八十七", 9487)
  end

  it "九千四百八十八" do
    compare_kanji_and_integer("九千四百八十八", 9488)
  end

  it "九千四百八十九" do
    compare_kanji_and_integer("九千四百八十九", 9489)
  end

  it "九千四百九十" do
    compare_kanji_and_integer("九千四百九十", 9490)
  end

  it "九千四百九十一" do
    compare_kanji_and_integer("九千四百九十一", 9491)
  end

  it "九千四百九十二" do
    compare_kanji_and_integer("九千四百九十二", 9492)
  end

  it "九千四百九十三" do
    compare_kanji_and_integer("九千四百九十三", 9493)
  end

  it "九千四百九十四" do
    compare_kanji_and_integer("九千四百九十四", 9494)
  end

  it "九千四百九十五" do
    compare_kanji_and_integer("九千四百九十五", 9495)
  end

  it "九千四百九十六" do
    compare_kanji_and_integer("九千四百九十六", 9496)
  end

  it "九千四百九十七" do
    compare_kanji_and_integer("九千四百九十七", 9497)
  end

  it "九千四百九十八" do
    compare_kanji_and_integer("九千四百九十八", 9498)
  end

  it "九千四百九十九" do
    compare_kanji_and_integer("九千四百九十九", 9499)
  end

  it "九千五百" do
    compare_kanji_and_integer("九千五百", 9500)
  end

  it "九千五百一" do
    compare_kanji_and_integer("九千五百一", 9501)
  end

  it "九千五百二" do
    compare_kanji_and_integer("九千五百二", 9502)
  end

  it "九千五百三" do
    compare_kanji_and_integer("九千五百三", 9503)
  end

  it "九千五百四" do
    compare_kanji_and_integer("九千五百四", 9504)
  end

  it "九千五百五" do
    compare_kanji_and_integer("九千五百五", 9505)
  end

  it "九千五百六" do
    compare_kanji_and_integer("九千五百六", 9506)
  end

  it "九千五百七" do
    compare_kanji_and_integer("九千五百七", 9507)
  end

  it "九千五百八" do
    compare_kanji_and_integer("九千五百八", 9508)
  end

  it "九千五百九" do
    compare_kanji_and_integer("九千五百九", 9509)
  end

  it "九千五百十" do
    compare_kanji_and_integer("九千五百十", 9510)
  end

  it "九千五百十一" do
    compare_kanji_and_integer("九千五百十一", 9511)
  end

  it "九千五百十二" do
    compare_kanji_and_integer("九千五百十二", 9512)
  end

  it "九千五百十三" do
    compare_kanji_and_integer("九千五百十三", 9513)
  end

  it "九千五百十四" do
    compare_kanji_and_integer("九千五百十四", 9514)
  end

  it "九千五百十五" do
    compare_kanji_and_integer("九千五百十五", 9515)
  end

  it "九千五百十六" do
    compare_kanji_and_integer("九千五百十六", 9516)
  end

  it "九千五百十七" do
    compare_kanji_and_integer("九千五百十七", 9517)
  end

  it "九千五百十八" do
    compare_kanji_and_integer("九千五百十八", 9518)
  end

  it "九千五百十九" do
    compare_kanji_and_integer("九千五百十九", 9519)
  end

  it "九千五百二十" do
    compare_kanji_and_integer("九千五百二十", 9520)
  end

  it "九千五百二十一" do
    compare_kanji_and_integer("九千五百二十一", 9521)
  end

  it "九千五百二十二" do
    compare_kanji_and_integer("九千五百二十二", 9522)
  end

  it "九千五百二十三" do
    compare_kanji_and_integer("九千五百二十三", 9523)
  end

  it "九千五百二十四" do
    compare_kanji_and_integer("九千五百二十四", 9524)
  end

  it "九千五百二十五" do
    compare_kanji_and_integer("九千五百二十五", 9525)
  end

  it "九千五百二十六" do
    compare_kanji_and_integer("九千五百二十六", 9526)
  end

  it "九千五百二十七" do
    compare_kanji_and_integer("九千五百二十七", 9527)
  end

  it "九千五百二十八" do
    compare_kanji_and_integer("九千五百二十八", 9528)
  end

  it "九千五百二十九" do
    compare_kanji_and_integer("九千五百二十九", 9529)
  end

  it "九千五百三十" do
    compare_kanji_and_integer("九千五百三十", 9530)
  end

  it "九千五百三十一" do
    compare_kanji_and_integer("九千五百三十一", 9531)
  end

  it "九千五百三十二" do
    compare_kanji_and_integer("九千五百三十二", 9532)
  end

  it "九千五百三十三" do
    compare_kanji_and_integer("九千五百三十三", 9533)
  end

  it "九千五百三十四" do
    compare_kanji_and_integer("九千五百三十四", 9534)
  end

  it "九千五百三十五" do
    compare_kanji_and_integer("九千五百三十五", 9535)
  end

  it "九千五百三十六" do
    compare_kanji_and_integer("九千五百三十六", 9536)
  end

  it "九千五百三十七" do
    compare_kanji_and_integer("九千五百三十七", 9537)
  end

  it "九千五百三十八" do
    compare_kanji_and_integer("九千五百三十八", 9538)
  end

  it "九千五百三十九" do
    compare_kanji_and_integer("九千五百三十九", 9539)
  end

  it "九千五百四十" do
    compare_kanji_and_integer("九千五百四十", 9540)
  end

  it "九千五百四十一" do
    compare_kanji_and_integer("九千五百四十一", 9541)
  end

  it "九千五百四十二" do
    compare_kanji_and_integer("九千五百四十二", 9542)
  end

  it "九千五百四十三" do
    compare_kanji_and_integer("九千五百四十三", 9543)
  end

  it "九千五百四十四" do
    compare_kanji_and_integer("九千五百四十四", 9544)
  end

  it "九千五百四十五" do
    compare_kanji_and_integer("九千五百四十五", 9545)
  end

  it "九千五百四十六" do
    compare_kanji_and_integer("九千五百四十六", 9546)
  end

  it "九千五百四十七" do
    compare_kanji_and_integer("九千五百四十七", 9547)
  end

  it "九千五百四十八" do
    compare_kanji_and_integer("九千五百四十八", 9548)
  end

  it "九千五百四十九" do
    compare_kanji_and_integer("九千五百四十九", 9549)
  end

  it "九千五百五十" do
    compare_kanji_and_integer("九千五百五十", 9550)
  end

  it "九千五百五十一" do
    compare_kanji_and_integer("九千五百五十一", 9551)
  end

  it "九千五百五十二" do
    compare_kanji_and_integer("九千五百五十二", 9552)
  end

  it "九千五百五十三" do
    compare_kanji_and_integer("九千五百五十三", 9553)
  end

  it "九千五百五十四" do
    compare_kanji_and_integer("九千五百五十四", 9554)
  end

  it "九千五百五十五" do
    compare_kanji_and_integer("九千五百五十五", 9555)
  end

  it "九千五百五十六" do
    compare_kanji_and_integer("九千五百五十六", 9556)
  end

  it "九千五百五十七" do
    compare_kanji_and_integer("九千五百五十七", 9557)
  end

  it "九千五百五十八" do
    compare_kanji_and_integer("九千五百五十八", 9558)
  end

  it "九千五百五十九" do
    compare_kanji_and_integer("九千五百五十九", 9559)
  end

  it "九千五百六十" do
    compare_kanji_and_integer("九千五百六十", 9560)
  end

  it "九千五百六十一" do
    compare_kanji_and_integer("九千五百六十一", 9561)
  end

  it "九千五百六十二" do
    compare_kanji_and_integer("九千五百六十二", 9562)
  end

  it "九千五百六十三" do
    compare_kanji_and_integer("九千五百六十三", 9563)
  end

  it "九千五百六十四" do
    compare_kanji_and_integer("九千五百六十四", 9564)
  end

  it "九千五百六十五" do
    compare_kanji_and_integer("九千五百六十五", 9565)
  end

  it "九千五百六十六" do
    compare_kanji_and_integer("九千五百六十六", 9566)
  end

  it "九千五百六十七" do
    compare_kanji_and_integer("九千五百六十七", 9567)
  end

  it "九千五百六十八" do
    compare_kanji_and_integer("九千五百六十八", 9568)
  end

  it "九千五百六十九" do
    compare_kanji_and_integer("九千五百六十九", 9569)
  end

  it "九千五百七十" do
    compare_kanji_and_integer("九千五百七十", 9570)
  end

  it "九千五百七十一" do
    compare_kanji_and_integer("九千五百七十一", 9571)
  end

  it "九千五百七十二" do
    compare_kanji_and_integer("九千五百七十二", 9572)
  end

  it "九千五百七十三" do
    compare_kanji_and_integer("九千五百七十三", 9573)
  end

  it "九千五百七十四" do
    compare_kanji_and_integer("九千五百七十四", 9574)
  end

  it "九千五百七十五" do
    compare_kanji_and_integer("九千五百七十五", 9575)
  end

  it "九千五百七十六" do
    compare_kanji_and_integer("九千五百七十六", 9576)
  end

  it "九千五百七十七" do
    compare_kanji_and_integer("九千五百七十七", 9577)
  end

  it "九千五百七十八" do
    compare_kanji_and_integer("九千五百七十八", 9578)
  end

  it "九千五百七十九" do
    compare_kanji_and_integer("九千五百七十九", 9579)
  end

  it "九千五百八十" do
    compare_kanji_and_integer("九千五百八十", 9580)
  end

  it "九千五百八十一" do
    compare_kanji_and_integer("九千五百八十一", 9581)
  end

  it "九千五百八十二" do
    compare_kanji_and_integer("九千五百八十二", 9582)
  end

  it "九千五百八十三" do
    compare_kanji_and_integer("九千五百八十三", 9583)
  end

  it "九千五百八十四" do
    compare_kanji_and_integer("九千五百八十四", 9584)
  end

  it "九千五百八十五" do
    compare_kanji_and_integer("九千五百八十五", 9585)
  end

  it "九千五百八十六" do
    compare_kanji_and_integer("九千五百八十六", 9586)
  end

  it "九千五百八十七" do
    compare_kanji_and_integer("九千五百八十七", 9587)
  end

  it "九千五百八十八" do
    compare_kanji_and_integer("九千五百八十八", 9588)
  end

  it "九千五百八十九" do
    compare_kanji_and_integer("九千五百八十九", 9589)
  end

  it "九千五百九十" do
    compare_kanji_and_integer("九千五百九十", 9590)
  end

  it "九千五百九十一" do
    compare_kanji_and_integer("九千五百九十一", 9591)
  end

  it "九千五百九十二" do
    compare_kanji_and_integer("九千五百九十二", 9592)
  end

  it "九千五百九十三" do
    compare_kanji_and_integer("九千五百九十三", 9593)
  end

  it "九千五百九十四" do
    compare_kanji_and_integer("九千五百九十四", 9594)
  end

  it "九千五百九十五" do
    compare_kanji_and_integer("九千五百九十五", 9595)
  end

  it "九千五百九十六" do
    compare_kanji_and_integer("九千五百九十六", 9596)
  end

  it "九千五百九十七" do
    compare_kanji_and_integer("九千五百九十七", 9597)
  end

  it "九千五百九十八" do
    compare_kanji_and_integer("九千五百九十八", 9598)
  end

  it "九千五百九十九" do
    compare_kanji_and_integer("九千五百九十九", 9599)
  end

  it "九千六百" do
    compare_kanji_and_integer("九千六百", 9600)
  end

  it "九千六百一" do
    compare_kanji_and_integer("九千六百一", 9601)
  end

  it "九千六百二" do
    compare_kanji_and_integer("九千六百二", 9602)
  end

  it "九千六百三" do
    compare_kanji_and_integer("九千六百三", 9603)
  end

  it "九千六百四" do
    compare_kanji_and_integer("九千六百四", 9604)
  end

  it "九千六百五" do
    compare_kanji_and_integer("九千六百五", 9605)
  end

  it "九千六百六" do
    compare_kanji_and_integer("九千六百六", 9606)
  end

  it "九千六百七" do
    compare_kanji_and_integer("九千六百七", 9607)
  end

  it "九千六百八" do
    compare_kanji_and_integer("九千六百八", 9608)
  end

  it "九千六百九" do
    compare_kanji_and_integer("九千六百九", 9609)
  end

  it "九千六百十" do
    compare_kanji_and_integer("九千六百十", 9610)
  end

  it "九千六百十一" do
    compare_kanji_and_integer("九千六百十一", 9611)
  end

  it "九千六百十二" do
    compare_kanji_and_integer("九千六百十二", 9612)
  end

  it "九千六百十三" do
    compare_kanji_and_integer("九千六百十三", 9613)
  end

  it "九千六百十四" do
    compare_kanji_and_integer("九千六百十四", 9614)
  end

  it "九千六百十五" do
    compare_kanji_and_integer("九千六百十五", 9615)
  end

  it "九千六百十六" do
    compare_kanji_and_integer("九千六百十六", 9616)
  end

  it "九千六百十七" do
    compare_kanji_and_integer("九千六百十七", 9617)
  end

  it "九千六百十八" do
    compare_kanji_and_integer("九千六百十八", 9618)
  end

  it "九千六百十九" do
    compare_kanji_and_integer("九千六百十九", 9619)
  end

  it "九千六百二十" do
    compare_kanji_and_integer("九千六百二十", 9620)
  end

  it "九千六百二十一" do
    compare_kanji_and_integer("九千六百二十一", 9621)
  end

  it "九千六百二十二" do
    compare_kanji_and_integer("九千六百二十二", 9622)
  end

  it "九千六百二十三" do
    compare_kanji_and_integer("九千六百二十三", 9623)
  end

  it "九千六百二十四" do
    compare_kanji_and_integer("九千六百二十四", 9624)
  end

  it "九千六百二十五" do
    compare_kanji_and_integer("九千六百二十五", 9625)
  end

  it "九千六百二十六" do
    compare_kanji_and_integer("九千六百二十六", 9626)
  end

  it "九千六百二十七" do
    compare_kanji_and_integer("九千六百二十七", 9627)
  end

  it "九千六百二十八" do
    compare_kanji_and_integer("九千六百二十八", 9628)
  end

  it "九千六百二十九" do
    compare_kanji_and_integer("九千六百二十九", 9629)
  end

  it "九千六百三十" do
    compare_kanji_and_integer("九千六百三十", 9630)
  end

  it "九千六百三十一" do
    compare_kanji_and_integer("九千六百三十一", 9631)
  end

  it "九千六百三十二" do
    compare_kanji_and_integer("九千六百三十二", 9632)
  end

  it "九千六百三十三" do
    compare_kanji_and_integer("九千六百三十三", 9633)
  end

  it "九千六百三十四" do
    compare_kanji_and_integer("九千六百三十四", 9634)
  end

  it "九千六百三十五" do
    compare_kanji_and_integer("九千六百三十五", 9635)
  end

  it "九千六百三十六" do
    compare_kanji_and_integer("九千六百三十六", 9636)
  end

  it "九千六百三十七" do
    compare_kanji_and_integer("九千六百三十七", 9637)
  end

  it "九千六百三十八" do
    compare_kanji_and_integer("九千六百三十八", 9638)
  end

  it "九千六百三十九" do
    compare_kanji_and_integer("九千六百三十九", 9639)
  end

  it "九千六百四十" do
    compare_kanji_and_integer("九千六百四十", 9640)
  end

  it "九千六百四十一" do
    compare_kanji_and_integer("九千六百四十一", 9641)
  end

  it "九千六百四十二" do
    compare_kanji_and_integer("九千六百四十二", 9642)
  end

  it "九千六百四十三" do
    compare_kanji_and_integer("九千六百四十三", 9643)
  end

  it "九千六百四十四" do
    compare_kanji_and_integer("九千六百四十四", 9644)
  end

  it "九千六百四十五" do
    compare_kanji_and_integer("九千六百四十五", 9645)
  end

  it "九千六百四十六" do
    compare_kanji_and_integer("九千六百四十六", 9646)
  end

  it "九千六百四十七" do
    compare_kanji_and_integer("九千六百四十七", 9647)
  end

  it "九千六百四十八" do
    compare_kanji_and_integer("九千六百四十八", 9648)
  end

  it "九千六百四十九" do
    compare_kanji_and_integer("九千六百四十九", 9649)
  end

  it "九千六百五十" do
    compare_kanji_and_integer("九千六百五十", 9650)
  end

  it "九千六百五十一" do
    compare_kanji_and_integer("九千六百五十一", 9651)
  end

  it "九千六百五十二" do
    compare_kanji_and_integer("九千六百五十二", 9652)
  end

  it "九千六百五十三" do
    compare_kanji_and_integer("九千六百五十三", 9653)
  end

  it "九千六百五十四" do
    compare_kanji_and_integer("九千六百五十四", 9654)
  end

  it "九千六百五十五" do
    compare_kanji_and_integer("九千六百五十五", 9655)
  end

  it "九千六百五十六" do
    compare_kanji_and_integer("九千六百五十六", 9656)
  end

  it "九千六百五十七" do
    compare_kanji_and_integer("九千六百五十七", 9657)
  end

  it "九千六百五十八" do
    compare_kanji_and_integer("九千六百五十八", 9658)
  end

  it "九千六百五十九" do
    compare_kanji_and_integer("九千六百五十九", 9659)
  end

  it "九千六百六十" do
    compare_kanji_and_integer("九千六百六十", 9660)
  end

  it "九千六百六十一" do
    compare_kanji_and_integer("九千六百六十一", 9661)
  end

  it "九千六百六十二" do
    compare_kanji_and_integer("九千六百六十二", 9662)
  end

  it "九千六百六十三" do
    compare_kanji_and_integer("九千六百六十三", 9663)
  end

  it "九千六百六十四" do
    compare_kanji_and_integer("九千六百六十四", 9664)
  end

  it "九千六百六十五" do
    compare_kanji_and_integer("九千六百六十五", 9665)
  end

  it "九千六百六十六" do
    compare_kanji_and_integer("九千六百六十六", 9666)
  end

  it "九千六百六十七" do
    compare_kanji_and_integer("九千六百六十七", 9667)
  end

  it "九千六百六十八" do
    compare_kanji_and_integer("九千六百六十八", 9668)
  end

  it "九千六百六十九" do
    compare_kanji_and_integer("九千六百六十九", 9669)
  end

  it "九千六百七十" do
    compare_kanji_and_integer("九千六百七十", 9670)
  end

  it "九千六百七十一" do
    compare_kanji_and_integer("九千六百七十一", 9671)
  end

  it "九千六百七十二" do
    compare_kanji_and_integer("九千六百七十二", 9672)
  end

  it "九千六百七十三" do
    compare_kanji_and_integer("九千六百七十三", 9673)
  end

  it "九千六百七十四" do
    compare_kanji_and_integer("九千六百七十四", 9674)
  end

  it "九千六百七十五" do
    compare_kanji_and_integer("九千六百七十五", 9675)
  end

  it "九千六百七十六" do
    compare_kanji_and_integer("九千六百七十六", 9676)
  end

  it "九千六百七十七" do
    compare_kanji_and_integer("九千六百七十七", 9677)
  end

  it "九千六百七十八" do
    compare_kanji_and_integer("九千六百七十八", 9678)
  end

  it "九千六百七十九" do
    compare_kanji_and_integer("九千六百七十九", 9679)
  end

  it "九千六百八十" do
    compare_kanji_and_integer("九千六百八十", 9680)
  end

  it "九千六百八十一" do
    compare_kanji_and_integer("九千六百八十一", 9681)
  end

  it "九千六百八十二" do
    compare_kanji_and_integer("九千六百八十二", 9682)
  end

  it "九千六百八十三" do
    compare_kanji_and_integer("九千六百八十三", 9683)
  end

  it "九千六百八十四" do
    compare_kanji_and_integer("九千六百八十四", 9684)
  end

  it "九千六百八十五" do
    compare_kanji_and_integer("九千六百八十五", 9685)
  end

  it "九千六百八十六" do
    compare_kanji_and_integer("九千六百八十六", 9686)
  end

  it "九千六百八十七" do
    compare_kanji_and_integer("九千六百八十七", 9687)
  end

  it "九千六百八十八" do
    compare_kanji_and_integer("九千六百八十八", 9688)
  end

  it "九千六百八十九" do
    compare_kanji_and_integer("九千六百八十九", 9689)
  end

  it "九千六百九十" do
    compare_kanji_and_integer("九千六百九十", 9690)
  end

  it "九千六百九十一" do
    compare_kanji_and_integer("九千六百九十一", 9691)
  end

  it "九千六百九十二" do
    compare_kanji_and_integer("九千六百九十二", 9692)
  end

  it "九千六百九十三" do
    compare_kanji_and_integer("九千六百九十三", 9693)
  end

  it "九千六百九十四" do
    compare_kanji_and_integer("九千六百九十四", 9694)
  end

  it "九千六百九十五" do
    compare_kanji_and_integer("九千六百九十五", 9695)
  end

  it "九千六百九十六" do
    compare_kanji_and_integer("九千六百九十六", 9696)
  end

  it "九千六百九十七" do
    compare_kanji_and_integer("九千六百九十七", 9697)
  end

  it "九千六百九十八" do
    compare_kanji_and_integer("九千六百九十八", 9698)
  end

  it "九千六百九十九" do
    compare_kanji_and_integer("九千六百九十九", 9699)
  end

  it "九千七百" do
    compare_kanji_and_integer("九千七百", 9700)
  end

  it "九千七百一" do
    compare_kanji_and_integer("九千七百一", 9701)
  end

  it "九千七百二" do
    compare_kanji_and_integer("九千七百二", 9702)
  end

  it "九千七百三" do
    compare_kanji_and_integer("九千七百三", 9703)
  end

  it "九千七百四" do
    compare_kanji_and_integer("九千七百四", 9704)
  end

  it "九千七百五" do
    compare_kanji_and_integer("九千七百五", 9705)
  end

  it "九千七百六" do
    compare_kanji_and_integer("九千七百六", 9706)
  end

  it "九千七百七" do
    compare_kanji_and_integer("九千七百七", 9707)
  end

  it "九千七百八" do
    compare_kanji_and_integer("九千七百八", 9708)
  end

  it "九千七百九" do
    compare_kanji_and_integer("九千七百九", 9709)
  end

  it "九千七百十" do
    compare_kanji_and_integer("九千七百十", 9710)
  end

  it "九千七百十一" do
    compare_kanji_and_integer("九千七百十一", 9711)
  end

  it "九千七百十二" do
    compare_kanji_and_integer("九千七百十二", 9712)
  end

  it "九千七百十三" do
    compare_kanji_and_integer("九千七百十三", 9713)
  end

  it "九千七百十四" do
    compare_kanji_and_integer("九千七百十四", 9714)
  end

  it "九千七百十五" do
    compare_kanji_and_integer("九千七百十五", 9715)
  end

  it "九千七百十六" do
    compare_kanji_and_integer("九千七百十六", 9716)
  end

  it "九千七百十七" do
    compare_kanji_and_integer("九千七百十七", 9717)
  end

  it "九千七百十八" do
    compare_kanji_and_integer("九千七百十八", 9718)
  end

  it "九千七百十九" do
    compare_kanji_and_integer("九千七百十九", 9719)
  end

  it "九千七百二十" do
    compare_kanji_and_integer("九千七百二十", 9720)
  end

  it "九千七百二十一" do
    compare_kanji_and_integer("九千七百二十一", 9721)
  end

  it "九千七百二十二" do
    compare_kanji_and_integer("九千七百二十二", 9722)
  end

  it "九千七百二十三" do
    compare_kanji_and_integer("九千七百二十三", 9723)
  end

  it "九千七百二十四" do
    compare_kanji_and_integer("九千七百二十四", 9724)
  end

  it "九千七百二十五" do
    compare_kanji_and_integer("九千七百二十五", 9725)
  end

  it "九千七百二十六" do
    compare_kanji_and_integer("九千七百二十六", 9726)
  end

  it "九千七百二十七" do
    compare_kanji_and_integer("九千七百二十七", 9727)
  end

  it "九千七百二十八" do
    compare_kanji_and_integer("九千七百二十八", 9728)
  end

  it "九千七百二十九" do
    compare_kanji_and_integer("九千七百二十九", 9729)
  end

  it "九千七百三十" do
    compare_kanji_and_integer("九千七百三十", 9730)
  end

  it "九千七百三十一" do
    compare_kanji_and_integer("九千七百三十一", 9731)
  end

  it "九千七百三十二" do
    compare_kanji_and_integer("九千七百三十二", 9732)
  end

  it "九千七百三十三" do
    compare_kanji_and_integer("九千七百三十三", 9733)
  end

  it "九千七百三十四" do
    compare_kanji_and_integer("九千七百三十四", 9734)
  end

  it "九千七百三十五" do
    compare_kanji_and_integer("九千七百三十五", 9735)
  end

  it "九千七百三十六" do
    compare_kanji_and_integer("九千七百三十六", 9736)
  end

  it "九千七百三十七" do
    compare_kanji_and_integer("九千七百三十七", 9737)
  end

  it "九千七百三十八" do
    compare_kanji_and_integer("九千七百三十八", 9738)
  end

  it "九千七百三十九" do
    compare_kanji_and_integer("九千七百三十九", 9739)
  end

  it "九千七百四十" do
    compare_kanji_and_integer("九千七百四十", 9740)
  end

  it "九千七百四十一" do
    compare_kanji_and_integer("九千七百四十一", 9741)
  end

  it "九千七百四十二" do
    compare_kanji_and_integer("九千七百四十二", 9742)
  end

  it "九千七百四十三" do
    compare_kanji_and_integer("九千七百四十三", 9743)
  end

  it "九千七百四十四" do
    compare_kanji_and_integer("九千七百四十四", 9744)
  end

  it "九千七百四十五" do
    compare_kanji_and_integer("九千七百四十五", 9745)
  end

  it "九千七百四十六" do
    compare_kanji_and_integer("九千七百四十六", 9746)
  end

  it "九千七百四十七" do
    compare_kanji_and_integer("九千七百四十七", 9747)
  end

  it "九千七百四十八" do
    compare_kanji_and_integer("九千七百四十八", 9748)
  end

  it "九千七百四十九" do
    compare_kanji_and_integer("九千七百四十九", 9749)
  end

  it "九千七百五十" do
    compare_kanji_and_integer("九千七百五十", 9750)
  end

  it "九千七百五十一" do
    compare_kanji_and_integer("九千七百五十一", 9751)
  end

  it "九千七百五十二" do
    compare_kanji_and_integer("九千七百五十二", 9752)
  end

  it "九千七百五十三" do
    compare_kanji_and_integer("九千七百五十三", 9753)
  end

  it "九千七百五十四" do
    compare_kanji_and_integer("九千七百五十四", 9754)
  end

  it "九千七百五十五" do
    compare_kanji_and_integer("九千七百五十五", 9755)
  end

  it "九千七百五十六" do
    compare_kanji_and_integer("九千七百五十六", 9756)
  end

  it "九千七百五十七" do
    compare_kanji_and_integer("九千七百五十七", 9757)
  end

  it "九千七百五十八" do
    compare_kanji_and_integer("九千七百五十八", 9758)
  end

  it "九千七百五十九" do
    compare_kanji_and_integer("九千七百五十九", 9759)
  end

  it "九千七百六十" do
    compare_kanji_and_integer("九千七百六十", 9760)
  end

  it "九千七百六十一" do
    compare_kanji_and_integer("九千七百六十一", 9761)
  end

  it "九千七百六十二" do
    compare_kanji_and_integer("九千七百六十二", 9762)
  end

  it "九千七百六十三" do
    compare_kanji_and_integer("九千七百六十三", 9763)
  end

  it "九千七百六十四" do
    compare_kanji_and_integer("九千七百六十四", 9764)
  end

  it "九千七百六十五" do
    compare_kanji_and_integer("九千七百六十五", 9765)
  end

  it "九千七百六十六" do
    compare_kanji_and_integer("九千七百六十六", 9766)
  end

  it "九千七百六十七" do
    compare_kanji_and_integer("九千七百六十七", 9767)
  end

  it "九千七百六十八" do
    compare_kanji_and_integer("九千七百六十八", 9768)
  end

  it "九千七百六十九" do
    compare_kanji_and_integer("九千七百六十九", 9769)
  end

  it "九千七百七十" do
    compare_kanji_and_integer("九千七百七十", 9770)
  end

  it "九千七百七十一" do
    compare_kanji_and_integer("九千七百七十一", 9771)
  end

  it "九千七百七十二" do
    compare_kanji_and_integer("九千七百七十二", 9772)
  end

  it "九千七百七十三" do
    compare_kanji_and_integer("九千七百七十三", 9773)
  end

  it "九千七百七十四" do
    compare_kanji_and_integer("九千七百七十四", 9774)
  end

  it "九千七百七十五" do
    compare_kanji_and_integer("九千七百七十五", 9775)
  end

  it "九千七百七十六" do
    compare_kanji_and_integer("九千七百七十六", 9776)
  end

  it "九千七百七十七" do
    compare_kanji_and_integer("九千七百七十七", 9777)
  end

  it "九千七百七十八" do
    compare_kanji_and_integer("九千七百七十八", 9778)
  end

  it "九千七百七十九" do
    compare_kanji_and_integer("九千七百七十九", 9779)
  end

  it "九千七百八十" do
    compare_kanji_and_integer("九千七百八十", 9780)
  end

  it "九千七百八十一" do
    compare_kanji_and_integer("九千七百八十一", 9781)
  end

  it "九千七百八十二" do
    compare_kanji_and_integer("九千七百八十二", 9782)
  end

  it "九千七百八十三" do
    compare_kanji_and_integer("九千七百八十三", 9783)
  end

  it "九千七百八十四" do
    compare_kanji_and_integer("九千七百八十四", 9784)
  end

  it "九千七百八十五" do
    compare_kanji_and_integer("九千七百八十五", 9785)
  end

  it "九千七百八十六" do
    compare_kanji_and_integer("九千七百八十六", 9786)
  end

  it "九千七百八十七" do
    compare_kanji_and_integer("九千七百八十七", 9787)
  end

  it "九千七百八十八" do
    compare_kanji_and_integer("九千七百八十八", 9788)
  end

  it "九千七百八十九" do
    compare_kanji_and_integer("九千七百八十九", 9789)
  end

  it "九千七百九十" do
    compare_kanji_and_integer("九千七百九十", 9790)
  end

  it "九千七百九十一" do
    compare_kanji_and_integer("九千七百九十一", 9791)
  end

  it "九千七百九十二" do
    compare_kanji_and_integer("九千七百九十二", 9792)
  end

  it "九千七百九十三" do
    compare_kanji_and_integer("九千七百九十三", 9793)
  end

  it "九千七百九十四" do
    compare_kanji_and_integer("九千七百九十四", 9794)
  end

  it "九千七百九十五" do
    compare_kanji_and_integer("九千七百九十五", 9795)
  end

  it "九千七百九十六" do
    compare_kanji_and_integer("九千七百九十六", 9796)
  end

  it "九千七百九十七" do
    compare_kanji_and_integer("九千七百九十七", 9797)
  end

  it "九千七百九十八" do
    compare_kanji_and_integer("九千七百九十八", 9798)
  end

  it "九千七百九十九" do
    compare_kanji_and_integer("九千七百九十九", 9799)
  end

  it "九千八百" do
    compare_kanji_and_integer("九千八百", 9800)
  end

  it "九千八百一" do
    compare_kanji_and_integer("九千八百一", 9801)
  end

  it "九千八百二" do
    compare_kanji_and_integer("九千八百二", 9802)
  end

  it "九千八百三" do
    compare_kanji_and_integer("九千八百三", 9803)
  end

  it "九千八百四" do
    compare_kanji_and_integer("九千八百四", 9804)
  end

  it "九千八百五" do
    compare_kanji_and_integer("九千八百五", 9805)
  end

  it "九千八百六" do
    compare_kanji_and_integer("九千八百六", 9806)
  end

  it "九千八百七" do
    compare_kanji_and_integer("九千八百七", 9807)
  end

  it "九千八百八" do
    compare_kanji_and_integer("九千八百八", 9808)
  end

  it "九千八百九" do
    compare_kanji_and_integer("九千八百九", 9809)
  end

  it "九千八百十" do
    compare_kanji_and_integer("九千八百十", 9810)
  end

  it "九千八百十一" do
    compare_kanji_and_integer("九千八百十一", 9811)
  end

  it "九千八百十二" do
    compare_kanji_and_integer("九千八百十二", 9812)
  end

  it "九千八百十三" do
    compare_kanji_and_integer("九千八百十三", 9813)
  end

  it "九千八百十四" do
    compare_kanji_and_integer("九千八百十四", 9814)
  end

  it "九千八百十五" do
    compare_kanji_and_integer("九千八百十五", 9815)
  end

  it "九千八百十六" do
    compare_kanji_and_integer("九千八百十六", 9816)
  end

  it "九千八百十七" do
    compare_kanji_and_integer("九千八百十七", 9817)
  end

  it "九千八百十八" do
    compare_kanji_and_integer("九千八百十八", 9818)
  end

  it "九千八百十九" do
    compare_kanji_and_integer("九千八百十九", 9819)
  end

  it "九千八百二十" do
    compare_kanji_and_integer("九千八百二十", 9820)
  end

  it "九千八百二十一" do
    compare_kanji_and_integer("九千八百二十一", 9821)
  end

  it "九千八百二十二" do
    compare_kanji_and_integer("九千八百二十二", 9822)
  end

  it "九千八百二十三" do
    compare_kanji_and_integer("九千八百二十三", 9823)
  end

  it "九千八百二十四" do
    compare_kanji_and_integer("九千八百二十四", 9824)
  end

  it "九千八百二十五" do
    compare_kanji_and_integer("九千八百二十五", 9825)
  end

  it "九千八百二十六" do
    compare_kanji_and_integer("九千八百二十六", 9826)
  end

  it "九千八百二十七" do
    compare_kanji_and_integer("九千八百二十七", 9827)
  end

  it "九千八百二十八" do
    compare_kanji_and_integer("九千八百二十八", 9828)
  end

  it "九千八百二十九" do
    compare_kanji_and_integer("九千八百二十九", 9829)
  end

  it "九千八百三十" do
    compare_kanji_and_integer("九千八百三十", 9830)
  end

  it "九千八百三十一" do
    compare_kanji_and_integer("九千八百三十一", 9831)
  end

  it "九千八百三十二" do
    compare_kanji_and_integer("九千八百三十二", 9832)
  end

  it "九千八百三十三" do
    compare_kanji_and_integer("九千八百三十三", 9833)
  end

  it "九千八百三十四" do
    compare_kanji_and_integer("九千八百三十四", 9834)
  end

  it "九千八百三十五" do
    compare_kanji_and_integer("九千八百三十五", 9835)
  end

  it "九千八百三十六" do
    compare_kanji_and_integer("九千八百三十六", 9836)
  end

  it "九千八百三十七" do
    compare_kanji_and_integer("九千八百三十七", 9837)
  end

  it "九千八百三十八" do
    compare_kanji_and_integer("九千八百三十八", 9838)
  end

  it "九千八百三十九" do
    compare_kanji_and_integer("九千八百三十九", 9839)
  end

  it "九千八百四十" do
    compare_kanji_and_integer("九千八百四十", 9840)
  end

  it "九千八百四十一" do
    compare_kanji_and_integer("九千八百四十一", 9841)
  end

  it "九千八百四十二" do
    compare_kanji_and_integer("九千八百四十二", 9842)
  end

  it "九千八百四十三" do
    compare_kanji_and_integer("九千八百四十三", 9843)
  end

  it "九千八百四十四" do
    compare_kanji_and_integer("九千八百四十四", 9844)
  end

  it "九千八百四十五" do
    compare_kanji_and_integer("九千八百四十五", 9845)
  end

  it "九千八百四十六" do
    compare_kanji_and_integer("九千八百四十六", 9846)
  end

  it "九千八百四十七" do
    compare_kanji_and_integer("九千八百四十七", 9847)
  end

  it "九千八百四十八" do
    compare_kanji_and_integer("九千八百四十八", 9848)
  end

  it "九千八百四十九" do
    compare_kanji_and_integer("九千八百四十九", 9849)
  end

  it "九千八百五十" do
    compare_kanji_and_integer("九千八百五十", 9850)
  end

  it "九千八百五十一" do
    compare_kanji_and_integer("九千八百五十一", 9851)
  end

  it "九千八百五十二" do
    compare_kanji_and_integer("九千八百五十二", 9852)
  end

  it "九千八百五十三" do
    compare_kanji_and_integer("九千八百五十三", 9853)
  end

  it "九千八百五十四" do
    compare_kanji_and_integer("九千八百五十四", 9854)
  end

  it "九千八百五十五" do
    compare_kanji_and_integer("九千八百五十五", 9855)
  end

  it "九千八百五十六" do
    compare_kanji_and_integer("九千八百五十六", 9856)
  end

  it "九千八百五十七" do
    compare_kanji_and_integer("九千八百五十七", 9857)
  end

  it "九千八百五十八" do
    compare_kanji_and_integer("九千八百五十八", 9858)
  end

  it "九千八百五十九" do
    compare_kanji_and_integer("九千八百五十九", 9859)
  end

  it "九千八百六十" do
    compare_kanji_and_integer("九千八百六十", 9860)
  end

  it "九千八百六十一" do
    compare_kanji_and_integer("九千八百六十一", 9861)
  end

  it "九千八百六十二" do
    compare_kanji_and_integer("九千八百六十二", 9862)
  end

  it "九千八百六十三" do
    compare_kanji_and_integer("九千八百六十三", 9863)
  end

  it "九千八百六十四" do
    compare_kanji_and_integer("九千八百六十四", 9864)
  end

  it "九千八百六十五" do
    compare_kanji_and_integer("九千八百六十五", 9865)
  end

  it "九千八百六十六" do
    compare_kanji_and_integer("九千八百六十六", 9866)
  end

  it "九千八百六十七" do
    compare_kanji_and_integer("九千八百六十七", 9867)
  end

  it "九千八百六十八" do
    compare_kanji_and_integer("九千八百六十八", 9868)
  end

  it "九千八百六十九" do
    compare_kanji_and_integer("九千八百六十九", 9869)
  end

  it "九千八百七十" do
    compare_kanji_and_integer("九千八百七十", 9870)
  end

  it "九千八百七十一" do
    compare_kanji_and_integer("九千八百七十一", 9871)
  end

  it "九千八百七十二" do
    compare_kanji_and_integer("九千八百七十二", 9872)
  end

  it "九千八百七十三" do
    compare_kanji_and_integer("九千八百七十三", 9873)
  end

  it "九千八百七十四" do
    compare_kanji_and_integer("九千八百七十四", 9874)
  end

  it "九千八百七十五" do
    compare_kanji_and_integer("九千八百七十五", 9875)
  end

  it "九千八百七十六" do
    compare_kanji_and_integer("九千八百七十六", 9876)
  end

  it "九千八百七十七" do
    compare_kanji_and_integer("九千八百七十七", 9877)
  end

  it "九千八百七十八" do
    compare_kanji_and_integer("九千八百七十八", 9878)
  end

  it "九千八百七十九" do
    compare_kanji_and_integer("九千八百七十九", 9879)
  end

  it "九千八百八十" do
    compare_kanji_and_integer("九千八百八十", 9880)
  end

  it "九千八百八十一" do
    compare_kanji_and_integer("九千八百八十一", 9881)
  end

  it "九千八百八十二" do
    compare_kanji_and_integer("九千八百八十二", 9882)
  end

  it "九千八百八十三" do
    compare_kanji_and_integer("九千八百八十三", 9883)
  end

  it "九千八百八十四" do
    compare_kanji_and_integer("九千八百八十四", 9884)
  end

  it "九千八百八十五" do
    compare_kanji_and_integer("九千八百八十五", 9885)
  end

  it "九千八百八十六" do
    compare_kanji_and_integer("九千八百八十六", 9886)
  end

  it "九千八百八十七" do
    compare_kanji_and_integer("九千八百八十七", 9887)
  end

  it "九千八百八十八" do
    compare_kanji_and_integer("九千八百八十八", 9888)
  end

  it "九千八百八十九" do
    compare_kanji_and_integer("九千八百八十九", 9889)
  end

  it "九千八百九十" do
    compare_kanji_and_integer("九千八百九十", 9890)
  end

  it "九千八百九十一" do
    compare_kanji_and_integer("九千八百九十一", 9891)
  end

  it "九千八百九十二" do
    compare_kanji_and_integer("九千八百九十二", 9892)
  end

  it "九千八百九十三" do
    compare_kanji_and_integer("九千八百九十三", 9893)
  end

  it "九千八百九十四" do
    compare_kanji_and_integer("九千八百九十四", 9894)
  end

  it "九千八百九十五" do
    compare_kanji_and_integer("九千八百九十五", 9895)
  end

  it "九千八百九十六" do
    compare_kanji_and_integer("九千八百九十六", 9896)
  end

  it "九千八百九十七" do
    compare_kanji_and_integer("九千八百九十七", 9897)
  end

  it "九千八百九十八" do
    compare_kanji_and_integer("九千八百九十八", 9898)
  end

  it "九千八百九十九" do
    compare_kanji_and_integer("九千八百九十九", 9899)
  end

  it "九千九百" do
    compare_kanji_and_integer("九千九百", 9900)
  end

  it "九千九百一" do
    compare_kanji_and_integer("九千九百一", 9901)
  end

  it "九千九百二" do
    compare_kanji_and_integer("九千九百二", 9902)
  end

  it "九千九百三" do
    compare_kanji_and_integer("九千九百三", 9903)
  end

  it "九千九百四" do
    compare_kanji_and_integer("九千九百四", 9904)
  end

  it "九千九百五" do
    compare_kanji_and_integer("九千九百五", 9905)
  end

  it "九千九百六" do
    compare_kanji_and_integer("九千九百六", 9906)
  end

  it "九千九百七" do
    compare_kanji_and_integer("九千九百七", 9907)
  end

  it "九千九百八" do
    compare_kanji_and_integer("九千九百八", 9908)
  end

  it "九千九百九" do
    compare_kanji_and_integer("九千九百九", 9909)
  end

  it "九千九百十" do
    compare_kanji_and_integer("九千九百十", 9910)
  end

  it "九千九百十一" do
    compare_kanji_and_integer("九千九百十一", 9911)
  end

  it "九千九百十二" do
    compare_kanji_and_integer("九千九百十二", 9912)
  end

  it "九千九百十三" do
    compare_kanji_and_integer("九千九百十三", 9913)
  end

  it "九千九百十四" do
    compare_kanji_and_integer("九千九百十四", 9914)
  end

  it "九千九百十五" do
    compare_kanji_and_integer("九千九百十五", 9915)
  end

  it "九千九百十六" do
    compare_kanji_and_integer("九千九百十六", 9916)
  end

  it "九千九百十七" do
    compare_kanji_and_integer("九千九百十七", 9917)
  end

  it "九千九百十八" do
    compare_kanji_and_integer("九千九百十八", 9918)
  end

  it "九千九百十九" do
    compare_kanji_and_integer("九千九百十九", 9919)
  end

  it "九千九百二十" do
    compare_kanji_and_integer("九千九百二十", 9920)
  end

  it "九千九百二十一" do
    compare_kanji_and_integer("九千九百二十一", 9921)
  end

  it "九千九百二十二" do
    compare_kanji_and_integer("九千九百二十二", 9922)
  end

  it "九千九百二十三" do
    compare_kanji_and_integer("九千九百二十三", 9923)
  end

  it "九千九百二十四" do
    compare_kanji_and_integer("九千九百二十四", 9924)
  end

  it "九千九百二十五" do
    compare_kanji_and_integer("九千九百二十五", 9925)
  end

  it "九千九百二十六" do
    compare_kanji_and_integer("九千九百二十六", 9926)
  end

  it "九千九百二十七" do
    compare_kanji_and_integer("九千九百二十七", 9927)
  end

  it "九千九百二十八" do
    compare_kanji_and_integer("九千九百二十八", 9928)
  end

  it "九千九百二十九" do
    compare_kanji_and_integer("九千九百二十九", 9929)
  end

  it "九千九百三十" do
    compare_kanji_and_integer("九千九百三十", 9930)
  end

  it "九千九百三十一" do
    compare_kanji_and_integer("九千九百三十一", 9931)
  end

  it "九千九百三十二" do
    compare_kanji_and_integer("九千九百三十二", 9932)
  end

  it "九千九百三十三" do
    compare_kanji_and_integer("九千九百三十三", 9933)
  end

  it "九千九百三十四" do
    compare_kanji_and_integer("九千九百三十四", 9934)
  end

  it "九千九百三十五" do
    compare_kanji_and_integer("九千九百三十五", 9935)
  end

  it "九千九百三十六" do
    compare_kanji_and_integer("九千九百三十六", 9936)
  end

  it "九千九百三十七" do
    compare_kanji_and_integer("九千九百三十七", 9937)
  end

  it "九千九百三十八" do
    compare_kanji_and_integer("九千九百三十八", 9938)
  end

  it "九千九百三十九" do
    compare_kanji_and_integer("九千九百三十九", 9939)
  end

  it "九千九百四十" do
    compare_kanji_and_integer("九千九百四十", 9940)
  end

  it "九千九百四十一" do
    compare_kanji_and_integer("九千九百四十一", 9941)
  end

  it "九千九百四十二" do
    compare_kanji_and_integer("九千九百四十二", 9942)
  end

  it "九千九百四十三" do
    compare_kanji_and_integer("九千九百四十三", 9943)
  end

  it "九千九百四十四" do
    compare_kanji_and_integer("九千九百四十四", 9944)
  end

  it "九千九百四十五" do
    compare_kanji_and_integer("九千九百四十五", 9945)
  end

  it "九千九百四十六" do
    compare_kanji_and_integer("九千九百四十六", 9946)
  end

  it "九千九百四十七" do
    compare_kanji_and_integer("九千九百四十七", 9947)
  end

  it "九千九百四十八" do
    compare_kanji_and_integer("九千九百四十八", 9948)
  end

  it "九千九百四十九" do
    compare_kanji_and_integer("九千九百四十九", 9949)
  end

  it "九千九百五十" do
    compare_kanji_and_integer("九千九百五十", 9950)
  end

  it "九千九百五十一" do
    compare_kanji_and_integer("九千九百五十一", 9951)
  end

  it "九千九百五十二" do
    compare_kanji_and_integer("九千九百五十二", 9952)
  end

  it "九千九百五十三" do
    compare_kanji_and_integer("九千九百五十三", 9953)
  end

  it "九千九百五十四" do
    compare_kanji_and_integer("九千九百五十四", 9954)
  end

  it "九千九百五十五" do
    compare_kanji_and_integer("九千九百五十五", 9955)
  end

  it "九千九百五十六" do
    compare_kanji_and_integer("九千九百五十六", 9956)
  end

  it "九千九百五十七" do
    compare_kanji_and_integer("九千九百五十七", 9957)
  end

  it "九千九百五十八" do
    compare_kanji_and_integer("九千九百五十八", 9958)
  end

  it "九千九百五十九" do
    compare_kanji_and_integer("九千九百五十九", 9959)
  end

  it "九千九百六十" do
    compare_kanji_and_integer("九千九百六十", 9960)
  end

  it "九千九百六十一" do
    compare_kanji_and_integer("九千九百六十一", 9961)
  end

  it "九千九百六十二" do
    compare_kanji_and_integer("九千九百六十二", 9962)
  end

  it "九千九百六十三" do
    compare_kanji_and_integer("九千九百六十三", 9963)
  end

  it "九千九百六十四" do
    compare_kanji_and_integer("九千九百六十四", 9964)
  end

  it "九千九百六十五" do
    compare_kanji_and_integer("九千九百六十五", 9965)
  end

  it "九千九百六十六" do
    compare_kanji_and_integer("九千九百六十六", 9966)
  end

  it "九千九百六十七" do
    compare_kanji_and_integer("九千九百六十七", 9967)
  end

  it "九千九百六十八" do
    compare_kanji_and_integer("九千九百六十八", 9968)
  end

  it "九千九百六十九" do
    compare_kanji_and_integer("九千九百六十九", 9969)
  end

  it "九千九百七十" do
    compare_kanji_and_integer("九千九百七十", 9970)
  end

  it "九千九百七十一" do
    compare_kanji_and_integer("九千九百七十一", 9971)
  end

  it "九千九百七十二" do
    compare_kanji_and_integer("九千九百七十二", 9972)
  end

  it "九千九百七十三" do
    compare_kanji_and_integer("九千九百七十三", 9973)
  end

  it "九千九百七十四" do
    compare_kanji_and_integer("九千九百七十四", 9974)
  end

  it "九千九百七十五" do
    compare_kanji_and_integer("九千九百七十五", 9975)
  end

  it "九千九百七十六" do
    compare_kanji_and_integer("九千九百七十六", 9976)
  end

  it "九千九百七十七" do
    compare_kanji_and_integer("九千九百七十七", 9977)
  end

  it "九千九百七十八" do
    compare_kanji_and_integer("九千九百七十八", 9978)
  end

  it "九千九百七十九" do
    compare_kanji_and_integer("九千九百七十九", 9979)
  end

  it "九千九百八十" do
    compare_kanji_and_integer("九千九百八十", 9980)
  end

  it "九千九百八十一" do
    compare_kanji_and_integer("九千九百八十一", 9981)
  end

  it "九千九百八十二" do
    compare_kanji_and_integer("九千九百八十二", 9982)
  end

  it "九千九百八十三" do
    compare_kanji_and_integer("九千九百八十三", 9983)
  end

  it "九千九百八十四" do
    compare_kanji_and_integer("九千九百八十四", 9984)
  end

  it "九千九百八十五" do
    compare_kanji_and_integer("九千九百八十五", 9985)
  end

  it "九千九百八十六" do
    compare_kanji_and_integer("九千九百八十六", 9986)
  end

  it "九千九百八十七" do
    compare_kanji_and_integer("九千九百八十七", 9987)
  end

  it "九千九百八十八" do
    compare_kanji_and_integer("九千九百八十八", 9988)
  end

  it "九千九百八十九" do
    compare_kanji_and_integer("九千九百八十九", 9989)
  end

  it "九千九百九十" do
    compare_kanji_and_integer("九千九百九十", 9990)
  end

  it "九千九百九十一" do
    compare_kanji_and_integer("九千九百九十一", 9991)
  end

  it "九千九百九十二" do
    compare_kanji_and_integer("九千九百九十二", 9992)
  end

  it "九千九百九十三" do
    compare_kanji_and_integer("九千九百九十三", 9993)
  end

  it "九千九百九十四" do
    compare_kanji_and_integer("九千九百九十四", 9994)
  end

  it "九千九百九十五" do
    compare_kanji_and_integer("九千九百九十五", 9995)
  end

  it "九千九百九十六" do
    compare_kanji_and_integer("九千九百九十六", 9996)
  end

  it "九千九百九十七" do
    compare_kanji_and_integer("九千九百九十七", 9997)
  end

  it "九千九百九十八" do
    compare_kanji_and_integer("九千九百九十八", 9998)
  end

  it "九千九百九十九" do
    compare_kanji_and_integer("九千九百九十九", 9999)
  end

  it "一万" do
    compare_kanji_and_integer("一万", 10000)
  end

  it "一万一" do
    compare_kanji_and_integer("一万一", 10001)
  end

  it "一万二" do
    compare_kanji_and_integer("一万二", 10002)
  end

  it "一万三" do
    compare_kanji_and_integer("一万三", 10003)
  end

  it "一万四" do
    compare_kanji_and_integer("一万四", 10004)
  end

  it "一万五" do
    compare_kanji_and_integer("一万五", 10005)
  end

  it "一万六" do
    compare_kanji_and_integer("一万六", 10006)
  end

  it "一万七" do
    compare_kanji_and_integer("一万七", 10007)
  end

  it "一万八" do
    compare_kanji_and_integer("一万八", 10008)
  end

  it "一万九" do
    compare_kanji_and_integer("一万九", 10009)
  end

  it "一万十" do
    compare_kanji_and_integer("一万十", 10010)
  end

  it "一万十一" do
    compare_kanji_and_integer("一万十一", 10011)
  end

  it "一万十二" do
    compare_kanji_and_integer("一万十二", 10012)
  end

  it "一万十三" do
    compare_kanji_and_integer("一万十三", 10013)
  end

  it "一万十四" do
    compare_kanji_and_integer("一万十四", 10014)
  end

  it "一万十五" do
    compare_kanji_and_integer("一万十五", 10015)
  end

  it "一万十六" do
    compare_kanji_and_integer("一万十六", 10016)
  end

  it "一万十七" do
    compare_kanji_and_integer("一万十七", 10017)
  end

  it "一万十八" do
    compare_kanji_and_integer("一万十八", 10018)
  end

  it "一万十九" do
    compare_kanji_and_integer("一万十九", 10019)
  end

  it "一万二十" do
    compare_kanji_and_integer("一万二十", 10020)
  end

  it "一万二十一" do
    compare_kanji_and_integer("一万二十一", 10021)
  end

  it "一万二十二" do
    compare_kanji_and_integer("一万二十二", 10022)
  end

  it "一万二十三" do
    compare_kanji_and_integer("一万二十三", 10023)
  end

  it "一万二十四" do
    compare_kanji_and_integer("一万二十四", 10024)
  end

  it "一万二十五" do
    compare_kanji_and_integer("一万二十五", 10025)
  end

  it "一万二十六" do
    compare_kanji_and_integer("一万二十六", 10026)
  end

  it "一万二十七" do
    compare_kanji_and_integer("一万二十七", 10027)
  end

  it "一万二十八" do
    compare_kanji_and_integer("一万二十八", 10028)
  end

  it "一万二十九" do
    compare_kanji_and_integer("一万二十九", 10029)
  end

  it "一万三十" do
    compare_kanji_and_integer("一万三十", 10030)
  end

  it "一万三十一" do
    compare_kanji_and_integer("一万三十一", 10031)
  end

  it "一万三十二" do
    compare_kanji_and_integer("一万三十二", 10032)
  end

  it "一万三十三" do
    compare_kanji_and_integer("一万三十三", 10033)
  end

  it "一万三十四" do
    compare_kanji_and_integer("一万三十四", 10034)
  end

  it "一万三十五" do
    compare_kanji_and_integer("一万三十五", 10035)
  end

  it "一万三十六" do
    compare_kanji_and_integer("一万三十六", 10036)
  end

  it "一万三十七" do
    compare_kanji_and_integer("一万三十七", 10037)
  end

  it "一万三十八" do
    compare_kanji_and_integer("一万三十八", 10038)
  end

  it "一万三十九" do
    compare_kanji_and_integer("一万三十九", 10039)
  end

  it "一万四十" do
    compare_kanji_and_integer("一万四十", 10040)
  end

  it "一万四十一" do
    compare_kanji_and_integer("一万四十一", 10041)
  end

  it "一万四十二" do
    compare_kanji_and_integer("一万四十二", 10042)
  end

  it "一万四十三" do
    compare_kanji_and_integer("一万四十三", 10043)
  end

  it "一万四十四" do
    compare_kanji_and_integer("一万四十四", 10044)
  end

  it "一万四十五" do
    compare_kanji_and_integer("一万四十五", 10045)
  end

  it "一万四十六" do
    compare_kanji_and_integer("一万四十六", 10046)
  end

  it "一万四十七" do
    compare_kanji_and_integer("一万四十七", 10047)
  end

  it "一万四十八" do
    compare_kanji_and_integer("一万四十八", 10048)
  end

  it "一万四十九" do
    compare_kanji_and_integer("一万四十九", 10049)
  end

  it "一万五十" do
    compare_kanji_and_integer("一万五十", 10050)
  end

  it "一万五十一" do
    compare_kanji_and_integer("一万五十一", 10051)
  end

  it "一万五十二" do
    compare_kanji_and_integer("一万五十二", 10052)
  end

  it "一万五十三" do
    compare_kanji_and_integer("一万五十三", 10053)
  end

  it "一万五十四" do
    compare_kanji_and_integer("一万五十四", 10054)
  end

  it "一万五十五" do
    compare_kanji_and_integer("一万五十五", 10055)
  end

  it "一万五十六" do
    compare_kanji_and_integer("一万五十六", 10056)
  end

  it "一万五十七" do
    compare_kanji_and_integer("一万五十七", 10057)
  end

  it "一万五十八" do
    compare_kanji_and_integer("一万五十八", 10058)
  end

  it "一万五十九" do
    compare_kanji_and_integer("一万五十九", 10059)
  end

  it "一万六十" do
    compare_kanji_and_integer("一万六十", 10060)
  end

  it "一万六十一" do
    compare_kanji_and_integer("一万六十一", 10061)
  end

  it "一万六十二" do
    compare_kanji_and_integer("一万六十二", 10062)
  end

  it "一万六十三" do
    compare_kanji_and_integer("一万六十三", 10063)
  end

  it "一万六十四" do
    compare_kanji_and_integer("一万六十四", 10064)
  end

  it "一万六十五" do
    compare_kanji_and_integer("一万六十五", 10065)
  end

  it "一万六十六" do
    compare_kanji_and_integer("一万六十六", 10066)
  end

  it "一万六十七" do
    compare_kanji_and_integer("一万六十七", 10067)
  end

  it "一万六十八" do
    compare_kanji_and_integer("一万六十八", 10068)
  end

  it "一万六十九" do
    compare_kanji_and_integer("一万六十九", 10069)
  end

  it "一万七十" do
    compare_kanji_and_integer("一万七十", 10070)
  end

  it "一万七十一" do
    compare_kanji_and_integer("一万七十一", 10071)
  end

  it "一万七十二" do
    compare_kanji_and_integer("一万七十二", 10072)
  end

  it "一万七十三" do
    compare_kanji_and_integer("一万七十三", 10073)
  end

  it "一万七十四" do
    compare_kanji_and_integer("一万七十四", 10074)
  end

  it "一万七十五" do
    compare_kanji_and_integer("一万七十五", 10075)
  end

  it "一万七十六" do
    compare_kanji_and_integer("一万七十六", 10076)
  end

  it "一万七十七" do
    compare_kanji_and_integer("一万七十七", 10077)
  end

  it "一万七十八" do
    compare_kanji_and_integer("一万七十八", 10078)
  end

  it "一万七十九" do
    compare_kanji_and_integer("一万七十九", 10079)
  end

  it "一万八十" do
    compare_kanji_and_integer("一万八十", 10080)
  end

  it "一万八十一" do
    compare_kanji_and_integer("一万八十一", 10081)
  end

  it "一万八十二" do
    compare_kanji_and_integer("一万八十二", 10082)
  end

  it "一万八十三" do
    compare_kanji_and_integer("一万八十三", 10083)
  end

  it "一万八十四" do
    compare_kanji_and_integer("一万八十四", 10084)
  end

  it "一万八十五" do
    compare_kanji_and_integer("一万八十五", 10085)
  end

  it "一万八十六" do
    compare_kanji_and_integer("一万八十六", 10086)
  end

  it "一万八十七" do
    compare_kanji_and_integer("一万八十七", 10087)
  end

  it "一万八十八" do
    compare_kanji_and_integer("一万八十八", 10088)
  end

  it "一万八十九" do
    compare_kanji_and_integer("一万八十九", 10089)
  end

  it "一万九十" do
    compare_kanji_and_integer("一万九十", 10090)
  end

  it "一万九十一" do
    compare_kanji_and_integer("一万九十一", 10091)
  end

  it "一万九十二" do
    compare_kanji_and_integer("一万九十二", 10092)
  end

  it "一万九十三" do
    compare_kanji_and_integer("一万九十三", 10093)
  end

  it "一万九十四" do
    compare_kanji_and_integer("一万九十四", 10094)
  end

  it "一万九十五" do
    compare_kanji_and_integer("一万九十五", 10095)
  end

  it "一万九十六" do
    compare_kanji_and_integer("一万九十六", 10096)
  end

  it "一万九十七" do
    compare_kanji_and_integer("一万九十七", 10097)
  end

  it "一万九十八" do
    compare_kanji_and_integer("一万九十八", 10098)
  end

  it "一万九十九" do
    compare_kanji_and_integer("一万九十九", 10099)
  end

  it "一万百" do
    compare_kanji_and_integer("一万百", 10100)
  end

  it "一万百一" do
    compare_kanji_and_integer("一万百一", 10101)
  end

  it "一万百二" do
    compare_kanji_and_integer("一万百二", 10102)
  end

  it "一万百三" do
    compare_kanji_and_integer("一万百三", 10103)
  end

  it "一万百四" do
    compare_kanji_and_integer("一万百四", 10104)
  end

  it "一万百五" do
    compare_kanji_and_integer("一万百五", 10105)
  end

  it "一万百六" do
    compare_kanji_and_integer("一万百六", 10106)
  end

  it "一万百七" do
    compare_kanji_and_integer("一万百七", 10107)
  end

  it "一万百八" do
    compare_kanji_and_integer("一万百八", 10108)
  end

  it "一万百九" do
    compare_kanji_and_integer("一万百九", 10109)
  end

  it "一万百十" do
    compare_kanji_and_integer("一万百十", 10110)
  end

  it "一万百十一" do
    compare_kanji_and_integer("一万百十一", 10111)
  end

  it "一万百十二" do
    compare_kanji_and_integer("一万百十二", 10112)
  end

  it "一万百十三" do
    compare_kanji_and_integer("一万百十三", 10113)
  end

  it "一万百十四" do
    compare_kanji_and_integer("一万百十四", 10114)
  end

  it "一万百十五" do
    compare_kanji_and_integer("一万百十五", 10115)
  end

  it "一万百十六" do
    compare_kanji_and_integer("一万百十六", 10116)
  end

  it "一万百十七" do
    compare_kanji_and_integer("一万百十七", 10117)
  end

  it "一万百十八" do
    compare_kanji_and_integer("一万百十八", 10118)
  end

  it "一万百十九" do
    compare_kanji_and_integer("一万百十九", 10119)
  end

  it "一万百二十" do
    compare_kanji_and_integer("一万百二十", 10120)
  end

  it "一万百二十一" do
    compare_kanji_and_integer("一万百二十一", 10121)
  end

  it "一万百二十二" do
    compare_kanji_and_integer("一万百二十二", 10122)
  end

  it "一万百二十三" do
    compare_kanji_and_integer("一万百二十三", 10123)
  end

  it "一万百二十四" do
    compare_kanji_and_integer("一万百二十四", 10124)
  end

  it "一万百二十五" do
    compare_kanji_and_integer("一万百二十五", 10125)
  end

  it "一万百二十六" do
    compare_kanji_and_integer("一万百二十六", 10126)
  end

  it "一万百二十七" do
    compare_kanji_and_integer("一万百二十七", 10127)
  end

  it "一万百二十八" do
    compare_kanji_and_integer("一万百二十八", 10128)
  end

  it "一万百二十九" do
    compare_kanji_and_integer("一万百二十九", 10129)
  end

  it "一万百三十" do
    compare_kanji_and_integer("一万百三十", 10130)
  end

  it "一万百三十一" do
    compare_kanji_and_integer("一万百三十一", 10131)
  end

  it "一万百三十二" do
    compare_kanji_and_integer("一万百三十二", 10132)
  end

  it "一万百三十三" do
    compare_kanji_and_integer("一万百三十三", 10133)
  end

  it "一万百三十四" do
    compare_kanji_and_integer("一万百三十四", 10134)
  end

  it "一万百三十五" do
    compare_kanji_and_integer("一万百三十五", 10135)
  end

  it "一万百三十六" do
    compare_kanji_and_integer("一万百三十六", 10136)
  end

  it "一万百三十七" do
    compare_kanji_and_integer("一万百三十七", 10137)
  end

  it "一万百三十八" do
    compare_kanji_and_integer("一万百三十八", 10138)
  end

  it "一万百三十九" do
    compare_kanji_and_integer("一万百三十九", 10139)
  end

  it "一万百四十" do
    compare_kanji_and_integer("一万百四十", 10140)
  end

  it "一万百四十一" do
    compare_kanji_and_integer("一万百四十一", 10141)
  end

  it "一万百四十二" do
    compare_kanji_and_integer("一万百四十二", 10142)
  end

  it "一万百四十三" do
    compare_kanji_and_integer("一万百四十三", 10143)
  end

  it "一万百四十四" do
    compare_kanji_and_integer("一万百四十四", 10144)
  end

  it "一万百四十五" do
    compare_kanji_and_integer("一万百四十五", 10145)
  end

  it "一万百四十六" do
    compare_kanji_and_integer("一万百四十六", 10146)
  end

  it "一万百四十七" do
    compare_kanji_and_integer("一万百四十七", 10147)
  end

  it "一万百四十八" do
    compare_kanji_and_integer("一万百四十八", 10148)
  end

  it "一万百四十九" do
    compare_kanji_and_integer("一万百四十九", 10149)
  end

  it "一万百五十" do
    compare_kanji_and_integer("一万百五十", 10150)
  end

  it "一万百五十一" do
    compare_kanji_and_integer("一万百五十一", 10151)
  end

  it "一万百五十二" do
    compare_kanji_and_integer("一万百五十二", 10152)
  end

  it "一万百五十三" do
    compare_kanji_and_integer("一万百五十三", 10153)
  end

  it "一万百五十四" do
    compare_kanji_and_integer("一万百五十四", 10154)
  end

  it "一万百五十五" do
    compare_kanji_and_integer("一万百五十五", 10155)
  end

  it "一万百五十六" do
    compare_kanji_and_integer("一万百五十六", 10156)
  end

  it "一万百五十七" do
    compare_kanji_and_integer("一万百五十七", 10157)
  end

  it "一万百五十八" do
    compare_kanji_and_integer("一万百五十八", 10158)
  end

  it "一万百五十九" do
    compare_kanji_and_integer("一万百五十九", 10159)
  end

  it "一万百六十" do
    compare_kanji_and_integer("一万百六十", 10160)
  end

  it "一万百六十一" do
    compare_kanji_and_integer("一万百六十一", 10161)
  end

  it "一万百六十二" do
    compare_kanji_and_integer("一万百六十二", 10162)
  end

  it "一万百六十三" do
    compare_kanji_and_integer("一万百六十三", 10163)
  end

  it "一万百六十四" do
    compare_kanji_and_integer("一万百六十四", 10164)
  end

  it "一万百六十五" do
    compare_kanji_and_integer("一万百六十五", 10165)
  end

  it "一万百六十六" do
    compare_kanji_and_integer("一万百六十六", 10166)
  end

  it "一万百六十七" do
    compare_kanji_and_integer("一万百六十七", 10167)
  end

  it "一万百六十八" do
    compare_kanji_and_integer("一万百六十八", 10168)
  end

  it "一万百六十九" do
    compare_kanji_and_integer("一万百六十九", 10169)
  end

  it "一万百七十" do
    compare_kanji_and_integer("一万百七十", 10170)
  end

  it "一万百七十一" do
    compare_kanji_and_integer("一万百七十一", 10171)
  end

  it "一万百七十二" do
    compare_kanji_and_integer("一万百七十二", 10172)
  end

  it "一万百七十三" do
    compare_kanji_and_integer("一万百七十三", 10173)
  end

  it "一万百七十四" do
    compare_kanji_and_integer("一万百七十四", 10174)
  end

  it "一万百七十五" do
    compare_kanji_and_integer("一万百七十五", 10175)
  end

  it "一万百七十六" do
    compare_kanji_and_integer("一万百七十六", 10176)
  end

  it "一万百七十七" do
    compare_kanji_and_integer("一万百七十七", 10177)
  end

  it "一万百七十八" do
    compare_kanji_and_integer("一万百七十八", 10178)
  end

  it "一万百七十九" do
    compare_kanji_and_integer("一万百七十九", 10179)
  end

  it "一万百八十" do
    compare_kanji_and_integer("一万百八十", 10180)
  end

  it "一万百八十一" do
    compare_kanji_and_integer("一万百八十一", 10181)
  end

  it "一万百八十二" do
    compare_kanji_and_integer("一万百八十二", 10182)
  end

  it "一万百八十三" do
    compare_kanji_and_integer("一万百八十三", 10183)
  end

  it "一万百八十四" do
    compare_kanji_and_integer("一万百八十四", 10184)
  end

  it "一万百八十五" do
    compare_kanji_and_integer("一万百八十五", 10185)
  end

  it "一万百八十六" do
    compare_kanji_and_integer("一万百八十六", 10186)
  end

  it "一万百八十七" do
    compare_kanji_and_integer("一万百八十七", 10187)
  end

  it "一万百八十八" do
    compare_kanji_and_integer("一万百八十八", 10188)
  end

  it "一万百八十九" do
    compare_kanji_and_integer("一万百八十九", 10189)
  end

  it "一万百九十" do
    compare_kanji_and_integer("一万百九十", 10190)
  end

  it "一万百九十一" do
    compare_kanji_and_integer("一万百九十一", 10191)
  end

  it "一万百九十二" do
    compare_kanji_and_integer("一万百九十二", 10192)
  end

  it "一万百九十三" do
    compare_kanji_and_integer("一万百九十三", 10193)
  end

  it "一万百九十四" do
    compare_kanji_and_integer("一万百九十四", 10194)
  end

  it "一万百九十五" do
    compare_kanji_and_integer("一万百九十五", 10195)
  end

  it "一万百九十六" do
    compare_kanji_and_integer("一万百九十六", 10196)
  end

  it "一万百九十七" do
    compare_kanji_and_integer("一万百九十七", 10197)
  end

  it "一万百九十八" do
    compare_kanji_and_integer("一万百九十八", 10198)
  end

  it "一万百九十九" do
    compare_kanji_and_integer("一万百九十九", 10199)
  end

  it "一万二百" do
    compare_kanji_and_integer("一万二百", 10200)
  end

  it "一万二百一" do
    compare_kanji_and_integer("一万二百一", 10201)
  end

  it "一万二百二" do
    compare_kanji_and_integer("一万二百二", 10202)
  end

  it "一万二百三" do
    compare_kanji_and_integer("一万二百三", 10203)
  end

  it "一万二百四" do
    compare_kanji_and_integer("一万二百四", 10204)
  end

  it "一万二百五" do
    compare_kanji_and_integer("一万二百五", 10205)
  end

  it "一万二百六" do
    compare_kanji_and_integer("一万二百六", 10206)
  end

  it "一万二百七" do
    compare_kanji_and_integer("一万二百七", 10207)
  end

  it "一万二百八" do
    compare_kanji_and_integer("一万二百八", 10208)
  end

  it "一万二百九" do
    compare_kanji_and_integer("一万二百九", 10209)
  end

  it "一万二百十" do
    compare_kanji_and_integer("一万二百十", 10210)
  end

  it "一万二百十一" do
    compare_kanji_and_integer("一万二百十一", 10211)
  end

  it "一万二百十二" do
    compare_kanji_and_integer("一万二百十二", 10212)
  end

  it "一万二百十三" do
    compare_kanji_and_integer("一万二百十三", 10213)
  end

  it "一万二百十四" do
    compare_kanji_and_integer("一万二百十四", 10214)
  end

  it "一万二百十五" do
    compare_kanji_and_integer("一万二百十五", 10215)
  end

  it "一万二百十六" do
    compare_kanji_and_integer("一万二百十六", 10216)
  end

  it "一万二百十七" do
    compare_kanji_and_integer("一万二百十七", 10217)
  end

  it "一万二百十八" do
    compare_kanji_and_integer("一万二百十八", 10218)
  end

  it "一万二百十九" do
    compare_kanji_and_integer("一万二百十九", 10219)
  end

  it "一万二百二十" do
    compare_kanji_and_integer("一万二百二十", 10220)
  end

  it "一万二百二十一" do
    compare_kanji_and_integer("一万二百二十一", 10221)
  end

  it "一万二百二十二" do
    compare_kanji_and_integer("一万二百二十二", 10222)
  end

  it "一万二百二十三" do
    compare_kanji_and_integer("一万二百二十三", 10223)
  end

  it "一万二百二十四" do
    compare_kanji_and_integer("一万二百二十四", 10224)
  end

  it "一万二百二十五" do
    compare_kanji_and_integer("一万二百二十五", 10225)
  end

  it "一万二百二十六" do
    compare_kanji_and_integer("一万二百二十六", 10226)
  end

  it "一万二百二十七" do
    compare_kanji_and_integer("一万二百二十七", 10227)
  end

  it "一万二百二十八" do
    compare_kanji_and_integer("一万二百二十八", 10228)
  end

  it "一万二百二十九" do
    compare_kanji_and_integer("一万二百二十九", 10229)
  end

  it "一万二百三十" do
    compare_kanji_and_integer("一万二百三十", 10230)
  end

  it "一万二百三十一" do
    compare_kanji_and_integer("一万二百三十一", 10231)
  end

  it "一万二百三十二" do
    compare_kanji_and_integer("一万二百三十二", 10232)
  end

  it "一万二百三十三" do
    compare_kanji_and_integer("一万二百三十三", 10233)
  end

  it "一万二百三十四" do
    compare_kanji_and_integer("一万二百三十四", 10234)
  end

  it "一万二百三十五" do
    compare_kanji_and_integer("一万二百三十五", 10235)
  end

  it "一万二百三十六" do
    compare_kanji_and_integer("一万二百三十六", 10236)
  end

  it "一万二百三十七" do
    compare_kanji_and_integer("一万二百三十七", 10237)
  end

  it "一万二百三十八" do
    compare_kanji_and_integer("一万二百三十八", 10238)
  end

  it "一万二百三十九" do
    compare_kanji_and_integer("一万二百三十九", 10239)
  end

  it "一万二百四十" do
    compare_kanji_and_integer("一万二百四十", 10240)
  end

  it "一万二百四十一" do
    compare_kanji_and_integer("一万二百四十一", 10241)
  end

  it "一万二百四十二" do
    compare_kanji_and_integer("一万二百四十二", 10242)
  end

  it "一万二百四十三" do
    compare_kanji_and_integer("一万二百四十三", 10243)
  end

  it "一万二百四十四" do
    compare_kanji_and_integer("一万二百四十四", 10244)
  end

  it "一万二百四十五" do
    compare_kanji_and_integer("一万二百四十五", 10245)
  end

  it "一万二百四十六" do
    compare_kanji_and_integer("一万二百四十六", 10246)
  end

  it "一万二百四十七" do
    compare_kanji_and_integer("一万二百四十七", 10247)
  end

  it "一万二百四十八" do
    compare_kanji_and_integer("一万二百四十八", 10248)
  end

  it "一万二百四十九" do
    compare_kanji_and_integer("一万二百四十九", 10249)
  end

  it "一万二百五十" do
    compare_kanji_and_integer("一万二百五十", 10250)
  end

  it "一万二百五十一" do
    compare_kanji_and_integer("一万二百五十一", 10251)
  end

  it "一万二百五十二" do
    compare_kanji_and_integer("一万二百五十二", 10252)
  end

  it "一万二百五十三" do
    compare_kanji_and_integer("一万二百五十三", 10253)
  end

  it "一万二百五十四" do
    compare_kanji_and_integer("一万二百五十四", 10254)
  end

  it "一万二百五十五" do
    compare_kanji_and_integer("一万二百五十五", 10255)
  end

  it "一万二百五十六" do
    compare_kanji_and_integer("一万二百五十六", 10256)
  end

  it "一万二百五十七" do
    compare_kanji_and_integer("一万二百五十七", 10257)
  end

  it "一万二百五十八" do
    compare_kanji_and_integer("一万二百五十八", 10258)
  end

  it "一万二百五十九" do
    compare_kanji_and_integer("一万二百五十九", 10259)
  end

  it "一万二百六十" do
    compare_kanji_and_integer("一万二百六十", 10260)
  end

  it "一万二百六十一" do
    compare_kanji_and_integer("一万二百六十一", 10261)
  end

  it "一万二百六十二" do
    compare_kanji_and_integer("一万二百六十二", 10262)
  end

  it "一万二百六十三" do
    compare_kanji_and_integer("一万二百六十三", 10263)
  end

  it "一万二百六十四" do
    compare_kanji_and_integer("一万二百六十四", 10264)
  end

  it "一万二百六十五" do
    compare_kanji_and_integer("一万二百六十五", 10265)
  end

  it "一万二百六十六" do
    compare_kanji_and_integer("一万二百六十六", 10266)
  end

  it "一万二百六十七" do
    compare_kanji_and_integer("一万二百六十七", 10267)
  end

  it "一万二百六十八" do
    compare_kanji_and_integer("一万二百六十八", 10268)
  end

  it "一万二百六十九" do
    compare_kanji_and_integer("一万二百六十九", 10269)
  end

  it "一万二百七十" do
    compare_kanji_and_integer("一万二百七十", 10270)
  end

  it "一万二百七十一" do
    compare_kanji_and_integer("一万二百七十一", 10271)
  end

  it "一万二百七十二" do
    compare_kanji_and_integer("一万二百七十二", 10272)
  end

  it "一万二百七十三" do
    compare_kanji_and_integer("一万二百七十三", 10273)
  end

  it "一万二百七十四" do
    compare_kanji_and_integer("一万二百七十四", 10274)
  end

  it "一万二百七十五" do
    compare_kanji_and_integer("一万二百七十五", 10275)
  end

  it "一万二百七十六" do
    compare_kanji_and_integer("一万二百七十六", 10276)
  end

  it "一万二百七十七" do
    compare_kanji_and_integer("一万二百七十七", 10277)
  end

  it "一万二百七十八" do
    compare_kanji_and_integer("一万二百七十八", 10278)
  end

  it "一万二百七十九" do
    compare_kanji_and_integer("一万二百七十九", 10279)
  end

  it "一万二百八十" do
    compare_kanji_and_integer("一万二百八十", 10280)
  end

  it "一万二百八十一" do
    compare_kanji_and_integer("一万二百八十一", 10281)
  end

  it "一万二百八十二" do
    compare_kanji_and_integer("一万二百八十二", 10282)
  end

  it "一万二百八十三" do
    compare_kanji_and_integer("一万二百八十三", 10283)
  end

  it "一万二百八十四" do
    compare_kanji_and_integer("一万二百八十四", 10284)
  end

  it "一万二百八十五" do
    compare_kanji_and_integer("一万二百八十五", 10285)
  end

  it "一万二百八十六" do
    compare_kanji_and_integer("一万二百八十六", 10286)
  end

  it "一万二百八十七" do
    compare_kanji_and_integer("一万二百八十七", 10287)
  end

  it "一万二百八十八" do
    compare_kanji_and_integer("一万二百八十八", 10288)
  end

  it "一万二百八十九" do
    compare_kanji_and_integer("一万二百八十九", 10289)
  end

  it "一万二百九十" do
    compare_kanji_and_integer("一万二百九十", 10290)
  end

  it "一万二百九十一" do
    compare_kanji_and_integer("一万二百九十一", 10291)
  end

  it "一万二百九十二" do
    compare_kanji_and_integer("一万二百九十二", 10292)
  end

  it "一万二百九十三" do
    compare_kanji_and_integer("一万二百九十三", 10293)
  end

  it "一万二百九十四" do
    compare_kanji_and_integer("一万二百九十四", 10294)
  end

  it "一万二百九十五" do
    compare_kanji_and_integer("一万二百九十五", 10295)
  end

  it "一万二百九十六" do
    compare_kanji_and_integer("一万二百九十六", 10296)
  end

  it "一万二百九十七" do
    compare_kanji_and_integer("一万二百九十七", 10297)
  end

  it "一万二百九十八" do
    compare_kanji_and_integer("一万二百九十八", 10298)
  end

  it "一万二百九十九" do
    compare_kanji_and_integer("一万二百九十九", 10299)
  end

  it "一万三百" do
    compare_kanji_and_integer("一万三百", 10300)
  end

  it "一万三百一" do
    compare_kanji_and_integer("一万三百一", 10301)
  end

  it "一万三百二" do
    compare_kanji_and_integer("一万三百二", 10302)
  end

  it "一万三百三" do
    compare_kanji_and_integer("一万三百三", 10303)
  end

  it "一万三百四" do
    compare_kanji_and_integer("一万三百四", 10304)
  end

  it "一万三百五" do
    compare_kanji_and_integer("一万三百五", 10305)
  end

  it "一万三百六" do
    compare_kanji_and_integer("一万三百六", 10306)
  end

  it "一万三百七" do
    compare_kanji_and_integer("一万三百七", 10307)
  end

  it "一万三百八" do
    compare_kanji_and_integer("一万三百八", 10308)
  end

  it "一万三百九" do
    compare_kanji_and_integer("一万三百九", 10309)
  end

  it "一万三百十" do
    compare_kanji_and_integer("一万三百十", 10310)
  end

  it "一万三百十一" do
    compare_kanji_and_integer("一万三百十一", 10311)
  end

  it "一万三百十二" do
    compare_kanji_and_integer("一万三百十二", 10312)
  end

  it "一万三百十三" do
    compare_kanji_and_integer("一万三百十三", 10313)
  end

  it "一万三百十四" do
    compare_kanji_and_integer("一万三百十四", 10314)
  end

  it "一万三百十五" do
    compare_kanji_and_integer("一万三百十五", 10315)
  end

  it "一万三百十六" do
    compare_kanji_and_integer("一万三百十六", 10316)
  end

  it "一万三百十七" do
    compare_kanji_and_integer("一万三百十七", 10317)
  end

  it "一万三百十八" do
    compare_kanji_and_integer("一万三百十八", 10318)
  end

  it "一万三百十九" do
    compare_kanji_and_integer("一万三百十九", 10319)
  end

  it "一万三百二十" do
    compare_kanji_and_integer("一万三百二十", 10320)
  end

  it "一万三百二十一" do
    compare_kanji_and_integer("一万三百二十一", 10321)
  end

  it "一万三百二十二" do
    compare_kanji_and_integer("一万三百二十二", 10322)
  end

  it "一万三百二十三" do
    compare_kanji_and_integer("一万三百二十三", 10323)
  end

  it "一万三百二十四" do
    compare_kanji_and_integer("一万三百二十四", 10324)
  end

  it "一万三百二十五" do
    compare_kanji_and_integer("一万三百二十五", 10325)
  end

  it "一万三百二十六" do
    compare_kanji_and_integer("一万三百二十六", 10326)
  end

  it "一万三百二十七" do
    compare_kanji_and_integer("一万三百二十七", 10327)
  end

  it "一万三百二十八" do
    compare_kanji_and_integer("一万三百二十八", 10328)
  end

  it "一万三百二十九" do
    compare_kanji_and_integer("一万三百二十九", 10329)
  end

  it "一万三百三十" do
    compare_kanji_and_integer("一万三百三十", 10330)
  end

  it "一万三百三十一" do
    compare_kanji_and_integer("一万三百三十一", 10331)
  end

  it "一万三百三十二" do
    compare_kanji_and_integer("一万三百三十二", 10332)
  end

  it "一万三百三十三" do
    compare_kanji_and_integer("一万三百三十三", 10333)
  end

  it "一万三百三十四" do
    compare_kanji_and_integer("一万三百三十四", 10334)
  end

  it "一万三百三十五" do
    compare_kanji_and_integer("一万三百三十五", 10335)
  end

  it "一万三百三十六" do
    compare_kanji_and_integer("一万三百三十六", 10336)
  end

  it "一万三百三十七" do
    compare_kanji_and_integer("一万三百三十七", 10337)
  end

  it "一万三百三十八" do
    compare_kanji_and_integer("一万三百三十八", 10338)
  end

  it "一万三百三十九" do
    compare_kanji_and_integer("一万三百三十九", 10339)
  end

  it "一万三百四十" do
    compare_kanji_and_integer("一万三百四十", 10340)
  end

  it "一万三百四十一" do
    compare_kanji_and_integer("一万三百四十一", 10341)
  end

  it "一万三百四十二" do
    compare_kanji_and_integer("一万三百四十二", 10342)
  end

  it "一万三百四十三" do
    compare_kanji_and_integer("一万三百四十三", 10343)
  end

  it "一万三百四十四" do
    compare_kanji_and_integer("一万三百四十四", 10344)
  end

  it "一万三百四十五" do
    compare_kanji_and_integer("一万三百四十五", 10345)
  end

  it "一万三百四十六" do
    compare_kanji_and_integer("一万三百四十六", 10346)
  end

  it "一万三百四十七" do
    compare_kanji_and_integer("一万三百四十七", 10347)
  end

  it "一万三百四十八" do
    compare_kanji_and_integer("一万三百四十八", 10348)
  end

  it "一万三百四十九" do
    compare_kanji_and_integer("一万三百四十九", 10349)
  end

  it "一万三百五十" do
    compare_kanji_and_integer("一万三百五十", 10350)
  end

  it "一万三百五十一" do
    compare_kanji_and_integer("一万三百五十一", 10351)
  end

  it "一万三百五十二" do
    compare_kanji_and_integer("一万三百五十二", 10352)
  end

  it "一万三百五十三" do
    compare_kanji_and_integer("一万三百五十三", 10353)
  end

  it "一万三百五十四" do
    compare_kanji_and_integer("一万三百五十四", 10354)
  end

  it "一万三百五十五" do
    compare_kanji_and_integer("一万三百五十五", 10355)
  end

  it "一万三百五十六" do
    compare_kanji_and_integer("一万三百五十六", 10356)
  end

  it "一万三百五十七" do
    compare_kanji_and_integer("一万三百五十七", 10357)
  end

  it "一万三百五十八" do
    compare_kanji_and_integer("一万三百五十八", 10358)
  end

  it "一万三百五十九" do
    compare_kanji_and_integer("一万三百五十九", 10359)
  end

  it "一万三百六十" do
    compare_kanji_and_integer("一万三百六十", 10360)
  end

  it "一万三百六十一" do
    compare_kanji_and_integer("一万三百六十一", 10361)
  end

  it "一万三百六十二" do
    compare_kanji_and_integer("一万三百六十二", 10362)
  end

  it "一万三百六十三" do
    compare_kanji_and_integer("一万三百六十三", 10363)
  end

  it "一万三百六十四" do
    compare_kanji_and_integer("一万三百六十四", 10364)
  end

  it "一万三百六十五" do
    compare_kanji_and_integer("一万三百六十五", 10365)
  end

  it "一万三百六十六" do
    compare_kanji_and_integer("一万三百六十六", 10366)
  end

  it "一万三百六十七" do
    compare_kanji_and_integer("一万三百六十七", 10367)
  end

  it "一万三百六十八" do
    compare_kanji_and_integer("一万三百六十八", 10368)
  end

  it "一万三百六十九" do
    compare_kanji_and_integer("一万三百六十九", 10369)
  end

  it "一万三百七十" do
    compare_kanji_and_integer("一万三百七十", 10370)
  end

  it "一万三百七十一" do
    compare_kanji_and_integer("一万三百七十一", 10371)
  end

  it "一万三百七十二" do
    compare_kanji_and_integer("一万三百七十二", 10372)
  end

  it "一万三百七十三" do
    compare_kanji_and_integer("一万三百七十三", 10373)
  end

  it "一万三百七十四" do
    compare_kanji_and_integer("一万三百七十四", 10374)
  end

  it "一万三百七十五" do
    compare_kanji_and_integer("一万三百七十五", 10375)
  end

  it "一万三百七十六" do
    compare_kanji_and_integer("一万三百七十六", 10376)
  end

  it "一万三百七十七" do
    compare_kanji_and_integer("一万三百七十七", 10377)
  end

  it "一万三百七十八" do
    compare_kanji_and_integer("一万三百七十八", 10378)
  end

  it "一万三百七十九" do
    compare_kanji_and_integer("一万三百七十九", 10379)
  end

  it "一万三百八十" do
    compare_kanji_and_integer("一万三百八十", 10380)
  end

  it "一万三百八十一" do
    compare_kanji_and_integer("一万三百八十一", 10381)
  end

  it "一万三百八十二" do
    compare_kanji_and_integer("一万三百八十二", 10382)
  end

  it "一万三百八十三" do
    compare_kanji_and_integer("一万三百八十三", 10383)
  end

  it "一万三百八十四" do
    compare_kanji_and_integer("一万三百八十四", 10384)
  end

  it "一万三百八十五" do
    compare_kanji_and_integer("一万三百八十五", 10385)
  end

  it "一万三百八十六" do
    compare_kanji_and_integer("一万三百八十六", 10386)
  end

  it "一万三百八十七" do
    compare_kanji_and_integer("一万三百八十七", 10387)
  end

  it "一万三百八十八" do
    compare_kanji_and_integer("一万三百八十八", 10388)
  end

  it "一万三百八十九" do
    compare_kanji_and_integer("一万三百八十九", 10389)
  end

  it "一万三百九十" do
    compare_kanji_and_integer("一万三百九十", 10390)
  end

  it "一万三百九十一" do
    compare_kanji_and_integer("一万三百九十一", 10391)
  end

  it "一万三百九十二" do
    compare_kanji_and_integer("一万三百九十二", 10392)
  end

  it "一万三百九十三" do
    compare_kanji_and_integer("一万三百九十三", 10393)
  end

  it "一万三百九十四" do
    compare_kanji_and_integer("一万三百九十四", 10394)
  end

  it "一万三百九十五" do
    compare_kanji_and_integer("一万三百九十五", 10395)
  end

  it "一万三百九十六" do
    compare_kanji_and_integer("一万三百九十六", 10396)
  end

  it "一万三百九十七" do
    compare_kanji_and_integer("一万三百九十七", 10397)
  end

  it "一万三百九十八" do
    compare_kanji_and_integer("一万三百九十八", 10398)
  end

  it "一万三百九十九" do
    compare_kanji_and_integer("一万三百九十九", 10399)
  end

  it "一万四百" do
    compare_kanji_and_integer("一万四百", 10400)
  end

  it "一万四百一" do
    compare_kanji_and_integer("一万四百一", 10401)
  end

  it "一万四百二" do
    compare_kanji_and_integer("一万四百二", 10402)
  end

  it "一万四百三" do
    compare_kanji_and_integer("一万四百三", 10403)
  end

  it "一万四百四" do
    compare_kanji_and_integer("一万四百四", 10404)
  end

  it "一万四百五" do
    compare_kanji_and_integer("一万四百五", 10405)
  end

  it "一万四百六" do
    compare_kanji_and_integer("一万四百六", 10406)
  end

  it "一万四百七" do
    compare_kanji_and_integer("一万四百七", 10407)
  end

  it "一万四百八" do
    compare_kanji_and_integer("一万四百八", 10408)
  end

  it "一万四百九" do
    compare_kanji_and_integer("一万四百九", 10409)
  end

  it "一万四百十" do
    compare_kanji_and_integer("一万四百十", 10410)
  end

  it "一万四百十一" do
    compare_kanji_and_integer("一万四百十一", 10411)
  end

  it "一万四百十二" do
    compare_kanji_and_integer("一万四百十二", 10412)
  end

  it "一万四百十三" do
    compare_kanji_and_integer("一万四百十三", 10413)
  end

  it "一万四百十四" do
    compare_kanji_and_integer("一万四百十四", 10414)
  end

  it "一万四百十五" do
    compare_kanji_and_integer("一万四百十五", 10415)
  end

  it "一万四百十六" do
    compare_kanji_and_integer("一万四百十六", 10416)
  end

  it "一万四百十七" do
    compare_kanji_and_integer("一万四百十七", 10417)
  end

  it "一万四百十八" do
    compare_kanji_and_integer("一万四百十八", 10418)
  end

  it "一万四百十九" do
    compare_kanji_and_integer("一万四百十九", 10419)
  end

  it "一万四百二十" do
    compare_kanji_and_integer("一万四百二十", 10420)
  end

  it "一万四百二十一" do
    compare_kanji_and_integer("一万四百二十一", 10421)
  end

  it "一万四百二十二" do
    compare_kanji_and_integer("一万四百二十二", 10422)
  end

  it "一万四百二十三" do
    compare_kanji_and_integer("一万四百二十三", 10423)
  end

  it "一万四百二十四" do
    compare_kanji_and_integer("一万四百二十四", 10424)
  end

  it "一万四百二十五" do
    compare_kanji_and_integer("一万四百二十五", 10425)
  end

  it "一万四百二十六" do
    compare_kanji_and_integer("一万四百二十六", 10426)
  end

  it "一万四百二十七" do
    compare_kanji_and_integer("一万四百二十七", 10427)
  end

  it "一万四百二十八" do
    compare_kanji_and_integer("一万四百二十八", 10428)
  end

  it "一万四百二十九" do
    compare_kanji_and_integer("一万四百二十九", 10429)
  end

  it "一万四百三十" do
    compare_kanji_and_integer("一万四百三十", 10430)
  end

  it "一万四百三十一" do
    compare_kanji_and_integer("一万四百三十一", 10431)
  end

  it "一万四百三十二" do
    compare_kanji_and_integer("一万四百三十二", 10432)
  end

  it "一万四百三十三" do
    compare_kanji_and_integer("一万四百三十三", 10433)
  end

  it "一万四百三十四" do
    compare_kanji_and_integer("一万四百三十四", 10434)
  end

  it "一万四百三十五" do
    compare_kanji_and_integer("一万四百三十五", 10435)
  end

  it "一万四百三十六" do
    compare_kanji_and_integer("一万四百三十六", 10436)
  end

  it "一万四百三十七" do
    compare_kanji_and_integer("一万四百三十七", 10437)
  end

  it "一万四百三十八" do
    compare_kanji_and_integer("一万四百三十八", 10438)
  end

  it "一万四百三十九" do
    compare_kanji_and_integer("一万四百三十九", 10439)
  end

  it "一万四百四十" do
    compare_kanji_and_integer("一万四百四十", 10440)
  end

  it "一万四百四十一" do
    compare_kanji_and_integer("一万四百四十一", 10441)
  end

  it "一万四百四十二" do
    compare_kanji_and_integer("一万四百四十二", 10442)
  end

  it "一万四百四十三" do
    compare_kanji_and_integer("一万四百四十三", 10443)
  end

  it "一万四百四十四" do
    compare_kanji_and_integer("一万四百四十四", 10444)
  end

  it "一万四百四十五" do
    compare_kanji_and_integer("一万四百四十五", 10445)
  end

  it "一万四百四十六" do
    compare_kanji_and_integer("一万四百四十六", 10446)
  end

  it "一万四百四十七" do
    compare_kanji_and_integer("一万四百四十七", 10447)
  end

  it "一万四百四十八" do
    compare_kanji_and_integer("一万四百四十八", 10448)
  end

  it "一万四百四十九" do
    compare_kanji_and_integer("一万四百四十九", 10449)
  end

  it "一万四百五十" do
    compare_kanji_and_integer("一万四百五十", 10450)
  end

  it "一万四百五十一" do
    compare_kanji_and_integer("一万四百五十一", 10451)
  end

  it "一万四百五十二" do
    compare_kanji_and_integer("一万四百五十二", 10452)
  end

  it "一万四百五十三" do
    compare_kanji_and_integer("一万四百五十三", 10453)
  end

  it "一万四百五十四" do
    compare_kanji_and_integer("一万四百五十四", 10454)
  end

  it "一万四百五十五" do
    compare_kanji_and_integer("一万四百五十五", 10455)
  end

  it "一万四百五十六" do
    compare_kanji_and_integer("一万四百五十六", 10456)
  end

  it "一万四百五十七" do
    compare_kanji_and_integer("一万四百五十七", 10457)
  end

  it "一万四百五十八" do
    compare_kanji_and_integer("一万四百五十八", 10458)
  end

  it "一万四百五十九" do
    compare_kanji_and_integer("一万四百五十九", 10459)
  end

  it "一万四百六十" do
    compare_kanji_and_integer("一万四百六十", 10460)
  end

  it "一万四百六十一" do
    compare_kanji_and_integer("一万四百六十一", 10461)
  end

  it "一万四百六十二" do
    compare_kanji_and_integer("一万四百六十二", 10462)
  end

  it "一万四百六十三" do
    compare_kanji_and_integer("一万四百六十三", 10463)
  end

  it "一万四百六十四" do
    compare_kanji_and_integer("一万四百六十四", 10464)
  end

  it "一万四百六十五" do
    compare_kanji_and_integer("一万四百六十五", 10465)
  end

  it "一万四百六十六" do
    compare_kanji_and_integer("一万四百六十六", 10466)
  end

  it "一万四百六十七" do
    compare_kanji_and_integer("一万四百六十七", 10467)
  end

  it "一万四百六十八" do
    compare_kanji_and_integer("一万四百六十八", 10468)
  end

  it "一万四百六十九" do
    compare_kanji_and_integer("一万四百六十九", 10469)
  end

  it "一万四百七十" do
    compare_kanji_and_integer("一万四百七十", 10470)
  end

  it "一万四百七十一" do
    compare_kanji_and_integer("一万四百七十一", 10471)
  end

  it "一万四百七十二" do
    compare_kanji_and_integer("一万四百七十二", 10472)
  end

  it "一万四百七十三" do
    compare_kanji_and_integer("一万四百七十三", 10473)
  end

  it "一万四百七十四" do
    compare_kanji_and_integer("一万四百七十四", 10474)
  end

  it "一万四百七十五" do
    compare_kanji_and_integer("一万四百七十五", 10475)
  end

  it "一万四百七十六" do
    compare_kanji_and_integer("一万四百七十六", 10476)
  end

  it "一万四百七十七" do
    compare_kanji_and_integer("一万四百七十七", 10477)
  end

  it "一万四百七十八" do
    compare_kanji_and_integer("一万四百七十八", 10478)
  end

  it "一万四百七十九" do
    compare_kanji_and_integer("一万四百七十九", 10479)
  end

  it "一万四百八十" do
    compare_kanji_and_integer("一万四百八十", 10480)
  end

  it "一万四百八十一" do
    compare_kanji_and_integer("一万四百八十一", 10481)
  end

  it "一万四百八十二" do
    compare_kanji_and_integer("一万四百八十二", 10482)
  end

  it "一万四百八十三" do
    compare_kanji_and_integer("一万四百八十三", 10483)
  end

  it "一万四百八十四" do
    compare_kanji_and_integer("一万四百八十四", 10484)
  end

  it "一万四百八十五" do
    compare_kanji_and_integer("一万四百八十五", 10485)
  end

  it "一万四百八十六" do
    compare_kanji_and_integer("一万四百八十六", 10486)
  end

  it "一万四百八十七" do
    compare_kanji_and_integer("一万四百八十七", 10487)
  end

  it "一万四百八十八" do
    compare_kanji_and_integer("一万四百八十八", 10488)
  end

  it "一万四百八十九" do
    compare_kanji_and_integer("一万四百八十九", 10489)
  end

  it "一万四百九十" do
    compare_kanji_and_integer("一万四百九十", 10490)
  end

  it "一万四百九十一" do
    compare_kanji_and_integer("一万四百九十一", 10491)
  end

  it "一万四百九十二" do
    compare_kanji_and_integer("一万四百九十二", 10492)
  end

  it "一万四百九十三" do
    compare_kanji_and_integer("一万四百九十三", 10493)
  end

  it "一万四百九十四" do
    compare_kanji_and_integer("一万四百九十四", 10494)
  end

  it "一万四百九十五" do
    compare_kanji_and_integer("一万四百九十五", 10495)
  end

  it "一万四百九十六" do
    compare_kanji_and_integer("一万四百九十六", 10496)
  end

  it "一万四百九十七" do
    compare_kanji_and_integer("一万四百九十七", 10497)
  end

  it "一万四百九十八" do
    compare_kanji_and_integer("一万四百九十八", 10498)
  end

  it "一万四百九十九" do
    compare_kanji_and_integer("一万四百九十九", 10499)
  end

  it "一万五百" do
    compare_kanji_and_integer("一万五百", 10500)
  end

  it "一万五百一" do
    compare_kanji_and_integer("一万五百一", 10501)
  end

  it "一万五百二" do
    compare_kanji_and_integer("一万五百二", 10502)
  end

  it "一万五百三" do
    compare_kanji_and_integer("一万五百三", 10503)
  end

  it "一万五百四" do
    compare_kanji_and_integer("一万五百四", 10504)
  end

  it "一万五百五" do
    compare_kanji_and_integer("一万五百五", 10505)
  end

  it "一万五百六" do
    compare_kanji_and_integer("一万五百六", 10506)
  end

  it "一万五百七" do
    compare_kanji_and_integer("一万五百七", 10507)
  end

  it "一万五百八" do
    compare_kanji_and_integer("一万五百八", 10508)
  end

  it "一万五百九" do
    compare_kanji_and_integer("一万五百九", 10509)
  end

  it "一万五百十" do
    compare_kanji_and_integer("一万五百十", 10510)
  end

  it "一万五百十一" do
    compare_kanji_and_integer("一万五百十一", 10511)
  end

  it "一万五百十二" do
    compare_kanji_and_integer("一万五百十二", 10512)
  end

  it "一万五百十三" do
    compare_kanji_and_integer("一万五百十三", 10513)
  end

  it "一万五百十四" do
    compare_kanji_and_integer("一万五百十四", 10514)
  end

  it "一万五百十五" do
    compare_kanji_and_integer("一万五百十五", 10515)
  end

  it "一万五百十六" do
    compare_kanji_and_integer("一万五百十六", 10516)
  end

  it "一万五百十七" do
    compare_kanji_and_integer("一万五百十七", 10517)
  end

  it "一万五百十八" do
    compare_kanji_and_integer("一万五百十八", 10518)
  end

  it "一万五百十九" do
    compare_kanji_and_integer("一万五百十九", 10519)
  end

  it "一万五百二十" do
    compare_kanji_and_integer("一万五百二十", 10520)
  end

  it "一万五百二十一" do
    compare_kanji_and_integer("一万五百二十一", 10521)
  end

  it "一万五百二十二" do
    compare_kanji_and_integer("一万五百二十二", 10522)
  end

  it "一万五百二十三" do
    compare_kanji_and_integer("一万五百二十三", 10523)
  end

  it "一万五百二十四" do
    compare_kanji_and_integer("一万五百二十四", 10524)
  end

  it "一万五百二十五" do
    compare_kanji_and_integer("一万五百二十五", 10525)
  end

  it "一万五百二十六" do
    compare_kanji_and_integer("一万五百二十六", 10526)
  end

  it "一万五百二十七" do
    compare_kanji_and_integer("一万五百二十七", 10527)
  end

  it "一万五百二十八" do
    compare_kanji_and_integer("一万五百二十八", 10528)
  end

  it "一万五百二十九" do
    compare_kanji_and_integer("一万五百二十九", 10529)
  end

  it "一万五百三十" do
    compare_kanji_and_integer("一万五百三十", 10530)
  end

  it "一万五百三十一" do
    compare_kanji_and_integer("一万五百三十一", 10531)
  end

  it "一万五百三十二" do
    compare_kanji_and_integer("一万五百三十二", 10532)
  end

  it "一万五百三十三" do
    compare_kanji_and_integer("一万五百三十三", 10533)
  end

  it "一万五百三十四" do
    compare_kanji_and_integer("一万五百三十四", 10534)
  end

  it "一万五百三十五" do
    compare_kanji_and_integer("一万五百三十五", 10535)
  end

  it "一万五百三十六" do
    compare_kanji_and_integer("一万五百三十六", 10536)
  end

  it "一万五百三十七" do
    compare_kanji_and_integer("一万五百三十七", 10537)
  end

  it "一万五百三十八" do
    compare_kanji_and_integer("一万五百三十八", 10538)
  end

  it "一万五百三十九" do
    compare_kanji_and_integer("一万五百三十九", 10539)
  end

  it "一万五百四十" do
    compare_kanji_and_integer("一万五百四十", 10540)
  end

  it "一万五百四十一" do
    compare_kanji_and_integer("一万五百四十一", 10541)
  end

  it "一万五百四十二" do
    compare_kanji_and_integer("一万五百四十二", 10542)
  end

  it "一万五百四十三" do
    compare_kanji_and_integer("一万五百四十三", 10543)
  end

  it "一万五百四十四" do
    compare_kanji_and_integer("一万五百四十四", 10544)
  end

  it "一万五百四十五" do
    compare_kanji_and_integer("一万五百四十五", 10545)
  end

  it "一万五百四十六" do
    compare_kanji_and_integer("一万五百四十六", 10546)
  end

  it "一万五百四十七" do
    compare_kanji_and_integer("一万五百四十七", 10547)
  end

  it "一万五百四十八" do
    compare_kanji_and_integer("一万五百四十八", 10548)
  end

  it "一万五百四十九" do
    compare_kanji_and_integer("一万五百四十九", 10549)
  end

  it "一万五百五十" do
    compare_kanji_and_integer("一万五百五十", 10550)
  end

  it "一万五百五十一" do
    compare_kanji_and_integer("一万五百五十一", 10551)
  end

  it "一万五百五十二" do
    compare_kanji_and_integer("一万五百五十二", 10552)
  end

  it "一万五百五十三" do
    compare_kanji_and_integer("一万五百五十三", 10553)
  end

  it "一万五百五十四" do
    compare_kanji_and_integer("一万五百五十四", 10554)
  end

  it "一万五百五十五" do
    compare_kanji_and_integer("一万五百五十五", 10555)
  end

  it "一万五百五十六" do
    compare_kanji_and_integer("一万五百五十六", 10556)
  end

  it "一万五百五十七" do
    compare_kanji_and_integer("一万五百五十七", 10557)
  end

  it "一万五百五十八" do
    compare_kanji_and_integer("一万五百五十八", 10558)
  end

  it "一万五百五十九" do
    compare_kanji_and_integer("一万五百五十九", 10559)
  end

  it "一万五百六十" do
    compare_kanji_and_integer("一万五百六十", 10560)
  end

  it "一万五百六十一" do
    compare_kanji_and_integer("一万五百六十一", 10561)
  end

  it "一万五百六十二" do
    compare_kanji_and_integer("一万五百六十二", 10562)
  end

  it "一万五百六十三" do
    compare_kanji_and_integer("一万五百六十三", 10563)
  end

  it "一万五百六十四" do
    compare_kanji_and_integer("一万五百六十四", 10564)
  end

  it "一万五百六十五" do
    compare_kanji_and_integer("一万五百六十五", 10565)
  end

  it "一万五百六十六" do
    compare_kanji_and_integer("一万五百六十六", 10566)
  end

  it "一万五百六十七" do
    compare_kanji_and_integer("一万五百六十七", 10567)
  end

  it "一万五百六十八" do
    compare_kanji_and_integer("一万五百六十八", 10568)
  end

  it "一万五百六十九" do
    compare_kanji_and_integer("一万五百六十九", 10569)
  end

  it "一万五百七十" do
    compare_kanji_and_integer("一万五百七十", 10570)
  end

  it "一万五百七十一" do
    compare_kanji_and_integer("一万五百七十一", 10571)
  end

  it "一万五百七十二" do
    compare_kanji_and_integer("一万五百七十二", 10572)
  end

  it "一万五百七十三" do
    compare_kanji_and_integer("一万五百七十三", 10573)
  end

  it "一万五百七十四" do
    compare_kanji_and_integer("一万五百七十四", 10574)
  end

  it "一万五百七十五" do
    compare_kanji_and_integer("一万五百七十五", 10575)
  end

  it "一万五百七十六" do
    compare_kanji_and_integer("一万五百七十六", 10576)
  end

  it "一万五百七十七" do
    compare_kanji_and_integer("一万五百七十七", 10577)
  end

  it "一万五百七十八" do
    compare_kanji_and_integer("一万五百七十八", 10578)
  end

  it "一万五百七十九" do
    compare_kanji_and_integer("一万五百七十九", 10579)
  end

  it "一万五百八十" do
    compare_kanji_and_integer("一万五百八十", 10580)
  end

  it "一万五百八十一" do
    compare_kanji_and_integer("一万五百八十一", 10581)
  end

  it "一万五百八十二" do
    compare_kanji_and_integer("一万五百八十二", 10582)
  end

  it "一万五百八十三" do
    compare_kanji_and_integer("一万五百八十三", 10583)
  end

  it "一万五百八十四" do
    compare_kanji_and_integer("一万五百八十四", 10584)
  end

  it "一万五百八十五" do
    compare_kanji_and_integer("一万五百八十五", 10585)
  end

  it "一万五百八十六" do
    compare_kanji_and_integer("一万五百八十六", 10586)
  end

  it "一万五百八十七" do
    compare_kanji_and_integer("一万五百八十七", 10587)
  end

  it "一万五百八十八" do
    compare_kanji_and_integer("一万五百八十八", 10588)
  end

  it "一万五百八十九" do
    compare_kanji_and_integer("一万五百八十九", 10589)
  end

  it "一万五百九十" do
    compare_kanji_and_integer("一万五百九十", 10590)
  end

  it "一万五百九十一" do
    compare_kanji_and_integer("一万五百九十一", 10591)
  end

  it "一万五百九十二" do
    compare_kanji_and_integer("一万五百九十二", 10592)
  end

  it "一万五百九十三" do
    compare_kanji_and_integer("一万五百九十三", 10593)
  end

  it "一万五百九十四" do
    compare_kanji_and_integer("一万五百九十四", 10594)
  end

  it "一万五百九十五" do
    compare_kanji_and_integer("一万五百九十五", 10595)
  end

  it "一万五百九十六" do
    compare_kanji_and_integer("一万五百九十六", 10596)
  end

  it "一万五百九十七" do
    compare_kanji_and_integer("一万五百九十七", 10597)
  end

  it "一万五百九十八" do
    compare_kanji_and_integer("一万五百九十八", 10598)
  end

  it "一万五百九十九" do
    compare_kanji_and_integer("一万五百九十九", 10599)
  end

  it "一万六百" do
    compare_kanji_and_integer("一万六百", 10600)
  end

  it "一万六百一" do
    compare_kanji_and_integer("一万六百一", 10601)
  end

  it "一万六百二" do
    compare_kanji_and_integer("一万六百二", 10602)
  end

  it "一万六百三" do
    compare_kanji_and_integer("一万六百三", 10603)
  end

  it "一万六百四" do
    compare_kanji_and_integer("一万六百四", 10604)
  end

  it "一万六百五" do
    compare_kanji_and_integer("一万六百五", 10605)
  end

  it "一万六百六" do
    compare_kanji_and_integer("一万六百六", 10606)
  end

  it "一万六百七" do
    compare_kanji_and_integer("一万六百七", 10607)
  end

  it "一万六百八" do
    compare_kanji_and_integer("一万六百八", 10608)
  end

  it "一万六百九" do
    compare_kanji_and_integer("一万六百九", 10609)
  end

  it "一万六百十" do
    compare_kanji_and_integer("一万六百十", 10610)
  end

  it "一万六百十一" do
    compare_kanji_and_integer("一万六百十一", 10611)
  end

  it "一万六百十二" do
    compare_kanji_and_integer("一万六百十二", 10612)
  end

  it "一万六百十三" do
    compare_kanji_and_integer("一万六百十三", 10613)
  end

  it "一万六百十四" do
    compare_kanji_and_integer("一万六百十四", 10614)
  end

  it "一万六百十五" do
    compare_kanji_and_integer("一万六百十五", 10615)
  end

  it "一万六百十六" do
    compare_kanji_and_integer("一万六百十六", 10616)
  end

  it "一万六百十七" do
    compare_kanji_and_integer("一万六百十七", 10617)
  end

  it "一万六百十八" do
    compare_kanji_and_integer("一万六百十八", 10618)
  end

  it "一万六百十九" do
    compare_kanji_and_integer("一万六百十九", 10619)
  end

  it "一万六百二十" do
    compare_kanji_and_integer("一万六百二十", 10620)
  end

  it "一万六百二十一" do
    compare_kanji_and_integer("一万六百二十一", 10621)
  end

  it "一万六百二十二" do
    compare_kanji_and_integer("一万六百二十二", 10622)
  end

  it "一万六百二十三" do
    compare_kanji_and_integer("一万六百二十三", 10623)
  end

  it "一万六百二十四" do
    compare_kanji_and_integer("一万六百二十四", 10624)
  end

  it "一万六百二十五" do
    compare_kanji_and_integer("一万六百二十五", 10625)
  end

  it "一万六百二十六" do
    compare_kanji_and_integer("一万六百二十六", 10626)
  end

  it "一万六百二十七" do
    compare_kanji_and_integer("一万六百二十七", 10627)
  end

  it "一万六百二十八" do
    compare_kanji_and_integer("一万六百二十八", 10628)
  end

  it "一万六百二十九" do
    compare_kanji_and_integer("一万六百二十九", 10629)
  end

  it "一万六百三十" do
    compare_kanji_and_integer("一万六百三十", 10630)
  end

  it "一万六百三十一" do
    compare_kanji_and_integer("一万六百三十一", 10631)
  end

  it "一万六百三十二" do
    compare_kanji_and_integer("一万六百三十二", 10632)
  end

  it "一万六百三十三" do
    compare_kanji_and_integer("一万六百三十三", 10633)
  end

  it "一万六百三十四" do
    compare_kanji_and_integer("一万六百三十四", 10634)
  end

  it "一万六百三十五" do
    compare_kanji_and_integer("一万六百三十五", 10635)
  end

  it "一万六百三十六" do
    compare_kanji_and_integer("一万六百三十六", 10636)
  end

  it "一万六百三十七" do
    compare_kanji_and_integer("一万六百三十七", 10637)
  end

  it "一万六百三十八" do
    compare_kanji_and_integer("一万六百三十八", 10638)
  end

  it "一万六百三十九" do
    compare_kanji_and_integer("一万六百三十九", 10639)
  end

  it "一万六百四十" do
    compare_kanji_and_integer("一万六百四十", 10640)
  end

  it "一万六百四十一" do
    compare_kanji_and_integer("一万六百四十一", 10641)
  end

  it "一万六百四十二" do
    compare_kanji_and_integer("一万六百四十二", 10642)
  end

  it "一万六百四十三" do
    compare_kanji_and_integer("一万六百四十三", 10643)
  end

  it "一万六百四十四" do
    compare_kanji_and_integer("一万六百四十四", 10644)
  end

  it "一万六百四十五" do
    compare_kanji_and_integer("一万六百四十五", 10645)
  end

  it "一万六百四十六" do
    compare_kanji_and_integer("一万六百四十六", 10646)
  end

  it "一万六百四十七" do
    compare_kanji_and_integer("一万六百四十七", 10647)
  end

  it "一万六百四十八" do
    compare_kanji_and_integer("一万六百四十八", 10648)
  end

  it "一万六百四十九" do
    compare_kanji_and_integer("一万六百四十九", 10649)
  end

  it "一万六百五十" do
    compare_kanji_and_integer("一万六百五十", 10650)
  end

  it "一万六百五十一" do
    compare_kanji_and_integer("一万六百五十一", 10651)
  end

  it "一万六百五十二" do
    compare_kanji_and_integer("一万六百五十二", 10652)
  end

  it "一万六百五十三" do
    compare_kanji_and_integer("一万六百五十三", 10653)
  end

  it "一万六百五十四" do
    compare_kanji_and_integer("一万六百五十四", 10654)
  end

  it "一万六百五十五" do
    compare_kanji_and_integer("一万六百五十五", 10655)
  end

  it "一万六百五十六" do
    compare_kanji_and_integer("一万六百五十六", 10656)
  end

  it "一万六百五十七" do
    compare_kanji_and_integer("一万六百五十七", 10657)
  end

  it "一万六百五十八" do
    compare_kanji_and_integer("一万六百五十八", 10658)
  end

  it "一万六百五十九" do
    compare_kanji_and_integer("一万六百五十九", 10659)
  end

  it "一万六百六十" do
    compare_kanji_and_integer("一万六百六十", 10660)
  end

  it "一万六百六十一" do
    compare_kanji_and_integer("一万六百六十一", 10661)
  end

  it "一万六百六十二" do
    compare_kanji_and_integer("一万六百六十二", 10662)
  end

  it "一万六百六十三" do
    compare_kanji_and_integer("一万六百六十三", 10663)
  end

  it "一万六百六十四" do
    compare_kanji_and_integer("一万六百六十四", 10664)
  end

  it "一万六百六十五" do
    compare_kanji_and_integer("一万六百六十五", 10665)
  end

  it "一万六百六十六" do
    compare_kanji_and_integer("一万六百六十六", 10666)
  end

  it "一万六百六十七" do
    compare_kanji_and_integer("一万六百六十七", 10667)
  end

  it "一万六百六十八" do
    compare_kanji_and_integer("一万六百六十八", 10668)
  end

  it "一万六百六十九" do
    compare_kanji_and_integer("一万六百六十九", 10669)
  end

  it "一万六百七十" do
    compare_kanji_and_integer("一万六百七十", 10670)
  end

  it "一万六百七十一" do
    compare_kanji_and_integer("一万六百七十一", 10671)
  end

  it "一万六百七十二" do
    compare_kanji_and_integer("一万六百七十二", 10672)
  end

  it "一万六百七十三" do
    compare_kanji_and_integer("一万六百七十三", 10673)
  end

  it "一万六百七十四" do
    compare_kanji_and_integer("一万六百七十四", 10674)
  end

  it "一万六百七十五" do
    compare_kanji_and_integer("一万六百七十五", 10675)
  end

  it "一万六百七十六" do
    compare_kanji_and_integer("一万六百七十六", 10676)
  end

  it "一万六百七十七" do
    compare_kanji_and_integer("一万六百七十七", 10677)
  end

  it "一万六百七十八" do
    compare_kanji_and_integer("一万六百七十八", 10678)
  end

  it "一万六百七十九" do
    compare_kanji_and_integer("一万六百七十九", 10679)
  end

  it "一万六百八十" do
    compare_kanji_and_integer("一万六百八十", 10680)
  end

  it "一万六百八十一" do
    compare_kanji_and_integer("一万六百八十一", 10681)
  end

  it "一万六百八十二" do
    compare_kanji_and_integer("一万六百八十二", 10682)
  end

  it "一万六百八十三" do
    compare_kanji_and_integer("一万六百八十三", 10683)
  end

  it "一万六百八十四" do
    compare_kanji_and_integer("一万六百八十四", 10684)
  end

  it "一万六百八十五" do
    compare_kanji_and_integer("一万六百八十五", 10685)
  end

  it "一万六百八十六" do
    compare_kanji_and_integer("一万六百八十六", 10686)
  end

  it "一万六百八十七" do
    compare_kanji_and_integer("一万六百八十七", 10687)
  end

  it "一万六百八十八" do
    compare_kanji_and_integer("一万六百八十八", 10688)
  end

  it "一万六百八十九" do
    compare_kanji_and_integer("一万六百八十九", 10689)
  end

  it "一万六百九十" do
    compare_kanji_and_integer("一万六百九十", 10690)
  end

  it "一万六百九十一" do
    compare_kanji_and_integer("一万六百九十一", 10691)
  end

  it "一万六百九十二" do
    compare_kanji_and_integer("一万六百九十二", 10692)
  end

  it "一万六百九十三" do
    compare_kanji_and_integer("一万六百九十三", 10693)
  end

  it "一万六百九十四" do
    compare_kanji_and_integer("一万六百九十四", 10694)
  end

  it "一万六百九十五" do
    compare_kanji_and_integer("一万六百九十五", 10695)
  end

  it "一万六百九十六" do
    compare_kanji_and_integer("一万六百九十六", 10696)
  end

  it "一万六百九十七" do
    compare_kanji_and_integer("一万六百九十七", 10697)
  end

  it "一万六百九十八" do
    compare_kanji_and_integer("一万六百九十八", 10698)
  end

  it "一万六百九十九" do
    compare_kanji_and_integer("一万六百九十九", 10699)
  end

  it "一万七百" do
    compare_kanji_and_integer("一万七百", 10700)
  end

  it "一万七百一" do
    compare_kanji_and_integer("一万七百一", 10701)
  end

  it "一万七百二" do
    compare_kanji_and_integer("一万七百二", 10702)
  end

  it "一万七百三" do
    compare_kanji_and_integer("一万七百三", 10703)
  end

  it "一万七百四" do
    compare_kanji_and_integer("一万七百四", 10704)
  end

  it "一万七百五" do
    compare_kanji_and_integer("一万七百五", 10705)
  end

  it "一万七百六" do
    compare_kanji_and_integer("一万七百六", 10706)
  end

  it "一万七百七" do
    compare_kanji_and_integer("一万七百七", 10707)
  end

  it "一万七百八" do
    compare_kanji_and_integer("一万七百八", 10708)
  end

  it "一万七百九" do
    compare_kanji_and_integer("一万七百九", 10709)
  end

  it "一万七百十" do
    compare_kanji_and_integer("一万七百十", 10710)
  end

  it "一万七百十一" do
    compare_kanji_and_integer("一万七百十一", 10711)
  end

  it "一万七百十二" do
    compare_kanji_and_integer("一万七百十二", 10712)
  end

  it "一万七百十三" do
    compare_kanji_and_integer("一万七百十三", 10713)
  end

  it "一万七百十四" do
    compare_kanji_and_integer("一万七百十四", 10714)
  end

  it "一万七百十五" do
    compare_kanji_and_integer("一万七百十五", 10715)
  end

  it "一万七百十六" do
    compare_kanji_and_integer("一万七百十六", 10716)
  end

  it "一万七百十七" do
    compare_kanji_and_integer("一万七百十七", 10717)
  end

  it "一万七百十八" do
    compare_kanji_and_integer("一万七百十八", 10718)
  end

  it "一万七百十九" do
    compare_kanji_and_integer("一万七百十九", 10719)
  end

  it "一万七百二十" do
    compare_kanji_and_integer("一万七百二十", 10720)
  end

  it "一万七百二十一" do
    compare_kanji_and_integer("一万七百二十一", 10721)
  end

  it "一万七百二十二" do
    compare_kanji_and_integer("一万七百二十二", 10722)
  end

  it "一万七百二十三" do
    compare_kanji_and_integer("一万七百二十三", 10723)
  end

  it "一万七百二十四" do
    compare_kanji_and_integer("一万七百二十四", 10724)
  end

  it "一万七百二十五" do
    compare_kanji_and_integer("一万七百二十五", 10725)
  end

  it "一万七百二十六" do
    compare_kanji_and_integer("一万七百二十六", 10726)
  end

  it "一万七百二十七" do
    compare_kanji_and_integer("一万七百二十七", 10727)
  end

  it "一万七百二十八" do
    compare_kanji_and_integer("一万七百二十八", 10728)
  end

  it "一万七百二十九" do
    compare_kanji_and_integer("一万七百二十九", 10729)
  end

  it "一万七百三十" do
    compare_kanji_and_integer("一万七百三十", 10730)
  end

  it "一万七百三十一" do
    compare_kanji_and_integer("一万七百三十一", 10731)
  end

  it "一万七百三十二" do
    compare_kanji_and_integer("一万七百三十二", 10732)
  end

  it "一万七百三十三" do
    compare_kanji_and_integer("一万七百三十三", 10733)
  end

  it "一万七百三十四" do
    compare_kanji_and_integer("一万七百三十四", 10734)
  end

  it "一万七百三十五" do
    compare_kanji_and_integer("一万七百三十五", 10735)
  end

  it "一万七百三十六" do
    compare_kanji_and_integer("一万七百三十六", 10736)
  end

  it "一万七百三十七" do
    compare_kanji_and_integer("一万七百三十七", 10737)
  end

  it "一万七百三十八" do
    compare_kanji_and_integer("一万七百三十八", 10738)
  end

  it "一万七百三十九" do
    compare_kanji_and_integer("一万七百三十九", 10739)
  end

  it "一万七百四十" do
    compare_kanji_and_integer("一万七百四十", 10740)
  end

  it "一万七百四十一" do
    compare_kanji_and_integer("一万七百四十一", 10741)
  end

  it "一万七百四十二" do
    compare_kanji_and_integer("一万七百四十二", 10742)
  end

  it "一万七百四十三" do
    compare_kanji_and_integer("一万七百四十三", 10743)
  end

  it "一万七百四十四" do
    compare_kanji_and_integer("一万七百四十四", 10744)
  end

  it "一万七百四十五" do
    compare_kanji_and_integer("一万七百四十五", 10745)
  end

  it "一万七百四十六" do
    compare_kanji_and_integer("一万七百四十六", 10746)
  end

  it "一万七百四十七" do
    compare_kanji_and_integer("一万七百四十七", 10747)
  end

  it "一万七百四十八" do
    compare_kanji_and_integer("一万七百四十八", 10748)
  end

  it "一万七百四十九" do
    compare_kanji_and_integer("一万七百四十九", 10749)
  end

  it "一万七百五十" do
    compare_kanji_and_integer("一万七百五十", 10750)
  end

  it "一万七百五十一" do
    compare_kanji_and_integer("一万七百五十一", 10751)
  end

  it "一万七百五十二" do
    compare_kanji_and_integer("一万七百五十二", 10752)
  end

  it "一万七百五十三" do
    compare_kanji_and_integer("一万七百五十三", 10753)
  end

  it "一万七百五十四" do
    compare_kanji_and_integer("一万七百五十四", 10754)
  end

  it "一万七百五十五" do
    compare_kanji_and_integer("一万七百五十五", 10755)
  end

  it "一万七百五十六" do
    compare_kanji_and_integer("一万七百五十六", 10756)
  end

  it "一万七百五十七" do
    compare_kanji_and_integer("一万七百五十七", 10757)
  end

  it "一万七百五十八" do
    compare_kanji_and_integer("一万七百五十八", 10758)
  end

  it "一万七百五十九" do
    compare_kanji_and_integer("一万七百五十九", 10759)
  end

  it "一万七百六十" do
    compare_kanji_and_integer("一万七百六十", 10760)
  end

  it "一万七百六十一" do
    compare_kanji_and_integer("一万七百六十一", 10761)
  end

  it "一万七百六十二" do
    compare_kanji_and_integer("一万七百六十二", 10762)
  end

  it "一万七百六十三" do
    compare_kanji_and_integer("一万七百六十三", 10763)
  end

  it "一万七百六十四" do
    compare_kanji_and_integer("一万七百六十四", 10764)
  end

  it "一万七百六十五" do
    compare_kanji_and_integer("一万七百六十五", 10765)
  end

  it "一万七百六十六" do
    compare_kanji_and_integer("一万七百六十六", 10766)
  end

  it "一万七百六十七" do
    compare_kanji_and_integer("一万七百六十七", 10767)
  end

  it "一万七百六十八" do
    compare_kanji_and_integer("一万七百六十八", 10768)
  end

  it "一万七百六十九" do
    compare_kanji_and_integer("一万七百六十九", 10769)
  end

  it "一万七百七十" do
    compare_kanji_and_integer("一万七百七十", 10770)
  end

  it "一万七百七十一" do
    compare_kanji_and_integer("一万七百七十一", 10771)
  end

  it "一万七百七十二" do
    compare_kanji_and_integer("一万七百七十二", 10772)
  end

  it "一万七百七十三" do
    compare_kanji_and_integer("一万七百七十三", 10773)
  end

  it "一万七百七十四" do
    compare_kanji_and_integer("一万七百七十四", 10774)
  end

  it "一万七百七十五" do
    compare_kanji_and_integer("一万七百七十五", 10775)
  end

  it "一万七百七十六" do
    compare_kanji_and_integer("一万七百七十六", 10776)
  end

  it "一万七百七十七" do
    compare_kanji_and_integer("一万七百七十七", 10777)
  end

  it "一万七百七十八" do
    compare_kanji_and_integer("一万七百七十八", 10778)
  end

  it "一万七百七十九" do
    compare_kanji_and_integer("一万七百七十九", 10779)
  end

  it "一万七百八十" do
    compare_kanji_and_integer("一万七百八十", 10780)
  end

  it "一万七百八十一" do
    compare_kanji_and_integer("一万七百八十一", 10781)
  end

  it "一万七百八十二" do
    compare_kanji_and_integer("一万七百八十二", 10782)
  end

  it "一万七百八十三" do
    compare_kanji_and_integer("一万七百八十三", 10783)
  end

  it "一万七百八十四" do
    compare_kanji_and_integer("一万七百八十四", 10784)
  end

  it "一万七百八十五" do
    compare_kanji_and_integer("一万七百八十五", 10785)
  end

  it "一万七百八十六" do
    compare_kanji_and_integer("一万七百八十六", 10786)
  end

  it "一万七百八十七" do
    compare_kanji_and_integer("一万七百八十七", 10787)
  end

  it "一万七百八十八" do
    compare_kanji_and_integer("一万七百八十八", 10788)
  end

  it "一万七百八十九" do
    compare_kanji_and_integer("一万七百八十九", 10789)
  end

  it "一万七百九十" do
    compare_kanji_and_integer("一万七百九十", 10790)
  end

  it "一万七百九十一" do
    compare_kanji_and_integer("一万七百九十一", 10791)
  end

  it "一万七百九十二" do
    compare_kanji_and_integer("一万七百九十二", 10792)
  end

  it "一万七百九十三" do
    compare_kanji_and_integer("一万七百九十三", 10793)
  end

  it "一万七百九十四" do
    compare_kanji_and_integer("一万七百九十四", 10794)
  end

  it "一万七百九十五" do
    compare_kanji_and_integer("一万七百九十五", 10795)
  end

  it "一万七百九十六" do
    compare_kanji_and_integer("一万七百九十六", 10796)
  end

  it "一万七百九十七" do
    compare_kanji_and_integer("一万七百九十七", 10797)
  end

  it "一万七百九十八" do
    compare_kanji_and_integer("一万七百九十八", 10798)
  end

  it "一万七百九十九" do
    compare_kanji_and_integer("一万七百九十九", 10799)
  end

  it "一万八百" do
    compare_kanji_and_integer("一万八百", 10800)
  end

  it "一万八百一" do
    compare_kanji_and_integer("一万八百一", 10801)
  end

  it "一万八百二" do
    compare_kanji_and_integer("一万八百二", 10802)
  end

  it "一万八百三" do
    compare_kanji_and_integer("一万八百三", 10803)
  end

  it "一万八百四" do
    compare_kanji_and_integer("一万八百四", 10804)
  end

  it "一万八百五" do
    compare_kanji_and_integer("一万八百五", 10805)
  end

  it "一万八百六" do
    compare_kanji_and_integer("一万八百六", 10806)
  end

  it "一万八百七" do
    compare_kanji_and_integer("一万八百七", 10807)
  end

  it "一万八百八" do
    compare_kanji_and_integer("一万八百八", 10808)
  end

  it "一万八百九" do
    compare_kanji_and_integer("一万八百九", 10809)
  end

  it "一万八百十" do
    compare_kanji_and_integer("一万八百十", 10810)
  end

  it "一万八百十一" do
    compare_kanji_and_integer("一万八百十一", 10811)
  end

  it "一万八百十二" do
    compare_kanji_and_integer("一万八百十二", 10812)
  end

  it "一万八百十三" do
    compare_kanji_and_integer("一万八百十三", 10813)
  end

  it "一万八百十四" do
    compare_kanji_and_integer("一万八百十四", 10814)
  end

  it "一万八百十五" do
    compare_kanji_and_integer("一万八百十五", 10815)
  end

  it "一万八百十六" do
    compare_kanji_and_integer("一万八百十六", 10816)
  end

  it "一万八百十七" do
    compare_kanji_and_integer("一万八百十七", 10817)
  end

  it "一万八百十八" do
    compare_kanji_and_integer("一万八百十八", 10818)
  end

  it "一万八百十九" do
    compare_kanji_and_integer("一万八百十九", 10819)
  end

  it "一万八百二十" do
    compare_kanji_and_integer("一万八百二十", 10820)
  end

  it "一万八百二十一" do
    compare_kanji_and_integer("一万八百二十一", 10821)
  end

  it "一万八百二十二" do
    compare_kanji_and_integer("一万八百二十二", 10822)
  end

  it "一万八百二十三" do
    compare_kanji_and_integer("一万八百二十三", 10823)
  end

  it "一万八百二十四" do
    compare_kanji_and_integer("一万八百二十四", 10824)
  end

  it "一万八百二十五" do
    compare_kanji_and_integer("一万八百二十五", 10825)
  end

  it "一万八百二十六" do
    compare_kanji_and_integer("一万八百二十六", 10826)
  end

  it "一万八百二十七" do
    compare_kanji_and_integer("一万八百二十七", 10827)
  end

  it "一万八百二十八" do
    compare_kanji_and_integer("一万八百二十八", 10828)
  end

  it "一万八百二十九" do
    compare_kanji_and_integer("一万八百二十九", 10829)
  end

  it "一万八百三十" do
    compare_kanji_and_integer("一万八百三十", 10830)
  end

  it "一万八百三十一" do
    compare_kanji_and_integer("一万八百三十一", 10831)
  end

  it "一万八百三十二" do
    compare_kanji_and_integer("一万八百三十二", 10832)
  end

  it "一万八百三十三" do
    compare_kanji_and_integer("一万八百三十三", 10833)
  end

  it "一万八百三十四" do
    compare_kanji_and_integer("一万八百三十四", 10834)
  end

  it "一万八百三十五" do
    compare_kanji_and_integer("一万八百三十五", 10835)
  end

  it "一万八百三十六" do
    compare_kanji_and_integer("一万八百三十六", 10836)
  end

  it "一万八百三十七" do
    compare_kanji_and_integer("一万八百三十七", 10837)
  end

  it "一万八百三十八" do
    compare_kanji_and_integer("一万八百三十八", 10838)
  end

  it "一万八百三十九" do
    compare_kanji_and_integer("一万八百三十九", 10839)
  end

  it "一万八百四十" do
    compare_kanji_and_integer("一万八百四十", 10840)
  end

  it "一万八百四十一" do
    compare_kanji_and_integer("一万八百四十一", 10841)
  end

  it "一万八百四十二" do
    compare_kanji_and_integer("一万八百四十二", 10842)
  end

  it "一万八百四十三" do
    compare_kanji_and_integer("一万八百四十三", 10843)
  end

  it "一万八百四十四" do
    compare_kanji_and_integer("一万八百四十四", 10844)
  end

  it "一万八百四十五" do
    compare_kanji_and_integer("一万八百四十五", 10845)
  end

  it "一万八百四十六" do
    compare_kanji_and_integer("一万八百四十六", 10846)
  end

  it "一万八百四十七" do
    compare_kanji_and_integer("一万八百四十七", 10847)
  end

  it "一万八百四十八" do
    compare_kanji_and_integer("一万八百四十八", 10848)
  end

  it "一万八百四十九" do
    compare_kanji_and_integer("一万八百四十九", 10849)
  end

  it "一万八百五十" do
    compare_kanji_and_integer("一万八百五十", 10850)
  end

  it "一万八百五十一" do
    compare_kanji_and_integer("一万八百五十一", 10851)
  end

  it "一万八百五十二" do
    compare_kanji_and_integer("一万八百五十二", 10852)
  end

  it "一万八百五十三" do
    compare_kanji_and_integer("一万八百五十三", 10853)
  end

  it "一万八百五十四" do
    compare_kanji_and_integer("一万八百五十四", 10854)
  end

  it "一万八百五十五" do
    compare_kanji_and_integer("一万八百五十五", 10855)
  end

  it "一万八百五十六" do
    compare_kanji_and_integer("一万八百五十六", 10856)
  end

  it "一万八百五十七" do
    compare_kanji_and_integer("一万八百五十七", 10857)
  end

  it "一万八百五十八" do
    compare_kanji_and_integer("一万八百五十八", 10858)
  end

  it "一万八百五十九" do
    compare_kanji_and_integer("一万八百五十九", 10859)
  end

  it "一万八百六十" do
    compare_kanji_and_integer("一万八百六十", 10860)
  end

  it "一万八百六十一" do
    compare_kanji_and_integer("一万八百六十一", 10861)
  end

  it "一万八百六十二" do
    compare_kanji_and_integer("一万八百六十二", 10862)
  end

  it "一万八百六十三" do
    compare_kanji_and_integer("一万八百六十三", 10863)
  end

  it "一万八百六十四" do
    compare_kanji_and_integer("一万八百六十四", 10864)
  end

  it "一万八百六十五" do
    compare_kanji_and_integer("一万八百六十五", 10865)
  end

  it "一万八百六十六" do
    compare_kanji_and_integer("一万八百六十六", 10866)
  end

  it "一万八百六十七" do
    compare_kanji_and_integer("一万八百六十七", 10867)
  end

  it "一万八百六十八" do
    compare_kanji_and_integer("一万八百六十八", 10868)
  end

  it "一万八百六十九" do
    compare_kanji_and_integer("一万八百六十九", 10869)
  end

  it "一万八百七十" do
    compare_kanji_and_integer("一万八百七十", 10870)
  end

  it "一万八百七十一" do
    compare_kanji_and_integer("一万八百七十一", 10871)
  end

  it "一万八百七十二" do
    compare_kanji_and_integer("一万八百七十二", 10872)
  end

  it "一万八百七十三" do
    compare_kanji_and_integer("一万八百七十三", 10873)
  end

  it "一万八百七十四" do
    compare_kanji_and_integer("一万八百七十四", 10874)
  end

  it "一万八百七十五" do
    compare_kanji_and_integer("一万八百七十五", 10875)
  end

  it "一万八百七十六" do
    compare_kanji_and_integer("一万八百七十六", 10876)
  end

  it "一万八百七十七" do
    compare_kanji_and_integer("一万八百七十七", 10877)
  end

  it "一万八百七十八" do
    compare_kanji_and_integer("一万八百七十八", 10878)
  end

  it "一万八百七十九" do
    compare_kanji_and_integer("一万八百七十九", 10879)
  end

  it "一万八百八十" do
    compare_kanji_and_integer("一万八百八十", 10880)
  end

  it "一万八百八十一" do
    compare_kanji_and_integer("一万八百八十一", 10881)
  end

  it "一万八百八十二" do
    compare_kanji_and_integer("一万八百八十二", 10882)
  end

  it "一万八百八十三" do
    compare_kanji_and_integer("一万八百八十三", 10883)
  end

  it "一万八百八十四" do
    compare_kanji_and_integer("一万八百八十四", 10884)
  end

  it "一万八百八十五" do
    compare_kanji_and_integer("一万八百八十五", 10885)
  end

  it "一万八百八十六" do
    compare_kanji_and_integer("一万八百八十六", 10886)
  end

  it "一万八百八十七" do
    compare_kanji_and_integer("一万八百八十七", 10887)
  end

  it "一万八百八十八" do
    compare_kanji_and_integer("一万八百八十八", 10888)
  end

  it "一万八百八十九" do
    compare_kanji_and_integer("一万八百八十九", 10889)
  end

  it "一万八百九十" do
    compare_kanji_and_integer("一万八百九十", 10890)
  end

  it "一万八百九十一" do
    compare_kanji_and_integer("一万八百九十一", 10891)
  end

  it "一万八百九十二" do
    compare_kanji_and_integer("一万八百九十二", 10892)
  end

  it "一万八百九十三" do
    compare_kanji_and_integer("一万八百九十三", 10893)
  end

  it "一万八百九十四" do
    compare_kanji_and_integer("一万八百九十四", 10894)
  end

  it "一万八百九十五" do
    compare_kanji_and_integer("一万八百九十五", 10895)
  end

  it "一万八百九十六" do
    compare_kanji_and_integer("一万八百九十六", 10896)
  end

  it "一万八百九十七" do
    compare_kanji_and_integer("一万八百九十七", 10897)
  end

  it "一万八百九十八" do
    compare_kanji_and_integer("一万八百九十八", 10898)
  end

  it "一万八百九十九" do
    compare_kanji_and_integer("一万八百九十九", 10899)
  end

  it "一万九百" do
    compare_kanji_and_integer("一万九百", 10900)
  end

  it "一万九百一" do
    compare_kanji_and_integer("一万九百一", 10901)
  end

  it "一万九百二" do
    compare_kanji_and_integer("一万九百二", 10902)
  end

  it "一万九百三" do
    compare_kanji_and_integer("一万九百三", 10903)
  end

  it "一万九百四" do
    compare_kanji_and_integer("一万九百四", 10904)
  end

  it "一万九百五" do
    compare_kanji_and_integer("一万九百五", 10905)
  end

  it "一万九百六" do
    compare_kanji_and_integer("一万九百六", 10906)
  end

  it "一万九百七" do
    compare_kanji_and_integer("一万九百七", 10907)
  end

  it "一万九百八" do
    compare_kanji_and_integer("一万九百八", 10908)
  end

  it "一万九百九" do
    compare_kanji_and_integer("一万九百九", 10909)
  end

  it "一万九百十" do
    compare_kanji_and_integer("一万九百十", 10910)
  end

  it "一万九百十一" do
    compare_kanji_and_integer("一万九百十一", 10911)
  end

  it "一万九百十二" do
    compare_kanji_and_integer("一万九百十二", 10912)
  end

  it "一万九百十三" do
    compare_kanji_and_integer("一万九百十三", 10913)
  end

  it "一万九百十四" do
    compare_kanji_and_integer("一万九百十四", 10914)
  end

  it "一万九百十五" do
    compare_kanji_and_integer("一万九百十五", 10915)
  end

  it "一万九百十六" do
    compare_kanji_and_integer("一万九百十六", 10916)
  end

  it "一万九百十七" do
    compare_kanji_and_integer("一万九百十七", 10917)
  end

  it "一万九百十八" do
    compare_kanji_and_integer("一万九百十八", 10918)
  end

  it "一万九百十九" do
    compare_kanji_and_integer("一万九百十九", 10919)
  end

  it "一万九百二十" do
    compare_kanji_and_integer("一万九百二十", 10920)
  end

  it "一万九百二十一" do
    compare_kanji_and_integer("一万九百二十一", 10921)
  end

  it "一万九百二十二" do
    compare_kanji_and_integer("一万九百二十二", 10922)
  end

  it "一万九百二十三" do
    compare_kanji_and_integer("一万九百二十三", 10923)
  end

  it "一万九百二十四" do
    compare_kanji_and_integer("一万九百二十四", 10924)
  end

  it "一万九百二十五" do
    compare_kanji_and_integer("一万九百二十五", 10925)
  end

  it "一万九百二十六" do
    compare_kanji_and_integer("一万九百二十六", 10926)
  end

  it "一万九百二十七" do
    compare_kanji_and_integer("一万九百二十七", 10927)
  end

  it "一万九百二十八" do
    compare_kanji_and_integer("一万九百二十八", 10928)
  end

  it "一万九百二十九" do
    compare_kanji_and_integer("一万九百二十九", 10929)
  end

  it "一万九百三十" do
    compare_kanji_and_integer("一万九百三十", 10930)
  end

  it "一万九百三十一" do
    compare_kanji_and_integer("一万九百三十一", 10931)
  end

  it "一万九百三十二" do
    compare_kanji_and_integer("一万九百三十二", 10932)
  end

  it "一万九百三十三" do
    compare_kanji_and_integer("一万九百三十三", 10933)
  end

  it "一万九百三十四" do
    compare_kanji_and_integer("一万九百三十四", 10934)
  end

  it "一万九百三十五" do
    compare_kanji_and_integer("一万九百三十五", 10935)
  end

  it "一万九百三十六" do
    compare_kanji_and_integer("一万九百三十六", 10936)
  end

  it "一万九百三十七" do
    compare_kanji_and_integer("一万九百三十七", 10937)
  end

  it "一万九百三十八" do
    compare_kanji_and_integer("一万九百三十八", 10938)
  end

  it "一万九百三十九" do
    compare_kanji_and_integer("一万九百三十九", 10939)
  end

  it "一万九百四十" do
    compare_kanji_and_integer("一万九百四十", 10940)
  end

  it "一万九百四十一" do
    compare_kanji_and_integer("一万九百四十一", 10941)
  end

  it "一万九百四十二" do
    compare_kanji_and_integer("一万九百四十二", 10942)
  end

  it "一万九百四十三" do
    compare_kanji_and_integer("一万九百四十三", 10943)
  end

  it "一万九百四十四" do
    compare_kanji_and_integer("一万九百四十四", 10944)
  end

  it "一万九百四十五" do
    compare_kanji_and_integer("一万九百四十五", 10945)
  end

  it "一万九百四十六" do
    compare_kanji_and_integer("一万九百四十六", 10946)
  end

  it "一万九百四十七" do
    compare_kanji_and_integer("一万九百四十七", 10947)
  end

  it "一万九百四十八" do
    compare_kanji_and_integer("一万九百四十八", 10948)
  end

  it "一万九百四十九" do
    compare_kanji_and_integer("一万九百四十九", 10949)
  end

  it "一万九百五十" do
    compare_kanji_and_integer("一万九百五十", 10950)
  end

  it "一万九百五十一" do
    compare_kanji_and_integer("一万九百五十一", 10951)
  end

  it "一万九百五十二" do
    compare_kanji_and_integer("一万九百五十二", 10952)
  end

  it "一万九百五十三" do
    compare_kanji_and_integer("一万九百五十三", 10953)
  end

  it "一万九百五十四" do
    compare_kanji_and_integer("一万九百五十四", 10954)
  end

  it "一万九百五十五" do
    compare_kanji_and_integer("一万九百五十五", 10955)
  end

  it "一万九百五十六" do
    compare_kanji_and_integer("一万九百五十六", 10956)
  end

  it "一万九百五十七" do
    compare_kanji_and_integer("一万九百五十七", 10957)
  end

  it "一万九百五十八" do
    compare_kanji_and_integer("一万九百五十八", 10958)
  end

  it "一万九百五十九" do
    compare_kanji_and_integer("一万九百五十九", 10959)
  end

  it "一万九百六十" do
    compare_kanji_and_integer("一万九百六十", 10960)
  end

  it "一万九百六十一" do
    compare_kanji_and_integer("一万九百六十一", 10961)
  end

  it "一万九百六十二" do
    compare_kanji_and_integer("一万九百六十二", 10962)
  end

  it "一万九百六十三" do
    compare_kanji_and_integer("一万九百六十三", 10963)
  end

  it "一万九百六十四" do
    compare_kanji_and_integer("一万九百六十四", 10964)
  end

  it "一万九百六十五" do
    compare_kanji_and_integer("一万九百六十五", 10965)
  end

  it "一万九百六十六" do
    compare_kanji_and_integer("一万九百六十六", 10966)
  end

  it "一万九百六十七" do
    compare_kanji_and_integer("一万九百六十七", 10967)
  end

  it "一万九百六十八" do
    compare_kanji_and_integer("一万九百六十八", 10968)
  end

  it "一万九百六十九" do
    compare_kanji_and_integer("一万九百六十九", 10969)
  end

  it "一万九百七十" do
    compare_kanji_and_integer("一万九百七十", 10970)
  end

  it "一万九百七十一" do
    compare_kanji_and_integer("一万九百七十一", 10971)
  end

  it "一万九百七十二" do
    compare_kanji_and_integer("一万九百七十二", 10972)
  end

  it "一万九百七十三" do
    compare_kanji_and_integer("一万九百七十三", 10973)
  end

  it "一万九百七十四" do
    compare_kanji_and_integer("一万九百七十四", 10974)
  end

  it "一万九百七十五" do
    compare_kanji_and_integer("一万九百七十五", 10975)
  end

  it "一万九百七十六" do
    compare_kanji_and_integer("一万九百七十六", 10976)
  end

  it "一万九百七十七" do
    compare_kanji_and_integer("一万九百七十七", 10977)
  end

  it "一万九百七十八" do
    compare_kanji_and_integer("一万九百七十八", 10978)
  end

  it "一万九百七十九" do
    compare_kanji_and_integer("一万九百七十九", 10979)
  end

  it "一万九百八十" do
    compare_kanji_and_integer("一万九百八十", 10980)
  end

  it "一万九百八十一" do
    compare_kanji_and_integer("一万九百八十一", 10981)
  end

  it "一万九百八十二" do
    compare_kanji_and_integer("一万九百八十二", 10982)
  end

  it "一万九百八十三" do
    compare_kanji_and_integer("一万九百八十三", 10983)
  end

  it "一万九百八十四" do
    compare_kanji_and_integer("一万九百八十四", 10984)
  end

  it "一万九百八十五" do
    compare_kanji_and_integer("一万九百八十五", 10985)
  end

  it "一万九百八十六" do
    compare_kanji_and_integer("一万九百八十六", 10986)
  end

  it "一万九百八十七" do
    compare_kanji_and_integer("一万九百八十七", 10987)
  end

  it "一万九百八十八" do
    compare_kanji_and_integer("一万九百八十八", 10988)
  end

  it "一万九百八十九" do
    compare_kanji_and_integer("一万九百八十九", 10989)
  end

  it "一万九百九十" do
    compare_kanji_and_integer("一万九百九十", 10990)
  end

  it "一万九百九十一" do
    compare_kanji_and_integer("一万九百九十一", 10991)
  end

  it "一万九百九十二" do
    compare_kanji_and_integer("一万九百九十二", 10992)
  end

  it "一万九百九十三" do
    compare_kanji_and_integer("一万九百九十三", 10993)
  end

  it "一万九百九十四" do
    compare_kanji_and_integer("一万九百九十四", 10994)
  end

  it "一万九百九十五" do
    compare_kanji_and_integer("一万九百九十五", 10995)
  end

  it "一万九百九十六" do
    compare_kanji_and_integer("一万九百九十六", 10996)
  end

  it "一万九百九十七" do
    compare_kanji_and_integer("一万九百九十七", 10997)
  end

  it "一万九百九十八" do
    compare_kanji_and_integer("一万九百九十八", 10998)
  end

  it "一万九百九十九" do
    compare_kanji_and_integer("一万九百九十九", 10999)
  end

  it "一万一千" do
    compare_kanji_and_integer("一万一千", 11000)
  end

  it "一万一千一" do
    compare_kanji_and_integer("一万一千一", 11001)
  end

  it "一万一千二" do
    compare_kanji_and_integer("一万一千二", 11002)
  end

  it "一万一千三" do
    compare_kanji_and_integer("一万一千三", 11003)
  end

  it "一万一千四" do
    compare_kanji_and_integer("一万一千四", 11004)
  end

  it "一万一千五" do
    compare_kanji_and_integer("一万一千五", 11005)
  end

  it "一万一千六" do
    compare_kanji_and_integer("一万一千六", 11006)
  end

  it "一万一千七" do
    compare_kanji_and_integer("一万一千七", 11007)
  end

  it "一万一千八" do
    compare_kanji_and_integer("一万一千八", 11008)
  end

  it "一万一千九" do
    compare_kanji_and_integer("一万一千九", 11009)
  end

  it "一万一千十" do
    compare_kanji_and_integer("一万一千十", 11010)
  end

  it "一万一千十一" do
    compare_kanji_and_integer("一万一千十一", 11011)
  end

  it "一万一千十二" do
    compare_kanji_and_integer("一万一千十二", 11012)
  end

  it "一万一千十三" do
    compare_kanji_and_integer("一万一千十三", 11013)
  end

  it "一万一千十四" do
    compare_kanji_and_integer("一万一千十四", 11014)
  end

  it "一万一千十五" do
    compare_kanji_and_integer("一万一千十五", 11015)
  end

  it "一万一千十六" do
    compare_kanji_and_integer("一万一千十六", 11016)
  end

  it "一万一千十七" do
    compare_kanji_and_integer("一万一千十七", 11017)
  end

  it "一万一千十八" do
    compare_kanji_and_integer("一万一千十八", 11018)
  end

  it "一万一千十九" do
    compare_kanji_and_integer("一万一千十九", 11019)
  end

  it "一万一千二十" do
    compare_kanji_and_integer("一万一千二十", 11020)
  end

  it "一万一千二十一" do
    compare_kanji_and_integer("一万一千二十一", 11021)
  end

  it "一万一千二十二" do
    compare_kanji_and_integer("一万一千二十二", 11022)
  end

  it "一万一千二十三" do
    compare_kanji_and_integer("一万一千二十三", 11023)
  end

  it "一万一千二十四" do
    compare_kanji_and_integer("一万一千二十四", 11024)
  end

  it "一万一千二十五" do
    compare_kanji_and_integer("一万一千二十五", 11025)
  end

  it "一万一千二十六" do
    compare_kanji_and_integer("一万一千二十六", 11026)
  end

  it "一万一千二十七" do
    compare_kanji_and_integer("一万一千二十七", 11027)
  end

  it "一万一千二十八" do
    compare_kanji_and_integer("一万一千二十八", 11028)
  end

  it "一万一千二十九" do
    compare_kanji_and_integer("一万一千二十九", 11029)
  end

  it "一万一千三十" do
    compare_kanji_and_integer("一万一千三十", 11030)
  end

  it "一万一千三十一" do
    compare_kanji_and_integer("一万一千三十一", 11031)
  end

  it "一万一千三十二" do
    compare_kanji_and_integer("一万一千三十二", 11032)
  end

  it "一万一千三十三" do
    compare_kanji_and_integer("一万一千三十三", 11033)
  end

  it "一万一千三十四" do
    compare_kanji_and_integer("一万一千三十四", 11034)
  end

  it "一万一千三十五" do
    compare_kanji_and_integer("一万一千三十五", 11035)
  end

  it "一万一千三十六" do
    compare_kanji_and_integer("一万一千三十六", 11036)
  end

  it "一万一千三十七" do
    compare_kanji_and_integer("一万一千三十七", 11037)
  end

  it "一万一千三十八" do
    compare_kanji_and_integer("一万一千三十八", 11038)
  end

  it "一万一千三十九" do
    compare_kanji_and_integer("一万一千三十九", 11039)
  end

  it "一万一千四十" do
    compare_kanji_and_integer("一万一千四十", 11040)
  end

  it "一万一千四十一" do
    compare_kanji_and_integer("一万一千四十一", 11041)
  end

  it "一万一千四十二" do
    compare_kanji_and_integer("一万一千四十二", 11042)
  end

  it "一万一千四十三" do
    compare_kanji_and_integer("一万一千四十三", 11043)
  end

  it "一万一千四十四" do
    compare_kanji_and_integer("一万一千四十四", 11044)
  end

  it "一万一千四十五" do
    compare_kanji_and_integer("一万一千四十五", 11045)
  end

  it "一万一千四十六" do
    compare_kanji_and_integer("一万一千四十六", 11046)
  end

  it "一万一千四十七" do
    compare_kanji_and_integer("一万一千四十七", 11047)
  end

  it "一万一千四十八" do
    compare_kanji_and_integer("一万一千四十八", 11048)
  end

  it "一万一千四十九" do
    compare_kanji_and_integer("一万一千四十九", 11049)
  end

  it "一万一千五十" do
    compare_kanji_and_integer("一万一千五十", 11050)
  end

  it "一万一千五十一" do
    compare_kanji_and_integer("一万一千五十一", 11051)
  end

  it "一万一千五十二" do
    compare_kanji_and_integer("一万一千五十二", 11052)
  end

  it "一万一千五十三" do
    compare_kanji_and_integer("一万一千五十三", 11053)
  end

  it "一万一千五十四" do
    compare_kanji_and_integer("一万一千五十四", 11054)
  end

  it "一万一千五十五" do
    compare_kanji_and_integer("一万一千五十五", 11055)
  end

  it "一万一千五十六" do
    compare_kanji_and_integer("一万一千五十六", 11056)
  end

  it "一万一千五十七" do
    compare_kanji_and_integer("一万一千五十七", 11057)
  end

  it "一万一千五十八" do
    compare_kanji_and_integer("一万一千五十八", 11058)
  end

  it "一万一千五十九" do
    compare_kanji_and_integer("一万一千五十九", 11059)
  end

  it "一万一千六十" do
    compare_kanji_and_integer("一万一千六十", 11060)
  end

  it "一万一千六十一" do
    compare_kanji_and_integer("一万一千六十一", 11061)
  end

  it "一万一千六十二" do
    compare_kanji_and_integer("一万一千六十二", 11062)
  end

  it "一万一千六十三" do
    compare_kanji_and_integer("一万一千六十三", 11063)
  end

  it "一万一千六十四" do
    compare_kanji_and_integer("一万一千六十四", 11064)
  end

  it "一万一千六十五" do
    compare_kanji_and_integer("一万一千六十五", 11065)
  end

  it "一万一千六十六" do
    compare_kanji_and_integer("一万一千六十六", 11066)
  end

  it "一万一千六十七" do
    compare_kanji_and_integer("一万一千六十七", 11067)
  end

  it "一万一千六十八" do
    compare_kanji_and_integer("一万一千六十八", 11068)
  end

  it "一万一千六十九" do
    compare_kanji_and_integer("一万一千六十九", 11069)
  end

  it "一万一千七十" do
    compare_kanji_and_integer("一万一千七十", 11070)
  end

  it "一万一千七十一" do
    compare_kanji_and_integer("一万一千七十一", 11071)
  end

  it "一万一千七十二" do
    compare_kanji_and_integer("一万一千七十二", 11072)
  end

  it "一万一千七十三" do
    compare_kanji_and_integer("一万一千七十三", 11073)
  end

  it "一万一千七十四" do
    compare_kanji_and_integer("一万一千七十四", 11074)
  end

  it "一万一千七十五" do
    compare_kanji_and_integer("一万一千七十五", 11075)
  end

  it "一万一千七十六" do
    compare_kanji_and_integer("一万一千七十六", 11076)
  end

  it "一万一千七十七" do
    compare_kanji_and_integer("一万一千七十七", 11077)
  end

  it "一万一千七十八" do
    compare_kanji_and_integer("一万一千七十八", 11078)
  end

  it "一万一千七十九" do
    compare_kanji_and_integer("一万一千七十九", 11079)
  end

  it "一万一千八十" do
    compare_kanji_and_integer("一万一千八十", 11080)
  end

  it "一万一千八十一" do
    compare_kanji_and_integer("一万一千八十一", 11081)
  end

  it "一万一千八十二" do
    compare_kanji_and_integer("一万一千八十二", 11082)
  end

  it "一万一千八十三" do
    compare_kanji_and_integer("一万一千八十三", 11083)
  end

  it "一万一千八十四" do
    compare_kanji_and_integer("一万一千八十四", 11084)
  end

  it "一万一千八十五" do
    compare_kanji_and_integer("一万一千八十五", 11085)
  end

  it "一万一千八十六" do
    compare_kanji_and_integer("一万一千八十六", 11086)
  end

  it "一万一千八十七" do
    compare_kanji_and_integer("一万一千八十七", 11087)
  end

  it "一万一千八十八" do
    compare_kanji_and_integer("一万一千八十八", 11088)
  end

  it "一万一千八十九" do
    compare_kanji_and_integer("一万一千八十九", 11089)
  end

  it "一万一千九十" do
    compare_kanji_and_integer("一万一千九十", 11090)
  end

  it "一万一千九十一" do
    compare_kanji_and_integer("一万一千九十一", 11091)
  end

  it "一万一千九十二" do
    compare_kanji_and_integer("一万一千九十二", 11092)
  end

  it "一万一千九十三" do
    compare_kanji_and_integer("一万一千九十三", 11093)
  end

  it "一万一千九十四" do
    compare_kanji_and_integer("一万一千九十四", 11094)
  end

  it "一万一千九十五" do
    compare_kanji_and_integer("一万一千九十五", 11095)
  end

  it "一万一千九十六" do
    compare_kanji_and_integer("一万一千九十六", 11096)
  end

  it "一万一千九十七" do
    compare_kanji_and_integer("一万一千九十七", 11097)
  end

  it "一万一千九十八" do
    compare_kanji_and_integer("一万一千九十八", 11098)
  end

  it "一万一千九十九" do
    compare_kanji_and_integer("一万一千九十九", 11099)
  end

  it "一万一千百" do
    compare_kanji_and_integer("一万一千百", 11100)
  end

  it "一万一千百一" do
    compare_kanji_and_integer("一万一千百一", 11101)
  end

  it "一万一千百二" do
    compare_kanji_and_integer("一万一千百二", 11102)
  end

  it "一万一千百三" do
    compare_kanji_and_integer("一万一千百三", 11103)
  end

  it "一万一千百四" do
    compare_kanji_and_integer("一万一千百四", 11104)
  end

  it "一万一千百五" do
    compare_kanji_and_integer("一万一千百五", 11105)
  end

  it "一万一千百六" do
    compare_kanji_and_integer("一万一千百六", 11106)
  end

  it "一万一千百七" do
    compare_kanji_and_integer("一万一千百七", 11107)
  end

  it "一万一千百八" do
    compare_kanji_and_integer("一万一千百八", 11108)
  end

  it "一万一千百九" do
    compare_kanji_and_integer("一万一千百九", 11109)
  end

  it "一万一千百十" do
    compare_kanji_and_integer("一万一千百十", 11110)
  end
end
