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

      def initialize(month:, even_term:, day: INVALID_DAY_VALUE)
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

      def initialize(number:, leaped:)
        @number = number
        @leaped = leaped
      end
    end

    #
    # EvenTerm 中気
    #
    class EvenTerm
      attr_reader :index, :name, :to, :day

      def initialize(to:, day: INVALID_DAY_VALUE)
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

      def initialize(calc:, actual:)
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

      def initialize(calc:, actual:)
        @calc = calc
        @actual = actual
      end
    end
  end
end
