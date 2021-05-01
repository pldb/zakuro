# frozen_string_literal: true

require_relative '../../../output/logger'

require_relative '../stella/winter_solstice'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :reek:TooManyStatements { max_statements: 7 }
    # :reek:TooManyInstanceVariables { max_instance_variables: 7 }

    #
    # LunarPhase 月の位相
    #
    class LunarPhase
      #
      # QuarterMoon 弦
      #
      module QuarterMoon
        # @return [Remainder] 弦（1分=8秒）
        DEFAULT = Remainder.new(day: 7, minute: 3214, second: 2)
        # @return [Remainder] 弦（1分=100秒）
        BASE_HUNDRED = LunarRemainder.new(day: 7, minute: 3214, second: 25)
      end

      # @return [Output::Logger] ロガー
      LOGGER = Output::Logger.new(location: 'lunar_phase')

      # @return [Array<String>] 月内の弦
      PHASE_INDEXES = %w[朔日 上弦 望月 下弦].freeze

      # @return [Integer] 西暦年
      attr_reader :western_year
      # @return [Remainder]] 経
      attr_reader :average_remainder
      # @return [True] 初回計算
      # @return [False] 次回以降計算
      attr_reader :first
      # @return [SolarTerm] 二十四節気（入定気）
      attr_reader :solar_term
      # @return [Remainder] 入暦
      attr_reader :moon_remainder
      # @return [True] 進（遠地点より数える）
      # @return [False] 退（近地点より数える）
      attr_reader :is_forward
      # @return [Integer] 弦
      attr_reader :phase_index

      #
      # 初期化
      #
      # @param [Integer] western_year 西暦年
      #
      def initialize(western_year:)
        @western_year = western_year
        # 経
        @average_remainder = WinterSolstice.calc_averaged_last_november_1st(
          western_year: @western_year
        )
        # 天正閏余
        winter_solstice_age = \
          WinterSolstice.calc_moon_age(western_year: @western_year)
        # 入定気
        @solar_term = SolarTerm.new(remainder: winter_solstice_age)
        # 入暦
        @moon_remainder = LunarRemainder.new(total: 0).add!(winter_solstice_age)

        @is_forward = false
        @first = true

        # 弦
        @phase_index = 0
      end

      #
      # 次の弦に進める
      #
      # @return [Remainder] 定朔
      #
      def next_phase
        adjusted = current_remainder

        @first = false if @first

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
      def next_phase_index
        @phase_index += 1
        @phase_index = 0 if @phase_index >= PHASE_INDEXES.size
        @phase_index
      end

      #
      # 朔月（月初）かを確認する
      #
      # @return [True] 朔月である
      # @return [False] 朔月ではない
      #
      def first_phase?
        @phase_index.zero?
      end

      #
      # 朔月のみログ出力する
      #
      # @param [String] messages メッセージ（可変長）
      #
      def debug(*messages)
        return unless first_phase?

        LOGGER.debug(*messages)
      end

      #
      # 現在の定朔を取得する
      #
      # @return [Remainder] 定朔
      #
      def current_remainder
        debug("@average_remainder.format: #{@average_remainder.format}")

        sum = correction_value
        adjusted = @average_remainder.add(
          Remainder.new(day: 0, minute: sum, second: 0)
        )
        adjusted.up_on_new_moon!

        debug("result: #{adjusted.format}")

        adjusted
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
        @solar_term = SolarLocation.get(
          solar_term: @solar_term
        )
        debug("@solar_term.remainder: #{@solar_term.remainder.format(form: '%d-%d.%d')}")
        debug("@solar_term.index: #{@solar_term.index}")

        SolarOrbit.calc_sun_orbit_value(solar_term: @solar_term)
      end

      #
      # 月運動の補正値を得る
      #
      # @return [Integer] 月運動の補正値
      #
      def correction_moon_value
        @moon_remainder, @is_forward = \
          LunarOrbit.calc_moon_point(remainder: @moon_remainder,
                                     western_year: @western_year,
                                     is_forward: @is_forward,
                                     first: @first)

        debug("@moon_remainder.format: #{@moon_remainder.format}")
        debug("@is_forward: #{@is_forward}")

        LunarOrbit.calc_moon_orbit_value(remainder_month: @moon_remainder,
                                         is_forward: @is_forward)
      end

      def add_quarter_moon_size
        @average_remainder.add!(QuarterMoon::DEFAULT)
        @solar_term.remainder.add!(QuarterMoon::DEFAULT)
        @moon_remainder.add!(QuarterMoon::BASE_HUNDRED)

        next_phase_index
      end
    end
  end
end
