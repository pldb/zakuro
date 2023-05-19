# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Type
      # :nodoc:
      module Validation
        # :nodoc:
        module Both
          #
          # Year 年
          #
          class Year
            # @return [String] 和暦元号年
            attr_reader :japan
            # @return [String] 西暦年
            attr_reader :western

            #
            # 初期化
            #
            # @param [Hash<String, Strin>] hash 年情報
            #
            def initialize(hash:)
              @japan = hash['japan']
              @western = hash['western']
            end

            #
            # 検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate
              failed = []

              failed.push("invalid japan year. #{japan}") unless japan?

              failed.push("invalid western year. #{western}") unless western?

              failed
            end

            #
            # 和暦元号年を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def japan?
              return false unless @japan

              japan.is_a?(Integer)
            end

            #
            # 和暦元号年を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def western?
              return false unless @western

              western.is_a?(Integer)
            end
          end
        end
      end
    end
  end
end
