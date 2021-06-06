# frozen_string_literal: true

require_relative '../abstract_version'

# :nodoc:
module Zakuro
  #
  # Taien 大衍暦
  #
  module Taien
    #
    # Gateway アクセサメソッド群
    #
    class Gateway < AbstractVersion
      # @return [True] リリースあり
      RELEASE = true

      # @return [String] 暦クラス名
      VERSION_NAME = 'Taien'

      #
      # 西暦日から和暦日に変換する
      #
      # @param [Date] western_date 西暦日
      #
      # @return [Result::Single] 和暦日
      #
      def self.to_japan_date(western_date:)
        date = Western::Calendar.create(date: western_date)

        context = Context.new(version_name: VERSION_NAME)
        Calculation::Summary::Single.get(context: context, date: date)
      end
    end
  end
end
