# frozen_string_literal: true

require_relative '../abstract_version'

# :nodoc:
module Zakuro
  #
  # Houryaku 宝暦暦
  #
  module Houryaku
    #
    # Gateway アクセサメソッド群
    #
    class Gateway < AbstractVersion
      # @return [False] リリースなし
      RELEASE = false
    end
  end
end
