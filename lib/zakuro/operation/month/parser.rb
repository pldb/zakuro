# frozen_string_literal: true

require 'yaml'
require_relative '../../era/western/calendar'
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

        Western::Calendar.parse(text: str)
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
        histories = create_histories(yaml_hash: yaml_hash)

        annotation_parser = AnnotationParser.new(yaml_hash: yaml_hash)
        annotation_parser.create

        add_annotations(histories: histories, annotation_parser: annotation_parser)
      end

      #
      # 変更履歴を読み込む
      #
      # @param [Hash] yaml_hash 設定ファイルテキスト
      #
      # @return [Array<MonthHistory>] 変更履歴
      #
      def self.create_histories(yaml_hash: {})
        result = []
        yaml_hash.each do |month|
          next unless Operation::TypeParser.modified?(str: month['modified'])

          result.push(
            create_history(yaml_hash: month)
          )
        end
        result
      end
      private_class_method :create_histories

      def self.create_history(yaml_hash: {})
        diffs = MonthDiffsParser.create(yaml_hash: yaml_hash['diffs'])

        western_date = Operation::TypeParser.western_date(str: yaml_hash['western_date'])
        reference = Reference.new(page: yaml_hash['page'].to_i, number: yaml_hash['number'].to_i,
                                  japan_date: yaml_hash['japan_date'])
        MonthHistory.new(id: yaml_hash['id'],
                         parent_id: Operation::TypeParser.text(str: yaml_hash['parent_id']),
                         reference: reference,
                         western_date: western_date,
                         diffs: diffs)
      end
      private_class_method :create_history

      def self.add_annotations(annotation_parser:, histories: [])
        result = []
        histories.each do |history|
          id = history.id
          result.push(
            MonthHistory.new(
              id: id, parent_id: history.parent_id, reference: history.reference,
              western_date: history.western_date,
              annotations: annotation_parser.specify(id: id),
              diffs: history.diffs
            )
          )
        end

        result
      end
      private_class_method :add_annotations

      def self.create_history_annnotations(history:, annotations: {}, relations: {})
        history_id = history.id
        history_annotations = []
        [history_id, relations.fetch(history_id, '')].each do |id|
          add_annotation(history_annotations: history_annotations,
                         annotations: annotations, id: id)
        end

        history_annotations
      end

      def self.add_annotation(history_annotations: [], annotations: {}, id: '')
        annotation = annotations.fetch(id, Annotation.new)
        return if annotation.invalid?

        history_annotations.push(annotation)
      end
      private_class_method :add_annotation
    end

    #
    # AnnotationParser 注釈解析
    #
    class AnnotationParser
      # @return [Hash<String, Annotation>] 注釈
      attr_reader :annotations
      # @return [Hash<String, String>] 関連注釈の対応関係
      attr_reader :relations

      #
      # 初期化
      #
      # @param [Hash] yaml_hash 設定ファイルテキスト
      #
      def initialize(yaml_hash: {})
        @annotations = {}
        @relations = {}
        @yaml_hash = yaml_hash
      end

      #
      # 注釈を生成する
      #
      def create
        @yaml_hash.each do |month|
          AnnotationParser.resolve_history(
            hash: month, annotations: @annotations, relations: @relations
          )
        end
      end

      #
      # 月別履歴情報から注釈情報を取り出す
      #
      # @param [<Type>] hash 月別履歴情報yaml
      # @param [Hash<String, Annotation>] annotations 注釈
      # @param [Hash<String, String>] relations 関連注釈の対応関係
      #
      def self.resolve_history(hash: {}, annotations: {}, relations: {})
        id = hash['id']
        annotations[id] = Annotation.new(
          id: id,
          description: Operation::TypeParser.text(str: hash['description']),
          note: Operation::TypeParser.text(str: hash['note'])
        )
        relation_id = hash['relation_id']

        return if Operation::TypeParser.invalid?(str: relation_id)

        relations[id] = relation_id
      end

      #
      # 注釈を特定する
      #
      # @param [String] id ID
      #
      # @return [Array<Annotation>] 注釈
      #
      def specify(id: '')
        ids = [id, relations.fetch(id, '')]
        specify_by_ids(ids: ids)
      end

      private

      def specify_by_ids(ids: [])
        annotations = []
        ids.each do |id|
          add_annotation(id: id, annotations: annotations)
        end

        annotations
      end

      def add_annotation(id: '', annotations: [])
        annotation = annotation(id: id)
        return if annotation.invalid?

        annotations.push(annotation)
      end

      def annotation(id: '')
        @annotations.fetch(id, Annotation.new)
      end
    end

    #
    # MonthDiffsParser 月情報（差分）解析
    #
    module MonthDiffsParser
      def self.create(yaml_hash: {})
        Diffs.new(
          month: create_month(yaml_hash: yaml_hash['month']),
          solar_term: create_solar_term(yaml_hash: yaml_hash['solar_term']),
          days: Operation::TypeParser.days(str: yaml_hash['days'])
        )
      end

      def self.create_solar_term(yaml_hash: {})
        SolarTerm::Direction.new(
          source: create_source_solar_term(yaml_hash: yaml_hash['calc']),
          destination: create_destination_solar_term(yaml_hash: yaml_hash['actual']),
          days: Operation::TypeParser.days(str: yaml_hash['days'])
        )
      end
      private_class_method :create_solar_term

      def self.create_source_solar_term(yaml_hash: {})
        SolarTerm::Source.new(
          index: Operation::TypeParser.solar_term_index(str: yaml_hash['index']),
          to: Operation::TypeParser.western_date(str: yaml_hash['to']),
          zodiac_name: Operation::TypeParser.text(str: yaml_hash['zodiac_name'])
        )
      end
      private_class_method :create_source_solar_term

      def self.create_destination_solar_term(yaml_hash: {})
        SolarTerm::Destination.new(
          index: Operation::TypeParser.solar_term_index(str: yaml_hash['index']),
          from: Operation::TypeParser.western_date(str: yaml_hash['from']),
          zodiac_name: Operation::TypeParser.text(str: yaml_hash['zodiac_name'])
        )
      end
      private_class_method :create_destination_solar_term

      def self.create_month(yaml_hash: {})
        Month.new(
          number: create_month_number(yaml_hash: yaml_hash['number']),
          leaped: create_month_leaped(yaml_hash: yaml_hash['leaped']),
          is_many_days: create_month_day(yaml_hash: yaml_hash['days'])
        )
      end
      private_class_method :create_month

      def self.create_month_number(yaml_hash: {})
        Number.new(
          calc: Operation::TypeParser.month_number(str: yaml_hash['calc']),
          actual: Operation::TypeParser.month_number(str: yaml_hash['actual'])
        )
      end
      private_class_method :create_month_number

      def self.create_month_leaped(yaml_hash: {})
        Leaped.new(
          calc: Operation::TypeParser.month_leaped(str: yaml_hash['calc']),
          actual: Operation::TypeParser.month_leaped(str: yaml_hash['actual'])
        )
      end
      private_class_method :create_month_leaped

      def self.create_month_day(yaml_hash: {})
        Days.new(
          calc: yaml_hash['calc'],
          actual: yaml_hash['actual']
        )
      end
      private_class_method :create_month_day
    end
  end
end
