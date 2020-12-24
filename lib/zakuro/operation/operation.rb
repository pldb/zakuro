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

      def initialize(id:, reference:, western_date:, annotations:, diffs:)
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

      def initialize(id:, description:, note:)
        @id = id
        @description = description
        @note = note
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
    # Parser yaml解析
    #
    module Parser
      def self.load
        # TODO: 変換処理、リファクタリング
        filepath = File.expand_path(
          './yaml/month.yaml',
          __dir__
        )
        yaml = YAML.load_file(filepath)

        annotations = []
        yaml.each do |month|
          annotations.push(
            Annotation.new(id: month['id'], description: month['description'], note: note['note'])
          )

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

          History.new(id: month['id'], reference: reference, western_date: month['western_date'],
                      diffs: diffs)
        end
      end
    end
  end
end
