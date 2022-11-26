# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # Western 西暦
  #
  module Western
    #
    # DateText 日付文字列
    #
    module DateText
      # @return [Regexp] ハイフン区切り
      HYPHEN = /^[0-9]{1,5}-[0-9]{1,2}-[0-9]{1,2}$/.freeze
      # @return [Regexp] スラッシュ区切り
      SLASH = %r{^[0-9]{1,5}/[0-9]{1,2}/[0-9]{1,2}$}.freeze

      #
      # 有効な日付文字列か検証する
      #
      #  * 従来は Date.parse で日付文字列を検証していた
      #  * [貞観4年3月20日] のような文字列でも有効扱いになっていた
      #  * [20] [20日] のように2桁の数字が含まれると有効な日付扱いされる
      #  * 特定のフォーマットのみ受け付けるように改変した
      #
      # @param [String] text 文字列
      #
      # @return [True] 有効
      # @return [True] 無効
      #
      def self.validate(text: '')
        return true if HYPHEN.match(text)

        return true if SLASH.match(text)

        false
      end
    end
  end
end
