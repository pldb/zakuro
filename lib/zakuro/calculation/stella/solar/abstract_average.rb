# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Solar
      #
      # AbstractAverage 平気（太陽軌道平均）
      #
      class AbstractAverage
        # @return [Cycle::AbstractSolarTerm] 入定気
        attr_reader :solar_term

        #
        # 初期化
        #
        # @param [Cycle::AbstractSolarTerm] solar_term 入定気
        #
        def initialize(solar_term:)
          @solar_term = solar_term
        end

        #
        # 冬至から数えた1年データの月ごとに二十四節気を割り当てる
        #
        # @param [Array<Month>] annual_range 1年データ
        #
        # @return [Array<Month>] 1年データ
        #
        def set(annual_range:)
          # 次月と比較しながら当月の二十四節気を決める
          # NOTE: 最後の月は処理できない（=計算外の余分な月が最後に必要である）
          annual_range.each_cons(2) do |(current_month, next_month)|
            set_solar_term(
              current_month: current_month,
              next_month: next_month
            )
          end

          annual_range
        end

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 月内（当月朔日から当月末日（来月朔日の前日）の間）に二十四節気があるか
        # @note 大余60で一巡するため 以下2パターンがある
        #   * current_month <= next_month : (二十四節気) >= current_month && (二十四節気) < next_month
        #   * current_month > next_month  : (二十四節気) >= current_month || (二十四節気) < next_month
        #
        # @param [Cycle::AbstractRemainder] solar_term 二十四節気
        # @param [Cycle::AbstractRemainder] current_month 月初
        # @param [Cycle::AbstractRemainder] next_month 月末
        #
        # @return [True] 対象の二十四節気がある
        # @return [False] 対象の二十四節気がない
        #
        def self.in_solar_term?(solar_term:, current_month:, next_month:)
          # 大余で比較する
          target_time = solar_term.day
          current_month_time = current_month.day
          next_month_time = next_month.day
          current_month_over = (target_time >= current_month_time)
          next_month_under = (target_time < next_month_time)

          return current_month_over && next_month_under if current_month_time <= next_month_time

          current_month_over || next_month_under
        end

        private

        # :reek:TooManyStatements { max_statements: 8 }

        #
        # 二十四節気を設定する
        #
        # @param [Month] current_month 当月
        # @param [Month] next_month 次月
        #
        def set_solar_term(current_month:, next_month:)
          # 安全策として無限ループは回避する
          # * 最大試行回数：4回（設定なし => 設定あり => 設定あり => 設定なし）
          # * 閏月は1回しか設定しない
          # * 最大2回設定する（中気・節気）
          (0..3).each do |_index|
            in_range = self.class.in_solar_term?(
              solar_term: solar_term.remainder, current_month: current_month.remainder,
              next_month: next_month.remainder
            )

            # 範囲外
            unless in_range
              # 1つ以上設定されていれば切り上げる（一つ飛ばしで二十四節気を設定することはない）
              break unless current_month.empty_solar_term?

              next_solar_term
              next
            end

            current_month.add_term(term: solar_term.clone)
            next_solar_term

            # 定気は最大2つまで
            break if current_month.solar_term_size == 2
          end
        end

        #
        # 次の二十四節気に移る
        #
        def next_solar_term
          solar_term.next_term!
        end
      end
    end
  end
end
