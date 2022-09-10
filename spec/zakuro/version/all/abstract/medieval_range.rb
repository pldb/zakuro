# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    class MedievalRange
      # @return [MedievalGengou] 開始元号
      attr_reader :start
      # @return [MedievalGengou] 終了元号
      attr_reader :last

      def initialize(start:, last:)
        @start = start
        @last = last
      end

      def start?(gengou:)
        start == gengou
      end

      def last?(gengou:)
        last == gengou
      end
    end
  end
end
