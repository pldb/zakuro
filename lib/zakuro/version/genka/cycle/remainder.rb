# frozen_string_literal: true

require_relative '../../../calculation/cycle/abstract_remainder'

require_relative '../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Genka
    # :nodoc:
    module Cycle
      #
      # Remainder 時刻情報（大余小余）
      #
      class Remainder < Calculation::Cycle::AbstractRemainder
        #
        # @note 『歴代天文律暦等志彙編　六』中華書房 p.1727
        # 「推弦望法..加朔大餘七，小餘二百八十七，小分三，小分満四從小餘」
        #
        # @return [Integer] 分（1分=4秒）
        MINUTE = 4

        #
        # 初期化
        #
        # @param [Integer] day 大余（"日"に相当）
        # @param [Integer] minute 小余（"分"に相当）
        # @param [Integer] second 秒
        # @param [Integer] total 繰り上げなしの小余
        #
        def initialize(day: -1, minute: -1, second: -1, total: -1)
          super(base_day: Const::Number::Cycle::DAY, base_mitune: MINUTE,
                day: day, minute: minute, second: second, total: total)
        end

        #
        # 特定の文字フォーマットにして出力する
        #
        # @return [String] フォーマットした結果
        #
        def format(form: '%.4f', digit: 4)
          return '' if invalid?

          decimal = @day + @minute / @base_day.to_f
          super(form, decimal.round(digit))
        end
      end

      #
      # TermRemainder 時刻情報（大余小余）
      #
      class TermRemainder < Calculation::Cycle::AbstractRemainder
        #
        # @note 『歴代天文律暦等志彙編　六』中華書房 p.1726
        # 「氣法，二十四」
        #
        # @return [Integer] 分（1分=24秒）
        MINUTE = 24

        #
        # 初期化
        #
        # @param [Integer] day 大余（"日"に相当）
        # @param [Integer] minute 小余（"分"に相当）
        # @param [Integer] second 秒
        # @param [Integer] total 繰り上げなしの小余
        #
        def initialize(day: -1, minute: -1, second: -1, total: -1)
          super(base_day: Const::Number::Cycle::TERM_DAY, base_mitune: MINUTE,
                day: day, minute: minute, second: second, total: total)
        end

        #
        # 特定の文字フォーマットにして出力する
        #
        # @return [String] フォーマットした結果
        #
        def format(form: '%.4f', digit: 4)
          return '' if invalid?

          decimal = @day + @minute / @base_day.to_f
          # NOTE: roundなしで format を使用した場合は、四捨五入が正しく実行されないことが判明した
          # 具体的には、468年の中気は '55.7813' だが '55.7812' になる
          # これは '55.7812500' を4桁にした際に、境界値の少数点以下5桁目の '5' が切り捨てを受けたためである
          # format による四捨五入は避け、roundによる四捨五入を採用する
          super(form, decimal.round(digit))
        end
      end
    end
  end
end
