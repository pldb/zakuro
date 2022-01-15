# frozen_string_literal: true

require_relative './era/western/calendar'

require_relative './calculation/summary/single'

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
    #
    def commit
      date = condition.date

      # TODO: does not have no patterns now
      return {} unless date

      western_date = Western::Calendar.create(date: date)

      # TODO: 引数不要
      context = Context.new(version_name: '')

      Calculation::Summary::Single.get(context: context, date: western_date)
    end
  end
end
