# frozen_string_literal: true

require_relative '../../const/remainder'

require_relative '../../cycle/solar_term'

# :nodoc:
module Zakuro
  # :nodoc:
  module Genka
    # :nodoc:
    module Solar
      #
      # Average 平気（太陽軌道平均）
      #
      class Average
        #
        # 初期化
        #
        # @param [Integer] western_year 西暦年
        #
        def initialize(western_year:)
          # TODO: 初期化
        end

        #
        # 冬至から数えた1年データの月ごとに二十四節気を割り当てる
        #
        # @param [Array<Month>] annual_range 1年データ
        #
        # @return [Array<Month>] 1年データ
        #
        def set(annual_range:)
          # TODO: 割り当て
          # super(annual_range: annual_range)
        end
      end
    end
  end
end
