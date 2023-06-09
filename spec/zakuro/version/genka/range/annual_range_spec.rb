# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/genka/range/annual_range',
                         __dir__)

# rubocop:disable Layout/LineLength

# :nodoc:
module Zakuro
  # @return [Hash<Integer, Array<Hash<Symbol, Object>>>] 期待値
  #
  # 全件チェックは下記テストケースで実施する
  #   spec/zakuro/version/all/genka_spec.rb
  #
  GENKA_EXPECTED_MONTHS = {
    445 => [
      { is_many_days: true, month: 1, leaped: false, remainder: '27.6157', phase_index: 0, even_term: '52.4836', even_term_index: 4, odd_term: '37.2649', odd_term_index: 3 },
      { is_many_days: false, month: 2, leaped: false, remainder: '57.1463', phase_index: 0, even_term: '22.9208', even_term_index: 6, odd_term: '7.7022', odd_term_index: 5 },
      { is_many_days: true, month: 3, leaped: false, remainder: '26.6769', phase_index: 0, even_term: '53.3580', even_term_index: 8, odd_term: '38.1394', odd_term_index: 7 },
      { is_many_days: false, month: 4, leaped: false, remainder: '56.2074', phase_index: 0, even_term: '23.7952', even_term_index: 10, odd_term: '8.5766', odd_term_index: 9 },
      { is_many_days: true, month: 5, leaped: false, remainder: '25.7380', phase_index: 0, even_term: '54.2325', even_term_index: 12, odd_term: '39.0138', odd_term_index: 11 },
      { is_many_days: false, month: 5, leaped: true, remainder: '55.2686', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '9.4511', odd_term_index: 13 },
      { is_many_days: true, month: 6, leaped: false, remainder: '24.7992', phase_index: 0, even_term: '24.6697', even_term_index: 14, odd_term: '39.8883', odd_term_index: 15 },
      { is_many_days: false, month: 7, leaped: false, remainder: '54.3298', phase_index: 0, even_term: '55.1069', even_term_index: 16, odd_term: '10.3255', odd_term_index: 17 },
      { is_many_days: true, month: 8, leaped: false, remainder: '23.8604', phase_index: 0, even_term: '25.5441', even_term_index: 18, odd_term: '40.7627', odd_term_index: 19 },
      { is_many_days: false, month: 9, leaped: false, remainder: '53.3910', phase_index: 0, even_term: '55.9814', even_term_index: 20, odd_term: '11.2000', odd_term_index: 21 },
      { is_many_days: true, month: 10, leaped: false, remainder: '22.9215', phase_index: 0, even_term: '26.4186', even_term_index: 22, odd_term: '41.6372', odd_term_index: 23 },
      { is_many_days: false, month: 11, leaped: false, remainder: '52.4521', phase_index: 0, even_term: '56.8558', even_term_index: 0, odd_term: '12.0744', odd_term_index: 1 },
      { is_many_days: true, month: 12, leaped: false, remainder: '21.9827', phase_index: 0, even_term: '27.2930', even_term_index: 2, odd_term: '42.5117', odd_term_index: 3 }
    ]
  }.freeze
end
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Version' do
    describe 'Genka' do
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
                Zakuro::GENKA_EXPECTED_MONTHS.each do |year, expects|
                  actuals = \
                    Zakuro::Version::Genka::Range::AnnualRange.get(
                      context: Zakuro::Context::Context.new(version: 'Genka'),
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
              #   Zakuro::Version::Genka::Range::AnnualRange.get(
              #     context: Zakuro::Context::Context.new(version: 'Genka'),
              #     western_year: 468
              #   )
              # end
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
