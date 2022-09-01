# frozen_string_literal: true

require_relative '../abstract/medieval_gengou'
require_relative '../abstract/medieval_range'
require_relative '../abstract/medieval_version'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Senmyou
      class << self
        #
        # データを取得する
        #
        # @return [Array<Integer, Hash>] テストデータ
        #
        def get
          MedievalVersion.get(
            range: MedievalRange.new(
              start: MedievalGengou.new(text: '貞観 4年'), last: MedievalGengou.new(text: '貞享 2年')
            )
          )
        end
      end
    end
  end
end
