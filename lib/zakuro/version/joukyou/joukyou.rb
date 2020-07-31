# frozen_string_literal: true

require_relative '../abstract_version'

# :nodoc:
module Zakuro
  #
  # Joukyou 貞享暦
  #
  module Joukyou
    #
    # Gateway アクセサメソッド群
    #
    class Gateway < AbstractVersion
      # @return [False] リリースなし
      RELEASE = false
    end
  end
end
