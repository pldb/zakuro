# frozen_string_literal: true

require_relative '../../monthly/month'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      # :nodoc:
      module Transfer
        #
        # GengouScroller 元号スクロール
        #
        module GengouScroller
          class << self
            #
            # 元号を年に設定する
            #
            # @param [Gengou::Scroll] scroll 元号スクロール
            # @param [Array<Base::Year>] years 年
            #
            def set(scroll:, years: [])
              years.each do |year|
                update_gengou_year(scroll: scroll, year: year)
              end
            end

            private

            #
            # 年の元号を更新する
            #
            # @param [Base::Year] year 年
            #
            def update_gengou_year(scroll:, year:)
              year.months.each_with_index do |month, index|
                scroll.run(month: month)
                gengou = scroll.to_gengou
                year.months[index] = replace_gengou(
                  month: month, gengou: gengou
                )
              end
            end

            #
            # 月情報のうち元号を差し替える
            #
            # @param [Monthly::Month] month 月情報
            # @param [Base::Gengou] gengou 元号
            #
            # @return [Monthly::Month] 月情報
            #
            def replace_gengou(month:, gengou:)
              Monthly::Month.new(
                context: month.context,
                month_label: month.month_label,
                first_day: Monthly::FirstDay.new(
                  remainder: month.first_day.remainder,
                  average_remainder: month.first_day.average_remainder,
                  western_date: gengou.start_date.clone
                ),
                solar_terms: month.solar_terms, gengou: gengou,
                meta: month.meta
              )
            end
          end
        end
      end
    end
  end
end
