# frozen_string_literal: true

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
        # @return [Array<AbstractSolarTerm>] 月の全ての二十四節気
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

        #
        # 初期化
        #
        # @param [Array<AbstractSolarTerm>] all_solar_terms 月の全ての二十四節気
        #
        def initialize(all_solar_terms: [])
          @all_solar_terms = all_solar_terms
        end

        #
        # ディープコピー
        #
        # @param [Meta] obj 自身
        #
        def initialize_copy(obj)
          @all_solar_terms = obj.all_solar_terms.clone
        end
      end
    end
  end
end
