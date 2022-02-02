# frozen_string_literal: true

require_relative '../../version/context'

require_relative '../../era/western/calendar'
require_relative '../../output/logger'

require_relative '../era/gengou/scroll'
require_relative '../era/version/version'

require_relative '../base/gengou'
require_relative '../base/year'

require_relative './transfer/year_boundary'

require_relative './transfer/gengou_scroller'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      # :reek:TooManyInstanceVariables { max_instance_variables: 6 }

      #
      # FullRange 完全範囲
      #   ある日からある日の範囲を計算可能な年月範囲
      #   * 前提として元号年はその元号の開始年から数える
      #   * ある日の元号年を求める場合、その元号が含まれる最初の年まで遡る
      #   * 元号は一つとは限らない。南北朝などで二つある場合は、古い方の元号から求める
      #
      # NOTE: 割り当てた元号は年初を基準にした元号年である
      #   * 元旦を基準にした時の正しい元号を設定している
      #   * 引き当てたい日付が元旦ではない場合、その月日に従い元号を再度求める
      #   * この再計算が必要になるのは、元号が切り替わる年のみである
      #
      class FullRange
        # @return [Context] 暦コンテキスト
        attr_reader :context
        # @return [Western::Calendar] 開始日
        attr_reader :start_date
        # @return [Western::Calendar] 終了日
        attr_reader :last_date
        # @return [MultiGengouRoller] 改元処理
        attr_reader :scroll

        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'full_range')

        #
        # 初期化
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        #
        def initialize(context:, start_date: Western::Calendar.new, last_date: Western::Calendar.new)
          @start_date = start_date
          @last_date = last_date
          return if invalid?

          # TODO: 現時点では使用していない。特定の暦を指定できるようになった状態で使用する
          @context = context
          @scroll = Gengou::Scroll.new(start_date: start_date, last_date: last_date)
        end

        #
        # 無効か
        #
        # @return [True] 無効
        # @return [False] 有効
        #
        def invalid?
          @start_date.invalid?
        end

        #
        # 完全範囲を取得する
        #
        # @return [Array<Base::Year>] 完全範囲
        #
        def get
          return [] if invalid?

          years = version_ranges

          years.each(&:commit)

          Transfer::GengouScroller.set(scroll: scroll, years: years)

          years
        end

        private

        #
        # 暦別範囲
        #
        # @return [Array<Base::Year>] 完全範囲
        #
        def version_ranges
          result = []

          start_year = @scroll.western_start_year
          last_year = @scroll.western_last_year

          versions = Version.get(start_year: start_year, last_year: last_year)

          versions.each_with_index do |version, index|
            context = Context.new(version_name: version.name)
            start_year = version.start_year
            last_year = version.last_year
            # 最後の暦だけ1年足す（次の元号の開始年まで計算するケースあり）
            last_year += 1 if (index + 1) == versions.size

            years = boundary_resolved_ranges(
              context: context, start_year: start_year, last_year: last_year
            )
            result.concat(years)
          end

          result
        end

        #
        # 年境界解決済みの範囲
        #
        # @param [Context] context 暦コンテキスト
        # @param [Integer] start_year 開始西暦年
        # @param [Integer] last_year 終了西暦年
        #
        # @return [Array<Base::Year>] 年境界解決済みの範囲
        #
        def boundary_resolved_ranges(context:, start_year:, last_year:)
          ranges = annual_ranges(
            context: context, start_year: start_year, last_year: last_year
          )

          Transfer::YearBoundary.get(
            context: context, annual_ranges: ranges
          )
        end

        #
        # 完全範囲内の年データを取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Integer] start_year 開始西暦年
        # @param [Integer] last_year 終了西暦年
        #
        # @return [Array<Base::Year>] 年データ（冬至基準）
        #
        def annual_ranges(context:, start_year:, last_year:)
          annual_range = context.resolver.annual_range

          years = []
          (start_year..(last_year + 1)).each do |year|
            years.push(
              annual_range.get(
                context: context, western_year: year
              )
            )
          end

          years
        end
      end
    end
  end
end
