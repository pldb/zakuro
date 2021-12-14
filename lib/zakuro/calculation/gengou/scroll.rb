# frozen_string_literal: true

require_relative '../../era/western/calendar'
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
        # @return [Array<Gengou::Counter>] 当月1行目元号
        attr_reader :current_first_gengou
        # @return [Array<Gengou::Counter>] 当月2行目元号
        attr_reader :current_second_gengou

        #
        # 初期化
        #
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] end_date 西暦終了日
        #
        def initialize(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
          @current_date = Western::Calendar.new
          @interval = Reserve::Interval.new(start_date: start_date, end_date: end_date)
          @current_first_gengou = []
          @current_second_gengou = []
        end

        #
        # 進める
        #
        # @param [Monthly::Month] month 月
        #
        def run(month:)
          # 開始日の検索を行う
          ignite(month: month)

          # 時間を進める
          advance(month: month)
        end

        #
        # 元号開始を試みる
        #
        # @param [Monthly::Month] month 月
        #
        def ignite(month:)
          return unless ignitable?(month: month)

          japan_start_date = @interval.japan_start_date

          western_start_date = @interval.western_start_date

          # 今月初日（和暦日が1月2日であれば、開始日の1日前が初日）
          start_date = western_start_date.clone - japan_start_date.day + 1

          # 今月末
          end_date = start_date + month.days

          first_gengou = @interval.collect_first_gengou(
            start_date: start_date, end_date: end_date
          )
          second_gengou = @interval.collect_second_gengou(
            start_date: start_date, end_date: end_date
          )

          replace_first_gengou(gengou: first_gengou)
          replace_second_gengou(gengou: second_gengou)
        end

        def replace_first_gengou(gengou: [])
          # TODO: refactor
          return if gengou.size.zero?

          if @current_first_gengou.size.zero?
            @current_first_gengou = gengou
            return
          end

          last = @current_first_gengou[-1]
          gengou[0] = last if gengou[0].name == last.name

          @current_first_gengou = gengou
        end

        def replace_second_gengou(gengou: [])
          # TODO: refactor
          return if gengou.size.zero?

          if @current_second_gengou.size.zero?
            @current_second_gengou = gengou
            return
          end

          last = @current_second_gengou[-1]
          gengou[0] = last if gengou[0].name == last.name

          @current_second_gengou = gengou
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
