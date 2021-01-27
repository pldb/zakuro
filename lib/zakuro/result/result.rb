# frozen_string_literal: true

require 'json'

require_relative './core'
require_relative './data'
require_relative './operation'
require_relative '../output/stringifier'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # Single 1日検索結果
    #
    class Single < Core
      # @return [Data::SingleDay] 1日
      attr_reader :data
      # @return [Operation::Bundle] 運用情報
      attr_reader :operation

      #
      # 初期化
      #
      # @param [Data::SingleDay] data 1日
      # @param [Operation::Bundle] operation 運用情報
      #
      def initialize(data:, operation:)
        super
        @data = data
        @operation = operation
      end
    end
  end
end
