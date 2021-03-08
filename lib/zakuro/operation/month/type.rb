# frozen_string_literal: true

require 'yaml'
require_relative '../../era/western'
require_relative './validator'

# :nodoc:
module Zakuro
  #
  # Operation 運用
  #
  module Operation
    #
    # 日（差分）無効値
    #
    INVALID_DAY_VALUE = -30

    #
    # MonthHistory 変更履歴
    #
    class MonthHistory
      attr_reader :id, :reference, :western_date, :annotations, :diffs

      def initialize(id: '', reference: Reference.new,
                     western_date: Western::Calendar.new, diffs: Diffs.new, annotations: [])
        @id = id
        @reference = reference
        @western_date = western_date
        @annotations = annotations
        @diffs = diffs
      end

      def invalid?
        id == ''
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

      def initialize(page: -1, number: -1, japan_date: '')
        @page = page
        @number = number
        @japan_date = japan_date
      end

      def invalid?
        page == -1
      end
    end

    #
    # Diffs 総差分
    #
    class Diffs
      attr_reader :month, :solar_term, :days

      def initialize(month: Month.new, solar_term: SolarTerm::Direction.new, days: INVALID_DAY_VALUE)
        @month = month
        @solar_term = solar_term
        @days = days
      end

      def invalid?
        @days == INVALID_DAY_VALUE
      end
    end

    #
    # Month 月差分
    #
    class Month
      attr_reader :number, :leaped

      def initialize(number: -1, leaped: false)
        @number = number
        @leaped = leaped
      end

      def invalid?
        number == -1
      end
    end

    #
    # 二十四節気
    #
    module SolarTerm
      #
      # Direction 二十四節気（移動）
      #
      class Direction
        attr_reader :source, :destination, :days
        #
        # 初期化
        #
        # @param [Source] source 二十四節気（移動元）
        # @param [Destination] destination 二十四節気（移動先）
        # @param [Integer] day 大余差分
        #
        def initialize(source: Source.new, destination: Destination.new,
                       days: INVALID_DAY_VALUE)
          @source = source
          @destination = destination
          @days = days
        end

        def invalid_day?
          @days == INVALID_DAY_VALUE
        end

        def invalid?
          @source.invalid? && @destination.invalid?
        end
      end

      #
      # Source 二十四節気（移動元）
      #
      class Source
        attr_reader :index, :to, :zodiac_name

        def initialize(index: -1, to: Western::Calendar.new, zodiac_name: '')
          @index = index
          @to = to
          @zodiac_name = zodiac_name
        end

        def invalid?
          @index == -1
        end
      end

      #
      # Destination 二十四節気（移動先）
      #
      class Destination
        attr_reader :index, :from, :zodiac_name

        def initialize(index: -1, from: Western::Calendar.new, zodiac_name: '')
          @index = index
          @from = from
          @zodiac_name = zodiac_name
        end

        def invalid?
          @index == -1
        end
      end
    end

    #
    # Number 月
    #
    class Number
      attr_reader :calc, :actual

      def initialize(calc: -1, actual: -1)
        @calc = calc
        @actual = actual
      end

      def invalid?
        @calc == -1 || @actual == -1
      end
    end

    #
    # Leaped 閏有無
    #
    class Leaped
      attr_reader :calc, :actual

      def initialize(calc: false, actual: false)
        @calc = calc
        @actual = actual
      end

      def invalid?
        !@calc && !@actual
      end
    end
  end
end
