# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
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
          # @return [Integer] 総法（1日=1340分）
          DAY = 1340
          # @return [Integer] 変日（1近日点 = 27日743分1秒（1分=12秒））
          ANOMALISTIC_MONTH = 36_923.1
          # @return [Integer] 朔望月
          SYNODIC_MONTH = 39_571
          # @return [Integer] 一年
          YEAR = 489_428
        end

        #
        # Derivation 導出
        #
        module Derivation
          # @return [Integer] 通余:  (YEAR - DAY * 12 * 30)
          REMAINDER_ALL_YEAR = 7028
          # @return [Integer] 旬周（60日） DAY * 60
          SIXTY_DAYS = 80_400
        end

        #
        # 累積
        #
        module Stack
          # @return [Integer] 積年（甲子夜半朔旦冬至〜暦の開始前）
          TOTAL_YEAR = 269_880
          # @return [Integer] 暦の開始年（麟徳元年）
          BEGIN_YEAR = 664
        end
      end
    end
  end
end
