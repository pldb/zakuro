# frozen_string_literal: true

require_relative '../../era/western/calendar'
require_relative '../base/gengou'
require_relative '../base/linear_gengou'
require_relative './internal/reserve/interval'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # Scroll
      #
      # 元号スクロール
      #
      class Scroll
        # @return [Western::Calendar] 月初日
        attr_reader :monthly_start_date
        # @return [Western::Calendar] 月末日
        attr_reader :monthly_end_date
        # @return [Reserve::Interval] 予約範囲
        attr_reader :interval
        # @return [Array<Counte>] 1行目元号
        attr_reader :first_gengou
        # @return [Array<Counte>] 2行目元号
        attr_reader :second_gengou

        #
        # 初期化
        #
        # @param [Western::Calendar] start_date 西暦開始日（最大範囲）
        # @param [Western::Calendar] end_date 西暦終了日（最大範囲）
        #
        def initialize(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
          @monthly_start_date = Western::Calendar.new
          @monthly_end_date = Western::Calendar.new
          @interval = Reserve::Interval.new(start_date: start_date, end_date: end_date)
          @first_gengou = []
          @second_gengou = []
          @ignited = false
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

          japan_start_date = @interval.japan_start_date

          western_start_date = @interval.western_start_date

          # 今月初日（和暦日が1月2日であれば、開始日の1日前が初日）
          @monthly_start_date = western_start_date.clone - japan_start_date.day + 1

          # 今月末
          @monthly_end_date = @monthly_start_date.clone + month.days - 1

          update_current_gengou

          true
        end

        #
        # 進める
        #
        # @param [Monthly::Month] month 月
        #
        def advance(month:)
          @monthly_start_date = @monthly_end_date.clone + 1

          @monthly_end_date = @monthly_start_date.clone + month.days - 1

          next_year if month.number == 1 && !month.leaped?

          update_current_gengou
        end

        #
        # 共通の元号に変換する
        #
        # @return [Base::Gengou] 元号
        #
        def to_gengou
          start_date = @monthly_start_date.clone
          end_date = @monthly_end_date.clone

          Base::Gengou.new(
            start_date: start_date,
            end_date: end_date,
            first_line: to_linear_gengou(
              start_date: start_date, end_date: end_date, gengou_list: @first_gengou
            ),
            second_line: to_linear_gengou(
              start_date: start_date, end_date: end_date, gengou_list: @second_gengou
            )
          )
        end

        #
        # 開始西暦年を取得する
        #
        # @return [Integer] 開始西暦年
        #
        def western_start_year
          @interval.western_start_year
        end

        #
        # 終了西暦年を取得する
        #
        # @return [Integer] 終了西暦年
        #
        def western_end_year
          @interval.western_end_year
        end

        private

        #
        # 現在月に合わせて元号を更新する
        #
        def update_current_gengou
          start_date = @monthly_start_date
          end_date = @monthly_end_date
          first_gengou = @interval.collect_first_gengou(start_date: start_date, end_date: end_date)
          second_gengou = @interval.collect_second_gengou(start_date: start_date,
                                                          end_date: end_date)

          @first_gengou = replace_gengou(source: @first_gengou, destination: first_gengou)
          @second_gengou = replace_gengou(source: @second_gengou, destination: second_gengou)
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
        # 直列元号に変換する
        #
        #   * 最初の元号：開始日～その元号の終了日
        #   * 中間の元号：その元号の開始日～その元号の終了日
        #   * 最後の元号：その元号の開始日～終了日
        #
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] end_date 西暦終了日
        # @param [Array<Counter>] gengou_list 元号リスト
        #
        # @return [Array<Base::Gengou>] 元号リスト
        #
        def to_linear_gengou(start_date:, end_date:, gengou_list: [])
          return [] if gengou_list.size.zero?

          result = []

          gengou_list.each do |gengou|
            if gengou.invalid?
              # 無効元号は無効のままにする
              result.push(Base::LinearGengou.new)
              next
            end

            linear_gengou = to_limited_linear_gengou(
              start_date: start_date,
              end_date: end_date,
              gengou: gengou
            )
            result.push(linear_gengou)
          end

          result
        end

        #
        # 範囲を限定した直列元号に変換する
        #
        # * 開始日・終了日により範囲を狭める
        #
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] end_date 西暦終了日
        # @param [Counter] gengou 加算元号
        #
        # @return [Base::Gengou] 元号
        #
        def to_limited_linear_gengou(start_date:, end_date:, gengou:)
          gengou_start_date = gengou.western_start_date.clone
          gengou_end_date = gengou.western_end_date.clone

          gengou_start_date = start_date.clone if start_date > gengou_start_date
          gengou_end_date = end_date.clone if end_date < gengou_end_date

          Base::LinearGengou.new(
            start_date: gengou_start_date, end_date: gengou_end_date,
            name: gengou.name, year: gengou.japan_year
          )
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
          return false unless @monthly_start_date.invalid?

          japan_start_date = @interval.japan_start_date

          japan_start_date.same_month?(leaped: month.leaped?, month: month.number)
        end

        #
        # 次年にする
        #
        def next_year
          @first_gengou.each(&:next_year)
          @second_gengou.each(&:next_year)
        end
      end
    end
  end
end
