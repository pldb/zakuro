# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Version
    # :nodoc:
    module Daien
      #
      # Const 定数
      #
      module Const
        #
        # Number 数値
        #
        module Number
          #
          # Cycle 周期
          #
          module Cycle
            # @return [Integer] 通法（1日=3040分）
            DAY = 3040
            #
            # @return [Float] 転日（1近点月 = 27日1685分79秒（1分=80秒））
            # @note 小数点以下の値によって大幅に結果が変わる。除算結果を設定した
            #
            ANOMALISTIC_MONTH = 83_765 + (79.0 / 80)
            # @return [Integer] 朔望月
            SYNODIC_MONTH = 89_773
            # @return [Integer] 一年
            YEAR = 1_110_343
          end

          #
          # Derivation 導出
          #
          module Derivation
            # @return [Integer] 通余:  (YEAR - DAY * 12 * 30)
            #   1110343 - 1094400
            REMAINDER_ALL_YEAR = 15_943
            # @return [Integer] 旬周（60日） DAY * 60
            SIXTY_DAYS = 182_400
            # @return [Integer] 朔虚分: (30 * 3040) % (29 * 3040 + 1613)
            REMAINDER_IDEAL_MONTH = 1427
          end

          #
          # 累積
          #
          module Stack
            # @return [Integer] 積年（甲子夜半朔旦冬至〜暦の開始前）
            TOTAL_YEAR = 96_961_740
            # @return [Integer] 暦の開始年（開元12年）
            BEGIN_YEAR = 724
          end
        end
      end
    end
  end
end
