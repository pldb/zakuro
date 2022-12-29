# frozen_string_literal: true

require_relative '../../../context/option'
require_relative '../../../result/data/option/dropped_date/option'
require_relative '../../../result/data/solar_term'
require_relative '../../../result/data/option/vanished_date/option'

require_relative '../../option/dropped_date/location'
require_relative '../../option/vanished_date/location'

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
            # TODO: refactor

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

            if context.option.vanished_date?
              remainder = day.remainder
              average_remainder = month.first_day.average_remainder
              option = vanished_date(
                context: context, remainder: remainder, average_remainder: average_remainder
              )
              options[Context::Option::VANISHED_DATE_KEY] = option
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
            option = Result::Data::Option::DroppedDate::Option.new

            return option if remainder.invalid?

            location = Calculation::Option::DroppedDate::Location.new(
              context: context, solar_terms: solar_terms
            )

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

          #
          # 滅日を求める
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Cycle::AbstractRemainder] remainder 当日和暦日
          # @param [Cycle::AbstractRemainder] average_remainder 経朔
          #
          # @return [Result::Data::Option::VanishedDate::Option] 滅日オプション値
          #
          def vanished_date(context:, remainder:, average_remainder:)
            return Result::Data::Option::VanishedDate::Option.new if average_remainder.invalid?

            location = Calculation::Option::VanishedDate::Location.new(
              context: context, average_remainder: average_remainder
            )

            unless location.exist?
              # 結果確認のため経朔だけは設定する
              return Result::Data::Option::VanishedDate::Option.new(
                calculation: Result::Data::Option::VanishedDate::Calculation.new(
                  average_remainder: average_remainder
                )
              )
            end

            vanished_date = location.get

            vanished_date_option(
              matched: remainder.day == vanished_date.day, location: location
            )
          end

          #
          # 滅日オプション値を生成する
          #
          # @param [True, False] matched 滅日有無
          # @param [Calculation::Option::VanishedDate::Location] location 滅日位置
          #
          # @return [Result::Data::Option::VanishedDate::Option] 滅日オプション値
          #
          def vanished_date_option(matched:, location:)
            vanished_date = location.get
            Result::Data::Option::VanishedDate::Option.new(
              matched: matched,
              calculation: Result::Data::Option::VanishedDate::Calculation.new(
                remainder: vanished_date.format,
                average_remainder: location.average_remainder
              )
            )
          end
        end
      end
    end
  end
end
