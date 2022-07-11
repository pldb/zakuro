# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # OperatedSolarTerm 運用二十四節気
      #
      module OperatedSolarTerm
        class << self
          #
          # 運用情報によって改変した二十四節気を作成する
          #
          # @param [<Type>] operated_solar_term 運用情報（二十四節気）
          # @param [Array<SolarTerm>] solar_terms 二十四節気
          #
          # @return [Array<SolarTerm>] 二十四節気
          #
          def create_operated_solar_term(operated_solar_term:, solar_terms:)
            index = operated_solar_term.index

            # 別の月に移動する二十四節気。割り当てない。
            result = remove_solar_term(index: index, solar_terms: solar_terms)

            return result if used_solar_term?(index: index, solar_terms: solar_terms)

            result.push(operated_solar_term)

            result
          end

          private

          # :reek:ControlParameter

          #
          # 二十四節気が使用されているか
          #
          # @param [Integer] index 二十四節気番号
          # @param [Array<SolarTerm>] solar_terms 二十四節気
          #
          # @return [True] 使用
          # @return [False] 未使用
          #
          def used_solar_term?(index:, solar_terms:)
            solar_terms.each do |solar_term|
              return true if index == solar_term.index
            end

            false
          end

          # :reek:ControlParameter

          #
          # 対象の二十四節気を除外する
          #
          # @param [Integer] index 二十四節気番号
          # @param [Array<SolarTerm>] solar_terms 二十四節気
          #
          # @return [Array<SolarTerm>] 二十四節気（対象除外済）
          #
          def remove_solar_term(index:, solar_terms:)
            result = []
            solar_terms.each do |solar_term|
              next if index == solar_term.index

              result.push(solar_term)
            end

            result
          end
        end
      end
    end
  end
end
