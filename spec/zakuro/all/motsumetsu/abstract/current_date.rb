# frozen_string_literal: true

require_relative './japan_date'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Motsumetsu
      #
      # CurrentDate 現在日
      #
      module CurrentDate
        # @return [Hash<String, JapanDate>] 元号別の開始日
        GENGOU_START_DATES = {
          # TODO: all patterns
          '神護景雲1年' => JapanDate.new(leaped: false, month: 8, day: 16)
        }.freeze

        class << self
          #
          # 取得する
          #
          # @param [JapanDate] date 現在和暦日
          # @param [Gengou] current_gengou 現在元号
          # @param [Gengou] before_gengou 前回元号
          #
          # @return [String] 和暦日文字列
          #
          def get(date:, current_gengou:, before_gengou:)
            gengou = gengou(
              date: date, current_gengou: current_gengou, before_gengou: before_gengou
            )

            "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"
          end

          private

          #
          # 元号を取得する
          #
          #  『日本暦日便覧』は元号年なの、開始日を考慮する
          #
          # @param [JapanDate] date 現在和暦日
          # @param [Gengou] current_gengou 現在元号
          # @param [Gengou] before_gengou 前回元号
          #
          # @return [Gengou] 元号
          #
          def gengou(date:, current_gengou:, before_gengou:)
            return current_gengou if before_gengou.invalid?

            start_date = GENGOU_START_DATES[current_gengou.to_s]

            return current_gengou unless start_date

            return current_gengou if date > start_date

            before_gengou
          end
        end
      end
    end
  end
end
