# frozen_string_literal: true

require_relative '../../../context/option'

require_relative './option/dropped_date'
require_relative './option/vanished_date'

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
              option = DroppedDate.get(month: month, day: day)

              options[Context::Option::DROPPED_DATE_KEY] = option
            end

            if context.option.vanished_date?
              option = VanishedDate.get(month: month, day: day)

              options[Context::Option::VANISHED_DATE_KEY] = option
            end

            options
          end
        end
      end
    end
  end
end
