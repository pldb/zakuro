# frozen_string_literal: true

require_relative '../../operation/operation'
require_relative '../monthly/month'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      #
      # OperatedSolarTerm 運用時二十四節気
      #
      class OperatedSolarTerms
        # @return [Array<Year>] 完全範囲（年データ）
        attr_reader :years
        # @return [Hash<String, SolarTerm>] 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
        #
        # * 移動元の二十四節気：無効な大余小余あり（削除対象）
        # * 移動先の二十四節気：移動元からの二十四節気（追加対象）
        #
        attr_reader :directions
        # @return [Context::Context] 暦コンテキスト
        attr_reader :context

        # TODO: クラス名が複数形

        #
        # 初期化
        #
        # @param [Context::Context] context 暦コンテキスト
        # @param [Array<Year>] years 完全範囲（年データ）
        #
        def initialize(context:, years: [])
          @context = context
          @years = years
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
          context = current_context(western_date: western_date)

          solar_term_class = context.resolver.solar_term
          solar_term = directions.fetch(western_date.format, solar_term_class.new)

          # 合致しない場合
          return false, solar_term_class.new if solar_term.empty?

          # 合致した上で、二十四節気が移動元（削除対象）の場合
          # 合致した上で、二十四節気が移動先（追加対象）の場合
          [true, solar_term]
        end

        # :reek:LongParameterList {max_params: 4}

        class << self
          # :reek:TooManyStatements { max_statements: 6 }

          #
          # 年内の全ての月の移動方向を作成する
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Hash<String, SolarTerm>] directions 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
          # @param [Array<Month>] months 年内の全ての月
          #
          def create_directions_with_months(context:, directions: {}, months: [])
            months.each do |month|
              history = Operation.specify_history(western_date: month.western_date)

              next if history.invalid?

              direction = history.diffs.solar_term

              next if direction.invalid?

              create_directions_each_month(
                context: context, directions: directions, direction: direction, month: month
              )
            end
          end

          #
          # 月毎の移動方向を作成する
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Month] 月
          # @param [Hash<String, SolarTerm>] directions 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
          # @param [Operation::SolarTerm::Diretion] 二十四節気（移動）
          #
          def create_directions_each_month(context:, month:, directions: {},
                                           direction: Operation::SolarTerm::Diretion.new)

            month.solar_terms.each do |solar_term|
              push_source(context: context, directions: directions,
                          direction: direction, solar_term: solar_term)
            end
            push_destination(context: context, directions: directions,
                             destination: direction.destination)
          end

          # :reek:LongParameterList {max_params: 4}

          #
          # 移動先に有効な二十四節気（差し替える二十四節気）を指定する
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [SolarTerm] solar_term 二十四節気（計算値）
          # @param [Hash<String, SolarTerm>] directions 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
          # @param [Operation::SolarTerm::Direction] source 二十四節気（移動）
          #
          def push_source(context:, solar_term:, directions: {},
                          direction: Operation::SolarTerm::Direction.new)
            source = direction.source

            return if source.invalid?

            return unless source.index == solar_term.index

            # 移動先に移動元の二十四節気を指定する
            directions[source.to.format] = created_source(
              context: context, direction: direction, solar_term: solar_term
            )
          end

          #
          # 移動先に有効な二十四節気（差し替える二十四節気）を生成する
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [SolarTerm] solar_term 二十四節気（計算値）
          # @param [Operation::SolarTerm::Direction] source 二十四節気（移動）
          #
          # @return [SolarTerm] 二十四節気（運用値）
          #
          def created_source(context:, solar_term:,
                             direction: Operation::SolarTerm::Direction.new)
            operated_solar_term = solar_term.clone
            remainder_class_name = context.resolver.remainder

            unless direction.invalid_days?
              # 二十四節気の大余をずらす
              operated_solar_term.remainder.add!(
                remainder_class_name.new(day: direction.days, minute: 0, second: 0)
              )
            end

            operated_solar_term
          end

          #
          # 移動元に無効な二十四節気（連番のみ指定）を指定する
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Hash<String, SolarTerm>] directions 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
          # @param [Operation::SolarTerm::Destination] destination 二十四節気（移動先）
          #
          def push_destination(context:, directions: {},
                               destination: Operation::SolarTerm::Destination.new)
            return if destination.invalid?

            solar_term_class = context.resolver.solar_term
            directions[destination.from.format] = solar_term_class.new(
              index: destination.index
            )
          end
        end

        private

        #
        # 日付に対応する暦コンテキストを取得する
        #
        # @param [Western::Calendar] western_date 西暦日
        #
        # @return [Context::Context] 暦コンテキスト
        #
        def current_context(western_date: Western::Calendar.new)
          years.each do |year|
            return year.context if western_date >= year.new_year_date
          end

          Context::Context.new
        end

        #
        # 二十四節気の移動元/移動先を生成する
        #
        # @return [Hash<String, SolarTerm>] 二十四節気の移動元/移動先（西暦日 -> 対応する二十四節気）
        #
        def create_directions
          directions = {}

          years.each do |year|
            self.class.create_directions_with_months(
              context: year.context, directions: directions, months: year.months
            )
          end

          directions
        end
      end
    end
  end
end
