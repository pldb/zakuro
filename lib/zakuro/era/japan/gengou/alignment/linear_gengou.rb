# frozen_string_literal: true

require_relative '../../../western/calendar'

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
        # @param [Resource::Gengou] gengou 元号
        #
        def initialize(start_date: Western::Calendar.new, last_date: Western::Calendar.new,
                       gengou: Resource::Gengou.new)
          @gengou = gengou
          @start_date = start_date.invalid? ? native_start_date : start_date
          @last_date = last_date.invalid? ? native_last_date : last_date
        end

        #
        # 元号名を取得する
        #
        # @return [String] 元号名
        #
        def name
          @gengou.name
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
        # 完全に範囲内か
        #
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        #
        # @return [True] 範囲内
        # @return [False] 範囲外あり
        #
        def in?(start_date:, last_date:)
          @start_date <= start_date && last_date <= @last_date
        end

        #
        # 完全に範囲外か
        #
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        #
        # @return [True] 範囲外
        # @return [False] 範囲内あり
        #
        def out?(start_date:, last_date:)
          # 範囲より前
          return true if start_date < @start_date && last_date < @start_date

          # 範囲より後
          return true if @last_date < start_date && @last_date < last_date

          false
        end

        #
        # 完全に範囲を超えているか
        #
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        #
        # @return [True] 完全超過
        # @return [True] 完全超過せず
        #
        def covered?(start_date:, last_date:)
          start_date < @start_date && @last_date < last_date
        end

        private

        #
        # 設定された元号の開始日を取得する
        #
        # @return [<Type>] <description>
        #
        def native_start_date
          @gengou.both_start_date.western
        end

        #
        # 設定された元号の終了日を取得する
        #
        # @return [<Type>] <description>
        #
        def native_last_date
          @gengou.last_date
        end
      end
    end
  end
end
