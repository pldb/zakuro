# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # DateComparer 日付比較
      #
      module DateComparer
        class << self
          #
          # 範囲内か
          #
          # @param [Western::Calendar] date 日付
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] last_date 終了日
          #
          # @return [True] 範囲内
          # @return [False] 範囲外
          #
          def include?(date:, start_date:, last_date:)
            return false if start_date.invalid?

            return false if date < start_date

            return false if date > last_date

            true
          end

          #
          # 範囲内か
          #
          # @param [Japan::Calendar] date 日付
          # @param [Base::Gengou] gengou 元号
          # @param [MonthLabel] month_label 月表示名
          #
          # @return [True] 範囲内
          # @return [False] 範囲外
          #
          def include_by_japan_date?(date:, gengou:, month_label:)
            linear_gengou = gengou.match_by_name(name: date.gengou)

            return false if linear_gengou.invalid?

            return false unless linear_gengou.name == date.gengou

            return false unless linear_gengou.year == date.year

            same_by_japan_date?(month_label: month_label, date: date)
          end

          private

          #
          # 同一の月情報かを検証する
          #
          # @param [MonthLabel] month_label 月表示名
          # @param [Japan::Calendar] date 日付
          #
          # @return [True] 同一の月
          # @return [False] 異なる月
          #
          def same_by_japan_date?(month_label:, date: Japan::Calendar.new)
            return false unless month_label.number == date.month

            return false unless month_label.leaped == date.leaped

            true
          end
        end
      end
    end
  end
end
