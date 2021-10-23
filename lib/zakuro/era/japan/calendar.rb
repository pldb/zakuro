# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # Calendar 年月日情報（和暦）
    #
    class Calendar
      # @return [Integer] 無効値
      INVALID = -1
      # @return [String] 空文字列
      EMPTY = ''
      # @return [Regexp] 和暦日フォーマット
      FORMAT = /^([一-龥]{2,4})([0-9]+)年(閏)?([0-9]+)月([0-9]+)日$/.freeze
      # @return [String] 出力用デフォルトフォーマット
      DEFAULT_OUTPUT_FORM = '%s%02d年%s%02d月%02d日'

      # @return [String] 元号
      attr_reader :gengou
      # @return [Integer] 元号年
      attr_reader :year
      # @return [True] 閏あり
      # @return [False] 閏なし
      attr_reader :leaped
      # @return [Integer] 月
      attr_reader :month
      # @return [Integer] 日
      attr_reader :day

      #
      # 初期化
      #
      # @param [String] text 和暦日文字列
      #
      def initialize(text: '')
        clear

        return unless text

        parse(text: text)
      end

      #
      # インスタンス変数クリア
      #
      def clear
        @gengou = EMPTY
        @year = INVALID
        @leaped = false
        @month = INVALID
        @day = INVALID
      end

      #
      # フォーマットに従い変換する
      #
      # @param [String] text 和暦日文字列
      #
      def parse(text: '')
        matched = text.match(FORMAT)

        return unless matched

        @gengou = matched[1]
        @year = matched[2].to_i
        @leaped = matched[3] ? true : false
        @month = matched[4].to_i
        @day = matched[5].to_i
      end

      #
      # 無効か
      #
      # @return [True] 無効
      # @return [False] 有効
      #
      def invalid?
        @gengou == EMPTY || @year == INVALID || @month == INVALID || @day == INVALID
      end

      #
      # 文字列にする
      #
      # @return [String] 和暦日フォーマット文字列
      #
      def format(form: DEFAULT_OUTPUT_FORM)
        leaped_text = @leaped ? '閏' : ''
        super(form, @gengou, @year, leaped_text, @month, @day)
      end
    end
  end
end
