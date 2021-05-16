# frozen_string_literal: true

require_relative '../../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    # :nodoc:
    module Lunar
      #
      # Localization 入暦特定
      #
      module Localization
        # TODO: 儀鳳暦にする

        # @return [Integer] 1近日点
        ANOMALISTIC_MONTH = Const::Number::Cycle::ANOMALISTIC_MONTH
        # @return [Integer] 積年
        TOTAL_YEAR = Const::Number::Stack::TOTAL_YEAR
        # @return [Integer] 開始年
        BEGIN_YEAR = Const::Number::Stack::BEGIN_YEAR
        # @return [Integer] 年
        YEAR = Const::Number::Cycle::YEAR

        #
        # 対象年の最初の入暦を求める
        #
        # @param [Remainder] lunar_age 天正閏余
        # @param [Integer] western_year 西暦年
        #
        # @return [Cycle::LunarRemainder] 入暦
        #
        def self.first_remainder(lunar_age:, western_year:)
          # 積年の開始から対象年までの年数
          total_year = TOTAL_YEAR + western_year - BEGIN_YEAR

          # 通積分 - 天正閏余
          total_day = \
            total_year * YEAR - lunar_age.to_minute

          Cycle::LunarRemainder.new(total: (total_day % ANOMALISTIC_MONTH))
        end
      end
    end
  end
end
