# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Reference
      # @return [String] テストデータファイルパス
      #
      # 下記の方針で管理している
      # * プライベートリポジトリに配置している
      # * ローカルに存在しない場合はテスト自体を失敗させる
      TEST_DATA_PATH = '../../../../../../zakuro-data/text/rekijitu.txt'

      class << self
        def path
          # TODO: ファイルが存在しない場合はスキップするようにする
          File.expand_path(TEST_DATA_PATH, __dir__)
        end
      end
    end
  end
end
