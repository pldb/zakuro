# frozen_string_literal: true

require_relative '../../../../western/calendar'

require_relative '../../../calendar'

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
          # Date 日
          #
          class Date
            # @return [String] 和暦日
            attr_reader :japan
            # @return [String] 西暦日
            attr_reader :western
            # @return [True] 省略可
            # @return [False] 省略不可
            attr_reader :optional

            #
            # 初期化
            #
            # @param [Hash<String, Strin>] hash 日情報
            #
            def initialize(hash:, optional: false)
              @japan = hash['japan']
              @western = hash['western']
              @optional = optional
            end

            #
            # 検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate
              failed = []

              failed.push("invalid japan date. #{japan}") unless japan?

              failed.push("invalid western date. #{western}") unless western?

              failed
            end

            #
            # 和暦日を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def japan?
              return true if optional?(text: japan)

              Japan::Calendar.valid_date_text(text: japan)
            end

            #
            # 西暦日を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def western?
              return true if optional?(text: western)

              Western::Calendar.valid_date_text(text: western)
            end

            #
            # 省略可で省略されているか
            #
            # @param [String] text 文字列
            #
            # @return [True] 省略あり
            # @return [False] 省略なし
            #
            def optional?(text: '')
              return false unless optional

              return true if text == ''

              false
            end
          end
        end
      end
    end
  end
end
