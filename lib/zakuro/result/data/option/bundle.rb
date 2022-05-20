# frozen_string_literal: true

require_relative './dropped_date/bundle'

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
          # @return [DroppedDate::Bundle] 没日
          attr_reader :dropped_date

          #
          # 初期化
          #
          # @param [DroppedDate::Bundle] dropped_date 没日
          #
          def initialize(dropped_date: DroppedDate::Bundle.new)
            @dropped_date = dropped_date
          end
        end
      end
    end
  end
end
