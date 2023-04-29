# frozen_string_literal: true

require_relative '../output/logger'

require_relative '../calculation/cycle/abstract_remainder'

require_relative '../calculation/era/gengou/dated_scroll'

# TODO: Tools -> Tool

# :nodoc:
module Zakuro
  #
  # Tools 汎用メソッド群
  #
  module Tools
    #
    # GengouRangeComparer 元号範囲比較
    #
    module GengouRangeComparer
      # @return [Output::Logger] ロガー
      LOGGER = Output::Logger.new(location: 'GengouRangeComparer')

      class << self
        #
        # 元号範囲が計算値/運用値で同一か
        #
        # @param [Western::Calendar] start_date 開始西暦日
        # @param [Western::Calendar] last_date 終了西暦日
        #
        # @return [True] 一致
        # @return [False] 不一致
        #
        def same?(start_date: Western::Calendar.new, last_date: Western::Calendar.new)
          calc_range = Calculation::Gengou::DatedScroll.new(
            start_date: start_date, last_date: last_date
          ).range

          ope_range = Calculation::Gengou::DatedScroll.new(
            start_date: start_date, last_date: last_date, operated: true
          ).range

          # 1行目元号
          unless same_line?(calc_line: calc_range.first_list.list,
                            ope_line: ope_range.first_list.list)
            return false
          end

          # 2行目元号
          unless same_line?(calc_line: calc_range.second_list.list,
                            ope_line: ope_range.second_list.list)
            return false
          end

          true
        end

        private

        #
        # 同じ予約元号一覧か
        #
        # @param [Array<Japan::Alignment::LinearGengou>] calc_line 予約元号一覧（計算値）
        # @param [Array<Japan::Alignment::LinearGengou>] ope_line 予約元号一覧（運用値）
        #
        # @return [True] 一致
        # @return [False] 不一致
        #
        def same_line?(calc_line: [], ope_line: [])
          return false unless calc_line.size == ope_line.size

          calc_line.each_with_index do |calc_gengou, index|
            ope_gengou = ope_line[index]
            return false unless calc_gengou.name == ope_gengou.name
          end

          true
        end
      end
    end
  end
end
