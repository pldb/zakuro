# frozen_string_literal: true

require_relative '../../../era/western/calendar'
require_relative '../../base/gengou'
require_relative '../../base/linear_gengou'
require_relative './internal/connector'
require_relative './internal/publisher'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # AbstractScroll
      #
      # 元号スクロール
      #
      class AbstractScroll
        # @return [Western::Calendar] 月初日
        attr_reader :monthly_start_date
        # @return [Western::Calendar] 月末日
        attr_reader :monthly_last_date
        # @return [Reserve::AbstractRange] 予約範囲
        attr_reader :range
        # @return [Array<Counte>] 1行目元号
        attr_reader :first_gengou
        # @return [Array<Counte>] 2行目元号
        attr_reader :second_gengou
        # @return [Connector] 行変更済元号
        attr_reader :connector

        #
        # 初期化
        #
        # @param [Reserve::AbstractRange] range 予約範囲
        #
        def initialize(range:)
          @monthly_start_date = Western::Calendar.new
          @monthly_last_date = Western::Calendar.new
          @range = range
          @first_gengou = []
          @second_gengou = []
          @ignited = false
          @connector = Connector.new
        end

        #
        # 進める
        #
        # @param [Monthly::Month] month 月
        #
        def run(month:)
          unless @ignited
            # 開始日の検索を行う
            @ignited = ignite(month: month)
            return
          end

          # 時間を進める
          advance(month: month)
        end

        #
        # 元号開始を試みる
        #
        # @param [Monthly::Month] month 月
        #
        # @return [True] 開始あり
        # @return [False] 開始なし
        #
        def ignite(month:)
          return false unless ignitable?(month: month)

          first_monthly_date(month: month)

          update_current_gengou

          true
        end

        #
        # 進める
        #
        # @param [Monthly::Month] month 月
        #
        def advance(month:)
          @monthly_start_date = monthly_last_date.clone + 1

          @monthly_last_date = monthly_start_date.clone + month.days - 1

          next_year if month.number == 1 && !month.leaped?

          update_current_gengou
        end

        #
        # 共通の元号に変換する
        #
        # @return [Base::Gengou] 元号
        #
        def to_gengou
          start_date = monthly_start_date.clone
          last_date = monthly_last_date.clone

          # 行を超えた元号切り替え処理
          continue_year

          Publisher.run(
            start_date: start_date, last_date: last_date,
            first_gengou: first_gengou, second_gengou: second_gengou
          )
        end

        #
        # 開始西暦年を取得する
        #
        # @return [Integer] 開始西暦年
        #
        def western_start_year
          range.western_start_year
        end

        #
        # 終了西暦年を取得する
        #
        # @return [Integer] 終了西暦年
        #
        def western_last_year
          range.western_last_year
        end

        private

        #
        # 最初の月初日/末日を設定する
        #
        # @param [Monthly::Month] month 月
        #
        def first_monthly_date(month:)
          japan_start_date = range.japan_start_date

          western_start_date = range.western_start_date

          # 今月初日（和暦日が1月2日であれば、開始日の1日前が初日）
          @monthly_start_date = western_start_date.clone - japan_start_date.day + 1

          # 今月末
          @monthly_last_date = monthly_start_date.clone + month.days - 1
        end

        #
        # 行を跨ぐ元号年を継続させる
        #
        def continue_year
          connector.update(lines: [first_gengou, second_gengou])
        end

        #
        # 現在月に合わせて元号を更新する
        #
        def update_current_gengou
          start_date = monthly_start_date
          last_date = monthly_last_date
          dest_first_gengou = range.collect_first(start_date: start_date, last_date: last_date)
          dest_second_gengou = range.collect_second(start_date: start_date,
                                                    last_date: last_date)

          @first_gengou = replace_gengou(source: first_gengou, destination: dest_first_gengou)
          @second_gengou = replace_gengou(source: second_gengou, destination: dest_second_gengou)
        end

        #
        # 元号を差し替える
        #
        # @param [Array<Counter>] source 元の元号
        # @param [Array<Counter>] destination 次の元号
        #
        # @return [Array<Counter>] 差し替え結果
        #
        def replace_gengou(source: [], destination: [])
          return destination if destination.size.zero?

          return destination if source.size.zero?

          last = source[-1]
          destination[0] = last if destination[0].name == last.name

          destination
        end

        #
        # 開始可能か
        #
        # @param [Monthly::Month] month 月
        #
        # @return [True] 開始可
        # @return [True] 開始不可
        #
        def ignitable?(month:)
          return false unless monthly_start_date.invalid?

          japan_start_date = range.japan_start_date

          japan_start_date.same_month?(leaped: month.leaped?, month: month.number)
        end

        #
        # 次年にする
        #
        def next_year
          first_gengou.each(&:next_year)
          second_gengou.each(&:next_year)
        end
      end
    end
  end
end
