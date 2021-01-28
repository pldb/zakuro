# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Single 一日
    #
    module Single
      #
      # 生成する
      #
      # @param [Western::Calendar] date 西暦日
      #
      # @return [Result::Single] 一日検索結果（和暦日）
      #
      def self.create(date: Western::Calendar.new)
        # TODO: 計算値の生成（full_range -> specifier）
        # TODO: 運用値の生成（operated_range -> specifier）
        # TODO: 運用情報の生成（operation/operation -> operated_range）
      end
    end
  end
end
