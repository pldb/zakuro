# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Gateway
    # :nodoc:
    class Locale
      #
      # Date 日付
      #
      class Date
        # @return [Western::Calendar] 西暦日
        attr_reader :western_date
        # @return [Japan::Calendar] 和暦日
        attr_reader :japan_date

        #
        # 初期化
        #
        # @param [Date, String] date 日付
        #
        def initialize(date:)
          @western_date = Western::Calendar.new
          @japan_date = Japan::Calendar.new

          parse(date: date)
        end

        #
        # 和暦日が有効か
        #
        # @return [True] 有効
        # @return [False] 無効
        #
        def valid_japan?
          !invalid_japan?
        end

        #
        # 和暦日が不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid_japan?
          @japan_date.invalid?
        end

        #
        # 西暦日が有効か
        #
        # @return [True] 有効
        # @return [False] 無効
        #
        def valid_western?
          !invalid_western?
        end

        #
        # 西暦日が不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid_western?
          @western_date.invalid?
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          invalid_japan? && invalid_western?
        end

        private

        #
        # 解析する
        #
        # @param [Date, String] date 日付
        #
        def parse(date:)
          return unless date

          if date.class == Date
            @western_date = Western::Calendar.create(date: date)
            return
          end

          return if date.class != String

          parse_text(text: date)
        end

        #
        # 文字解析する
        #
        # @param [String] text 日付文字列
        #
        def parse_text(text:)
          if Western::Calendar.valid_date_string(str: text)
            @western_date = Western::Calendar.parse(str: text)
            return
          end

          return unless Japan::Calendar.valid_date_string(text: text)

          @japan_date = Japan::Calendar.parse(text: text)
        end
      end
    end
  end
end
