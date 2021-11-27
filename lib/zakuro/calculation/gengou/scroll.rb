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
        # @return [Base::Gengou] 元号
        attr_reader :gengou

        #
        # 初期化
        #
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] end_date 西暦終了日
        #
        def initialize(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
          @current_date = Western::Calendar.new
          @interval = Reserve::Interval.new(start_date: start_date, end_date: end_date)
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

          start_date = western_start_date.clone - month.days

          # 今月末まで進める（開始日 + 月日数 - 和暦日の日）- 1
          end_date = western_start_date.clone + (month.days - japan_start_date.day) - 1

          first_gengou = @interval.collect_first_gengou(start_date: start_date, end_date: end_date)
          second_gengou = @interval.collect_second_gengou(start_date: start_date, end_date: end_date)

          # TODO: make
          p first_gengou
          p second_gengou
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