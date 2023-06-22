# frozen_string_literal: true

require_relative '../../type/validation/gengou_set'

require 'yaml'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Gengou
      #
      # Resource yaml解析結果
      #
      module Resource
        #
        # Validator yaml解析
        #
        module Validator
          class << self
            #
            # 検証する
            #
            # @param [Hash<String, Object>] yaml_hash yaml取得結果
            #
            # @return [Array<String>] 不正メッセージ
            #
            def run(yaml_hash:)
              Type::Validation::GengouSet.new(hash: yaml_hash).validate
            end
          end
        end
      end
    end
  end
end
