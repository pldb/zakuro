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
          return unless @current_date.invalid?

          japan_start_date = @interval.japan_start_date

          return unless japan_start_date.same_month?(leaped: month.leaped?, month: month.number)

          western_start_date = @interval.western_start_date

          start_date = western_start_date.clone - month.days

          # 今月末まで進める（開始日 + 月日数 - 和暦日の日）- 1
          end_date = western_start_date.clone + (month.days - japan_start_date.day) - 1

          # TODO: make
          # first_line = []
          # second_line = []
          # second_gengou = @interval.match_second_gengou(western_date: western_start_date)

          p start_date
          p end_date

          # TODO: make
          # * 一致する場合はその月を元号開始月にする
          #    * 月のうち、何日かを見て範囲も設定する
          #    * 現在日を来月初日に更新する
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
