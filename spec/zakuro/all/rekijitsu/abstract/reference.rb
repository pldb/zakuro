# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Rekijitsu
      # :nodoc:
      module Reference
        # @return [String] テストデータファイルパス
        #
        # 下記の方針で管理している
        # * プライベートリポジトリに配置している
        # * ローカルに存在しない場合はテスト自体を失敗させる
        TEST_DATA_PATH = '../../../../../../zakuro-data/text/rekijitu.txt'

        class << self
          #
          # テストデータのパスを取得する
          #
          # @return [String] パス（存在なし時は空文字）
          #
          def path
            fullpath = File.expand_path(TEST_DATA_PATH, __dir__)

            return fullpath if File.exist?(fullpath)

            ''
          end
        end
      end
    end
  end
end
