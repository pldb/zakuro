# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Cycle
      #
      # 大余小余（時刻情報）
      # @abstract 大余小余計算に必要な処理を行う、暦に依存しない汎用的なクラス
      #
      # * 十干十二支（60日）を上限とした「日時分秒」の情報で、日付（date）/時刻（time）と部分的に重なる概念
      # * 「15日1012分5秒」のような形式で表される
      # * 分の上限で大余に繰り上げる
      # * 秒の上限で1分に繰り上げる
      #
      class AbstractRemainder # rubocop:disable Metrics/ClassLength
        # @return [Integer] 大余上限
        LIMIT = 60

        # @return [Integer] 大余（"日"に相当）
        attr_reader :day
        # @return [Integer] 小余（"分"に相当）
        attr_reader :minute
        # @return [Integer] 秒
        attr_reader :second
        # @return [Integer] 繰り上げなしの小余
        attr_reader :base_limit
        # @return [Integer] 1大余に必要な小余（暦によって基数が異なる）
        attr_reader :base_day
        # @return [Integer] 1小余に必要な秒（暦によって基数が異なる）
        attr_reader :base_minute
        # 繰り上げ有無
        # @return [True] 繰り上げあり
        # @return [False] 繰り上げなし
        attr_reader :limited

        # :reek:instanceVariableAssumption
        # rubocop:disable Metrics/ParameterLists

        #
        # 初期化
        #
        # @param [Integer] base_day 1大余に必要な小余（暦によって基数が異なる）
        # @param [Integer] base_minute 1小余に必要な秒（暦によって基数が異なる）
        # @param [Integer] day 大余（"日"に相当）
        # @param [Integer] minute 小余（"分"に相当）
        # @param [Integer] second 秒
        # @param [Integer] total 繰り上げなしの小余
        #
        def initialize(base_day: -1, base_minute: -1, day: -1, minute: -1, second: -1, total: -1)
          @base_limit = LIMIT
          @base_day = base_day
          @base_minute = base_minute
          @limited = true

          set(day: day, minute: minute, second: second, total: total)
        end
        # rubocop:enable Metrics/ParameterLists

        #
        # 値を設定する
        #
        # @param [Integer] day 大余（"日"に相当）
        # @param [Integer] minute 小余（"分"に相当）
        # @param [Integer] second 秒
        # @param [Integer] total 繰り上げなしの小余
        #
        # @return [AbstractRemainder] 自身の参照
        #
        def set(day: -1, minute: -1, second: -1, total: -1)
          @day = day
          @minute = minute
          @second = second

          if total != -1
            @day = (total.to_f / base_day).floor
            @minute = (total % base_day)
            @second = 0
          end

          self
        end

        #
        # 繰り上げ処理を外す
        #
        # @return [AbstractRemainder] 自身の参照
        #
        def lift_limit
          @limited = false

          self
        end

        #
        # 繰り上げ処理を設定する
        #
        # @return [AbstractRemainder] 自身の参照
        #
        def set_limit
          @limited = true

          self
        end

        #
        # 無効かどうか
        #
        # @param [AbstractRemainder] param 自クラスのインスタンス（デフォルトは自身の参照）
        #
        # @return [True] 無効
        # @return [False] 有効
        #
        # @raise [ArgumentError] 引数エラー
        #
        def invalid?(param: self)
          raise ArgumentError, 'unmatch parameter type' unless param.is_a?(AbstractRemainder)

          param.day == -1 || param.minute == -1 || param.second == -1
        end

        #
        # 十干十二支名
        #
        # @return [String] 十干十二支名
        #
        def zodiac_name
          Cycle::Zodiac.day_name(day: day)
        end

        #
        # 日が同じ十干かどうか（大小の月判定）
        #
        # @param [Integer] other 大余
        #
        # @return [True] 当月朔日と翌月朔日が同じ十干（「大」の月）
        # @return [False] 当月朔日と翌月朔日が異なる十干（「小」の月）
        #
        def same_remainder_divided_by_ten?(other:)
          remainder_day = day % LIMIT

          (remainder_day % 10) == (other % 10)
        end

        #
        # （非破壊的に）加算する
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [AbstractRemainder] 加算結果
        #
        def add(other)
          invalid?(param: other)
          sum_day = day + other.day
          sum_minute = minute + other.minute
          sum_second = second + other.second
          sum_day, sum_minute, sum_second = carry(
            sum_day, sum_minute, sum_second
          )

          clone.set(day: sum_day, minute: sum_minute, second: sum_second)
        end

        #
        # （破壊的に）加算する
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [AbstractRemainder] 加算結果
        #
        def add!(other)
          result = add(other)
          @day = result.day
          @minute = result.minute
          @second = result.second

          self
        end

        #
        # （非破壊的に）除算する
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [AbstractRemainder] 除算結果
        #
        def sub(other)
          invalid?(param: other)
          sum_day = day - other.day
          sum_minute = minute - other.minute
          sum_second = second - other.second
          sum_day, sum_minute, sum_second = carry(
            sum_day, sum_minute, sum_second
          )

          clone.set(day: sum_day, minute: sum_minute, second: sum_second)
        end

        #
        # （破壊的に）除算する
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [AbstractRemainder] 除算結果
        #
        def sub!(other)
          result = sub(other)
          @day = result.day
          @minute = result.minute
          @second = result.second

          self
        end

        #
        # 大小比較（>）
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [True] より大きい
        # @return [False] 以下
        #
        def >(other)
          up?(other)
        end

        #
        # 大小比較（>=）
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [True] 以上
        # @return [False] より小さい
        #
        def >=(other)
          up?(other) || eql?(other)
        end

        #
        # 大小比較（<）
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [True] より小さい
        # @return [False] 以上
        #
        def <(other)
          down?(other)
        end

        #
        # 大小比較（<=）
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [True] 以下
        # @return [False] より大きい
        #
        def <=(other)
          down?(other) || eql?(other)
        end

        #
        # 大小比較（==）
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [True] 等しい
        # @return [False] 等しくない
        #
        def ==(other)
          eql?(other)
        end

        #
        # 大小比較（!=）
        #
        # @param [AbstractRemainder] other 他の大余小余
        #
        # @return [True] 等しくない
        # @return [False] 等しい
        #
        def !=(other)
          !eql?(other)
        end

        # 進朔
        # @see 進朔 http://eco.mtk.nao.ac.jp/koyomi/wiki/C2C0B1A2C2C0CDDBCEF12FBFCABAF3.html
        # 進朔とは、朔の瞬間が1日の3/4すなわち夕方以降となる場合に、その日ではなく1日進めて翌日を1日目にする方法のことです。
        # 進朔するかどうかの基準時刻を進朔限といいます。宣明暦では1日8400分ですから、進朔限は6300分で、それ以降だと進朔されます。

        #
        # （非破壊的に）進朔する
        #
        # @see http://eco.mtk.nao.ac.jp/koyomi/wiki/C2C0B1A2C2C0CDDBCEF12FBFCABAF3.html
        #
        # 進朔とは、朔の瞬間が1日の3/4すなわち夕方以降となる場合に、その日ではなく1日進めて翌日を1日目にする方法のことです。
        # 進朔するかどうかの基準時刻を進朔限といいます。宣明暦では1日8400分ですから、進朔限は6300分で、それ以降だと進朔されます。
        #
        # @return [AbstractRemainder] 進朔結果
        #
        def up_on_new_moon
          cloned = clone
          limit = (base_day * 3) / 4
          if minute >= limit
            sum_day, sum_minute, sum_second = carry((day + 1), minute, second)
            return cloned.set(day: sum_day, minute: sum_minute, second: sum_second)
          end

          cloned
        end

        #
        # （破壊的に）進朔する
        #
        # @see http://eco.mtk.nao.ac.jp/koyomi/wiki/C2C0B1A2C2C0CDDBCEF12FBFCABAF3.html
        #
        # 進朔とは、朔の瞬間が1日の3/4すなわち夕方以降となる場合に、その日ではなく1日進めて翌日を1日目にする方法のことです。
        # 進朔するかどうかの基準時刻を進朔限といいます。宣明暦では1日8400分ですから、進朔限は6300分で、それ以降だと進朔されます。
        #
        # @return [AbstractRemainder] 進朔結果
        #
        def up_on_new_moon!
          result = up_on_new_moon
          @day = result.day
          @minute = result.minute
          @second = result.second

          self
        end

        #
        # 小余に揃えた結果を返す（秒は除外する）
        #
        # @return [Integer] 小余
        #
        def to_minute
          day * base_day + minute
        end

        #
        # 小余（秒切り捨て）を返す
        #
        # @note 切り捨て前に繰り上げる
        #
        # @return [Integer] 小余（秒切り捨て）
        #
        def floor_minute
          result = float_minute
          # NOTE: 『日本暦日原典』に準じ、少数点以下桁数を2桁とし、3桁目は四捨五入する
          # これが判明したのは、月の運動による計算を行う際、下記の小余が±1ズレていたことによる
          #
          # ## 儀鳳暦
          # * 大宝 2年 5 大 丁卯 3-1129 702 5 31 (12)22-138 (11)6-1185
          # * 養老 3年 閏7 小 丁巳 53-767 719 8 20            (17)7-478
          #
          # ## 大衍暦
          # * 神護景雲 2年 5 小 甲辰 40-632 768 5 21 (12)8-363 (11)52-2739
          # * 仁寿 2年 10 大 癸亥 59-1781 852 11 15 (22)0-2538 (23)16-162
          #
          # ## 宣明暦
          # * 天暦 2年 7 小 戊申 44-8274 948 8 8 (16)53-690 (17)8-2525
          # * 仁平 2年 3 小 丙申 32-1497 1152 4 7 (8)41-2025 (9)56-3860
          # * 承久 2年 庚辰   2 小 壬戌 58-7037 1220 3 7 (6)7-3693 (7)22-5529
          # * 安貞 1年 8 大 丁未 43-5913 1227 9 12 (18)46-6506 (19)1-8341
          # * 永享 10年 12 大 辛亥 47-2832 1438 12 17 (2)15-1196 (1)59-7760
          #
          # これらは月の運行で表の引き当て時に使う大余小余のズレが原因だった
          # 小余は、小余と秒の合算値で求められるが、次の合算値が『日本暦日原典』で切り上げられていた
          #
          # ## 儀鳳暦
          # |小余|小余（秒 / 12）|合算|
          # |:----|:----|:----|
          # |950.4999913|0.5|950.9999913|
          # |390.7499913|0.25|390.9999913|
          #
          # ## 大衍暦
          # |小余|小余（秒 / 80）|合算|
          # |:----|:----|:----|
          # |1697.921259|0.075|1697.996259|
          # |2656.833759|0.1625|2656.996259|
          #
          # ## 宣明暦
          # |小余|小余（秒 / 100）|合算|
          # |:----|:----|:----|
          # |6291.709782|0.29|6291.999782|
          # |361.9497818|0.05|361.9997818|
          # |5470.569782|0.43|5470.999782|
          # |4552.089782|0.91|4552.999782|
          # |2161.659782|0.34|2161.999782|
          #
          # 従って、少数点以下桁数を2桁とし、3桁目は四捨五入することとした
          result = result.round(2)
          # 秒は切り捨てる
          result.floor
        end

        #
        # 秒を含めた小余を返す
        #
        # @return [Float] 小余
        #
        def float_minute
          minute + second.to_f / base_minute
        end

        #
        # 大余に四捨五入した結果を返す（秒は除外する）
        #
        # @return [AbstractRemainder] 大余
        #
        def round
          sum_day = day
          sum_day += 1 if minute >= (base_day / 2)

          initialize(sum_day, 0, 0)
        end

        #
        # 文字化する
        #
        # @return [String] 文字化
        #
        def to_s
          "大余（日）: #{day}, 小余（分）: #{minute}, 小余（秒）: #{second}"
        end

        #
        # 繰り上げる
        #
        # @return [AbstractRemainder] 繰り上げ結果
        #
        def carry!
          @day, @minute, @second = carry(day, minute, second)

          self
        end

        private

        # 繰り上げ、繰り下げ
        def carry(param_day, param_minute, param_second)
          # NOTE: 計算方法としてマイナスでも徐算・剰余算の結果をプラス同様に扱う
          minute, second = carry_second(param_minute, param_second)

          day, minute = carry_minute(param_day, minute)

          day = carry_day(day, @limited)

          [day, minute, second]
        end

        def carry_second(param_minute, param_second)
          sign = param_second.negative? ? -1 : 1
          abs = sign * param_second
          minute = param_minute + (sign * (abs / base_minute).floor)
          second = sign * (abs % base_minute)

          if sign.negative?
            second += base_minute
            minute -= 1
          end

          [minute, second]
        end

        def carry_minute(param_day, param_minute)
          sign = param_minute.negative? ? -1 : 1
          abs = sign * param_minute

          day = param_day + (sign * (abs / base_day).floor)
          minute = sign * (abs % base_day)

          if sign.negative?
            minute += base_day
            day -= 1
          end

          [day, minute]
        end

        def carry_day(day, limited)
          sign = day.negative? ? -1 : 1
          abs = sign * day
          carried = sign * (abs % base_limit) if limited
          carried += base_limit if sign.negative?
          carried
        end

        def up?(other)
          invalid?(param: other)
          other_day = other.day
          other_minute = other.float_minute

          return true if day > other_day

          return false if day < other_day

          float_minute > other_minute
        end

        def eql?(other)
          invalid?(param: other)

          (day == other.day && float_minute == other.float_minute)
        end

        def down?(other)
          invalid?(param: other)
          other_day = other.day
          other_minute = other.float_minute

          return true if day < other_day

          return false if day > other_day

          float_minute < other_minute
        end
      end
    end
  end
end
