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
        # TODO: バリデーション
        annotations = {}
        relations = {}
        histories = create_histories(yaml_hash: yaml_hash, annotations: annotations,
                                     relations: relations)

        add_annotations(histories: histories, annotations: annotations, relations: relations)
      end

      def self.create_histories(yaml_hash: {}, annotations: {}, relations: {})
        result = []
        yaml_hash.each do |month|
          id = month['id']
          annotations[id] = Annotation.new(id: id, description: month['description'],
                                           note: month['note'])
          relation_id = month['relation_id']

          relations[id] = relation_id unless relation_id == '-'

          next unless month['valid'] == 'true'

          history = create_history(yaml_hash: month)
          result.push(history)
        end

        result
      end

      def self.create_history(yaml_hash: {})
        diffs = create_diffs(yaml_hash: yaml_hash['diff'])

        History.new(id: yaml_hash['id'],
                    reference: Reference.new(page: yaml_hash['page'], number: yaml_hash['number'],
                                             japan_date: yaml_hash['japan_date']),
                    western_date: yaml_hash['western_date'],
                    diffs: diffs)
      end

      def self.create_diffs(yaml_hash: {})
        month = yaml_hash['month']
        number = month['number']
        leaped = month['leaped']
        even_term = yaml_hash['even_term']

        Diffs.new(
          month: Month.new(
            number: Diff.new(calc: number['calc'], actual: number['actual']),
            leaped: Diff.new(calc: leaped['calc'], actual: leaped['actual'])
          ),
          even_term: Diff.new(calc: even_term['calc'], actual: even_term['actual']),
          day: month['day']
        )
      end

      def self.add_annotations(histories: [], annotations: {}, relations: {})
        result = []
        histories.each do |history|
          history_annotations = []
          [history.id, relations.fetch(history.id, '')].each do |history_id|
            add_annotation(history_annotations: history_annotations,
                           annotations: annotations, id: history_id)
          end

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
