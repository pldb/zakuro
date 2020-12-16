# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # Operation 運用
  #
  module Operation
    #
    # Month 月
    #
    class MonthHistory
      attr_reader :id, :relation_id, :page, :number
      attr_reader :japan_date, :western_date, :description, :note, :valid, :diff
      # TODO
    end
  end
end
