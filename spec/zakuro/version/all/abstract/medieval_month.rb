# frozen_string_literal: true

require_relative './medieval_solar_term'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # MedievalMonth 月（中世）
    class MedievalMonth
      # @return [Regexp] コメント行
      COMMENT = /^\s*#/.freeze

      # @return [Regexp] 前方抽出
      #
      # 1 大 庚午
      #
      PREFIX = /\s+(閏?[0-9]{1,2})\s+([大小])\s+([一-龥]{2})\s+/.freeze

      # rubocop:disable Layout/LineLength

      # @return [Regexp] 前方抽出
      #
      # 19-6647 1573 2 3 (4)28-3037 (5)43-4873
      #
      SUFFIX = /^.+\s+([0-9]{1,2}-[0-9]{1,4})\s+([0-9]{3,4}\s+[0-9]{1,2}\s+[0-9]{1,2})\s+(\([0-9]{1,2}\)[0-9]{1,2}-[0-9]{1,4}\s+)?(\([0-9]{1,2}\)[0-9]{1,2}-[0-9]{1,4})$/.freeze
      # rubocop:enable Layout/LineLength

      # @return [Integer] 西暦年
      attr_reader :western_year
      # @return [True, False] 閏の有無
      attr_reader :leaped
      # @return [Integer] 月
      attr_reader :month
      # @return [True, False] 月の大小
      attr_reader :is_many_days
      # @return [String] 大余小余
      attr_reader :remainder
      # @return [SolarTerm] 二十四節気（節気）
      attr_reader :even_term
      # @return [SolarTerm] 二十四節気（中気）
      attr_reader :odd_term

      #
      # 初期化
      #
      # @param [String] text 文字列
      #
      def initialize(text:)
        @western_year = -1
        @leaped = false
        @month = -1
        # 月相（テスト対象外）
        @phase_index = 0
        @is_many_days = false
        @remainder = ''
        @even_term = MedievalSolarTerm.new
        @odd_term = MedievalSolarTerm.new

        parse(text: text)
      end

      #
      # 1月か
      #
      # @return [True] 1月
      # @return [True] 1月以外
      #
      def first?
        return false unless @month == 1

        return false if @leaped

        true
      end

      #
      # 閏10月か
      #
      # @return [True] 閏10月
      # @return [True] 閏10月以外
      #
      def leaped_october?
        return false unless @month == 10

        return false unless @leaped

        true
      end

      #
      # 11月か
      #
      # @return [True] 11月
      # @return [True] 11月以外
      #
      def november?
        return false unless @month == 11

        return false if @leaped

        true
      end

      #
      # 閏11月か
      #
      # @return [True] 閏11月
      # @return [True] 閏11月以外
      #
      def leaped_november?
        return false unless @month == 11

        return false unless @leaped

        true
      end

      #
      # ハッシュ化する
      #
      # @return [Hash<String, Objcet>] ハッシュ
      #
      def to_h
        {
          is_many_days: is_many_days,
          month: month,
          leaped: leaped,
          remainder: remainder,
          phase_index: @phase_index,
          even_term: even_term.remainder,
          even_term_index: even_term.index,
          odd_term: odd_term.remainder,
          odd_term_index: odd_term.index
        }
      end

      #
      # 不正か
      #
      # @return [True] 不正
      # @return [False] 不正なし
      #
      def invalid?
        @western_year == -1
      end

      private

      def parse(text:)
        # コメント行
        matched = text.match(COMMENT)
        return if matched

        matched = text.match(PREFIX)

        return unless matched

        prefix(matched: matched)

        matched = text.match(SUFFIX)

        return unless matched

        @remainder = matched[1]

        extract_year(text: matched[2])

        solar_terms(
          terms: [
            MedievalSolarTerm.new(text: matched[3]), MedievalSolarTerm.new(text: matched[4])
          ]
        )
      end

      def extract_year(text:)
        # 450 1 2
        date = text.split(/\s+/)
        @western_year = date[0].to_i
      end

      def prefix(matched:)
        @leaped = matched[1].include?('閏')
        @month = matched[1].gsub(/閏/, '').to_i
        @is_many_days = (matched[2] == '大')
      end

      def solar_terms(terms: [])
        terms.each do |term|
          next if term.invalid?

          if term.index.even?
            @even_term = term
            next
          end
          @odd_term = term
        end
      end
    end
  end
end
