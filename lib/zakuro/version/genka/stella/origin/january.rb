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
      # January 1月
      #
      module January
        # @return [Integer] 日法
        DAY = Const::Number::Cycle::DAY
        # @return [Integer] 朔望月
        SYNODIC_MONTH = Const::Number::Cycle::SYNODIC_MONTH
        # @return [Integer] 西暦0年の積年
        WESTERN_YEAR = Const::Number::Stack::WESTERN_YEAR

        #
        # 1月経朔を求める
        #
        # @param [Integer] western_year 西暦年
        #
        # @return [Remainder] 11月経朔
        #
        def self.get(western_year:)
          # (1612 + x) * 235/19 = A ...余り
          stack = ((WESTERN_YEAR + western_year) * (235.to_f / 19)).to_i
          # A * 22207/752 = B ...余りが朔の小余
          minute_total = (stack * (SYNODIC_MONTH.to_f / DAY)).to_i
          minute = (stack * SYNODIC_MONTH.to_f % DAY).to_i
          # B / 60 = C ...余りが朔の大余
          day = minute_total % Cycle::Remainder::LIMIT
          # p stack
          # p minute_total
          # p minute
          # p day
          Cycle::Remainder.new(day: day, minute: minute, second: 0)
        end
      end
    end
  end
end
