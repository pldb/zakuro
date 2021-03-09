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
      # Types 型判定
      #
      module Types
        EMPTY_STRING = '-'
        BOOLEANS = %w[true false].freeze

        # :reek:NilCheck

        def self.string?(str: '')
          !str.nil? && !str.empty? && str.is_a?(String)
        end

        # :reek:NilCheck

        def self.empiable_string?(str: '')
          !str.nil? && str.is_a?(String)
        end

        # :reek:NilCheck

        def self.positive?(str: '')
          return true if str == EMPTY_STRING

          !str.nil? && !str.empty? && str =~ /^[0-9]+$/
        end

        # :reek:NilCheck

        def self.num?(str: '')
          return true if str == EMPTY_STRING

          !str.nil? && !str.empty? && str =~ /^[-0-9]+$/
        end

        def self.bool?(str: '')
          BOOLEANS.include?(str)
        end

        def self.empiable_bool?(str: '')
          return true if str == EMPTY_STRING

          bool?(str: str)
        end

        def self.western_date?(str: '')
          return Western::Calendar.new if str == EMPTY_STRING

          Western::Calendar.valid_date_string(str: str)
        end
      end
      #
      # MonthHistory 変更履歴
      #
      class MonthHistory
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
          Types.string?(str: @id)
        end

        def western_date?
          Types.western_date?(str: @western_date)
        end

        def modified?
          Types.bool?(str: @modified)
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
          Types.string?(str: @id)
        end

        def description?
          Types.empiable_string?(str: @description)
        end

        def note?
          Types.string?(str: @note)
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
          Types.positive?(str: @page)
        end

        def number?
          Types.positive?(str: @number)
        end

        def japan_date?
          Types.string?(str: @japan_date)
        end
      end

      #
      # Diffs 総差分
      #
      class Diffs
        attr_reader :index, :month, :solar_term, :days

        def initialize(index:, yaml_hash: {})
          @index = index
          @month = Month.new(index: index, yaml_hash: yaml_hash['month'])
          @solar_term = SolarTerm::Direction.new(index: index, yaml_hash: yaml_hash['solar_term'])
          @days = yaml_hash['days']
        end

        def validate
          failed = []

          prefix = "[#{@index}] invalid"

          failed += @month.validate

          failed += @solar_term.validate

          failed.push("#{prefix} 'days'. #{@days}") unless days?

          failed
        end

        def days?
          Types.num?(str: @days)
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

      module SolarTerm
        #
        # Direction 二十四節気（移動）
        #
        class Direction
          attr_reader :index, :source, :destination, :days
          #
          # 初期化
          #
          # @param [Source] source 二十四節気（移動元）
          # @param [Destination] destination 二十四節気（移動先）
          # @param [Integer] day 大余差分
          #
          def initialize(index:, yaml_hash: {})
            @index = index
            @source = Source.new(diff_index: index, yaml_hash: yaml_hash['calc'])
            @destination = Destination.new(diff_index: index, yaml_hash: yaml_hash['actual'])
            @days = yaml_hash['days']
          end

          def days?
            Types.positive?(str: @days)
          end

          def validate
            failed = []

            prefix = "[#{index}][solar_term] invalid"

            failed += @source.validate

            failed += @destination.validate

            failed.push("#{prefix} 'days'. #{@days}") unless days?

            failed
          end
        end

        #
        # Source 二十四節気（移動元）
        #
        class Source
          attr_reader :diff_index, :index, :to, :zodiac_name

          def initialize(diff_index:, yaml_hash: {})
            @diff_index = diff_index
            @index = yaml_hash['index']
            @to = yaml_hash['to']
            @zodiac_name = yaml_hash['zodiac_name']
          end

          def validate
            failed = []

            prefix = "[#{@diff_index}][solar_term.calc] invalid"

            failed.push("#{prefix} 'index'. #{@index}") unless index?

            failed.push("#{prefix} 'to'. #{@to}") unless to?

            failed.push("#{prefix} 'zodiac_name'. #{@zodiac_name}") unless zodiac_name?

            failed
          end

          def index?
            Types.positive?(str: @index)
          end

          def to?
            Types.western_date?(str: @to)
          end

          def zodiac_name?
            Types.string?(str: @zodiac_name)
          end
        end

        #
        # Destination 二十四節気（移動先）
        #
        class Destination
          attr_reader :diff_index, :index, :from, :zodiac_name

          def initialize(diff_index:, yaml_hash: {})
            @diff_index = diff_index
            @index = yaml_hash['index']
            @from = yaml_hash['from']
            @zodiac_name = yaml_hash['zodiac_name']
          end

          def validate
            failed = []

            prefix = "[#{@diff_index}][solar_term.actual] invalid"

            failed.push("#{prefix} 'index'. #{@index}") unless index?

            failed.push("#{prefix} 'from'. #{@from}") unless from?

            failed.push("#{prefix} 'zodiac_name'. #{@zodiac_name}") unless zodiac_name?

            failed
          end

          def index?
            Types.positive?(str: @index)
          end

          def from?
            Types.western_date?(str: @from)
          end

          def zodiac_name?
            Types.string?(str: @zodiac_name)
          end
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
          Types.positive?(str: @calc)
        end

        def actual?
          Types.positive?(str: @actual)
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
          Types.empiable_bool?(str: @calc)
        end

        def actual?
          Types.empiable_bool?(str: @actual)
        end
      end

      def self.run(yaml_hash: {})
        failed = []
        yaml_hash.each_with_index do |history, index|
          failed += MonthHistory.new(index: index, yaml_hash: history).validate
          failed += Annotation.new(index: index, yaml_hash: history).validate
          failed += Reference.new(index: index, yaml_hash: history).validate
          failed += Diffs.new(index: index, yaml_hash: history['diffs']).validate
        end

        failed
      end
    end
  end
end
