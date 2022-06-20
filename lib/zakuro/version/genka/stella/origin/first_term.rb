# frozen_string_literal: true

require_relative '../../const/number'
require_relative '../../cycle/remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Genka
    # :nodoc:
    module Origin
      #
      # FirstTerm 年初の中気（正月中雨水）
      #
      module FirstTerm
        # @return [Integer] 二十四節気の1日
        TERM_DAY = Const::Number::Cycle::TERM_DAY
        # @return [Float] 余数
        YEAR_REMAINDER = Const::Number::Stack::YEAR_REMAINDER.to_f
        # @return [Integer] 西暦0年の積年
        WESTERN_YEAR = Const::Number::Stack::WESTERN_YEAR

        class << self
          #
          # 年初の中気（正月中雨水）を求める
          #
          # @note 計算は宋書（1）に従う。念のため『日本暦日原典』（2）と比較する
          #   1. (1612 + 西暦年) * 餘数（1595） / 度法（304） = A' ...余りが中気の小余
          #      A' / 60 = B' ...余りが朔の大余
          #     『歴代天文律暦等志彙編　六』中華書房 p.1728
          #
          #   2. (1612 + x) * 222070 / 608 = A' ...余りが中気の小余
          #      A' / 60 = B' ...余りが朔の大余
          #
          #   小余上限（度法）の違いで、宋書に従ったほうが良いと判断した。分母が変わるだけで結果に相違はない
          #
          # @param [Integer] western_year 西暦年
          #
          # @return [Remainder] 年初の中気（正月中雨水）
          #
          def get(western_year:)
            total_western_year = WESTERN_YEAR + western_year
            # (1612 + x) * 222070 / 608 = A' ...余りが中気の小余
            stack = (total_western_year * YEAR_REMAINDER / TERM_DAY).to_i
            minute = (total_western_year * YEAR_REMAINDER % TERM_DAY).to_i
            # A' / 60 = B' ...余りが朔の大余
            day = stack % Cycle::TermRemainder::LIMIT
            # p stack
            # p minute
            # p day
            Cycle::TermRemainder.new(day: day, minute: minute, second: 0)
          end
        end
      end
    end
  end
end
