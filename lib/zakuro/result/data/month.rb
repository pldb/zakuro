# frozen_string_literal: true

require_relative './day'

require_relative './solar_term'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # データ部
    #
    module Data
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
    end
  end
end
