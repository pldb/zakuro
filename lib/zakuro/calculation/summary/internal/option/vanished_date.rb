# frozen_string_literal: true

require_relative '../../../../context/option'
require_relative '../../../../result/data/option/vanished_date/option'
require_relative '../../../../result/data/solar_term'

require_relative '../../../option/vanished_date/location'

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
        # VanishedDate 滅日
        #
        module VanishedDate
          class << self
            #
            # 滅日を取得する
            #
            # @param [Calculation::Monthly::Month] month 月情報（各暦のデータ型）
            # @param [Calculation::Base::Day] day 日情報
            #
            # @return [Result::Data::Option::VanishedDate::Option] 滅日オプション値
            #
            def get(month:, day:)
              context = month.context

              remainder = day.remainder
              average_remainder = month.first_day.average_remainder
              # p "remainder: #{remainder.format}"
              # p "last_average_remainder: #{month.meta.last_average_remainder.format}"

              if day.number == 1
                option = vanished_date(
                  context: context, remainder: remainder,
                  average_remainder: month.meta.last_average_remainder
                )

                return option if option.matched
              end

              option = vanished_date(
                context: context, remainder: remainder, average_remainder: average_remainder
              )

              option
            end

            private

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

              return Result::Data::Option::VanishedDate::Option.new if location.invalid?

              unless location.exist?
                # 結果確認のため経朔だけは設定する
                return Result::Data::Option::VanishedDate::Option.new(
                  calculation: Result::Data::Option::VanishedDate::Calculation.new(
                    average_remainder: average_remainder
                  )
                )
              end

              vanished_date = location.get

              vanished_date_option(matched: remainder.day == vanished_date.day, location: location)
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
end
