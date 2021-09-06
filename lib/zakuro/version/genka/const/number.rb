# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Genka
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
          # @return [Integer] 日法（1日=752分）
          DAY = 752
          # @return [Integer] 二十四節気の1日（1日=608分）
          TERM_DAY = 608
          # @return [Integer] 朔望月
          SYNODIC_MONTH = 22_207
        end

        #
        # 累積
        #
        module Stack
          # @return [Integer] 積年（甲子夜半朔旦冬至〜暦の開始前）
          TOTAL_YEAR = 5703
          # @return [Integer] 暦の開始年（元嘉20年）
          BEGIN_YEAR = 443
          # @return [Integer] 西暦0年の積年
          WESTERN_YEAR = 1612
        end
      end
    end
  end
end
