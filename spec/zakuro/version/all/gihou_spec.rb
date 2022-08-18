# frozen_string_literal: true

require File.expand_path('../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/version/gihou/range/annual_range',
                         __dir__)

require_relative './gihou/gihou'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Gihou' do
      context 'all months every year' do
        # :reek:UtilityFunction
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

        # :reek:UtilityFunction
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

        it 'should be expected values' do
          expected = Zakuro::All::Gihou.get

          # TODO: refactor

          fails = []
          expected.each_with_index do |(year, expects), hash_index|
            actuals = \
              Zakuro::Gihou::Range::AnnualRange.get(
                context: Zakuro::Context::Context.new(version: 'Gihou'),
                western_year: year + 1
              )

            # 暦の切り替え時は完全なチェックができない
            if hash_index.zero? || hash_index == expected.size - 1
              p 'first or last'

              expects.each do |expect_line|
                expect = expect_line[:month]
                matched = false
                actuals.each do |month|
                  actual = month_actual(month: month)

                  next unless actual[:month] == expect[:month] && actual[:leaped] == expect[:leaped]

                  matched = true

                  break if actual.eql?(expect)

                  fails.push(
                    year: year, num: expect_line[:num], actual: actual, expect: expect
                  )
                  break
                end

                next if matched

                fails.push(
                  year: year, num: expect_line[:num], actual: {}, expect: expect
                )
              end

              next
            end

            actuals.each_with_index do |month, index|
              actual = month_actual(month: month)

              expect_month = expects[index][:month]
              next if actual.eql?(expect_month)

              fails.push(
                year: year, num: expects[index][:num], actual: actual, expect: expect_month
              )
            end
          end

          expect(fails).to be_empty, error_message(fails)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
