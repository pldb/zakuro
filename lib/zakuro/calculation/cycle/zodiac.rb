# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Cycle
      #
      # Zodiac 十干十二支
      #
      module Zodiac
        # @return [Hash<Integer, String>] 十干十二支
        ZODIAC_NAME_PATTERNS = {
          0 => '甲子',   # きのえね
          1 => '乙丑',   # きのとうし
          2 => '丙寅',   # ひのえとら
          3 => '丁卯',   # ひのとう
          4 => '戊辰',   # つちのえたつ
          5 => '己巳',   # つちのとみ
          6 => '庚午',   # かのえうま
          7 => '辛未',   # かのとひつじ
          8 => '壬申',   # みずのえさる
          9 => '癸酉',   # みずのととり
          10 => '甲戌',  # きのえいぬ
          11 => '乙亥',  # きのとい
          12 => '丙子',  # ひのえね
          13 => '丁丑',  # ひのとうし
          14 => '戊寅',  # つちのえとら
          15 => '己卯',  # つちのとう
          16 => '庚辰',  # かのえたつ
          17 => '辛巳',  # かのとみ
          18 => '壬午',  # みずのえうま
          19 => '癸未',  # みずのとひつじ
          20 => '甲申',  # きのえさる
          21 => '乙酉',  # きのととり
          22 => '丙戌',  # ひのえいぬ
          23 => '丁亥',  # ひのとい
          24 => '戊子',  # つちのえね
          25 => '己丑',  # つちのとうし
          26 => '庚寅',  # かのえとら
          27 => '辛卯',  # かのとう
          28 => '壬辰',  # みずのえたつ
          29 => '癸巳',  # みずのとみ
          30 => '甲午',  # きのえうま
          31 => '乙未',  # きのとひつじ
          32 => '丙申',  # ひのえさる
          33 => '丁酉',  # ひのととり
          34 => '戊戌',  # つちのえいぬ
          35 => '己亥',  # つちのとい
          36 => '庚子',  # かのえね
          37 => '辛丑',  # かのとうし
          38 => '壬寅',  # みずのえとら
          39 => '癸卯',  # みずのとう
          40 => '甲辰',  # きのえたつ
          41 => '乙巳',  # きのとみ
          42 => '丙午',  # ひのえうま
          43 => '丁未',  # ひのとひつじ
          44 => '戊申',  # つちのえさる
          45 => '己酉',  # つちのととり
          46 => '庚戌',  # かのえいぬ
          47 => '辛亥',  # かのとい
          48 => '壬子',  # みずのえね
          49 => '癸丑',  # みずのとうし
          50 => '甲寅',  # きのえとら
          51 => '乙卯',  # きのとう
          52 => '丙辰',  # ひのえたつ
          53 => '丁巳',  # ひのとみ
          54 => '戊午',  # つちのえうま
          55 => '己未',  # つちのとひつじ
          56 => '庚申',  # かのえさる
          57 => '辛酉',  # かのととり
          58 => '壬戌',  # みずのえいぬ
          59 => '癸亥'   # みずのとい
        }.freeze

        # @return [Integer] 組み合わせ数
        LENGTH = ZODIAC_NAME_PATTERNS.length

        #
        # 大余を十干十二支に変換する
        #
        # @param [Integer] day 大余
        #
        # @return [String] 十干十二支
        #
        def self.day_name(day:)
          index = day % LENGTH

          ZODIAC_NAME_PATTERNS[index]
        end

        #
        # 西暦年を十干十二支に変換する
        #
        # @param [Integer] western_year 西暦年
        #
        # @return [String] 十干十二支
        #
        def self.year_name(western_year: 0)
          ZODIAC_NAME_PATTERNS[(western_year - 4) % LENGTH]
        end
      end
    end
  end
end