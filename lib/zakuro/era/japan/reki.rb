# frozen_string_literal: true

require_relative '../western'

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

        #
        # 初期化
        #
        # @param [String] class_name 暦のクラス名
        # @param [Western::Calendar] start_date 暦の開始日
        #
        def initialize(class_name:, start_date:)
          @class_name = class_name
          @start_date = start_date
        end
      end

      LIST = [
        Range.new(
          class_name: 'Zakuro::Genka::Gateway',
          start_date: Western::Calendar.new(year: 445, month: 1, day: 24)
        ),
        Range.new(
          class_name: 'Zakuro::Gihou::Gateway',
          start_date: Western::Calendar.new(year: 698, month: 2, day: 16)
        ),
        Range.new(
          class_name: 'Zakuro::Taien::Gateway',
          start_date: Western::Calendar.new(year: 764, month: 2, day: 7)
        ),
        Range.new(
          class_name: 'Zakuro::Senmyou::Gateway',
          start_date: Western::Calendar.new(year: 862, month: 2, day: 3)
        ),
        Range.new(
          class_name: 'Zakuro::Joukyou::Gateway',
          start_date: Western::Calendar.new(year: 1685, month: 2, day: 4)
        ),
        Range.new(
          class_name: 'Zakuro::Houryaku::Gateway',
          start_date: Western::Calendar.new(year: 1755, month: 2, day: 11)
        ),
        Range.new(
          class_name: 'Zakuro::Kansei::Gateway',
          start_date: Western::Calendar.new(year: 1798, month: 2, day: 16)
        ),
        Range.new(
          class_name: 'Zakuro::Tenpou::Gateway',
          start_date: Western::Calendar.new(year: 1844, month: 2, day: 18)
        ),
        Range.new(
          class_name: 'Zakuro::Gregorio::Gateway',
          start_date: Western::Calendar.new(year: 1872, month: 12, day: 9)
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
