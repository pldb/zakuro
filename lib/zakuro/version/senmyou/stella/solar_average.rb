# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # SolarAverage 常気（太陽軌道平均）
    #
    module SolarAverage
      # @return [Remainder] 気策（24分の1年）
      SOLAR_TERM_AVERAGE = Remainder.new(day: 15, minute: 1835, second: 5)

      # :reek:TooManyStatements { max_statements: 6 }

      #
      # 冬至から数えた1年データの月ごとに二十四節気を割り当てる
      #
      # @param [Integer] western_year 西暦年
      # @param [Array<Month>] annual_range 1年データ
      #
      # @return [Array<Month>] 1年データ
      #
      def self.set_solar_terms_into_annual_range(western_year:, annual_range:)
        # 天正冬至
        winter_solstice = WinterSolstice.calc(western_year: western_year)

        # 前年冬至からの二十四節気
        solar_terms = collect_solar_terms_from_last_winter_solstice(
          winter_solstice: winter_solstice
        )

        apply_solar_terms_from_last_winter_solstice(annual_range: annual_range,
                                                    solar_terms: solar_terms)

        # 前後の二十四節気
        rest_solar_terms = \
          collect_solar_terms_before_and_after(solar_terms: solar_terms)

        apply_solar_terms_before_and_after(annual_range: annual_range,
                                           rest_solar_terms: rest_solar_terms)

        annual_range
      end

      # :reek:TooManyStatements { max_statements: 6 }

      #
      # 前年冬至から当年大雪までの二十四節気を計算する
      #
      # @param [Remainder] winter_solstice 冬至
      #
      # @return [Array<SolarTerm>] 二十四節気
      #
      def self.collect_solar_terms_from_last_winter_solstice(winter_solstice:)
        result = []
        term = winter_solstice
        (0...24).each do |index|
          result.push(SolarTerm.new(remainder: term, index: index))
          term = term.add(SOLAR_TERM_AVERAGE)
        end

        result
      end
      private_class_method :collect_solar_terms_from_last_winter_solstice

      # :reek:TooManyStatements { max_statements: 9 }

      #
      # 各月の二十四節気を設定する
      #
      # @param [Array<Month>] annual_range 1年データ
      # @param [Array<SolarTerm>] solar_terms 1年データ内の全二十四節気
      #
      def self.apply_solar_terms_from_last_winter_solstice(annual_range:, solar_terms:)
        month_index = 0
        solar_term_index = 0
        month_size = annual_range.size

        while month_index < month_size && solar_term_index < solar_terms.size
          raise StandardError, "month is over. idx: #{month_index}" if month_index >= month_size

          if set_solar_term_on_current_month(current_month: annual_range[month_index],
                                             next_month: annual_range[month_index + 1],
                                             solar_term: solar_terms[solar_term_index])
            solar_term_index += 1
            next
          end

          month_index += 1
        end
      end
      private_class_method :apply_solar_terms_from_last_winter_solstice

      #
      # 当月に二十四節気を設定する
      #
      # @param [Remainder] current_month 当月
      # @param [Month] next_month 次月
      # @param [SolarTerm] solar_term 二十四節気
      #
      # @return [True] 設定済
      # @return [False] 未設定
      #
      def self.set_solar_term_on_current_month(current_month:,
                                               next_month:, solar_term:)
        if in_range_solar_term?(target: solar_term.remainder, min: current_month.remainder,
                                max: next_month.remainder)

          current_month.add_term(term: solar_term)
          return true
        end

        # 一度も割り当てがない場合は設定済みとして次の二十四節気を進める
        return true if current_month.empty_solar_term?

        false
      end

      #
      # 1年データ内の二十四節気の前後を収集する
      #
      # @param [Array<SolarTerm>] solar_terms 1年データ内の全二十四節気
      #
      # @return [Array<Hash<Symbol => Integer, SolarTerm>>] 前後
      #
      def self.collect_solar_terms_before_and_after(solar_terms:)
        raise ArgumentError, 'parameter must be 24 solar terms' unless solar_terms.size == 24

        taisetsu = SolarTerm.new(remainder: solar_terms[0].remainder.sub(SOLAR_TERM_AVERAGE),
                                 index: 23)
        touji = SolarTerm.new(remainder: solar_terms[-1].remainder.add(SOLAR_TERM_AVERAGE),
                              index: 0)
        shoukan = SolarTerm.new(remainder: touji.remainder.add(SOLAR_TERM_AVERAGE), index: 1)
        [
          # 前年大雪
          { month_index: 0, solar_term: taisetsu },
          # 当年冬至
          { month_index: -2, solar_term: touji },
          # 当年小寒
          { month_index: -2, solar_term: shoukan }
        ]
      end
      private_class_method :collect_solar_terms_before_and_after

      # :reek:TooManyStatements { max_statements: 6 }

      #
      # 1年データ前後の二十四節気を適用する
      #
      # @param [Array<Month>] annual_range 1年データ
      # @param [Array<Hash<Symbol => Integer, SolarTerm>>] rest_solar_terms 前後
      #
      def self.apply_solar_terms_before_and_after(annual_range:, rest_solar_terms:)
        rest_solar_terms.each do |rest_solar_term|
          index = rest_solar_term[:month_index]
          solar_term = rest_solar_term[:solar_term]
          month = annual_range[index]
          next unless in_range_solar_term?(
            target: solar_term.remainder,
            min: month.remainder, max: annual_range[index + 1].remainder
          )

          month.add_term(term: solar_term)
        end
      end
      private_class_method :apply_solar_terms_before_and_after

      # :reek:TooManyStatements { max_statements: 7 }

      #
      # 月内（currentからnextの間）に二十四節気があるか
      # @note 大余60で一巡するため 以下2パターンがある
      #   * current(min) <= next(max) : (二十四節気) >= current && (二十四節気) < next
      #   * current(min) > next(max)  : (二十四節気) >= current || (二十四節気) < next
      #
      # @param [Remainder] target 対象の二十四節気
      # @param [Remainder] min 月初
      # @param [Remainder] max 月末
      #
      # @return [True] 対象の二十四節気がある
      # @return [False] 対象の二十四節気がない
      #
      def self.in_range_solar_term?(target:, min:, max:)
        # 大余で比較する
        target_time = target.day
        min_time = min.day
        max_time = max.day
        min_over = (target_time >= min_time)
        max_under = (target_time < max_time)

        return min_over && max_under if min_time <= max_time

        min_over || max_under
      end
      private_class_method :in_range_solar_term?
    end
  end
end
