# frozen_string_literal: true

require_relative './japan/gengou'
require_relative './western'

# TODO: 宣明暦以外にも対応させる

# :nodoc:
module Zakuro
  # :nodoc:
  module Era
    #
    # VersionLimitter 暦境界
    #
    module VersionLimitter
      # @return [Western::Calendar] 貞観4年1月1日
      START_DATE = Western::Calendar.new(year: 862, month: 2, day: 3)
      # @return [Western::Calendar] 貞享2年12月29日
      END_DATE = Western::Calendar.new(year: 1686, month: 1, day: 23)

      #
      # 元号（1行目）を取得する
      #
      # @param [Western::Calendar] start_date 開始日
      #
      # @return [Japan::Gengou] 元号（1行目）
      #
      def self.first(start_date:)
        Japan::GengouResource.first_line(date: start_date)
      end

      #
      # 元号（2行目）を取得する
      #
      # @param [Western::Calendar] start_date 開始日
      #
      # @return [Japan::Gengou] 元号（2行目）
      #
      def self.second(start_date:)
        Japan::GengouResource.second_line(date: start_date)
      end

      #
      # 宣明暦に含まれるかを確認する
      #
      # @param [Western::Calendar] date 日付
      #
      # @return [True] 含まれる
      # @return [False] 含まれない
      #
      def self.include?(date:)
        (START_DATE <= date && date <= END_DATE)
      end
    end
  end
end
