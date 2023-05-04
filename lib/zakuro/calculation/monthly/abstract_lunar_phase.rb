# frozen_string_literal: true

require_relative '../../output/logger'

require_relative './part/const'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # AbstractLunarPhase 月の位相
      #
      class AbstractLunarPhase
        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'lunar_phase')

        # @return [Array<String>] 月内の弦
        PHASE_INDEXES = Const::PHASE_INDEXES

        # @return [Cycle::AbstractRemainder] 弦
        attr_reader :quarter
        # @return [Cycle::AbstractRemainder] 経
        attr_reader :average_remainder
        # @return [Solar::AbstractLocation] 入定気
        attr_reader :solar_location
        # @return [Lunar::AbstractLocation] 入暦
        attr_reader :lunar_location
        # @return [Integer] 弦の位置
        attr_reader :index

        #
        # 初期化
        #
        # @param [Cycle::AbstractRemainder] quarter 弦
        # @param [Solar::AbstractLocation] average_remainder 経
        # @param [Solar::AbstractLocation] solar_location 入定気
        # @param [Lunar::AbstractLocation] lunar_location 入暦
        #
        def initialize(quarter:, average_remainder:, solar_location:, lunar_location:)
          # 弦
          @quarter = quarter
          # 経
          @average_remainder = average_remainder
          # 入定気
          @solar_location = solar_location
          # 入暦
          @lunar_location = lunar_location

          # 弦の位置
          @index = 0
        end

        #
        # 次の弦に進める
        #
        # @return [Remainder] 定朔
        #
        def next_phase
          adjusted = current_remainder

          add_quarter_moon_size

          adjusted
        end

        #
        # 次の月に進める
        # @note 進めた後の月の定朔ではなく、当月のものを返却する
        #
        # @return [Remainder] 当月初の定朔
        #
        def next_month
          result = nil
          PHASE_INDEXES.each_with_index do |_phase, index|
            adjust = next_phase
            result = adjust if index.zero?
          end

          result
        end

        private

        #
        # 次の弦に進める
        #
        # @return [Integer] 弦
        #
        def next_index
          @index += 1
          @index = 0 if index >= PHASE_INDEXES.size
          @index
        end

        #
        # 朔月（月初）であるか
        #
        # @return [True] 朔月である
        # @return [False] 朔月ではない
        #
        def first_phase?
          index.zero?
        end

        #
        # 朔月のみログ出力する
        #
        # @param [String] messages メッセージ（可変長）
        #
        def debug(*messages)
          # 全ての弦を対象にするためコメントアウトする
          # return unless first_phase?

          LOGGER.debug(*messages)
        end

        #
        # 現在の定朔を取得する
        #
        # @return [Remainder] 定朔
        #
        def current_remainder
          # abstract
        end

        #
        # 補正値を得る
        #
        # @return [Integer] 補正値
        #
        def correction_value
          sun = correction_solar_value
          moon = correction_moon_value

          sum = sun + moon

          debug("sun: #{sun}", "moon: #{moon}", "sun + moon : #{sum}")

          sum
        end

        #
        # 太陽運動の補正値を得る
        #
        # @return [Integer] 太陽運動の補正値
        #
        def correction_solar_value
          # abstract
        end

        #
        # 月運動の補正値を得る
        #
        # @return [Integer] 月運動の補正値
        #
        def correction_moon_value
          # abstract
        end

        def add_quarter_moon_size
          average_remainder.add!(quarter)
          solar_location.add_quarter
          lunar_location.add_quarter

          next_index
        end
      end
    end
  end
end
