# frozen_string_literal: true

require_relative '../../../context/option'
require_relative '../../../result/data/option/dropped_date/option'
require_relative '../../../result/data/solar_term'

require_relative '../../option/dropped_date/location'

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
        class << self
          #
          # 初期化
          #
          # @param [Calculation::Monthly::Month] month 月情報（各暦のデータ型）
          # @param [Calculation::Base::Day] day 日情報
          #
          # @return [Hash<String, Result::Data::Option::AbstractOption>] オプション結果
          #
          def create(month:, day:)
            options = {}
            context = month.context

            if context.option.dropped_date?
              remainder = day.remainder
              solar_terms = month.solar_terms
              option = dropped_date(
                context: context, remainder: remainder, solar_terms: solar_terms
              )
              options[Context::Option::DROPPED_DATE_KEY] = option
            end

            options
          end

          private

          #
          # 没日を求める
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Cycle::AbstractRemainder] remainder 当日和暦日
          # @param [Array<Cycle::AbstractSolarTerm>] solar_terms 二十四節気
          #
          # @return [Result::Data::Option::DroppedDate::Option] 没日
          #
          def dropped_date(context:, remainder:, solar_terms:)
            option = Result::Data::Option::DroppedDate::Option.new(
              matched: false,
              calculation: Result::Data::Option::DroppedDate::Calculation.new
            )

            return option if remainder.invalid?

            location = Calculation::Option::DroppedDate::Location.new(
              context: context, solar_terms: solar_terms
            )

            return option unless location.exist?

            dropped_date = location.get

            return option unless remainder.day == dropped_date.day

            dropped_date_option(location: location)
          end

          #
          # 没日オプション値を生成する
          #
          # @param [Calculation::Option::DroppedDate::Location] location 没日位置
          #
          # @return [Result::Data::Option::DroppedDate::Option] 没日オプション値
          #
          def dropped_date_option(location:)
            dropped_date = location.get
            solar_term = location.solar_term
            Result::Data::Option::DroppedDate::Option.new(
              matched: true,
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
