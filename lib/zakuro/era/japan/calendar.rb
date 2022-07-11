# frozen_string_literal: true

require_relative '../../tools/typeconv'

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
      # @return [String] 閏を示す文字列
      LEAPED_TEXT = '閏'
      # @return [Regexp] 和暦日フォーマット
      FORMAT = /^([一-龥]{2,4})([0-9]+)年(#{LEAPED_TEXT})?([0-9]+)月([0-9]+)日$/.freeze
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
      # @return [Integer] 日
      attr_reader :day

      #
      # 初期化
      #
      # @param [String] gengou 元号
      # @param [Integer] year 元号年
      # @param [True, False] leaped 閏
      # @param [Integer] month 月
      # @param [Integer] day 日
      #
      def initialize(gengou: EMPTY, year: INVALID, leaped: false, month: INVALID, day: INVALID)
        @gengou = gengou
        @year = year
        @leaped = leaped
        @month = month
        @day = day
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
        leaped_text = @leaped ? LEAPED_TEXT : ''
        super(form, @gengou, @year, leaped_text, @month, @day)
      end

      #
      # 同月か
      #   年と日は無視する
      #
      # @param [True, False] leaped 閏
      # @param [Integer] month 月
      #
      # @return [True] 同月
      # @return [True] 同月ではない
      #
      def same_month?(leaped:, month:)
        return false unless @leaped == leaped

        @month == month
      end

      class << self
        #
        # 年月日情報（和暦）を生成する
        #
        # @param [Regexp] regex 正規表現
        # @param [String] text 和暦日文字列
        #
        # @return [Calendar] 年月日情報（和暦）
        #
        def parse(regex: FORMAT, text: '')
          return Calendar.new unless valid_date_string(regex: regex, text: text)

          matched = text.match(regex)

          Calendar.new(
            gengou: matched[1],
            year: Tools::Typeconv.to_i(text: matched[2], default: INVALID),
            leaped: matched[3] ? true : false,
            month: Tools::Typeconv.to_i(text: matched[4], default: INVALID),
            day: Tools::Typeconv.to_i(text: matched[5], default: INVALID)
          )
        end

        #
        # 日付文字列を検証する
        #
        # @param [Regexp] regex 正規表現
        # @param [String] text 和暦日文字列
        #
        # @return [True] 正しい
        # @return [True] 正しくない
        #
        def valid_date_string(regex: FORMAT, text: '')
          return false unless text

          matched = text.match(regex)

          return false unless matched

          matched.size == 6
        end
      end
    end
  end
end
