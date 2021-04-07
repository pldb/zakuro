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

        calc_date = SingleDaySpecifier.get(years: full_range.get, date: date)

        operated_range = OperatedRange.new(full_range: full_range)

        actual_date = SingleDaySpecifier.get(years: operated_range.get, date: date)

        operation_history = Operation.specify_history(western_date: date)

        operation_month = Single.create_operation_month(operation_history: operation_history)

        Result::Single.new(data: actual_date, operation: Result::Operation::Bundle.new(
          operated: !operation_history.invalid?, month: operation_month, original: calc_date
        ))
      end

      def self.create_operation_month(operation_history: Operation::MonthHistory.new)
        # TODO: MonthHistory が持つ親IDとの紐付け
        return Result::Operation::Month.new if operation_history.invalid?

        annotations = []
        operation_history.annotations.each do |annotation|
          annotations.push(
            Result::Operation::Annotation.new(
              description: annotion.description,
              note: annotation.note
            )
          )
        end

        reference = operation_history.reference
        Result::Operation::Month.new(
          page: reference.page, number: reference.number, annotations: annotations
        )
      end
    end
  end
end
