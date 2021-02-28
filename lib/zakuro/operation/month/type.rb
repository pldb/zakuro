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
      attr_reader :month, :even_term, :day

      def initialize(month: Month.new, even_term: EvenTerm.new, day: INVALID_DAY_VALUE)
        @month = month
        @even_term = even_term
        @day = day
      end

      def invalid?
        @day == INVALID_DAY_VALUE
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
    # EvenTerm 中気
    #
    class EvenTerm
      attr_reader :index, :name, :to, :day

      def initialize(to: Western::Calendar.new, day: INVALID_DAY_VALUE)
        @to = to
        @day = day
      end

      def invalid?
        @day == INVALID_DAY_VALUE
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
