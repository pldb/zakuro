# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Rekijitsu
      # :nodoc:
      module MedievalComperer
        class << self
          #
          # 比較用のハッシュを生成する
          #
          # @param [Zakuro::Calculation::Monthly::Month] month 月情報
          #
          # @return [Hash<Symbol, Object>] 比較用のハッシュ
          #
          def month_actual(month:)
            even_term = month.even_term
            odd_term = month.odd_term
            {
              is_many_days: month.many_days?,
              month: month.number,
              leaped: month.leaped?,
              remainder: month.remainder.format,
              phase_index: month.phase_index,
              even_term: even_term.remainder.format,
              even_term_index: even_term.index,
              odd_term: odd_term.remainder.format,
              odd_term_index: odd_term.index
            }
          end

          #
          # メッセージ出力
          #
          # @param [Array<Hash<Symbol, Object>>] fails 失敗結果
          #
          # @return [String] メッセージ
          #
          def error_message(fails)
            message = ''
            fails.each do |fail|
              message += "[num: #{fail[:num]}, \n" \
              "year: #{fail[:year]}, \n" \
              "actual: #{fail[:actual]}\n" \
              "expect: #{fail[:expect]}]\n"
            end
            message
          end

          #
          # 部分的な範囲での比較を行う
          #   * 対象年の月の期待値すべてが揃わないことを「部分的」とする
          #   * 合致した月の分だけチェックする
          #
          # @param [Integer] year 年
          # @param [Array<Zakuro::All::MedievalLine>] expects 期待値
          # @param [Array<Zakuro::Calculation::Monthly::Month>] actuals 実際値
          # @param [Array<Hash<Symbol, Object>>] fails 失敗結果
          #
          def check_with_partially_expection(year:, expects: [], actuals: [], fails: [])
            expects.each do |expect_line|
              matched = matched_actuals(
                year: year, expect_line: expect_line, actuals: actuals, fails: fails
              )

              next if matched

              fails.push(
                year: year, num: expect_line[:num], actual: {}, expect: expect_line[:month]
              )
            end
          end

          #
          # 実際値との比較を行う
          #
          # @param [Integer] year 年
          # @param [Zakuro::All::MedievalLine] expect_line 期待値
          # @param [Array<Zakuro::Calculation::Monthly::Month>] actuals 実際値
          # @param [Array<Hash<Symbol, Object>>] fails 失敗結果
          #
          def matched_actuals(year:, expect_line:, actuals:, fails:)
            expect = expect_line[:month]
            actuals.each do |month|
              actual = month_actual(month: month)

              next unless actual[:month] == expect[:month] && actual[:leaped] == expect[:leaped]

              unless actual.eql?(expect)
                fails.push(
                  year: year, num: expect_line[:num], actual: actual, expect: expect
                )
              end
              return true
            end

            false
          end
        end
      end
    end
  end
end
