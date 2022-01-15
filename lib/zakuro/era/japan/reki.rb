# frozen_string_literal: true

require_relative '../western/calendar'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # Reki 暦
    #
    module Reki
      #
      # Range 暦（範囲）
      #
      class Range
        # @return [String] 暦のクラス名
        #   version 以下を参照
        attr_reader :class_name
        # @return [Western::Calendar] 暦の開始日
        attr_reader :start_date
        # @return [Integer] 開始西暦年
        attr_reader :start_year

        #
        # 初期化
        #
        # @param [String] class_name 暦のクラス名
        # @param [Western::Calendar] start_date 暦の開始日
        # @param [Integer] start_year 開始西暦年
        #
        def initialize(class_name:, start_date:, start_year:)
          @class_name = class_name
          @start_date = start_date
          @start_year = start_year
        end
      end

      LIST = [
        # 允恭天皇34年01月01日
        Range.new(
          class_name: 'Zakuro::Genka::Gateway',
          start_date: Western::Calendar.new(year: 445, month: 1, day: 24),
          start_year: 445
        ),
        # 文武天皇02年01月01日
        Range.new(
          class_name: 'Zakuro::Gihou::Gateway',
          start_date: Western::Calendar.new(year: 698, month: 2, day: 16),
          start_year: 698
        ),
        # 天平宝字08年01月01日
        Range.new(
          class_name: 'Zakuro::Daien::Gateway',
          start_date: Western::Calendar.new(year: 764, month: 2, day: 7),
          start_year: 764
        ),
        # 貞観02年01月01日
        Range.new(
          class_name: 'Zakuro::Senmyou::Gateway',
          start_date: Western::Calendar.new(year: 862, month: 2, day: 3),
          start_year: 862
        ),
        # 貞享02年01月01日
        Range.new(
          class_name: 'Zakuro::Joukyou::Gateway',
          start_date: Western::Calendar.new(year: 1685, month: 2, day: 4),
          start_year: 1685
        ),
        # 宝暦05年01月01日
        Range.new(
          class_name: 'Zakuro::Houryaku::Gateway',
          start_date: Western::Calendar.new(year: 1755, month: 2, day: 11),
          start_year: 1755
        ),
        # 寛政10年01月01日
        Range.new(
          class_name: 'Zakuro::Kansei::Gateway',
          start_date: Western::Calendar.new(year: 1798, month: 2, day: 16),
          start_year: 1798
        ),
        # 天保13年01月01日
        Range.new(
          class_name: 'Zakuro::Tenpou::Gateway',
          start_date: Western::Calendar.new(year: 1844, month: 2, day: 18),
          start_year: 1844
        ),
        # 明治01年09月08日
        Range.new(
          class_name: 'Zakuro::Gregorio::Gateway',
          start_date: Western::Calendar.new(year: 1868, month: 10, day: 23),
          start_year: 1868
        )
      ].freeze

      #
      # 指定した日付から対象の暦を引き当てる
      #
      # @param [Western::Calendar] date 日付
      #
      # @return [String] 暦のクラス名
      #
      def self.class_name(date: Western::Calendar.new)
        LIST.reverse_each do |range|
          return range.class_name if date >= range.start_date
        end
        raise ArgumentError, "invalid date: #{date.format}"
      end
    end
  end
end
