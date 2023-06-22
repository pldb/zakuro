# frozen_string_literal: true

require_relative './resource/parser'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Version
      #
      # Resource yaml解析結果
      #
      module Resource
        LIST = Parser.run(filepath: File.expand_path(
          './resource/yaml/version.yaml',
          __dir__
        ))
      end
    end
  end
end
