# frozen_string_literal: true

require_relative '../../../../calculation/stella/solar/abstract_average'

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
      class Average < Calculation::Solar::AbstractAverage
        #
        # 初期化
        #
        # @param [Integer] western_year 西暦年
        #
        def initialize(solar_term:)
          super(solar_term: solar_term)
        end

        #
        # 冬至から数えた1年データの月ごとに二十四節気を割り当てる
        #
        # @param [Array<Month>] annual_range 1年データ
        #
        # @return [Array<Month>] 1年データ
        #
        def set(annual_range:)
          super(annual_range: annual_range)
        end
      end
    end
  end
end
