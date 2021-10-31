# frozen_string_literal: true

require_relative '../../era/japan/gengou'
require_relative '../../era/japan/calendar'
require_relative '../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Base
      #
      # CountableGengou 計算対象の元号
      #
      class CountableGengou
        # @return [Japan::Gengou] 元号
        attr_reader :gengou
        # @return [Integer] 元号年
        attr_reader :japan_year
        # @return [Integer] 西暦年
        attr_reader :western_year

        #
        # 初期化
        #
        # @param [Japan::Gengou] gengou 元号
        #
        def initialize(gengou: Japan::Gengou.new)
          @gengou = gengou
          @japan_year = gengou.both_start_year.japan
          @western_year = gengou.both_start_year.western
        end

        #
        # 次年にする
        #
        # @return [MultiGengou] 自身
        #
        def next_year
          @japan_year += 1
          @western_year += 1

          self
        end

        def invalid?
          @gengou.invalid? || @japan_year.invalid? || @western_year.invalid?
        end

        #
        # ディープコピー
        #
        # @param [MultiGengou] obj 自身
        #
        def initialize_copy(obj)
          @gengou = obj.gengou.clone
          @japan_year = obj.japan_year
          @western_year = obj.western_year
        end
      end
    end
  end
end
