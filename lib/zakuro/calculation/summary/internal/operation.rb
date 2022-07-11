# frozen_string_literal: true

require_relative '../../../operation/operation'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      #
      # Operation 運用情報
      #
      module Operation
        class << self
          #
          # 運用情報を生成する
          #
          # @param [Result::Data::SingleDay] calc_date 和暦日（計算値）
          #
          # @return [Result::Operation] 運用情報
          #
          def create(calc_date: Result::Data::SingleDay.new)
            first_day = calc_date.month.first_day.western_date
            operation_history = Zakuro::Operation.specify_history(western_date: first_day)

            operation_month = create_operation_month(operation_history: operation_history)

            Result::Operation.new(
              operated: !operation_history.invalid?, month: operation_month, original: calc_date
            )
          end

          private

          #
          # 月履歴集約情報を生成する
          #
          # @param [Operation::MonthHistory] operation_history 変更履歴（月）
          #
          # @return [Result::Operation::Month] 月履歴情報
          #
          def create_operation_month(operation_history: Operation::MonthHistory.new)
            return Result::Operation::Month.new if operation_history.invalid?

            parent_operation_history = Zakuro::Operation.specify_history_by_id(
              id: operation_history.parent_id
            )

            Result::Operation::Month.new(
              current: create_operation_month_history(operation_history: operation_history),
              parent: create_operation_month_history(operation_history: parent_operation_history)
            )
          end

          #
          # 月別履歴情報を生成する
          #
          # @param [Operation::MonthHistory] operation_history 変更履歴（月）
          #
          # @return [Result::Operation::Month::History] 月別履歴情報
          #
          def create_operation_month_history(operation_history: Operation::MonthHistory.new)
            return Result::Operation::Month::History.new if operation_history.invalid?

            annotations = create_annnotations(operation_history: operation_history)

            reference = operation_history.reference
            Result::Operation::Month::History.new(
              id: operation_history.id, western_date: operation_history.western_date.format,
              page: reference.page, number: reference.number, annotations: annotations
            )
          end

          #
          # 注釈情報を生成する
          #
          # @param [Operation::MonthHistory] operation_history 変更履歴（月）
          #
          # @return [Array<Result::Operation::Month::Annotation>] 注釈
          #
          def create_annnotations(operation_history: Operation::MonthHistory.new)
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
        end
      end
    end
  end
end
