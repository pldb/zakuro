# frozen_string_literal: true

require_relative './version_factory'
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
      return VersionFactory.to_japan_date(western_date: date) if date

      # TODO: does not have no patterns now
      {}
    end
  end
end
