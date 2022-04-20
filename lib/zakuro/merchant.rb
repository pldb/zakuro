# frozen_string_literal: true

require_relative './gateway/single'

require_relative './gateway/range'

require_relative './condition'

require_relative './exception/exception'

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
      raise Exception.get(presets: failed) unless failed.empty?

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
      raise Exception.get(presets: failed) unless failed.empty?

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
      # TODO: condition で設定する
      context = Context.new(version_name: '')

      single = Gateway::Single.new(context: context, date: condition.date)

      return single.get unless single.invalid?

      range = Gateway::Range.new(context: context, range: condition.range)

      return range.get unless range.invalid?

      {}
    end
  end
end
