# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # TestTool テスト用メソッド群
  #
  module TestTool
    # :nodoc:
    module Setting
      # @return [True] 滅日チェックを実施する
      # @return [False] 滅日チェックを実施しない
      #
      # 非常に重い試験のため通常は実施しない
      METSUNICHI_ENABLED = false

      # @return [True] 没日滅日全体チェックを実施する
      # @return [False] 没日滅日全体チェックを実施しない
      #
      # 非常に重い試験のため通常は実施しない
      MOTSUMETSU_ENABLED = false

      # @return [True] 没日チェックを実施する
      # @return [False] 没日チェックを実施しない
      #
      # 非常に重い試験のため通常は実施しない
      MOTSUNICHI_ENABLED = false

      # @return [True] 逆引きチェックを実施する
      # @return [False] 逆引きチェックを実施しない
      #
      # 非常に重い試験のため通常は実施しない
      REVERSE_ENABLED = false
    end
  end
end
