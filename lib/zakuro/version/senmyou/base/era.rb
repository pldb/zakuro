# frozen_string_literal: true

require_relative '../../../era/japan/gengou'
require_relative '../../../era/western'
require_relative '../../../cycle/zodiac'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Era 宣明暦時代
    #
    module Era
      # FIXME: JOUGAN_START_DATE は不要。'貞観' かどうかだけで良い

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

      #
      # 十干十二支を引き当てる
      #
      # @param [String] western_year 西暦年
      #
      # @return [String] 十干十二支
      #
      def self.zodiac_name(western_year: 0)
        Cycle::Zodiac.year_name(western_year: western_year)
      end
    end
  end
end
