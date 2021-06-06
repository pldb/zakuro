# frozen_string_literal: true

require_relative '../../../../output/logger'

require_relative '../../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    # :nodoc:
    module Origin
      #
      # LunarAge 天正閏余
      #
      module LunarAge
        # @return [Integer] 朔望月
        SYNODIC_MONTH = Const::Number::Cycle::SYNODIC_MONTH
        # @return [Integer] 一年
        YEAR = Const::Number::Cycle::YEAR
        # @return [Integer] 積年
        TOTAL_YEAR = Const::Number::Stack::TOTAL_YEAR
        # @return [Integer] 暦の開始年
        BEGIN_YEAR = Const::Number::Stack::BEGIN_YEAR

        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'lunar_age')

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 対象年の天正閏余（冬至より前にある11月経朔との差 = 月齢）を算出する
        # 太陽と月の運動による補正値を算出し、その補正結果を返す
        #
        # @param [Integer] western_year 西暦年
        #
        # @return [Remainder] 天正閏余
        #
        def self.get(western_year:)
          # 積年の開始から対象年までの年数
          total = TOTAL_YEAR + western_year - BEGIN_YEAR

          # 12朔望月に対する1年の余り（単位:分）
          remainder_minute = YEAR - (SYNODIC_MONTH * 12)

          # 朔望月に含まれなかった余り（単位:年）
          remainder_year = total % SYNODIC_MONTH

          LOGGER.debug("[01]: #{remainder_year}")

          # 天正閏余
          lunar_age = remainder_minute * remainder_year % SYNODIC_MONTH

          LOGGER.debug("[02]: #{lunar_age}")

          # 大余・小余に変換する
          Cycle::Remainder.new(total: lunar_age)
        end
      end
    end
  end
end
