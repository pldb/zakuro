# frozen_string_literal: true

require_relative '../cycle/remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    #
    # Const 定数
    #
    module Const
      #
      # Remainder 大余小余
      #
      module Remainder
        #
        # Solar 太陽
        #
        module Solar
          # @return [Remainder] 気策（24分の1年）
          SOLAR_TERM_AVERAGE = Cycle::Remainder.new(day: 15, minute: 292, second: 5)
          #
          # 下記のように算出した
          #   * 宣明暦: 7-3214.25（大余7の3214分2秒） = 7 * 8400 + 3214.25 = 62014.25（分）
          #   * 62014.25（分） / 8400 * 1340 = 9892.7494 / 1300 = 7 余り 512.7494048...
          #   * 0.7494048... * 6（1分=6秒） = 4.496428571...
          #   * 四捨五入して 大余7の512分4.5秒
          #
          # @return [Cycle::Remainder] 弦（1分=6秒）
          QUARTER = Cycle::Remainder.new(day: 7, minute: 512, second: 4.5)
        end

        #
        # Lunar 月
        #
        module Lunar
          # @return [Cycle::LunarRemainder] 変日
          ANOMALISTIC_MONTH = \
            Cycle::LunarRemainder.new(day: 27, minute: 743, second: 1)
          # @return [Cycle::LunarRemainder] 入暦上限
          LIMIT = Cycle::LunarRemainder.new(day: 28, minute: 743, second: 0)
          #
          # 下記のように算出した
          #   * 宣明暦: 7-3214.25（大余7の3214分25秒） = 7 * 8400 + 3214.25 = 62014.25（分）
          #   * 62014.25（分） / 8400 * 1340 = 9892.7494 / 1300 = 7 余り 512.7494048...
          #   * 0.7494048... * 12（1分=12秒） = 8.992857143...
          #   * 四捨五入して 大余7の512分9秒
          #
          # @return [Cycle::LunarRemainder] 弦（1分=12秒）
          # TODO: 全て通った。9秒だと53回で2秒のズレがあったので、2/53 = 0.037735849056604.. に近しい数を足した
          QUARTER = Cycle::LunarRemainder.new(day: 7, minute: 512, second: 9.00378)
        end
      end
    end
  end
end
