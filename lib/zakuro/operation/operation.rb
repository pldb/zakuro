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
    # Validator バリデーション
    #
    module Validator
      #
      # History 変更履歴
      #
      class History
        attr_reader :index, :id, :western_date, :modified

        def initialize(index:, yaml_hash: {})
          @index = index
          @id = yaml_hash['id']
          @western_date = yaml_hash['western_date']
          @modified = yaml_hash['modified']
        end

        def validate
          failed = []

          prefix = "#{@index}]. invalid"

          failed.push("#{prefix} 'id'. #{@id}") unless id?

          failed.push("#{prefix} 'western_date'. #{@western_date}") unless western_date?

          failed.push("#{prefix} 'modified'. #{@modified}") unless modified?

          failed
        end

        def id?
          !@id.nil? || !@id.empty? || @id.is_a?(String)
        end

        def western_date?
          Western::Calendar.valid_date_string(str: @western_date)
        end

        def modified?
          @modified == 'true' || @modified == 'false'
        end
      end

      #
      # Annotation 注釈
      #
      class Annotation
        attr_reader :index, :id, :description, :note

        def initialize(index:, yaml_hash: {})
          @index = index
          @id = yaml_hash['id']
          @description = yaml_hash['description']
          @note = yaml_hash['note']
        end

        def validate
          failed = []

          prefix = "#{@index}]. invalid"

          failed.push("#{prefix} 'id'. #{@id}") unless id?

          failed.push("#{prefix} 'description'. #{@description}") unless description?

          failed.push("#{prefix} 'note'. #{@note}") unless note?

          failed
        end

        def id?
          !@id.nil? || !@id.empty? || @id.is_a?(String)
        end

        def description?
          !@description.nil? || @description.is_a?(String)
        end

        def note?
          !@note.nil? || @note.is_a?(String)
        end
      end

      #
      # Reference 参照
      #
      class Reference
        attr_reader :index, :page, :number, :japan_date

        def initialize(index:, yaml_hash: {})
          @index = index
          @page = yaml_hash['page']
          @number = yaml_hash['number']
          @japan_date = yaml_hash['japan_date']
        end

        def validate
          failed = []

          prefix = "#{@index}]. invalid"

          failed.push("#{prefix} 'page'. #{@page}") unless page?

          failed.push("#{prefix} 'number'. #{@number}") unless number?

          failed.push("#{prefix} 'japan_date'. #{@japan_date}") unless japan_date?

          failed
        end

        def page?
          !@page.nil? || !@page.empty? || @page =~ /^[0-9]+$/
        end

        def number?
          !@number.nil? || !@number.empty? || @number =~ /^[0-9]+$/
        end

        def japan_date?
          !@japan_date.nil? || @japan_date.is_a?(String)
        end
      end

      #
      # Diffs 総差分
      #
      class Diffs
        attr_reader :month, :even_term, :day

        def initialize(yaml_hash: {})
          @month = Month.new(yaml_hash: yaml_hash['month'])
          @even_term = Diff.new(yaml_hash: yaml_hash['even_term'])
          @day = yaml_hash['day']
        end
      end

      #
      # Month 月
      #
      class Month
        attr_reader :number, :leaped

        def initialize(yaml_hash: {})
          @number = Diff.new(yaml_hash: yaml_hash['number'])
          @leaped = Diff.new(yaml_hash: yaml_hash['leaped'])
        end
      end

      #
      # Diff 差分
      #
      class Diff
        attr_reader :calc, :actual

        def initialize(yaml_hash: {})
          @calc = yaml_hash['calc']
          @actual = yaml_hash['actual']
        end
      end

      def self.run(yaml_hash: {})
        failed = []
        yaml_hash.each_with_index do |history, index|
          failed += History.new(index: index, yaml_hash: history).validate
          # TODO: 他クラス
        end

        failed
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

        failed = Validator.run(yaml_hash: hash)

        raise YAML::ParseError, failed.join('\n') unless failed.empty?

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

          next unless month['modified'] == 'true'

          history = create_history(yaml_hash: month)
          result.push(history)
        end

        result
      end

      def self.create_history(yaml_hash: {})
        diffs = create_diffs(yaml_hash: yaml_hash['diff'])

        History.new(id: yaml_hash['id'],
                    reference: Reference.new(page: yaml_hash['page'].to_i,
                                             number: yaml_hash['number'].to_i,
                                             japan_date: yaml_hash['japan_date']),
                    western_date: Western::Calendar.parse(str: yaml_hash['western_date']),
                    diffs: diffs)
      end

      def self.create_diffs(yaml_hash: {})
        month = yaml_hash['month']
        number = month['number']
        leaped = month['leaped']
        even_term = yaml_hash['even_term']

        Diffs.new(
          month: Month.new(
            number: Diff.new(calc: parse_month_number(str: number['calc']),
                             actual: parse_month_number(str: number['actual'])),
            leaped: Diff.new(calc: parse_month_leaped(str: leaped['calc']),
                             actual: parse_month_leaped(str: leaped['actual']))
          ),
          even_term: Diff.new(calc: even_term['calc'], actual: even_term['actual']),
          day: month['day']
        )
      end

      def self.parse_month_number(str:)
        return -1 if str == '-'

        str.to_i
      end

      def self.parse_month_leaped(str:)
        str == 'true'
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
