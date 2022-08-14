# frozen_string_literal: true

require File.expand_path('../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/version/genka/range/annual_range',
                         __dir__)

require_relative './genka/genka'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
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
              expected = Zakuro::All::Genka.get

              fails = []
              expected.each do |year, expects|
                actuals = \
                  Zakuro::Genka::Range::AnnualRange.get(
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
            #   Zakuro::Genka::Range::AnnualRange.get(
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
# rubocop:enable Metrics/BlockLength
