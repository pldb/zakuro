# frozen_string_literal: true

require_relative '../../../../calculation/stella/solar/abstract_average'

require_relative '../../const/remainder'

require_relative '../../cycle/solar_term'

require_relative '../origin/winter_solstice'

require_relative './location'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    # :nodoc:
    module Solar
      #
      # Average 定気（太陽軌道平均）
      #
      class Average < Calculation::Solar::AbstractAverage
        #
        # 初期化
        #
        # @param [Integer] western_year 西暦年
        #
        def initialize(western_year:)
          solar_term = Average.first_solar_term(western_year: western_year)
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

        #
        # 計算開始する二十四節気を求める
        #
        # @param [Integer] western_year 西暦年
        #
        # @return [SolarTerm] 二十四節気
        #
        def self.first_solar_term(western_year:)
          # 天正冬至
          winter_solstice = Origin::WinterSolstice.get(western_year: western_year)

          # 二十四節気（冬至）
          solar_term = Cycle::SolarTerm.new(index: 0, remainder: winter_solstice)

          first_solar_term_index = Average.calc_fist_solar_term_index(western_year: western_year)

          # 対象の二十四節気まで戻す
          solar_term.prev_by_index(first_solar_term_index)

          solar_term
        end

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 計算開始する二十四節気番号を求める
        #
        # * 前提として入定気は冬至の手前にある
        # * 例えば、定気が大雪であれば入定気は大雪の範囲内にある
        # * 入定気は、定気の開始位置に重複しない限り、常に定気より後にある
        # * 基本的に定気の一つ前から起算すれば、当時から求めた11月(閏10/閏11月)に二十四節気を割り当てられる
        #
        # @param [Integer] western_year 西暦年
        #
        # @return [Integer] 二十四節気番号
        #
        def self.calc_fist_solar_term_index(western_year:)
          # 天正閏余
          lunar_age = Origin::LunarAge.get(western_year: western_year)

          solar_location = Solar::Location.new(lunar_age: lunar_age)
          solar_location.run

          solar_term_index = solar_location.index

          # 入定気の一つ後の二十四節気まで戻す（ただし11月経朔が二十四節気上にある場合は戻さない）
          solar_term_index += 1 unless solar_location.remainder == Cycle::Remainder.new(total: 0)

          solar_term_index
        end
      end
    end
  end
end
