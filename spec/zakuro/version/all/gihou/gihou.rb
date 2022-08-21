# frozen_string_literal: true

require_relative '../abstract/medieval_gengou'
require_relative '../abstract/medieval_range'
require_relative '../abstract/medieval_version'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Gihou
      class << self
        #
        # データを取得する
        #
        # @return [Array<Integer, Hash>] テストデータ
        #
        def get
          MedievalVersion.get(
            range: MedievalRange.new(
              start: MedievalGengou.new(text: '文武 2年'), last: MedievalGengou.new(text: '天平宝字 8年')
            )
          )
        end
      end
    end
  end
end
