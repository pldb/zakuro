# frozen_string_literal: true

require_relative '../abstract_version'

# :nodoc:
module Zakuro
  #
  # Genka 元嘉暦
  #
  module Genka
    #
    # Gateway アクセサメソッド群
    #
    class Gateway < AbstractVersion
      # @return [False] リリースなし
      RELEASE = false
    end
  end
end
