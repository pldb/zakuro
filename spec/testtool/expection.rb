# frozen_string_literal: true

require 'rspec/expectations'

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
    # @param [<Type>] actual <description>
    # @param [<Type>] expect <description>
    #
    # @return [<Type>] <description>
    #
    def eql?(actual:, expect:)
      expect(actual).to eql(expect)
    end
  end
end
