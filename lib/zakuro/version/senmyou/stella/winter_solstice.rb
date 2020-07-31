# frozen_string_literal: true

require_relative '../../../output/logger'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :reek:TooManyConstants

    #
    # WinterSolstice 冬至
    #
    module WinterSolstice
      # @return [Integer] 統法（1日=8400分）
      DAY = 8400
      # @return [Integer] 朔望月
      SYNODIC_MONTH = 248_057
      # @return [Integer] 一年
      YEAR = 3_068_055
      # @return [Integer] 通余:  (YEAR - DAY * 12 * 30)  = 44055
      REMAINDER_ALL_YEAR = 44_055
      # @return [Integer] 旬周（60日） 8400 * 60
      SIXTY_DAYS = 504_000
      # @return [Integer] 積年（甲子夜半朔旦冬至〜暦の開始前）
      TOTAL_YEAR = 7_070_138
      # @return [Integer] 暦の開始年（長慶2年）
      BEGIN_YEAR = 822

      # @return [Logger] ロガー
      LOGGER = Logger.new(location: 'winter_solstice')

      # :reek:TooManyStatements { max_statements: 6 }

      #
      # 対象年の前年の冬至を求める
      #
      # @param [Integer] western_year 西暦年
      #
      # @return [Remainder] 前年の冬至
      #
      def self.calc(western_year:)
        # 積年の開始から対象年までの年数
        total = TOTAL_YEAR + western_year - BEGIN_YEAR
        remainder_year = total % SIXTY_DAYS

        LOGGER.debug("[a01]:#{remainder_year}")

        # 通余を使う
        winter_solstice_minute = (remainder_year * REMAINDER_ALL_YEAR) % SIXTY_DAYS

        LOGGER.debug("[a02]:#{winter_solstice_minute}")

        Remainder.new(total: winter_solstice_minute)
      end

      # :reek:TooManyStatements { max_statements: 7 }

      #
      # 対象年の天正閏余（冬至より前にある11月経朔との差 = 月齢）を算出する
      # 太陽と月の運動による補正値を算出し、その補正結果を返す
      #
      # @param [Integer] western_year 西暦年
      #
      # @return [Remainder] 天正閏余
      #
      def self.calc_moon_age(western_year:)
        # 積年の開始から対象年までの年数
        total = TOTAL_YEAR + western_year - BEGIN_YEAR

        # 12朔望月に対する1年の余り（単位:分）
        remainder_minute = YEAR - (SYNODIC_MONTH * 12)

        # 朔望月に含まれなかった余り（単位:年）
        remainder_year = total % SYNODIC_MONTH

        LOGGER.debug("[b01]: #{remainder_year}")

        # 天正閏余
        winter_solstice_age = remainder_minute * remainder_year % SYNODIC_MONTH

        LOGGER.debug("[b02]: #{winter_solstice_age}")

        # 大余・小余に変換する
        Remainder.new(total: winter_solstice_age)
      end

      #
      # 11月経朔（冬至が含まれる月の1日）を求める
      #
      # @param [Integer] western_year 西暦年
      #
      # @return [Remainder] 11月経朔
      #
      def self.calc_averaged_last_november_1st(western_year:)
        # 冬至
        winter_solstice = calc(western_year: western_year)
        # 天正閏余
        winter_solstice_age = calc_moon_age(western_year: western_year)

        # 11月経朔
        winter_solstice.sub(winter_solstice_age)
      end
    end
  end
end
