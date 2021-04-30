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
      # @return [Western::Calendar] 貞観1年1月1日
      JOUGAN_START_DATE = Western::Calendar.new(year: 859, month: 2, day: 7)

      # @return [Western::Calendar] 貞観4年1月1日
      START_DATE = Western::Calendar.new(year: 862, month: 2, day: 3)
      # @return [Integer] （貞観）4年
      START_GENGOU_YEAR = 4
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
        first_gengou = Japan::GengouResource.first_line(date: start_date)
        # 宣明暦の初めの元号であれば、起算年を4年とする
        if JOUGAN_START_DATE == first_gengou.start_date
          first_gengou = Japan::Gengou.new(
            name: first_gengou.name,
            start_date: START_DATE,
            end_date: first_gengou.end_date,
            year: START_GENGOU_YEAR
          )
        end

        first_gengou
      end

      def self.start_gengou_name
        first_gengou = Japan::GengouResource.first_line(date: START_DATE)

        first_gengou.name
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
