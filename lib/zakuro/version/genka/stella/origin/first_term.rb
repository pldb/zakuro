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
        # @return [Integer] 朔望月
        SYNODIC_MONTH = Const::Number::Cycle::SYNODIC_MONTH
        # @return [Integer] 西暦0年の積年
        WESTERN_YEAR = Const::Number::Stack::WESTERN_YEAR

        #
        # 年初の中気（正月中雨水）を求める
        #
        # @param [Integer] western_year 西暦年
        #
        # @return [Remainder] 年初の中気（正月中雨水）
        #
        def self.get(western_year:)
          # (1612 + x) * 222070/608 = A' ...余りが中気の小余
          stack = ((WESTERN_YEAR + western_year) * ((SYNODIC_MONTH * 10).to_f / 608)).to_i
          minute = ((WESTERN_YEAR + western_year) * (SYNODIC_MONTH * 10).to_f % 608).to_i
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
