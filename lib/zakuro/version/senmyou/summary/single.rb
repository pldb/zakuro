# frozen_string_literal: true

require File.expand_path('../../../../../' \
                        'lib/zakuro/version/senmyou/specifier/single_day_specifier',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/range/full_range',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/range/operated_range',
                         __dir__)

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Single 一日
    #
    module Single
      #
      # 生成する
      #
      # @param [Western::Calendar] date 西暦日
      #
      # @return [Result::Single] 一日検索結果（和暦日）
      #
      def self.get(date: Western::Calendar.new)
        full_range = FullRange.new(start_date: date)
        years = full_range.get

        calc_date = SingleDaySpecifier.get(years: years, date: date)

        operated_range = OperatedRange.new(years: years)

        actual_date = SingleDaySpecifier.get(years: operated_range.get, date: date)

        first_day = calc_date.month.first_day.western_date
        operation_history = Operation.specify_history(western_date: first_day)

        operation_month = Single.create_operation_month(operation_history: operation_history)

        Result::Single.new(data: actual_date, operation: Result::Operation::Bundle.new(
          operated: !operation_history.invalid?, month: operation_month, original: calc_date
        ))
      end

      def self.create_operation_month(operation_history: Operation::MonthHistory.new)
        return Result::Operation::Month.new if operation_history.invalid?

        annotations = create_annnotations(operation_history: operation_history)

        reference = operation_history.reference
        Result::Operation::Month.new(
          page: reference.page, number: reference.number, annotations: annotations
        )
      end

      def self.create_annnotations(operation_history: Operation::MonthHistory.new)
        annotations = []
        operation_history.annotations.each do |annotation|
          annotations.push(
            Result::Operation::Annotation.new(
              id: annotation.id,
              # TODO: MonthHistory が持つ親IDとの紐付け
              parent: Result::Operation::Parent.new,
              description: annotation.description,
              note: annotation.note
            )
          )
        end

        annotations
      end
    end
  end
end
