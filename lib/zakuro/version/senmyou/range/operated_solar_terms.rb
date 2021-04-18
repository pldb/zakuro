# frozen_string_literal: true

require_relative './full_range'
require_relative '../../../operation/operation'
require_relative '../monthly/month'

# TODO: solar_termの中はsrc/destだが、yamlはcalc/actual。統一したい。

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # OperatedSolarTerm 運用時二十四節気
    #
    class OperatedSolarTerms
      # @return [Array<Year>] 完全範囲（年データ）
      attr_reader :years
      # @return [Array<MonthHistory>] 変更履歴
      attr_reader :month_histroies
      # @return [Hash<String, SolarTerm>] 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
      #
      # * 移動元の二十四節気：無効な大余小余あり（削除対象）
      # * 移動先の二十四節気：移動元からの二十四節気（追加対象）
      #
      attr_reader :directions

      #
      # 初期化
      #
      # @param [Array<Year>] years 完全範囲（年データ）
      # @param [Array<MonthHistory>] 変更履歴
      #
      def initialize(years: [], month_histories: Operation.month_histories)
        @years = years
        @month_histroies = month_histories
        @directions = {}
      end

      #
      # データ生成する
      #
      # @return [<Type>] <description>
      #
      def create
        @directions = create_directions
      end

      #
      # 二十四節気を取得する
      #
      # @param [Western::Calendar] western_date 月初日の西暦日
      #
      # @return [True] 対象あり
      # @return [False] 対象なし
      # @return [SolarTerm] 二十四節気
      #
      def get(western_date: Western::Calendar.new)
        solar_term = @directions.fetch(western_date.format, SolarTerm.new)

        # 合致しない場合
        return false, SolarTerm.new if solar_term.empty?

        # 合致した上で、二十四節気が移動元（削除対象）の場合
        # 合致した上で、二十四節気が移動先（追加対象）の場合
        [true, solar_term]
      end

      #
      # 二十四節気の移動元/移動先を生成する
      #
      # @return [Hash<String, SolarTerm>] 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
      #
      def create_directions
        directions = {}

        years.each do |year|
          create_directions_with_months(directions: directions, months: year.months)
        end

        directions
      end

      #
      # 年内の全ての月の移動方向を作成する
      #
      # @param [Hash<String, SolarTerm>] directions 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
      # @param [Array<Month>] months 年内の全ての月
      #
      def create_directions_with_months(directions: {}, months: [])
        months.each do |month|
          @month_histroies.each do |history|
            next unless month.western_date == history.western_date

            direction = history.diffs.solar_term

            next if direction.invalid?

            OperatedSolarTerms.create_directions_each_month(
              directions: directions, direction: direction, month: month
            )
          end
        end
      end

      #
      # 月毎の移動方向を作成する
      #
      # @param [Hash<String, SolarTerm>] directions 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
      # @param [Operation::SolarTerm::Diretion] 二十四節気（移動）
      # @param [Month] 月
      #
      def self.create_directions_each_month(directions: {},
                                            direction: Operation::SolarTerm::Diretion.new,
                                            month: Month.new)

        month.solar_terms.each do |solar_term|
          OperatedSolarTerms.push_source(directions: directions, direction: direction,
                                         solar_term: solar_term)
        end
        OperatedSolarTerms.push_destination(directions: directions,
                                            destination: direction.destination)
      end

      #
      # 移動先に有効な二十四節気（差し替える二十四節気）を指定する
      #
      # @param [Hash<String, SolarTerm>] directions 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
      # @param [Operation::SolarTerm::Direction] source 二十四節気（移動）
      # @param [SolarTerm] solar_term 二十四節気（計算値）
      #
      def self.push_source(directions: {}, direction: Operation::SolarTerm::Direction.new,
                           solar_term: SolarTerm.new)
        source = direction.source

        return if source.invalid?

        return unless source.index == solar_term.index

        operated_solar_term = solar_term.clone
        unless direction.invalid_days?
          # 二十四節気の大余をずらす
          operated_solar_term.remainder.add!(Remainder.new(day: direction.days, minute: 0, second: 0))
        end

        # 移動先に移動元の二十四節気を指定する
        directions[source.to.format] = operated_solar_term
      end

      #
      # 移動元に無効な二十四節気（連番のみ指定）を指定する
      #
      # @param [Hash<String, SolarTerm>] directions 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
      # @param [Operation::SolarTerm::Destination] destination 二十四節気（移動先）
      #
      def self.push_destination(directions: {}, destination: Operation::SolarTerm::Destination.new)
        return if destination.invalid?

        directions[destination.from.format] = SolarTerm.new(index: destination.index)
      end
    end
  end
end
