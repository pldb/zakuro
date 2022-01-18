# frozen_string_literal: true

require_relative '../base/year'

require_relative '../../era/western/calendar'
require_relative '../../output/response'
require_relative '../../output/logger'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Specifier
      #
      # MultipleDay 複数日検索
      #
      module MultipleDay
        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'specifier')

        #
        # 取得する
        #
        # @param [Array<Year>] yeas 範囲
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [Result::Range] 期間検索結果（和暦日）
        #
        def self.get(years: [], start_date: Western::Calendar.new, last_date: Western::Calendar.new)
          # TODO: make
        end
      end
    end
  end
end
