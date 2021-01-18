# frozen_string_literal: true

require 'yaml'
require_relative '../../era/western'

# :nodoc:
module Zakuro
  #
  # Operation 運用
  #
  module Operation
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

          prefix = "[#{@index}] invalid"

          failed.push("#{prefix} 'id'. #{@id}") unless id?

          failed.push("#{prefix} 'western_date'. #{@western_date}") unless western_date?

          failed.push("#{prefix} 'modified'. #{@modified}") unless modified?

          failed
        end

        def id?
          !@id.nil? && !@id.empty? && @id.is_a?(String)
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

          prefix = "[#{@index}] invalid"

          failed.push("#{prefix} 'id'. #{@id}") unless id?

          failed.push("#{prefix} 'description'. #{@description}") unless description?

          failed.push("#{prefix} 'note'. #{@note}") unless note?

          failed
        end

        def id?
          !@id.nil? && !@id.empty? && @id.is_a?(String)
        end

        def description?
          !@description.nil? && @description.is_a?(String)
        end

        def note?
          !@note.nil? && @note.is_a?(String)
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

          prefix = "[#{@index}] invalid"

          failed.push("#{prefix} 'page'. #{@page}") unless page?

          failed.push("#{prefix} 'number'. #{@number}") unless number?

          failed.push("#{prefix} 'japan_date'. #{@japan_date}") unless japan_date?

          failed
        end

        def page?
          return true if @page == '-'

          !@page.nil? && !@page.empty? && @page =~ /^[0-9]+$/
        end

        def number?
          return true if @number == '-'

          !@number.nil? && !@number.empty? && @number =~ /^[0-9]+$/
        end

        def japan_date?
          !@japan_date.nil? && @japan_date.is_a?(String)
        end
      end

      #
      # Diffs 総差分
      #
      class Diffs
        attr_reader :index, :month, :even_term, :day

        def initialize(index:, yaml_hash: {})
          @index = index
          @month = Month.new(index: index, yaml_hash: yaml_hash['month'])
          @even_term = EvenTerm.new(index: index, yaml_hash: yaml_hash['even_term'])
          @day = yaml_hash['day']
        end

        def validate
          failed = []

          prefix = "[#{@index}] invalid"

          failed += @month.validate

          failed += @even_term.validate

          failed.push("#{prefix} 'day'. #{@day}") unless day?

          failed
        end

        def day?
          return true if @day == '-'

          !@day.nil? && !@day.empty? && @day =~ /^-?[0-9]+$/
        end
      end

      #
      # Month 月
      #
      class Month
        attr_reader :index, :number, :leaped

        def initialize(index:, yaml_hash: {})
          @index = index
          @number = Number.new(index: index, yaml_hash: yaml_hash['number'])
          @leaped = Leaped.new(index: index, yaml_hash: yaml_hash['leaped'])
        end

        def validate
          failed = []

          failed += @number.validate

          failed += @leaped.validate

          failed
        end
      end

      #
      # EvenTerm 中気
      #
      class EvenTerm
        attr_reader :index, :name, :to, :day

        def initialize(index:, yaml_hash: {})
          @index = index
          @name = 'even_term'
          @to = yaml_hash['to']
          @day = yaml_hash['day']
        end

        def validate
          failed = []

          prefix = "[#{@index}][#{@name}] invalid"

          failed.push("#{prefix} 'to'. #{@to}") unless to?

          failed.push("#{prefix} 'day'. #{@day}") unless day?

          failed
        end

        def to?
          Western::Calendar.valid_date_string(str: @to)
        end

        def day?
          return true if @day == '-'

          !@day.nil? && !@day.empty? && @day =~ /^-?[0-9]+$/
        end
      end

      #
      # Number 月
      #
      class Number
        attr_reader :index, :name, :calc, :actual

        def initialize(index:, yaml_hash: {})
          @index = index
          @name = 'number'
          @calc = yaml_hash['calc']
          @actual = yaml_hash['actual']
        end

        def validate
          failed = []

          prefix = "[#{@index}][#{@name}] invalid"

          failed.push("#{prefix} 'calc'. #{@calc}") unless calc?

          failed.push("#{prefix} 'actual'. #{@actual}") unless actual?

          failed
        end

        def calc?
          return true if @calc == '-'

          !@calc.nil? && !@calc.empty? && @calc =~ /^-?[0-9]+$/
        end

        def actual?
          return true if @calc == '-'

          !@actual.nil? && !@actual.empty? && @actual =~ /^-?[0-9]+$/
        end
      end

      #
      # Leaped 閏有無
      #
      class Leaped
        attr_reader :index, :name, :calc, :actual

        def initialize(index:, yaml_hash: {})
          @index = index
          @name = 'leaped'
          @calc = yaml_hash['calc']
          @actual = yaml_hash['actual']
        end

        def validate
          failed = []

          prefix = "[#{@index}][#{@name}] invalid"

          failed.push("#{prefix} 'calc'. #{@calc}") unless calc?

          failed.push("#{prefix} 'actual'. #{@actual}") unless actual?

          failed
        end

        def calc?
          return true if @calc == '-'

          @calc == 'true' || @calc == 'false'
        end

        def actual?
          return true if @actual == '-'

          @actual == 'true' || @actual == 'false'
        end
      end

      def self.run(yaml_hash: {})
        failed = []
        yaml_hash.each_with_index do |history, index|
          failed += History.new(index: index, yaml_hash: history).validate
          failed += Annotation.new(index: index, yaml_hash: history).validate
          failed += Reference.new(index: index, yaml_hash: history).validate
          failed += Diffs.new(index: index, yaml_hash: history['diffs']).validate
        end

        failed
      end
    end
  end
end
