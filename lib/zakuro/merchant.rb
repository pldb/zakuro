# frozen_string_literal: true

require_relative './gateway/single'

require_relative './gateway/range'

require_relative './condition'

require_relative './exception/exception'

require_relative './calculation/type/optional'

# :nodoc:
module Zakuro
  #
  # Merchant ざくろ商人
  #   東西の暦を取引する、素敵な笑顔の持ち主
  #
  class Merchant
    # @return [Output::Logger] ロガー
    LOGGER = Output::Logger.new(location: Merchant)
    # @return [Hash<Symbol, Object>] 条件
    attr_reader :condition

    #
    # 初期化
    #
    # @param [Hash<Symbol, Object>] condition 条件
    #
    # @raise [Exception::ZakuroError] ライブラリ内エラー
    #
    def initialize(condition: {})
      failed = Condition.validate(hash: condition)
      raise Exception.get(presets: failed) unless failed.empty?

      @condition = Condition.new(hash: condition)
    rescue Exception::ZakuroError => e
      raise e
    rescue StandardError => e
      make_internal_error(error: e)
    end

    #
    # 条件提示する
    #
    # @param [Hash<Symbol, Object>] condition 条件
    #
    # @return [Merchant] 自インスタンス
    #
    # @raise [Exception::ZakuroError] ライブラリ内エラー
    #
    def offer(condition: {})
      failed = Condition.validate(hash: condition)
      raise Exception.get(presets: failed) unless failed.empty?

      @condition.rewrite(hash: condition)

      self
    rescue Exception::ZakuroError => e
      raise e
    rescue StandardError => e
      make_internal_error(error: e)
    end

    #
    # 承諾する
    #
    # @return [Result::SingleDay] 和暦日
    # @return [Result::Range] 和暦日範囲
    #
    # @raise [Exception::ZakuroError] ライブラリ内エラー
    #
    def commit
      # TODO: condition で設定する
      context = Context.new(version_name: '')

      result = get(context: context)

      return result.get unless result.invalid?

      make_uncommitable_error
    rescue Exception::ZakuroError => e
      raise e
    rescue StandardError => e
      make_internal_error(error: e)
    end

    private

    #
    # 結果取得する
    #
    # @param [Context] context 暦コンテキスト
    #
    # @return [Calculation::Type::Optional] 参照
    #
    def get(context:)
      single = Gateway::Single.new(context: context, date: condition.date)

      return Calculation::Type::Optional.new(obj: single.get) unless single.invalid?

      range = Gateway::Range.new(context: context, range: condition.range)

      return Calculation::Type::Optional.new(obj: range.get) unless range.invalid?

      Calculation::Type::Optional.new
    end

    #
    # 内部エラーを生成する
    #
    # @param [StandardError] error 内部エラー
    #
    # @raise [Exception::ZakuroError] ライブラリ内エラー
    #
    def make_internal_error(error:)
      LOGGER.error(error)
      presets = [
        Exception::Case::Preset.new(
          template: Exception::Case::Pattern::INTERNAL_ERROR
        )
      ]
      raise Exception.get(presets: presets)
    end

    #
    # 内部エラーを生成する
    #
    # @raise [Exception::ZakuroError] ライブラリ内エラー
    #
    def make_uncommitable_error
      raise Exception.get(
        presets: [
          Exception::Case::Preset.new(
            template: Exception::Case::Pattern::UNCOMMITTABLE_DATE
          )
        ]
      )
    end
  end
end
