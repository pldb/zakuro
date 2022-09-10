# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/range/annual_range',
                         __dir__)

# rubocop:disable Layout/LineLength

# @return [Hash<Integer, Array<Hash<Symbol, Object>>>] 期待値
#
# 全件チェックは下記テストケースで実施する
#   spec/zakuro/version/all/senmyou_spec.rb
#
SENMYOU_EXPECTED_MONTHS = {
  1600 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '43-8015', phase_index: 0, even_term: '49-780', even_term_index: 0, odd_term: '4-2615', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '12-4851', phase_index: 0, even_term: '19-4451', even_term_index: 2, odd_term: '34-6286', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '42-847', phase_index: 0, even_term: '49-8122', even_term_index: 4, odd_term: '5-1558', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '11-4371', phase_index: 0, even_term: '20-3393', even_term_index: 6, odd_term: '35-5229', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '41-7161', phase_index: 0, even_term: '50-7065', even_term_index: 8, odd_term: '6-500', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '10-1359', phase_index: 0, even_term: '21-2336', even_term_index: 10, odd_term: '36-4171', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '39-4189', phase_index: 0, even_term: '51-6007', even_term_index: 12, odd_term: '6-7843', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '9-7384', phase_index: 0, even_term: '22-1278', even_term_index: 14, odd_term: '37-3114', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '38-2939', phase_index: 0, even_term: '52-4950', even_term_index: 16, odd_term: '7-6785', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '8-7705', phase_index: 0, even_term: '23-221', even_term_index: 18, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '37-4914', phase_index: 0, even_term: '53-3892', even_term_index: 20, odd_term: '38-2056', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '7-2865', phase_index: 0, even_term: '23-7563', even_term_index: 22, odd_term: '8-5728', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '37-1008', phase_index: 0, even_term: '54-2835', even_term_index: 0, odd_term: '39-999', odd_term_index: 23 }
  ]
}.freeze
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Range' do
      describe 'AnnualRange' do
        describe 'get' do
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
                message += "[year: #{fail[:year]}, \n" \
                           "actual: #{fail[:actual]}\n" \
                           "expect: #{fail[:expect]}]\n"
              end
              message
            end

            it 'should be expected values' do
              fails = []
              SENMYOU_EXPECTED_MONTHS.each do |year, expects|
                actuals = \
                  Zakuro::Senmyou::Range::AnnualRange.get(
                    context: Zakuro::Context::Context.new(version: 'Senmyou'),
                    western_year: year
                  )
                actuals.each_with_index do |month, index|
                  actual = month_actual(month: month)

                  next if actual.eql?(expects[index])

                  fails.push(year: year, actual: actual, expect: expects[index])
                end
              end

              expect(fails).to be_empty, error_message(fails)
            end
            # it 'call example' do
            #   Zakuro::Senmyou::Range::AnnualRange.get(
            #     context: Zakuro::Context::Context.new(version: 'Senmyou'),
            #     western_year: 1333
            #   )
            # end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
