# frozen_string_literal: true

# TODO: spec内の全てのモジュール・クラスをZakuroモジュール内に入れる

#
# SingleDatePrinter 一日検索結果出力
#
class SingleDatePrinter
  # @return [Zakuro::Result::Single] 一日検索結果
  attr_reader :date

  #
  # 初期化
  #
  # @param [Zakuro::Result::Single] date 一日検索結果
  #
  def initialize(date:)
    @date = date
  end

  #
  # 西暦日を返す
  #
  # @return [String] 西暦日
  #
  def western_date
    date.data.day.western_date.format
  end

  #
  # 滅日結果を返す
  #
  # @return [String] 滅日結果
  #
  def vanished_date_result
    vanished_date = date.data.options['vanished_date']

    "#{vanished_date.matched} / #{vanished_date.calculation.remainder}"
  end

  #
  # 該当する滅日の経朔を返す
  #
  # @return [String] 滅日の経朔
  #
  def vanished_date_average_remainder
    vanished_date = date.data.options['vanished_date']

    vanished_date.calculation.average_remainder
  end

  #
  # 没日結果を返す
  #
  # @return [String] 没日結果
  #
  def dropped_date_result
    dropped_date = date.data.options['dropped_date']

    "#{dropped_date.matched} / #{dropped_date.calculation.remainder}"
  end

  #
  # 没日か
  #
  # @return [True] 没日あり
  # @return [False] 没日なし
  #
  def dropped_date?
    dropped_date = date.data.options['dropped_date']

    dropped_date.matched
  end

  #
  # 滅日か
  #
  # @return [True] 滅日あり
  # @return [False] 滅日なし
  #
  def vanished_date?
    vanished_date = date.data.options['vanished_date']

    vanished_date.matched
  end

  #
  # 没日・滅日か
  #
  # @return [True] 没日・滅日あり
  # @return [False] 没日・滅日なし
  #
  def event?
    dropped_date? || vanished_date?
  end

  #
  # 和暦日を返す
  #
  # @return [String] 和暦日
  #
  def japan_date
    data = date.data

    "#{data.year.first_gengou.name}#{data.year.first_gengou.number}年" \
              "#{data.month.leaped ? '閏' : ''}#{data.month.number}月#{data.day.number}日"
  end
end
