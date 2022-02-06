# frozen_string_literal: true

require_relative '../../western/calendar'

require_relative '../resource/type'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Alignment
      #
      # LinearGengou 直列元号
      #
      class LinearGengou
        INVALID_YEAR = -1

        # @return [Western::Calendar] 開始日
        attr_reader :start_date
        # @return [Western::Calendar] 終了日
        attr_reader :last_date
        # @return [Gengou] 元号
        attr_reader :gengou

        #
        # 初期化
        #
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        # @param [Gengou] gengou 元号
        #
        def initialize(start_date: Western::Calendar.new, last_date: Western::Calendar.new,
                       gengou: Gengou.new)
          @start_date = start_date.invalid? ? gengou.both_start_date.western : start_date
          @last_date = last_date.invalid? ? gengou.last_date : last_date
          @gengou = gengou
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          @gengou.invalid?
        end

        #
        # 範囲内か
        #
        # @param [Western::Calendar] date 西暦日
        #
        # @return [True] 範囲内
        # @return [False] 範囲外
        #
        def include?(date: Western::Calendar.new)
          return false if invalid?

          return false if @start_date.invalid?

          return false if @last_date.invalid?

          return false if date < @start_date

          return false if date > @last_date

          true
        end

        #
        # 範囲が重複しない差分を返す
        #
        # @param [Array<LinearGengou>] other 元号
        #
        # @return [Array<LinearGengou>] 差分
        #
        def sub(other:)
          # TODO: make
        end

        #
        # 重複した範囲を返す
        #
        # @param [Array<LinearGengou>] other 元号
        #
        # @return [Array<LinearGengou>] 重複分
        #
        def meet(other:)
          # TODO: make
        end
      end
    end
  end
end
