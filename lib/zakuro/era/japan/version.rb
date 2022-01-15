# frozen_string_literal: true

require_relative '../western/calendar'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # Version 暦
    #
    module Version
      #
      # Range 暦（範囲）
      #
      class Range
        # @return [String] 暦名
        attr_reader :name
        # @return [Western::Calendar] 暦の開始日
        attr_reader :start_date
        # @return [Integer] 開始西暦年
        attr_reader :start_year
        # @return [Integer] 終了西暦年
        attr_reader :end_year
        # @return [True] リリース済
        # @return [False] 未リリース
        attr_reader :released

        #
        # 初期化
        #
        # @param [String] name 暦名
        # @param [Western::Calendar] start_date 暦の開始日
        # @param [Integer] start_year 開始西暦年
        # @param [Integer] end_year 終了西暦年
        # @param [True, False] released リリース済 / 未リリース
        #
        def initialize(name:, start_date:, start_year:, end_year:, released:)
          @name = name
          @start_date = start_date
          @start_year = start_year
          @end_year = end_year
          @released = released
        end
      end

      # TODO: yamlにする
      # TODO: end_year は不要

      # @return [Array<Range>] 全和暦
      LIST = [
        # 允恭天皇34年01月01日
        Range.new(
          name: 'Genka',
          start_date: Western::Calendar.new(year: 445, month: 1, day: 24),
          start_year: 445,
          end_year: 697,
          released: true
        ),
        # 文武天皇02年01月01日
        Range.new(
          name: 'Gihou',
          start_date: Western::Calendar.new(year: 698, month: 2, day: 16),
          start_year: 698,
          end_year: 763,
          released: true
        ),
        # 天平宝字08年01月01日
        Range.new(
          name: 'Daien',
          start_date: Western::Calendar.new(year: 764, month: 2, day: 7),
          start_year: 764,
          end_year: 861,
          released: true
        ),
        # 貞観02年01月01日
        Range.new(
          name: 'Senmyou',
          start_date: Western::Calendar.new(year: 862, month: 2, day: 3),
          start_year: 862,
          end_year: 1684,
          released: true
        ),
        # 貞享02年01月01日
        Range.new(
          name: 'Joukyou',
          start_date: Western::Calendar.new(year: 1685, month: 2, day: 4),
          start_year: 1685,
          end_year: 1754,
          released: false
        ),
        # 宝暦05年01月01日
        Range.new(
          name: 'Houryaku',
          start_date: Western::Calendar.new(year: 1755, month: 2, day: 11),
          start_year: 1755,
          end_year: 1797,
          released: false
        ),
        # 寛政10年01月01日
        Range.new(
          name: 'Kansei',
          start_date: Western::Calendar.new(year: 1798, month: 2, day: 16),
          start_year: 1798,
          end_year: 1843,
          released: false
        ),
        # 天保13年01月01日
        Range.new(
          name: 'Tenpou',
          start_date: Western::Calendar.new(year: 1844, month: 2, day: 18),
          start_year: 1844,
          end_year: 1867,
          released: false
        ),
        # 明治01年09月08日
        Range.new(
          name: 'Gregorio',
          start_date: Western::Calendar.new(year: 1868, month: 10, day: 23),
          start_year: 1868,
          end_year: 9999,
          released: false
        )
      ].freeze

      #
      # 年を基準に暦を引き当てる
      #
      # @param [Integer] start_year 開始西暦年
      # @param [Integer] end_year 終了西暦年
      #
      # @return [Array<Range>] 和暦
      #
      def self.ranges_with_year(start_year:, end_year:)
        result = []

        LIST.each do |range|
          next if start_year > range.end_year

          next if end_year < range.start_year

          result.push(range)
        end

        result
      end
    end
  end
end