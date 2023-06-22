# frozen_string_literal: true

require 'rspec/expectations'

# :nodoc:
module Zakuro
  #
  # TestTool テスト用メソッド群
  #
  module TestTool
    #
    # Expection Rspec判定
    #
    # https://github.com/rspec/rspec-expectations
    #
    class Expection
      include RSpec::Matchers

      #
      # `Usage outside rspec-core`
      #
      # @param [Object] actual 実際値
      # @param [Object] expect 期待値
      #
      # @return [True] 一致
      # @return [True] 不一致
      #
      def eql?(actual:, expect:)
        expect(actual).to eql(expect)
      end
    end
  end
end
