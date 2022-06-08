# frozen_string_literal: true

require_relative '../../../output/response'

require_relative './day'
require_relative './option'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      #
      # Month 特定月
      #
      class Month
        # @return [Context::Context] 暦コンテキスト
        attr_reader :context
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
        # @param [Context::Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        # @param [Base::Year] year 年
        # @param [Monthly::Month] month 月
        #
        def initialize(context:, start_date:, last_date:, year:, month:)
          @context = context
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

            day = Day.get(month: @month, date: current_date)

            options = Option.create(context: @context, month: @month, day: day)

            single_day = Output::Response::SingleDay.create(
              year: @year, month: @month, day: day, options: options
            )

            result.push(single_day)
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
