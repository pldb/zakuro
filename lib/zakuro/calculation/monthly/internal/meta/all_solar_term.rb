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
          # 取得する
          #
          # @param [Monthly::Month] before_month 前月
          # @param [Monthly::Month] current_month 当月
          #
          # @return [Array<Cycle::AbstractSolarTerm>] その月の全ての二十四節気
          #
          def get(before_month:, current_month:)
            remainder = current_month.remainder
            solar_terms = current_month.solar_terms
            before_solar_terms = before_month.solar_terms

            resolve(
              remainder: remainder, solar_terms: solar_terms,
              before_solar_terms: before_solar_terms
            )
          end

          private

          #
          # 前月を使用して解決する
          #
          # @param [Cycle::AbstractRemainder] remainder 月初日の大余小余
          # @param [Array<Cycle::AbstractSolarTerm>] solar_terms その月の二十四節気
          # @param [Array<Cycle::AbstractSolarTerm>] before_solar_terms 前月の二十四節気
          #
          # @return [Array<Cycle::AbstractSolarTerm>] その月の全ての二十四節気
          #
          def resolve(remainder:, solar_terms: [], before_solar_terms: [])
            all_solar_terms = solar_terms.clone.each(&:clone)

            return all_solar_terms if all_solar_terms.empty?

            first = all_solar_terms[0].clone

            return all_solar_terms if before_solar_terms.empty?

            # 最初の二十四節気が月初日と同日であれば何もしない
            return all_solar_terms if first.remainder.day == remainder.day

            all_solar_terms.unshift(before_solar_terms[-1].clone)

            all_solar_terms
          end
        end
      end
    end
  end
end
