# frozen_string_literal: true

require 'yaml'
require_relative '../../era/western'
require_relative './validator'
require_relative './type'

# :nodoc:
module Zakuro
  #
  # Operation 運用
  #
  module Operation
    #
    # TypeParser 型ごと変換
    #
    module TypeParser
      #
      # 無効値かを判定する
      #
      # @param [String] str 文字列
      #
      # @return [True] 無効値
      # @return [False] 有効値
      #
      def self.invalid?(str:)
        str == '-'
      end

      def self.text(str:)
        return '' if invalid?(str: str)

        str
      end

      #
      # 有効行を変換する
      #
      # @param [String] str 文字列
      #
      # @return [True] 有効
      # @return [False] 無効
      #
      def self.modified?(str:)
        str == 'true'
      end

      #
      # 月を変換する
      #
      # @param [String] str 文字列
      #
      # @return [Integer] 月
      #
      def self.month_number(str:)
        return -1 if invalid?(str: str)

        str.to_i
      end

      #
      # 閏有無を変換する
      #
      # @param [String] str 文字列
      #
      # @return [True] 閏あり
      # @return [True] 閏なし/閏設定なし
      #
      def self.month_leaped(str:)
        str == 'true'
      end

      #
      # 西暦日を変換する
      #
      # @param [String] str 文字列
      #
      # @return [Western::Calendar] 西暦日
      #
      def self.western_date(str:)
        return Western::Calendar.new if invalid?(str: str)

        Western::Calendar.parse(str: str)
      end

      #
      # 日（差分）を変換する
      #
      # @param [String] str 文字列
      #
      # @return [Integer] 日（差分）
      #
      def self.days(str:)
        return INVALID_DAY_VALUE if invalid?(str: str)

        str.to_i
      end

      def self.solar_term_index(str:)
        return -1 if invalid?(str: str)

        str.to_i
      end
    end

    #
    # MonthParser 月情報解析（yaml）
    #
    module MonthParser
      #
      # 実行する
      #
      # @return [Array<MonthHistory>] 変更履歴
      #
      def self.run(filepath:)
        hash = YAML.load_file(filepath)

        failed = Validator.run(yaml_hash: hash)

        raise ArgumentError, failed.join("\n") unless failed.empty?

        load(yaml_hash: hash)
      end

      #
      # 設定ファイルを読み込む
      #
      # @param [Hash] yaml_hash 設定ファイルテキスト
      #
      # @return [Array<MonthHistory>] 変更履歴
      #
      def self.load(yaml_hash: {})
        annotations = {}
        relations = {}
        histories = create_histories(yaml_hash: yaml_hash, annotations: annotations,
                                     relations: relations)

        add_annotations(histories: histories, annotations: annotations, relations: relations)
      end

      #
      # 変更履歴を読み込む
      #
      # @param [Hash] yaml_hash 設定ファイルテキスト
      # @param [Hash] annotations 注釈（空）
      # @param [Hash] relations 関連ID設定（空）
      #
      # @return [Array<MonthHistory>] 変更履歴
      #
      def self.create_histories(yaml_hash: {}, annotations: {}, relations: {})
        result = []
        yaml_hash.each do |month|
          id = month['id']
          annotations[id] = Annotation.new(
            id: id,
            description: Operation::TypeParser.text(str: month['description']),
            note: Operation::TypeParser.text(str: month['note'])
          )
          relation_id = month['relation_id']

          relations[id] = relation_id unless Operation::TypeParser.invalid?(str: relation_id)

          next unless Operation::TypeParser.modified?(str: month['modified'])

          history = create_history(yaml_hash: month)
          result.push(history)
        end

        result
      end
      private_class_method :create_histories

      def self.create_history(yaml_hash: {})
        diffs = create_diffs(yaml_hash: yaml_hash['diffs'])

        western_date = Operation::TypeParser.western_date(str: yaml_hash['western_date'])
        MonthHistory.new(id: yaml_hash['id'],
                         reference: Reference.new(page: yaml_hash['page'].to_i,
                                                  number: yaml_hash['number'].to_i,
                                                  japan_date: yaml_hash['japan_date']),
                         western_date: western_date,
                         diffs: diffs)
      end
      private_class_method :create_history

      def self.create_diffs(yaml_hash: {})
        Diffs.new(
          month: create_month(yaml_hash: yaml_hash['month']),
          solar_term: create_solar_term(yaml_hash: yaml_hash['solar_term']),
          days: Operation::TypeParser.days(str: yaml_hash['days'])
        )
      end
      private_class_method :create_diffs

      def self.create_solar_term(yaml_hash: {})
        calc = yaml_hash['calc']
        actual = yaml_hash['actual']

        source = SolarTerm::Source.new(
          index: Operation::TypeParser.solar_term_index(str: calc['index']),
          to: Operation::TypeParser.western_date(str: calc['to']),
          zodiac_name: Operation::TypeParser.text(str: calc['zodiac_name'])
        )
        destination = SolarTerm::Destination.new(
          index: Operation::TypeParser.solar_term_index(str: actual['index']),
          from: Operation::TypeParser.western_date(str: actual['from']),
          zodiac_name: Operation::TypeParser.text(str: actual['zodiac_name'])
        )

        SolarTerm::Direction.new(
          source: source, destination: destination,
          days: Operation::TypeParser.days(str: yaml_hash['days'])
        )
      end

      def self.create_month(yaml_hash: {})
        number = yaml_hash['number']
        leaped = yaml_hash['leaped']

        Month.new(
          number: Number.new(calc: Operation::TypeParser.month_number(str: number['calc']),
                             actual: Operation::TypeParser.month_number(str: number['actual'])),
          leaped: Leaped.new(calc: Operation::TypeParser.month_leaped(str: leaped['calc']),
                             actual: Operation::TypeParser.month_leaped(str: leaped['actual']))
        )
      end
      private_class_method :create_month

      def self.add_annotations(histories: [], annotations: {}, relations: {})
        result = []
        histories.each do |history|
          history_annotations = []
          [history.id, relations.fetch(history.id, '')].each do |history_id|
            add_annotation(history_annotations: history_annotations,
                           annotations: annotations, id: history_id)
          end

          result.push(
            MonthHistory.new(
              id: history.id, reference: history.reference, western_date: history.western_date,
              annotations: history_annotations, diffs: history.diffs
            )
          )
        end

        result
      end
      private_class_method :add_annotations

      def self.add_annotation(history_annotations: [], annotations: {}, id: '')
        annotation = annotations.fetch(id, Annotation.new)
        history_annotations.push(annotation) unless annotation.invalid?
      end
      private_class_method :add_annotation
    end
  end
end
