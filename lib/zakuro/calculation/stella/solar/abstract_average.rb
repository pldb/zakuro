# frozen_string_literal: true

require_relative '../../../tools/remainder_comparer'

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
          4.times.each do |_index|
            in_range = Tools::RemainderComparer.in_range?(
              target: solar_term.remainder, start: current_month.remainder,
              last: next_month.remainder
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
