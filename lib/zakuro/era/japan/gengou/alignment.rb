# frozen_string_literal: true

require_relative './alignment/aligner'

require_relative './resource'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # Alignment 整列
    #
    module Alignment
      # @return [Aligner] 整列結果
      SUMMARY = Aligner.new(resources: Resource::LIST)
    end
  end
end
