# frozen_string_literal: true

require_relative '../../../era/western/calendar'

require_relative '../month'

require_relative './all_solar_term'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # MetaCollector メタ情報の収集
      #
      # 前月データを次のように扱う
      # 1. 範囲内の最初の月は無視する
      #   * 元号範囲は常に余裕を持って取っている
      #   * 求めたい日付よりは常に1ヶ月以上を計算範囲にしている
      #   * 元嘉暦の最初の月は無視する
      #     * 元嘉暦は正月始まり
      #     * 初めの月は手前の月がないため前月がない
      #     * 没日・滅日の対象外のため不要とする
      # 2. 年境界を解決した後の1年データで再度移行する
      #   * 冬至データの最初の月には前月がない
      #   * 1年データにすることで前月が生まれるので再度移行する
      # 3. 暦の切り替えを考慮する
      #   * 手前の月が異なる暦であれば、その月のデータを参照する
      module MetaCollector
        class << self
          #
          # メタ情報を取得する
          #
          # @param [Monthly::Month] before_month 前月
          # @param [Monthly::Month] current_month 当月
          #
          # @return [Monthly::Meta] 当月のメタ情報
          #
          def get(before_month:, current_month:)
            Monthly::Meta.new(
              all_solar_terms: all_solar_terms(
                before_month: before_month, current_month: current_month
              ),
              inherited_average_remainder: inherited_average_remainder(
                before_month: before_month
              )
            )
          end

          private

          #
          # 全ての二十四節気を取得する
          #
          # @param [Monthly::Month] before_month 前月
          # @param [Monthly::Month] current_month 当月
          #
          # @return [Array<Cycle::AbstractSolarTerm>] その月の全ての二十四節気
          #
          def all_solar_terms(before_month:, current_month:)
            AllSolarTerm.get(before_month: before_month, current_month: current_month)
          end

          #
          # 前月から継承した経朔を取得する
          #
          # @param [Monthly::Month] before_month 前月
          #
          # @return [Cycle::AbstractRemainder] 前月から継承した経朔
          #
          def inherited_average_remainder(before_month:)
            remainder = before_month.first_day.average_remainder
            days = before_month.days

            remainder = remainder.add(
              # 常に参照元のRemainderクラスで生成する
              remainder.class.new(day: days, minute: 0, second: 0)
            )

            remainder
          end
        end
      end
    end
  end
end
