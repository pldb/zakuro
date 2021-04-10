# frozen_string_literal: true

require_relative './month/parser'

# :nodoc:
module Zakuro
  #
  # Operation 運用
  #
  module Operation
    #
    # 変更履歴（月）
    #
    MONTH_HISTORIES = MonthParser.run(filepath: File.expand_path(
      './yaml/month.yaml',
      __dir__
    ))

    #
    # 変更履歴（月）を返す
    #
    # @return [Array<MonthHistory>] 変更履歴
    #
    def self.month_histories
      MONTH_HISTORIES
    end

    #
    # 変更履歴を特定する
    #
    # @param [Western::Calendar] western_date 月初日の西暦日
    #
    # @return [Operation::MonthHistory] 変更履歴
    #
    def self.specify_history(western_date:)
      month_histroies = Operation.month_histories

      month_histroies.each do |history|
        return history if western_date == history.western_date
      end

      Operation::MonthHistory.new
    end
  end
end
