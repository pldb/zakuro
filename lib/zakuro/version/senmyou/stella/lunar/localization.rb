# frozen_string_literal: true

require_relative '../../const/const'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :nodoc:
    module Lunar
      #
      # Localization 入暦特定
      #
      module Localization
        # @return [Integer] 1近日点
        ANOMALISTIC_MONTH = Const::Cycle::ANOMALISTIC_MONTH
        # @return [Integer] 積年
        TOTAL_YEAR = Const::Stack::TOTAL_YEAR
        # @return [Integer] 開始年
        BEGIN_YEAR = Const::Stack::BEGIN_YEAR
        # @return [Integer] 年
        YEAR = Const::Cycle::YEAR

        #
        # 対象年の最初の入暦を求める
        #
        # @param [Remainder] winter_solstice_age 天正閏余
        # @param [Integer] western_year 西暦年
        #
        # @return [Cycle::LunarRemainder] 入暦
        #
        def self.first_remainder(winter_solstice_age:, western_year:)
          # 積年の開始から対象年までの年数
          total_year = TOTAL_YEAR + western_year - BEGIN_YEAR

          # 通積分 - 天正閏余
          total_day = \
            total_year * YEAR - winter_solstice_age.to_minute

          Cycle::LunarRemainder.new(total: (total_day % ANOMALISTIC_MONTH))
        end
      end
    end
  end
end
