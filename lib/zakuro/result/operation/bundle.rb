# frozen_string_literal: true

require_relative '../data/single_day'

require_relative './month/bundle'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # 運用情報
    #
    module Operation
      #
      # Bundle 運用情報
      #
      class Bundle
        # @return [True] 運用あり
        # @return [False] 運用なし
        attr_reader :operated
        # @return [Month::Bundle] 月別履歴情報
        attr_reader :month
        # @return [Data::SingleDay] 計算値
        attr_reader :original

        #
        # 初期化
        #
        # @param [True, False] operated 運用有無
        # @param [Month::Bundle] month 月別履歴情報
        # @param [Data::SingleDay] original 計算値
        #
        def initialize(operated:, month:, original:)
          @operated = operated
          @month = month
          @original = original
        end
      end
    end
  end
end
