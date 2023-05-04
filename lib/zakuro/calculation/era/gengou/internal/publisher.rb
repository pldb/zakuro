# frozen_string_literal: true

require_relative '../../../../era/western/calendar'
require_relative '../../../base/linear_gengou'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # Publisher
      #
      # 元号発行
      #
      module Publisher
        class << self
          #
          # 発行する
          #
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] last_date 西暦終了日
          # @param [Array<Counter>] first_gengou 1行目元号
          # @param [Array<Counter>] second_gengou 2行目元号
          #
          # @return [Base::Gengou] 元号
          #
          def run(start_date: Western::Calendar.new, last_date: Western::Calendar.new,
                  first_gengou: [], second_gengou: [])

            Base::Gengou.new(
              start_date: start_date,
              last_date: last_date,
              first_line: to_linear_gengou(
                start_date: start_date, last_date: last_date, gengou_list: first_gengou
              ),
              second_line: to_linear_gengou(
                start_date: start_date, last_date: last_date, gengou_list: second_gengou
              )
            )
          end

          #
          # 直列元号に変換する
          #
          #   * 最初の元号：開始日～その元号の終了日
          #   * 中間の元号：その元号の開始日～その元号の終了日
          #   * 最後の元号：その元号の開始日～終了日
          #
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] last_date 西暦終了日
          # @param [Array<Counter>] gengou_list 元号リスト
          #
          # @return [Array<Base::LinearGengou>] 元号リスト
          #
          def to_linear_gengou(start_date:, last_date:, gengou_list: [])
            return [] if gengou_list.empty?

            result = []

            gengou_list.each do |gengou|
              if gengou.invalid?
                # 無効元号は無効のままにする
                result.push(Base::LinearGengou.new)
                next
              end

              linear_gengou = to_limited_linear_gengou(
                start_date: start_date,
                last_date: last_date,
                gengou: gengou
              )
              result.push(linear_gengou)
            end

            result
          end

          #
          # 範囲を限定した直列元号に変換する
          #
          # * 開始日・終了日により範囲を狭める
          #
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] last_date 西暦終了日
          # @param [Counter] gengou 加算元号
          #
          # @return [Base::LinearGengou] 元号
          #
          def to_limited_linear_gengou(start_date:, last_date:, gengou:)
            gengou_start_date = gengou.western_start_date.clone
            gengou_last_date = gengou.western_last_date.clone

            gengou_start_date = start_date.clone if start_date > gengou_start_date
            gengou_last_date = last_date.clone if last_date < gengou_last_date

            Base::LinearGengou.new(
              start_date: gengou_start_date, last_date: gengou_last_date,
              name: gengou.name, year: gengou.japan_year
            )
          end
        end
      end
    end
  end
end
