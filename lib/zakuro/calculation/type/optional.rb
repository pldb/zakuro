# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Type
      #
      # Optional 参照管理
      #
      # * インスタンスのnil操作を避ける
      # * safe navigation operator を使用しない
      #
      class Optional
        #
        # 初期化
        #
        # @param [Object] obj インスタンス
        #
        def initialize(obj: nil)
          @obj = obj
        end

        #
        # インスタンスを取得する
        #
        # @return [Object] インスタンス
        #
        def get
          @obj
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          @obj.nil?
        end
      end
    end
  end
end
