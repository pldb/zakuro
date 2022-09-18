# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/daien/range/annual_range',
                         __dir__)

# rubocop:disable Layout/LineLength

# @return [Hash<Integer, Array<Hash<Symbol, Object>>>] 期待値
#
# 全件チェックは下記テストケースで実施する
#   spec/zakuro/version/all/daien_spec.rb
#
DAIEN_EXPECTED_MONTHS = {
  780 => [
    # 計算上では11が小の月、（12を飛ばして）1が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '3-54', phase_index: 0, even_term: '8-1308', even_term_index: 0, odd_term: '23-1972', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '32-2481', phase_index: 0, even_term: '38-2636', even_term_index: 2, odd_term: '54-260', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '2-1828', phase_index: 0, even_term: '9-925', even_term_index: 4, odd_term: '24-1589', odd_term_index: 5 },
    # 計算上では2が小の月、3が大の月
    { is_many_days: false, month: 2, leaped: false, remainder: '32-954', phase_index: 0, even_term: '39-2253', even_term_index: 6, odd_term: '54-2918', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '1-2852', phase_index: 0, even_term: '10-542', even_term_index: 8, odd_term: '25-1206', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '31-1439', phase_index: 0, even_term: '40-1870', even_term_index: 10, odd_term: '55-2535', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '0-2637', phase_index: 0, even_term: '11-159', even_term_index: 12, odd_term: '26-823', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '30-563', phase_index: 0, even_term: '41-1488', even_term_index: 14, odd_term: '56-2152', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '59-1479', phase_index: 0, even_term: '11-2816', even_term_index: 16, odd_term: '27-440', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '28-2405', phase_index: 0, even_term: '42-1105', even_term_index: 18, odd_term: '57-1769', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '58-503', phase_index: 0, even_term: '12-2433', even_term_index: 20, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 10, leaped: false, remainder: '27-1911', phase_index: 0, even_term: '43-722', even_term_index: 22, odd_term: '28-58', odd_term_index: 21 },
    # 計算上では11が小の月、（12を飛ばして）1が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '57-569', phase_index: 0, even_term: '13-2051', even_term_index: 0, odd_term: '58-1386', odd_term_index: 23 }
  ]
}.freeze
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Daien' do
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

            # TODO: comment out

            # it 'should be expected values' do
            #   fails = []
            #   DAIEN_EXPECTED_MONTHS.each do |year, expects|
            #     actuals = \
            #       Zakuro::Daien::Range::AnnualRange.get(
            #         context: Zakuro::Context::Context.new(version: 'Daien'),
            #         western_year: year
            #       )
            #     actuals.each_with_index do |month, index|
            #       actual = month_actual(month: month)

            #       next if actual.eql?(expects[index])

            #       fails.push(year: year, actual: actual, expect: expects[index])
            #     end
            #   end

            #   expect(fails).to be_empty, error_message(fails)
            # end
            it 'call example' do
              Zakuro::Daien::Range::AnnualRange.get(
                context: Zakuro::Context::Context.new(version: 'Daien'),
                western_year: 768
              )
              Zakuro::Daien::Range::AnnualRange.get(
                context: Zakuro::Context::Context.new(version: 'Daien'),
                western_year: 852
              )
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
