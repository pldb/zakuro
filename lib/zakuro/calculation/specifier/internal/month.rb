# frozen_string_literal: true

require_relative '../../../output/response'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Specifier
      #
      # Month 特定月
      #
      class Month
        # @return [Western::Calendar] 西暦開始日
        attr_reader :start_date
        # @return [Western::Calendar] 西暦終了日
        attr_reader :last_date
        # @return [Base::Year] 年
        attr_reader :year
        # @return [Monthly::Month] 月
        attr_reader :month

        #
        # 初期化
        #
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        # @param [Base::Year] year 年
        # @param [Monthly::Month] month 月
        #
        def initialize(start_date:, last_date:, year:, month:)
          @start_date = start_date
          @last_date = last_date
          @year = year
          @month = month
        end

        #
        # 取得する
        #
        # @return [Array<Result::Data::SingleDay>] 1日データ
        #
        def get
          result = []
          first_date = @month.western_date.clone

          (0..@month.days).each do |index|
            current_date = first_date.clone + index

            next unless include?(date: current_date)

            day = Output::Response::SingleDay.save_single_day(
              param: Output::Response::SingleDay::Param.new(
                year: @year, month: @month,
                date: first_date, days: index
              )
            )

            result.push(day)
          end

          result
        end

        #
        # 含まれるか
        #
        # @param [Western::Calendar] date 西暦日
        #
        # @return [True] 含む
        # @return [False] 含まない
        #
        def include?(date:)
          return false if date < @start_date

          return false if date > @last_date

          true
        end
      end
    end
  end
end
