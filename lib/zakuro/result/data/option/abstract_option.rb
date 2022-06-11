# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # データ部
    #
    module Data
      #
      # Option オプション
      #
      module Option
        #
        # AbstractOption 抽象オプション結果
        #
        class AbstractOption
          # @return [True] オプション値有
          # @return [False] オプション値無
          attr_reader :matched

          #
          # 初期化
          #
          # @param [True, False] matched オプション値有無
          #
          def initialize(matched: false)
            @matched = matched
          end
        end
      end
    end
  end
end
