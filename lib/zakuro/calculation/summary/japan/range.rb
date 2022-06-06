# frozen_string_literal: true

require_relative '../../range/named_operation_range'

require_relative '../../range/named_full_range'

require_relative '../western/specifier/multiple_day'

require_relative '../internal/operation'

require_relative './specifier/single_day'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      # :nodoc:
      module Japan
        #
        # Range 期間
        #
        module Range
          #
          # 生成する
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Japan::Calendar] start_date 和暦開始日
          # @param [Japan::Calendar] last_date 和暦終了日
          #
          # @return [Result::Range] 期間検索結果（和暦日）
          #
          def self.get(context:, start_date: Japan::Calendar.new,
                       last_date: Japan::Calendar.new)
            years = get_full_range_years(
              context: context, start_date: start_date, last_date: last_date
            )
            operated_years = get_operation_range_years(
              context: context, years: years, start_date: start_date, last_date: last_date
            )

            japan_start_date = Specifier::SingleDay.get(years: operated_years, date: start_date)
            japan_last_date = Specifier::SingleDay.get(years: operated_years, date: last_date)

            list = create_list(
              operated_years: operated_years, years: years,
              start_date: japan_start_date, last_date: japan_last_date
            )

            Result::Range.new(list: list)
          end

          #
          # <Description>
          #
          # @param [Array<Base::OperatedYear>] operated_years 運用結果範囲
          # @param [Array<Base::Year>] years 完全範囲
          # @param [Result::Data::SingleDay] start_date 和暦開始日
          # @param [Result::Data::SingleDay] last_date 和暦終了日
          #
          # @return [Array<Result::Single>] 結果リスト
          #
          def self.create_list(operated_years: [], years: [],
                               start_date:, last_date:)
            western_start_date = start_date.day.western_date
            western_last_date = last_date.day.western_date

            operated_dates = Western::Specifier::MultipleDay.get(
              years: operated_years, start_date: western_start_date, last_date: western_last_date
            )

            dates = Western::Specifier::MultipleDay.get(
              years: years, start_date: western_start_date, last_date: western_last_date
            )

            create_result_list(dates: dates, operated_dates: operated_dates)
          end
          private_class_method :create_list

          #
          # 完全範囲を取得する
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Japan::Calendar] start_date 和暦開始日
          # @param [Japan::Calendar] last_date 和暦終了日
          #
          # @return [Array<Base::Year>] 完全範囲
          #
          def self.get_full_range_years(context:, start_date: Japan::Calendar.new,
                                        last_date: Japan::Calendar.new)
            full_range = Calculation::Range::NamedFullRange.new(
              context: context, start_name: start_date.gengou, last_name: last_date.gengou
            )
            full_range.get
          end
          private_class_method :get_full_range_years

          #
          # 運用結果範囲を取得する
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Array<Base::Year>] years 完全範囲
          # @param [Japan::Calendar] start_date 和暦開始日
          # @param [Japan::Calendar] last_date 和暦終了日
          #
          # @return [Array<Base::OperatedYear>] 運用結果範囲
          #
          def self.get_operation_range_years(context:, years:, start_date: Japan::Calendar.new,
                                             last_date: Japan::Calendar.new)
            operation_range = Calculation::Range::NamedOperationRange.new(
              context: context, years: years,
              start_name: start_date.gengou, last_name: last_date.gengou
            )
            operation_range.get
          end
          private_class_method :get_operation_range_years

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
end
