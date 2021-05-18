# frozen_string_literal: true

require_relative '../../const/remainder'

require_relative '../origin/winter_solstice'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    # :nodoc:
    module Solar
      #
      # Average 常気（太陽軌道平均）
      #
      class Average
        # @return [Remainder] 気策
        SOLAR_TERM_AVERAGE = Const::Remainder::Solar::SOLAR_TERM_AVERAGE

        #
        # 初期化
        #
        # @param [Integer] western_year 西暦年
        #
        def initialize(western_year:)
          @solar_term = Average.first_solar_term(western_year: western_year)
        end

        #
        # 冬至から数えた1年データの月ごとに二十四節気を割り当てる
        #
        # @param [Array<Month>] annual_range 1年データ
        #
        # @return [Array<Month>] 1年データ
        #
        def set(annual_range:)
          # 次月と比較しながら当月の二十四節気を決める
          # NOTE: 最後の月は処理できない（=計算外の余分な月が最後に必要である）
          annual_range.each_cons(2) do |(current_month, next_month)|
            set_solar_term(
              current_month: current_month,
              next_month: next_month
            )
          end

          annual_range
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

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 月内（当月朔日から当月末日（来月朔日の前日）の間）に二十四節気があるか
        # @note 大余60で一巡するため 以下2パターンがある
        #   * current_month <= next_month : (二十四節気) >= current_month && (二十四節気) < next_month
        #   * current_month > next_month  : (二十四節気) >= current_month || (二十四節気) < next_month
        #
        # @param [Remainder] solar_term 二十四節気
        # @param [Remainder] current_month 月初
        # @param [Remainder] next_month 月末
        #
        # @return [True] 対象の二十四節気がある
        # @return [False] 対象の二十四節気がない
        #
        def self.in_solar_term?(solar_term:, current_month:, next_month:)
          # 大余で比較する
          target_time = solar_term.day
          current_month_time = current_month.day
          next_month_time = next_month.day
          current_month_over = (target_time >= current_month_time)
          next_month_under = (target_time < next_month_time)

          return current_month_over && next_month_under if current_month_time <= next_month_time

          current_month_over || next_month_under
        end

        private

        # :reek:TooManyStatements { max_statements: 8 }

        #
        # 二十四節気を設定する
        #
        # @param [Month] current_month 当月
        # @param [Month] next_month 次月
        #
        def set_solar_term(current_month:, next_month:)
          # 安全策として無限ループは回避する
          # * 最大試行回数：4回（設定なし => 設定あり => 設定あり => 設定なし）
          # * 閏月は1回しか設定しない
          # * 最大2回設定する（中気・節気）
          (0..3).each do |_index|
            in_range = Average.in_solar_term?(
              solar_term: @solar_term.remainder, current_month: current_month.remainder,
              next_month: next_month.remainder
            )

            # 範囲外
            unless in_range
              # 1つ以上設定されていれば切り上げる（一つ飛ばしで二十四節気を設定することはない）
              break unless current_month.empty_solar_term?

              next_solar_term
              next
            end

            current_month.add_term(term: @solar_term.clone)
            next_solar_term

            # 定気は最大2つまで
            break if current_month.solar_term_size == 2
          end
        end

        #
        # 次の二十四節気に移る
        #
        def next_solar_term
          @solar_term.next_term!
        end
      end
    end
  end
end
