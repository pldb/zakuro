# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/gihou/range/annual_range',
                         __dir__)

require_relative './abstract/medieval_comperer'

require_relative './gihou/gihou'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Gihou' do
      context 'all months every year' do
        it 'should be expected values' do
          expected = Zakuro::All::Gihou.get

          fails = []
          expected.each_with_index do |(year, expects), hash_index|
            actuals = \
              Zakuro::Gihou::Range::AnnualRange.get(
                context: Zakuro::Context::Context.new(version: 'Gihou'),
                western_year: year + 1
              )

            # 暦の切り替え時は完全なチェックができない
            if hash_index.zero? || hash_index == expected.size - 1
              Zakuro::All::MedievalComperer.check_with_partially_expection(
                year: year, expects: expects, actuals: actuals, fails: fails
              )
              next
            end

            actuals.each_with_index do |month, index|
              actual = Zakuro::All::MedievalComperer.month_actual(month: month)

              expect_month = expects[index][:month]
              next if actual.eql?(expect_month)

              fails.push(
                year: year, num: expects[index][:num], actual: actual, expect: expect_month
              )
            end
          end

          expect(fails).to be_empty, Zakuro::All::MedievalComperer.error_message(fails)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
