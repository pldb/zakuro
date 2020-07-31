# frozen_string_literal: true

require_relative '../abstract_version'

# :nodoc:
module Zakuro
  #
  # Gregorio グレゴリオ暦
  #
  module Gregorio
    #
    # Gateway アクセサメソッド群
    #
    class Gateway < AbstractVersion
      # @return [False] リリースなし
      RELEASE = false
    end
  end
end
