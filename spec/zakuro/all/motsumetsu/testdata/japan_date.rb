# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Motsumetsu
      #
      # JapanDate 和暦日
      #
      class JapanDate
        # @return [True] 閏
        # @return [False] 閏なし
        attr_reader :leaped
        # @return [Integer] 月
        attr_reader :month
        # @return [Integer] 日
        attr_reader :day
        # @return [String] 干支
        attr_reader :zodiac
        # @return [True] 没日
        # @return [False] 没日なし
        attr_reader :dropped
        # @return [True] 滅日
        # @return [False] 滅日なし
        attr_reader :vanished

        REGEX = /^(閏?[0-9]{1,2})・([0-9]{1,2})\(([一-龥]{2})\)([滅没])/.freeze

        #
        # 初期化
        #
        # @param [String] text 和暦日文字列
        # @param [True, False] leaped 閏/閏なし
        # @param [Integer] month 月
        # @param [Integer] day 日
        #
        def initialize(text: '', leaped: false, month: -1, day: -1)
          @leaped = leaped
          @month = month
          @day = day
          @zodiac = ''
          @dropped = false
          @vanished = false

          parse(text: text)
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          @month == -1
        end

        #
        # より大きいか（後か）
        #
        # @param [JapanDate] other 他和暦日
        #
        # @return [True] より大きい
        # @return [False] 以下
        #
        def >(other)
          return true if month > other.month

          return false if month < other.month

          return true if leaped && !other.leaped

          return true if day > other.day

          false
        end

        private

        def parse(text:)
          m = text.match(REGEX)
          return unless m

          @leaped = m[1].include?('閏')
          @month = m[1].gsub('閏', '').to_i
          @day = m[2].to_i
          @zodiac = m[3]
          @dropped = m[4].include?('没')
          @vanished = m[4].include?('滅')
        end
      end
    end
  end
end
