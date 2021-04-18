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

        Result::Single.new(
          data: SingleDaySpecifier.get(years: operated_range.get, date: date),
          operation: create_operation(calc_date: calc_date)
        )
      end

      #
      # 運用情報を生成する
      #
      # @param [Result::Data::SingleDay] calc_date 和暦日（計算値）
      #
      # @return [Result::Operation::Bundle] 運用情報
      #
      def self.create_operation(calc_date: Result::Data::SingleDay.new)
        first_day = calc_date.month.first_day.western_date
        operation_history = Operation.specify_history(western_date: first_day)

        operation_month = create_operation_month(operation_history: operation_history)

        Result::Operation::Bundle.new(
          operated: !operation_history.invalid?, month: operation_month, original: calc_date
        )
      end
      private_class_method :create_operation

      #
      # 月履歴集約情報を生成する
      #
      # @param [Operation::MonthHistory] operation_history 変更履歴（月）
      #
      # @return [Result::Operation::Month::Bundle] 月履歴集約情報
      #
      def self.create_operation_month(operation_history: Operation::MonthHistory.new)
        return Result::Operation::Month::Bundle.new if operation_history.invalid?

        parent_operation_history = Operation.specify_history_by_id(id: operation_history.parent_id)

        Result::Operation::Month::Bundle.new(
          current: create_operation_month_history(operation_history: operation_history),
          parent: create_operation_month_history(operation_history: parent_operation_history)
        )
      end
      private_class_method :create_operation_month

      #
      # 月別履歴情報を生成する
      #
      # @param [Operation::MonthHistory] operation_history 変更履歴（月）
      #
      # @return [Result::Operation::Month::History] 月別履歴情報
      #
      def self.create_operation_month_history(operation_history: Operation::MonthHistory.new)
        return Result::Operation::Month::History.new if operation_history.invalid?

        annotations = create_annnotations(operation_history: operation_history)

        reference = operation_history.reference
        Result::Operation::Month::History.new(
          id: operation_history.id, western_date: operation_history.western_date.format,
          page: reference.page, number: reference.number, annotations: annotations
        )
      end
      private_class_method :create_operation_month_history

      #
      # 注釈情報を生成する
      #
      # @param [Operation::MonthHistory] operation_history 変更履歴（月）
      #
      # @return [Array<Result::Operation::Month::Annotation>] 注釈
      #
      def self.create_annnotations(operation_history: Operation::MonthHistory.new)
        annotations = []
        operation_history.annotations.each do |annotation|
          annotations.push(
            Result::Operation::Month::Annotation.new(
              description: annotation.description,
              note: annotation.note
            )
          )
        end

        annotations
      end
      private_class_method :create_annnotations
    end
  end
end
