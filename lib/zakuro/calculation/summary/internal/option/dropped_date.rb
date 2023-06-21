# frozen_string_literal: true

require_relative '../../../../context/option'
require_relative '../../../../result/data/option/dropped_date/option'
require_relative '../../../../result/data/solar_term'

require_relative '../../../option/dropped_date/location'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      #
      # Option オプション
      #
      module Option
        #
        # DroppedDate 没日
        #
        module DroppedDate
          class << self
            #
            # 没日を取得する
            #
            # @param [Calculation::Monthly::Month] month 月情報（各暦のデータ型）
            # @param [Calculation::Base::Day] day 日情報
            #
            # @return [Result::Data::Option::DroppedDate::Option] 没日
            #
            def get(month:, day:)
              context = month.context

              solar_term = month.solar_term_by_day(day: day.remainder.day)

              remainder = day.remainder

              dropped_date(
                context: context, remainder: remainder, solar_term: solar_term
              )
            end

            private

            #
            # 没日を求める
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Cycle::AbstractRemainder] remainder 当日和暦日
            # @param [Cycle::AbstractSolarTerm] solar_terms 二十四節気
            #
            # @return [Result::Data::Option::DroppedDate::Option] 没日
            #
            def dropped_date(context:, remainder:, solar_term:)
              option = Result::Data::Option::DroppedDate::Option.new

              return option if remainder.invalid?

              location = Calculation::Option::DroppedDate::Location.new(
                context: context, solar_term: solar_term
              )

              return option if location.invalid?

              return option unless location.exist?

              dropped_date = location.get

              dropped_date_option(
                matched: remainder.day == dropped_date.day, location: location
              )
            end

            #
            # 没日オプション値を生成する
            #
            # @param [True, False] matched 没日有無
            # @param [Calculation::Option::DroppedDate::Location] location 没日位置
            #
            # @return [Result::Data::Option::DroppedDate::Option] 没日オプション値
            #
            def dropped_date_option(matched:, location:)
              dropped_date = location.get
              solar_term = location.solar_term
              Result::Data::Option::DroppedDate::Option.new(
                matched: matched,
                calculation: Result::Data::Option::DroppedDate::Calculation.new(
                  remainder: dropped_date.format,
                  solar_term: Result::Data::SolarTerm.new(
                    index: solar_term.index,
                    remainder: solar_term.remainder.format
                  )
                )
              )
            end
          end
        end
      end
    end
  end
end
