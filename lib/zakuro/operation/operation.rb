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
    MONTHS = MonthParser.run(filepath: File.expand_path(
      './yaml/month.yaml',
      __dir__
    ))

    #
    # 変更履歴（月）を返す
    #
    # @return [Array<MonthHistory>] 変更履歴
    #
    def self.months
      MONTHS
    end
  end
end
