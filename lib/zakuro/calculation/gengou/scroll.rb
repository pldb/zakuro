# frozen_string_literal: true

require_relative '../../era/western/calendar'
require_relative '../base/gengou'
require_relative '../base/linear_gengou'
require_relative './reserve/interval'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # Scroll
      #
      # 元号目録
      #
      class Scroll
        # @return [Western::Calendar] 現在日
        attr_reader :current_date
        # @return [Reserve::Interval] 予約範囲
        attr_reader :interval
        # @return [Base::Gengou] 元号
        attr_reader :current_gengou

        #
        # 初期化
        #
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] end_date 西暦終了日
        #
        def initialize(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
          @current_date = Western::Calendar.new
          @interval = Reserve::Interval.new(start_date: start_date, end_date: end_date)
          @current_gengou = Base::Gengou.new
        end

        #
        # 進める
        #
        # @param [Monthly::Month] month 月
        #
        def run(month:)
          # 開始日の検索を行う
          ignited = ignite(month: month)

          # 時間を進める
          advance(month: month) unless ignited
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
          start_date = western_start_date.clone - japan_start_date.day + 1

          # 今月末
          end_date = start_date + month.days

          update_current_gengou(start_date: start_date, end_date: end_date)

          true
        end

        def update_current_gengou(start_date:, end_date:)
          first_gengou = @interval.collect_first_gengou(
            start_date: start_date, end_date: end_date
          )
          second_gengou = @interval.collect_second_gengou(
            start_date: start_date, end_date: end_date
          )

          first_line = replace_first_gengou(gengou_list: first_gengou)
          second_line = replace_second_gengou(gengou_list: second_gengou)

          @current_gengou = Base::Gengou.new(
            first_line: to_linear_gengou(
              start_date: start_date, end_date: end_date, gengou_list: first_line
            ),
            second_line: to_linear_gengou(
              start_date: start_date, end_date: end_date, gengou_list: second_line
            )
          )

          # 来月初日
          @current_date = end_date.clone + 1
        end

        def replace_first_gengou(gengou_list: [])
          return gengou_list if gengou_list.size.zero?

          current_gengou = @current_gengou.first_line

          return gengou_list if current_gengou.size.zero?

          last = current_gengou[-1]
          gengou_list[0] = last if gengou_list[0].name == last.name

          gengou_list
        end

        def replace_second_gengou(gengou_list: [])
          return gengou_list if gengou_list.size.zero?

          current_gengou = @current_gengou.second_line

          return gengou_list if current_gengou.size.zero?

          last = current_gengou[-1]
          gengou_list[0] = last if gengou_list[0].name == last.name

          gengou_list
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
            gengou_start_date = gengou.western_start_date.clone
            gengou_end_date = gengou.western_end_date.clone

            gengou_start_date = start_date.clone if start_date > gengou_start_date
            gengou_end_date = end_date.clone if end_date < gengou_end_date

            result.push(
              Base::LinearGengou.new(
                start_date: gengou_start_date, end_date: gengou_end_date,
                name: gengou.name, year: gengou.japan_year
              )
            )
          end

          result
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
          return false unless @current_date.invalid?

          japan_start_date = @interval.japan_start_date

          japan_start_date.same_month?(leaped: month.leaped?, month: month.number)
        end

        #
        # 進める
        #
        # @param [Monthly::Month] month 月
        #
        def advance(month:)
          # TODO: make
          # * 月の日数だけ現在日を進める
          # * 月が1月の時は年を改める
        end
      end
    end
  end
end
