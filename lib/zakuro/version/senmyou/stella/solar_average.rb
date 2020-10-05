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
      # @return [Array<Remainder>] 二十四節気
      #
      def self.collect_solar_terms_from_last_winter_solstice(winter_solstice:)
        result = []
        term = winter_solstice
        (0...24).each do |_i|
          result.push(term)
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
      # @param [Array<Remainder>] solar_terms 1年データ内の全二十四節気
      #
      def self.apply_solar_terms_from_last_winter_solstice(annual_range:,
                                                           solar_terms:)

        c_idx = 0
        st_idx = 0
        month_size = annual_range.size

        while c_idx < month_size && st_idx < solar_terms.size
          raise StandardError, "month is over. idx: #{c_idx}" if c_idx >= month_size

          current_month = annual_range[c_idx]
          next_month = annual_range[c_idx + 1]
          solar_term = solar_terms[st_idx]

          if in_range_solar_term?(target: solar_term, min: current_month.remainder,
                                  max: next_month.remainder)
            set_solar_term(month: current_month,
                           solar_term: solar_term, solar_term_index: st_idx)
            st_idx += 1
            next
          end

          # 一度も割り当てがない場合は二十四節気を進める
          if current_month.empty_solar_term?
            st_idx += 1
            next
          end

          c_idx += 1
        end
      end
      private_class_method :apply_solar_terms_from_last_winter_solstice

      #
      # 1年データ内の二十四節気の前後を収集する
      #
      # @param [Array<Remainder>] solar_terms 1年データ内の全二十四節気
      #
      # @return [Hash<Integer, Hash<Symbol, Integer>>, Hash<Integer, Hash<Symbol, Remainder>>] 前後
      #
      def self.collect_solar_terms_before_and_after(solar_terms:)
        raise ArgumentError, 'parameter must be 24 solar terms' unless solar_terms.size == 24

        touji = solar_terms[-1].add(SOLAR_TERM_AVERAGE)
        {
          # 前年大雪
          23 => { index: 0, solar_term: solar_terms[0].sub(SOLAR_TERM_AVERAGE) },
          # 当年冬至
          0 => { index: -2, solar_term: touji },
          # 当年小寒
          1 => { index: -2, solar_term: touji.add(SOLAR_TERM_AVERAGE) }
        }
      end
      private_class_method :collect_solar_terms_before_and_after

      # :reek:TooManyStatements { max_statements: 6 }

      #
      # 1年データ前後の二十四節気を適用する
      #
      # @param [Array<Month>] annual_range 1年データ
      # @param [Hash<Integer, Hash<Symbol, Integer>>, Hash<Integer, Hash<Symbol, Remainder>>]
      #   rest_solar_terms 前後
      #
      def self.apply_solar_terms_before_and_after(annual_range:, rest_solar_terms:)
        rest_solar_terms.each do |key, value|
          index = value[:index]
          solar_term = value[:solar_term]
          data = annual_range[index]
          next unless in_range_solar_term?(
            target: solar_term,
            min: data.remainder, max: annual_range[index + 1].remainder
          )

          set_solar_term(month: data,
                         solar_term: solar_term, solar_term_index: key)
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

        (min_time <= max_time ? min_over && max_under : min_over || max_under)
      end
      private_class_method :in_range_solar_term?

      #
      # 二十四節気を設定する
      #
      # @param [Month] month 月
      # @param [Remainder] solar_term 二十四節気
      # @param [Integer] solar_term_index 連番（二十四節気）
      #
      def self.set_solar_term(month:, solar_term:, solar_term_index:)
        term = SolarTerm.new(remainder: solar_term, index: solar_term_index)
        if solar_term_index.even?
          # 中気
          month.even_term = term
        else
          # 節気
          month.odd_term = term
        end

        nil
      end
      private_class_method :set_solar_term
    end
  end
end
