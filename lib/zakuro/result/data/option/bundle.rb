# frozen_string_literal: true

require_relative './motsunichi/bundle'

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
        # Bundle オプション集約
        #
        class Bundle
          # @return [Motsunichi::Bundle] 没日
          attr_reader :motsunichi

          #
          # 初期化
          #
          # @param [Motsunichi::Bundle] motsunichi 没日
          #
          def initialize(motsunichi: Motsunichi::Bundle.new)
            @motsunichi = motsunichi
          end
        end
      end
    end
  end
end
