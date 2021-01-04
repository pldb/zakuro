# frozen_string_literal: true

require 'yaml'

# :nodoc:
module Zakuro
  #
  # Operation 運用
  #
  module Operation
    #
    # History 変更履歴
    #
    class History
      attr_reader :id, :reference, :western_date, :annotations, :diffs

      def initialize(id:, reference:, western_date:, diffs:, annotations: [])
        @id = id
        @reference = reference
        @western_date = western_date
        @annotations = annotations
        @diffs = diffs
      end
    end

    #
    # Annotation 注釈
    #
    class Annotation
      attr_reader :id, :description, :note

      def initialize(id: '', description: '', note: '')
        @id = id
        @description = description
        @note = note
      end

      def invalid?
        @id == ''
      end
    end

    #
    # Reference 参照
    #
    class Reference
      attr_reader :page, :number, :japan_date

      def initialize(page:, number:, japan_date:)
        @page = page
        @number = number
        @japan_date = japan_date
      end
    end

    #
    # Diffs 総差分
    #
    class Diffs
      attr_reader :month, :even_term, :day

      def initialize(month:, even_term:, day:)
        @month = month
        @even_term = even_term
        @day = day
      end
    end

    #
    # Month 月差分
    #
    class Month
      attr_reader :number, :leaped

      def initialize(number:, leaped:)
        @number = number
        @leaped = leaped
      end
    end

    #
    # Diff 差分
    #
    class Diff
      attr_reader :calc, :actual

      def initialize(calc:, actual:)
        @calc = calc
        @actual = actual
      end
    end

    #
    # MonthParser 月情報解析（yaml）
    #
    module MonthParser
      def self.run
        filepath = File.expand_path(
          './yaml/month.yaml',
          __dir__
        )
        hash = YAML.load_file(filepath)

        load(yaml_hash: hash)
      end

      def self.load(yaml_hash: {})
        # TODO: 変換処理、リファクタリング、バリデーション
        annotations = {}
        relations = {}
        histories = []
        yaml_hash.each do |month|
          id = month['id']
          annotations[id] = Annotation.new(id: id, description: month['description'],
                                           note: month['note'])
          relation_id = month['relation_id']

          relations[id] = relation_id unless relation_id == '-'

          reference = Reference.new(page: month['page'], number: month['number'],
                                    japan_date: month['japan_date'])

          next unless month['valid'] == 'true'

          yaml_diff = month['diff']
          yaml_month = yaml_diff['month']
          yaml_number = yaml_month['number']
          yaml_leaped = yaml_month['leaped']
          yaml_even_term = yaml_diff['even_term']

          diffs = Diffs.new(
            month: Month.new(
              number: Diff.new(calc: yaml_number['calc'], actual: yaml_number['actual']),
              leaped: Diff.new(calc: yaml_leaped['calc'], actual: yaml_leaped['actual'])
            ),
            even_term: Diff.new(calc: yaml_even_term['calc'], actual: yaml_even_term['actual']),
            day: yaml_month['day']
          )

          histories.push(
            History.new(id: id, reference: reference, western_date: month['western_date'],
                        diffs: diffs)
          )
        end

        add_annotations(histories: histories, annotations: annotations, relations: relations)
      end

      def self.add_annotations(histories: [], annotations: {}, relations: {})
        result = []
        histories.each do |history|
          history_annotations = []
          add_annotation(history_annotations: history_annotations,
                         annotations: annotations, id: history.id)
          add_annotation(history_annotations: history_annotations,
                         annotations: annotations, id: relations.fetch(history.id, ''))

          result.push(
            History.new(id: history.id, reference: history.reference,
                        western_date: history.western_date, annotations: history_annotations,
                        diffs: history.diffs)
          )
        end

        result
      end

      def self.add_annotation(history_annotations: [], annotations: {}, id: '')
        annotation = annotations.fetch(id, Annotation.new)
        history_annotations.push(annotation) unless annotation.invalid?
      end
    end
  end
end
