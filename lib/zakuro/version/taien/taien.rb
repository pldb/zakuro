# frozen_string_literal: true

require_relative '../abstract_version'

# :nodoc:
module Zakuro
  #
  # Taien 大衍暦
  #
  module Taien
    #
    # Gateway アクセサメソッド群
    #
    class Gateway < AbstractVersion
      # @return [False] リリースなし
      RELEASE = false
    end
  end
end
