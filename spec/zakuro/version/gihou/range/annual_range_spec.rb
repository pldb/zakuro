# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/gihou/range/annual_range',
                         __dir__)

# rubocop:disable Layout/LineLength

# @return [Hash<Integer, Array<Hash<Symbol, Object>>>] 期待値
#
# 全件チェックは下記テストケースで実施する
#   spec/zakuro/version/all/gihou_spec.rb
#
GIHOU_EXPECTED_MONTHS = {
  700 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '47-1041', phase_index: 0, even_term: '8-1328', even_term_index: 0, odd_term: '53-1035', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '17-756', phase_index: 0, even_term: '39-573', even_term_index: 2, odd_term: '24-280', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '47-465', phase_index: 0, even_term: '9-1159', even_term_index: 4, odd_term: '54-866', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '17-102', phase_index: 0, even_term: '40-405', even_term_index: 6, odd_term: '25-112', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '46-960', phase_index: 0, even_term: '10-990', even_term_index: 8, odd_term: '55-697', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '16-255', phase_index: 0, even_term: '41-236', even_term_index: 10, odd_term: '25-1283', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '45-810', phase_index: 0, even_term: '11-822', even_term_index: 12, odd_term: '56-529', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '14-1253', phase_index: 0, even_term: '42-67', even_term_index: 14, odd_term: '26-1114', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '44-295', phase_index: 0, even_term: '12-653', even_term_index: 16, odd_term: '57-360', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: true, remainder: '13-684', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '27-946', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '42-1118', phase_index: 0, even_term: '42-1239', even_term_index: 18, odd_term: '58-191', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '12-475', phase_index: 0, even_term: '13-484', even_term_index: 20, odd_term: '28-777', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '41-1255', phase_index: 0, even_term: '43-1070', even_term_index: 22, odd_term: '59-23', odd_term_index: 23 }
  ]
}.freeze
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Gihou' do
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
            #   GIHOU_EXPECTED_MONTHS.each do |year, expects|
            #     actuals = \
            #       Zakuro::Gihou::Range::AnnualRange.get(
            #         context: Zakuro::Context::Context.new(version: 'Gihou'),
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
              Zakuro::Gihou::Range::AnnualRange.get(
                context: Zakuro::Context::Context.new(version: 'Gihou'),
                western_year: 702
              )
              Zakuro::Gihou::Range::AnnualRange.get(
                context: Zakuro::Context::Context.new(version: 'Gihou'),
                western_year: 719
              )
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
