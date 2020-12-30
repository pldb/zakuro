# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Cycle
    #
    # 大余小余（時刻情報）
    # @abstract 大余小余計算に必要な処理を行う、暦に依存しない汎用的なクラス
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
      # @param [Integer] base_mitune 1小余に必要な秒（暦によって基数が異なる）
      # @param [Integer] day 大余（"日"に相当）
      # @param [Integer] minute 小余（"分"に相当）
      # @param [Integer] second 秒
      # @param [Integer] total 繰り上げなしの小余
      #
      def initialize(base_day:, base_mitune:, day: -1, minute: -1, second: -1, total: -1)
        @base_limit = LIMIT
        @base_day = base_day
        @base_minute = base_mitune
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
          @day = (total.to_f / @base_day).floor
          @minute = (total % @base_day)
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
        Cycle::Zodiac.day_name(day: @day)
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
        day = @day % LIMIT

        (day % 10) == (other % 10)
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
        day = @day + other.day
        minute = @minute + other.minute
        second = @second + other.second
        day, minute, second = carry(day, minute, second)

        clone.set(day: day, minute: minute, second: second)
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
        day = @day - other.day
        minute = @minute - other.minute
        second = @second - other.second
        day, minute, second = carry(day, minute, second)

        clone.set(day: day, minute: minute, second: second)
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
        up?(other) || \
          (@day == other.day && @minute == other.minute && @second == other.second)
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
        down?(other) || \
          (@day == other.day && @minute == other.minute && @second == other.second)
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
        if @minute >= limit
          day, minute, second = carry((@day + 1), @minute, @second)
          return cloned.set(day: day, minute: minute, second: second)
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
        @day * @base_day + @minute
      end

      #
      # 大余に四捨五入した結果を返す（秒は除外する）
      #
      # @return [AbstractRemainder] 大余
      #
      def round
        day = @day
        day += 1 if @minute >= (@base_day / 2)

        initialize(day, 0, 0)
      end

      #
      # 文字化する
      #
      # @return [String] 文字化
      #
      def to_s
        "大余（日）: #{@day}, 小余（分）: #{@minute}, 小余（秒）: #{@second}"
      end

      #
      # 特定の文字フォーマットにして出力する
      #
      # @param [String] form フォーマット（大余、小余、秒それぞれを%dで指定する）
      #
      # @return [String] フォーマットした結果
      #
      def format(form: '%d-%d')
        return '' if invalid?

        super(form, @day, @minute, @second)
      end

      private

      def carry!(day, minute, second)
        @day, @minute, @second = carry(day, minute, second)

        self
      end

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
        minute = param_minute + (sign * (abs / @base_minute).floor)
        second = sign * (abs % @base_minute)

        if sign.negative?
          second += @base_minute
          minute -= 1
        end

        [minute, second]
      end

      def carry_minute(param_day, param_minute)
        sign = param_minute.negative? ? -1 : 1
        abs = sign * param_minute

        day = param_day + (sign * (abs / @base_day).floor)
        minute = sign * (abs % @base_day)

        if sign.negative?
          minute += @base_day
          day -= 1
        end

        [day, minute]
      end

      def carry_day(day, limited)
        sign = day.negative? ? -1 : 1
        abs = sign * day
        carried = sign * (abs % @base_limit) if limited
        carried += @base_limit if sign.negative?
        carried
      end

      def up?(other)
        invalid?(param: other)
        day = other.day
        minute = other.minute
        return true if @day > day
        return false if @day < day

        return true if @minute > minute
        return false if @minute < minute

        @second > other.second
      end

      def eql?(other)
        invalid?(param: other)

        (@day == other.day && @minute == other.minute && @second == other.second)
      end

      def down?(other)
        invalid?(param: other)
        day = other.day
        minute = other.minute
        return true if @day < day
        return false if @day > day

        return true if @minute < minute
        return false if @minute > minute

        @second < other.second
      end
    end
  end
end
