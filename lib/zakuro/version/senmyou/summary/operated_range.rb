# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # OperatedRange 運用結果範囲
    #
    # 何らかの理由により、計算された暦とは異なる運用結果である場合、その結果に合わせて計算結果を上書きする
    class OperatedRange
      attr_reader :full_range

      #
      # 初期化
      #
      # @param [Western::Calendar] start_date 開始日
      # @param [Western::Calendar] end_date 終了日
      #
      def initialize(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
        @full_range = FullRange.new(start_date: start_date, end_date: end_date)
      end

      def get
        # TODO: 運用結果範囲を返すこと
      end
    end
  end
end
