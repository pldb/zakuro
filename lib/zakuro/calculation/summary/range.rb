# frozen_string_literal: true

require_relative '../specifier/multiple_day'

require_relative '../range/operated_range'

require_relative '../range/dated_full_range'

require_relative './internal/operation'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      #
      # Range 期間
      #
      module Range
        #
        # 生成する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [Result::Range] 期間検索結果（和暦日）
        #
        def self.get(context:, start_date: Western::Calendar.new, last_date: Western::Calendar.new)
          years = get_full_range_years(
            context: context, start_date: start_date, last_date: last_date
          )
          operated_years = get_operated_range_years(
            context: context, years: years, start_date: start_date, last_date: last_date
          )

          dates = Specifier::MultipleDay.get(
            years: years, start_date: start_date, last_date: last_date
          )

          operated_dates = Specifier::MultipleDay.get(
            years: operated_years, start_date: start_date, last_date: last_date
          )

          list = create_result_list(dates: dates, operated_dates: operated_dates)

          Result::Range.new(list: list)
        end

        #
        # 完全範囲を取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [Array<Base::Year>] 完全範囲
        #
        def self.get_full_range_years(context:, start_date: Western::Calendar.new,
                                      last_date: Western::Calendar.new)
          full_range = Calculation::Range::DatedFullRange.new(
            context: context, start_date: start_date, last_date: last_date
          )
          full_range.get
        end
        private_class_method :get_full_range_years

        #
        # 運用結果範囲を取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Array<Base::OperatedYear>] 運用結果範囲
        #
        def self.get_operated_range_years(context:, years:, start_date: Western::Calendar.new,
                                          last_date: Western::Calendar.new)
          operated_range = Calculation::Range::OperatedRange.new(
            context: context, start_date: start_date, last_date: last_date, years: years
          )
          operated_range.get
        end
        private_class_method :get_operated_range_years

        #
        # 結果リストを生成する
        #
        # @param [Array<Result::Data::SingleDay>] dates 検索結果（計算値）
        # @param [Array<Result::Data::SingleDay>] operated_dates 検索結果（運用値）
        #
        # @return [Array<Result::Single>] 結果リスト
        #
        def self.create_result_list(dates:, operated_dates:)
          result = []

          return result if dates.size != operated_dates.size

          (0..(dates.size - 1)).each do |index|
            data = operated_dates[index]

            date = dates[index]
            operation = Operation.create(calc_date: date)

            result.push(
              Result::Single.new(
                data: data,
                operation: operation
              )
            )
          end

          result
        end
      end
    end
  end
end
