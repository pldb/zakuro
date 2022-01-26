# frozen_string_literal: true

require_relative './era/western/calendar'

require_relative './calculation/summary/single'

require_relative './calculation/summary/range'

require_relative './condition'

require_relative './output/error'

# :nodoc:
module Zakuro
  #
  # Merchant ざくろ商人
  #   東西の暦を取引する、素敵な笑顔の持ち主
  #
  class Merchant
    # @return [Hash<Symbol, Object>] 条件
    attr_reader :condition

    #
    # 初期化
    #
    # @param [Hash<Symbol, Object>] condition 条件
    #
    def initialize(condition: {})
      failed = Condition.validate(hash: condition)
      raise Output::ZakuroError, failed.join('\n') unless failed.empty?

      @condition = Condition.new(hash: condition)
    end

    #
    # 条件提示する
    #
    # @param [Hash<Symbol, Object>] condition 条件
    #
    # @return [Merchant] 自インスタンス
    #
    def offer(condition: {})
      failed = Condition.validate(hash: condition)
      raise Output::ZakuroError, failed.join('\n') unless failed.empty?

      @condition.rewrite(hash: condition)

      self
    end

    #
    # 承諾する
    #
    # @return [Result::SingleDay] 和暦日
    # @return [Result::Range] 和暦日範囲
    #
    def commit
      date = condition.date

      return single(date: date) if date

      range = condition.range

      return range(range: range) if range

      {}
    end

    private

    #
    # 1日検索
    #
    # @param [Date] date 西暦日
    #
    # @return [Result::Single] 検索結果
    #
    def single(date:)
      western_date = Western::Calendar.create(date: date)

      # TODO: condition で設定する
      context = Context.new(version_name: '')

      Calculation::Summary::Single.get(context: context, date: western_date)
    end

    #
    # 期間検索
    #
    # @param [Catalog::Range] range 期間
    #
    # @return [Result::Range] 和暦日範囲
    #
    def range(range:)
      start_date = Western::Calendar.create(date: range[:start])
      last_date = Western::Calendar.create(date: range[:last])

      # TODO: condition で設定する
      context = Context.new(version_name: '')

      Calculation::Summary::Range.get(
        context: context, start_date: start_date, last_date: last_date
      )
    end
  end
end
