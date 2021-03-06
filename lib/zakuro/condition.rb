# frozen_string_literal: true

require 'date'

# :nodoc:
module Zakuro
  #
  # Catalog 目録
  #
  module Catalog
    #
    # BasisDate 基準日
    #
    class BasisDate
      # @return [Date] 西暦日
      attr_reader :date

      #
      # 初期化
      #
      # @param [Date] date 西暦日
      #
      def initialize(date:)
        # TODO: 和暦日（String）から西暦日（Date）への変換
        @date = date
      end

      #
      # 検証する
      #
      # @param [Date] date 日付
      #
      # @return [Array<String>] エラーメッセージ
      #
      def self.validate(date:)
        failed = []
        return failed unless date

        return failed if date.is_a?(Date) || date.is_a?(String)

        failed.push("invalid date: #{date}")
        failed
      end
    end

    #
    # Range 範囲（開始日-終了日）
    #
    class Range
      # @return [Date] 開始日
      attr_reader :start
      # @return [Date] 終了日
      attr_reader :last

      #
      # 初期化
      #
      # @param [Hash<Symbol>] hash パラメータ
      # @option hash [Symbol] :start 開始日
      # @option hash [Symbol] :start 終了日
      #
      def initialize(hash: {})
        @start = hash[:start]
        @last = hash[:last]
      end

      # :reek:TooManyStatements { max_statements: 7 }

      #
      # 検証する
      #
      # @param [Hash<Symbol>] hash パラメータ
      #
      # @return [Array<String>] エラーメッセージ
      #
      def self.validate(hash:)
        failed = []
        return failed unless hash

        unless hash.is_a?(Hash)
          failed.push("invalid range type. #{hash}. should be hash")
          return failed
        end

        failed.concat(BasisDate.validate(date: hash[:start]))
        failed.concat(BasisDate.validate(date: hash[:last]))

        failed
      end
    end

    #
    # Columns 特定の列（フィールド）
    # @note 指定された列のみ出力する
    #
    class Columns
      # @return [Array<String>] 列
      attr_reader :columns

      #
      # 初期化
      #
      # @param [Array<String>] columns 列
      #
      def initialize(columns: [])
        @columns = columns
      end

      #
      # 検証する
      #
      # @param [Array<String>] columns 列
      #
      # @return [Array<String>] エラーメッセージ
      #
      def self.validate(columns:)
        # TODO: 列内容のバリデーション
        failed = []

        return failed unless columns

        return failed if columns.is_a?(Array)

        failed.push("invalid columns type. #{columns}. should be array")

        failed
      end
    end

    #
    # Options オプション
    # 取得内容を変更する
    #
    #   * unit: 年/月/日
    #   * lost_days: 没日あり
    #   * seasons: 四季あり
    #
    class Options
      # @return [Array<String>] オプション
      attr_reader :options

      #
      # 初期化
      #
      # @param [Array<String>] options オプション
      #
      def initialize(options: [])
        @options = options
      end

      # TODO: オプションキーのバリデーション

      #
      # 検証する
      #
      # @param [Array<String>] options オプション
      #
      # @return [Array<String>] エラーメッセージ
      #
      def self.validate(options:)
        failed = []
        return failed unless options

        return failed if options.is_a?(Hash)

        failed.push("invalid options type. #{options}. should be hash")

        failed
      end
    end
  end

  #
  # Condition 条件
  #
  class Condition
    # @return [Date] 基準日
    attr_reader :date
    # @return [Hash<Symbol, Date>] 範囲
    attr_reader :range
    # @return [Array<String>] 列
    attr_reader :columns
    # @return [Array<String>] オプション
    attr_reader :options

    #
    # 初期化
    #
    # @param [Hash<Symbol, Object>] hash パラメータ
    # @option hash [Date] :date 基準日
    # @option hash [Hash<Symbol, Date>] :range 範囲
    # @option hash [Array<String>] :columns 列
    # @option hash [Array<String>] :options オプション
    #
    def initialize(hash: {})
      @date = hash[:date]
      @range = hash[:range]
      @columns = hash[:columns]
      @options = hash[:options]
    end

    # :reek:TooManyStatements { max_statements: 8 }

    #
    # 検証する
    #
    # @param [Hash<Symbol, Object>] hash パラメータ
    #
    # @return [Array<String>] エラーメッセージ
    #
    def self.validate(hash:)
      failed = []

      unless hash.is_a?(Hash)
        failed.push("invalid condition type. #{hash}. should be hash")
        return failed
      end

      failed.concat(Catalog::BasisDate.validate(date: hash[:date]))
      failed.concat(Catalog::Range.validate(hash: hash[:range]))
      failed.concat(Catalog::Columns.validate(columns: hash[:columns]))
      failed.concat(Catalog::Options.validate(options: hash[:options]))

      failed
    end

    #
    # 上書きする
    #
    # @param [Hash<Symbol, Object>] hash パラメータ
    #
    def rewrite(hash: {})
      instance_variables.each do |var|
        key = var.to_s.delete('@')
        val = hash[key.intern]

        next unless val

        instance_variable_set(var, val)
      end
    end
  end
end
