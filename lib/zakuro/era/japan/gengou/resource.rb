# frozen_string_literal: true

require_relative './resource/parser'

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
        # @return [Array<Set>] 元号セット情報リスト
        LIST = [
          Parser.run(filepath: File.expand_path(
            './resource/yaml/set-001-until-south.yaml',
            __dir__
          )),
          Parser.run(filepath: File.expand_path(
            './resource/yaml/set-002-from-north.yaml',
            __dir__
          )),
          Parser.run(filepath: File.expand_path(
            './resource/yaml/set-003-modern.yaml',
            __dir__
          ))
        ].freeze
      end
    end
  end
end
