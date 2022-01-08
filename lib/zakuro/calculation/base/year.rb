# frozen_string_literal: true

require_relative '../cycle/zodiac'

require_relative '../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Base
      #
      # Year 年
      #
      class Year
        # @return [Array<Month>] 年内の全ての月
        attr_reader :months
        # @return [Integer] 年の日数
        attr_reader :total_days

        #
        # 初期化
        #
        # @param [Array<Month>] months 年内の全ての月
        # @param [Integer] total_days 年の日数
        #
        def initialize(months: [], total_days: 0)
          @months = months
          @total_days = total_days
        end

        #
        # 年の日数を確定する
        #
        def commit
          @total_days = 0
          months.each do |month|
            @total_days += month.days
          end

          self
        end

        #
        # 次年にする
        #
        # @param [Japan::Gengou] first_line 元号（1行目）
        # @param [Japan::Gengou] second_line 元号（2行目）
        #
        # @return [MultiGengou] 自身
        #
        def next_year
          @total_days = 0

          self
        end

        #
        # 年初を取得する
        #
        # @return [Western::Calendar] 年初
        #
        def new_year_date
          return Western::Calendar.new unless months

          return Western::Calendar.new if months.size.zero?

          @months.first_day.western_date
        end

        #
        # 十干十二支を取得する
        #
        # @return [String] 十干十二支
        #
        def zodiac_name
          date = new_year_date
          return '' if date.invalid?

          Cycle::Zodiac.year_name(western_year: date.year)
        end

        #
        # 月を追加する
        #
        # @param [Month] month 月
        #
        def push(month:)
          return if duplicated?(month: month)

          @months.push(month)

          nil
        end

        #
        # すでに登録済みの月と重複しているか判定する
        #
        # @note 昨年11月1日から今年1月1日の前日までで、去年データと重複する場合は登録スキップする
        #
        # @param [Month] month 月
        #
        # @return [True] 重複している
        # @return [True] 重複していない
        #
        def duplicated?(month:)
          @months.each do |existed|
            return true if existed.same?(other: month)
          end
          false
        end
      end
    end
  end
end
