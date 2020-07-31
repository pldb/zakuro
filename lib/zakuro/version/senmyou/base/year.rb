# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Year 年
    #
    class Year
      # @return [Gengou] 元号
      attr_reader :gengou
      # @return [Array<Month>] 年内の全ての月
      attr_reader :months

      #
      # 初期化
      #
      # @param [Gengou] gengou 元号
      #
      def initialize(gengou:)
        @gengou = gengou
        @months = []
      end

      #
      # 月を追加する
      #
      # @param [Month] month 月
      #
      def push(month:)
        return if duplicated?(month: month)

        @months.push(month)
        @gengou.add_days(days: month.days)

        nil
      end

      #
      # すでに登録済みの月と重複しているか判定する
      #
      # @note 昨年11月1日から今年1月1日の前日までで、去年データと重複する場合は登録スキップする
      #
      # @param [Month] month 月
      #
      # @return [True] 重複している
      # @return [True] 重複していない
      #
      def duplicated?(month:)
        @months.each do |existed|
          return true if existed.same?(other: month)
        end
        false
      end
    end
  end
end
