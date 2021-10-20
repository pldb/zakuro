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
      INVALID = -1
      EMPTY = ''

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

      def initialize(text: '')
        clear

        return unless text

        parse(text: text)
      end

      def clear
        @gengou = EMPTY
        @year = INVALID
        @leaped = false
        @month = INVALID
        @day = INVALID
      end

      def parse(text: '')
        matched = text.match(/^([一-龥]{2,4})([0-9]+)年(閏)?([0-9]+)月([0-9]+)日$/)

        return unless matched

        @gengou = matched[1]
        @year = matched[2].to_i
        @leaped = matched[3] ? true : false
        @month = matched[4].to_i
        @day = matched[5].to_i
      end

      def invalid?
        @gengou == EMPTY || @year == INVALID || @month == INVALID || @day == INVALID
      end
    end
  end
end
