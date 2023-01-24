# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # AllSolarTerm 月内の全ての二十四節気
      #
      module AllSolarTerm
        class << self
          #
          # 全ての二十四節気を取得する
          #
          # @param [Cycle::AbstractRemainder] remainder 月初日の大余小余
          # @param [Array<Cycle::AbstractSolarTerm>] solar_terms その月の二十四節気
          #
          # @return [Array<Cycle::AbstractSolarTerm>] その月の全ての二十四節気
          #
          def get(remainder:, solar_terms: [])
            all_solar_terms = solar_terms.clone.each(&:clone)

            return all_solar_terms if all_solar_terms.empty?

            first = all_solar_terms[0].clone

            # 最初の二十四節気が月初日と同日であれば何もしない
            return all_solar_terms if first.remainder.day == remainder.day

            first.prev_term!

            all_solar_terms.unshift(first)

            all_solar_terms
          end
        end
      end
    end
  end
end
