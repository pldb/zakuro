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
        # 月地点を計算する
        #
        # @param [Location] location 入暦
        # @param [Integer] western_year 西暦年
        #
        # @return [Location] 入暦
        #
        def self.calc_moon_point(location:, western_year:)
          if location.calculated
            location.decrease
            return location
          end

          calc_first_moon_point(winter_solstice_age: location.remainder,
                                western_year: western_year)
        end

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 入暦（月の遠地点から数えた日数/近地点から数えた日数）を求める
        #
        # 天正冬至（入暦前回未計算）を求める
        #
        # @param [Remainder] winter_solstice_age 天正閏余
        # @param [Integer] western_year 西暦年
        #
        # @return [Location] 入暦
        #
        def self.calc_first_moon_point(winter_solstice_age:, western_year:)
          # 積年の開始から対象年までの年数
          total_year = TOTAL_YEAR + western_year - BEGIN_YEAR

          # 通積分 - 天正閏余
          total_day = \
            total_year * YEAR - winter_solstice_age.to_minute

          remainder_month = \
            Cycle::LunarRemainder.new(total: (total_day % ANOMALISTIC_MONTH))

          location = Location.new(remainder: remainder_month, forward: true)
          location.first

          location
        end
        private_class_method :calc_first_moon_point
      end
    end
  end
end
