# frozen_string_literal: true

require 'json'

require_relative './stringifier'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # Gengou 元号
    #
    class Gengou
      # @return [String] 元号名
      attr_reader :name
      # @return [Integer] 元号年
      attr_reader :number

      #
      # 初期化
      #
      # @param [String] name 元号名
      # @param [Integer] number 元号年
      #
      def initialize(name:, number:)
        @name = name
        @number = number
      end
    end

    #
    # Year 年
    #
    class Year
      # @return [Gengou] 元号（1行目）
      attr_reader :first_gengou
      # @return [Gengou] 元号（2行目）
      attr_reader :second_gengou
      # @return [String] 十干十二支
      attr_reader :zodiac_name
      # @return [Integer] 日数
      attr_reader :total_days

      #
      # 初期化
      #
      # @param [Gengou] first_gengou 元号（1行目）
      # @param [Gengou] second_gengou 元号（2行目）
      # @param [String] zodiac_name 十干十二支
      # @param [Integer] total_days 日数
      #
      def initialize(first_gengou:, second_gengou:, zodiac_name:, total_days:)
        @first_gengou = first_gengou
        @second_gengou = second_gengou
        @zodiac_name = zodiac_name
        @total_days = total_days
      end
    end

    #
    # SolarTerm 二十四節気
    #
    class SolarTerm
      # @return [Integer] 連番
      attr_reader :index
      # @return [String] 大余小余
      attr_reader :remainder

      #
      # 初期化
      #
      # @param [Integer] index 連番
      # @param [String] remainder 大余小余
      #
      def initialize(index:, remainder:)
        @index = index
        @remainder = remainder
      end
    end

    # :reek:TooManyInstanceVariables { max_instance_variables: 6 }

    #
    # Month 月
    #
    class Month
      # @return [Integer] 月順（1-12）
      attr_reader :number
      # @return [True] 閏月
      # @return [False] 平月
      attr_reader :leaped
      # @return [String] 月の大小
      attr_reader :days_name
      # @return [Day] 月初日データ
      attr_reader :first_day
      # @return [SolarTerm] 二十四節気（節気）
      attr_reader :odd_solar_terms
      # @return [SolarTerm] 二十四節気（中気）
      attr_reader :even_solar_terms

      # rubocop:disable Metrics/ParameterLists
      # :reek:LongParameterList { max_params: 6 }

      #
      # 初期化
      #
      # @param [Integer] number 月順（1-12）
      # @param [True, False] leaped 閏月/平月
      # @param [String] days_name 月の大小
      # @param [Day] first_day 月初日データ
      # @param [SolarTerm] odd_solar_terms 二十四節気（節気）
      # @param [SolarTerm] even_solar_terms 二十四節気（中気）
      #
      def initialize(number:, leaped:, days_name:, first_day:,
                     odd_solar_terms:, even_solar_terms:)
        @number = number
        @leaped = leaped
        @days_name = days_name
        @first_day = first_day
        @odd_solar_terms = odd_solar_terms
        @even_solar_terms = even_solar_terms
      end
      # rubocop:enable Metrics/ParameterLists
    end

    #
    # Day 日
    #
    class Day
      # @return [Integer] 月初日から数えた日（M月d日のdに相当）
      attr_reader :number
      # @return [String] 十干十二支
      attr_reader :zodiac_name
      # @return [String] 大余小余
      attr_reader :remainder
      # @return [String] 年月日
      attr_reader :western_date

      #
      # 初期化
      #
      # @param [Integer] number 月初日から数えた日（M月d日のdに相当）
      # @param [String] zodiac_name 十干十二支
      # @param [String] remainder 大余小余
      # @param [String] western_date 年月日
      #
      def initialize(number:, zodiac_name:, remainder:, western_date:)
        @number = number
        @zodiac_name = zodiac_name
        @remainder = remainder
        @western_date = western_date
      end
    end

    #
    # Core 共通処理
    #
    class Core
      #
      # 初期化
      #
      def initialize(*_args); end

      #
      # ハッシュ化する
      #
      # @return [Hash<String, Object>] ハッシュ
      #
      def to_h
        Stringifier.to_h(obj: self, class_prefix: 'Zakuro::Result')
      end

      #
      # JSON化する
      #
      # @param [JSON::State] _args 引数（ Struct#to_json ）
      #
      # @return [String] JSON文字列
      #
      def to_json(*_args)
        JSON.generate(to_h)
      end

      #
      # JSON（整形）化する
      #
      # @return [String] JSON（整形）文字列
      #
      def to_pretty_json
        JSON.pretty_generate(to_h)
      end
    end

    #
    # SingleDay 1日分情報
    #
    class SingleDay < Core
      # @return [Year] 年
      attr_reader :year
      # @return [Month] 月
      attr_reader :month
      # @return [Day] 日
      attr_reader :day

      #
      # 初期化
      #
      # @param [Year] year 年
      # @param [Month] month 月
      # @param [Day] day 日
      #
      def initialize(year:, month:, day:)
        super
        @year = year
        @month = month
        @day = day
      end
    end
  end
end
