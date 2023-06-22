# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Version
    # :nodoc:
    module Senmyou
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
            # @return [Integer] 統法（1日=8400分）
            DAY = 8400
            # @return [Float] 暦周（1近点月）
            ANOMALISTIC_MONTH = 231_458.19
            # @return [Integer] 朔望月
            SYNODIC_MONTH = 248_057
            # @return [Integer] 一年
            YEAR = 3_068_055
          end

          #
          # Derivation 導出
          #
          module Derivation
            # @return [Integer] 通余: (YEAR - DAY * 12 * 30)  = 44055
            REMAINDER_ALL_YEAR = 44_055
            # @return [Integer] 旬周（60日） DAY * 60
            SIXTY_DAYS = 504_000
            # @return [Integer] 朔虚分: (30 * 8400) % 248057
            REMAINDER_IDEAL_MONTH = 3943
          end

          #
          # 累積
          #
          module Stack
            # @return [Integer] 積年（甲子夜半朔旦冬至〜暦の開始前）
            TOTAL_YEAR = 7_070_138
            # @return [Integer] 暦の開始年（長慶2年）
            BEGIN_YEAR = 822
          end
        end
      end
    end
  end
end
