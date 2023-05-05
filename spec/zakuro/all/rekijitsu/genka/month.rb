# frozen_string_literal: true

require_relative './solar_term'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Rekijitsu
      # :nodoc:
      module Genka
        # Month 月
        class Month
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
          # 49.8936 529 1 25 (4)13.2072 (3)57.9886
          #
          SUFFIX = /^.+\s+([0-9]{1,2}\.[0-9]{1,4})\s+([0-9]{3,4}\s+[0-9]{1,2}\s+[0-9]{1,2})\s+(\([0-9]{1,2}\)[0-9]{1,2}\.[0-9]{1,4}\s+)?(\([0-9]{1,2}\)[0-9]{1,2}\.[0-9]{1,4})$/.freeze
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
            @even_term = SolarTerm.new
            @odd_term = SolarTerm.new

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

          def parse(text:) # rubocop:disable Metrics/AbcSize
            # コメント行
            matched = text.match(COMMENT)
            return if matched

            matched = text.match(PREFIX)

            return unless matched

            prefix(matched: matched)

            matched = text.match(SUFFIX)

            return unless matched

            @remainder = matched[1]

            # 450 1 2
            date = matched[2].split(/\s+/)
            @western_year = date[0].to_i

            solar_terms(
              terms: [
                SolarTerm.new(text: matched[3]), SolarTerm.new(text: matched[4])
              ]
            )
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
  end
end
