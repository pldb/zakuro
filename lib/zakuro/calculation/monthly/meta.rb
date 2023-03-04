# frozen_string_literal: true

require_relative '../cycle/abstract_remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # Meta 付加情報
      #
      class Meta
        # @return [Array<Cycle::AbstractSolarTerm>] 月の全ての二十四節気
        # @note 前提として、『日本暦日原典』にある月ごとの二十四節気は、その月の全ての二十四節気ではない
        #
        # 下表を例に取った場合、『日本暦日原典』の二十四節気連番のうち、2と3がその月の二十四節気となる
        # ここで、当月のうち2より手前の日は前月の1の二十四節気に属しており、当月だけでは参照できない
        # この参照を可能とするための情報となる
        #
        # |No| 項目          | 前月                |  当月              | 次月                |
        # |1 | 月            | month[index - 1]   |   month[index]    |   month[index + 1]  |
        # |2 | 考えられる範囲  |                    |-------------------|                     |
        # |3 | 二十四節気連番  | 0          1       |   2        3      |   4          5      |
        # |4 | 二十四節気大余  | 55         10      |   25       40     |   55         5      |
        #
        attr_reader :all_solar_terms

        # @return [Cycle::AbstractRemainder] 前月からの平朔
        # @note 滅日計算に用いる
        #
        # * 前月の平朔に日数を足し、今月平朔として扱えるようにする
        # * 月の1日目で前月からの平朔が用いられている
        #
        attr_reader :inherited_average_remainder

        #
        # 初期化
        #
        # @param [Array<AbstractSolarTerm>] all_solar_terms 月の全ての二十四節気
        # @param [Cycle::AbstractRemainder] inherited_average_remainder 前月からの平朔
        #
        def initialize(all_solar_terms: [], inherited_average_remainder: Cycle::AbstractRemainder.new)
          @all_solar_terms = all_solar_terms
          @inherited_average_remainder = inherited_average_remainder
        end

        #
        # ディープコピー
        #
        # @param [Meta] obj 自身
        #
        def initialize_copy(obj)
          @all_solar_terms = obj.all_solar_terms.clone
          @inherited_average_remainder = obj.inherited_average_remainder.clone
        end
      end
    end
  end
end
