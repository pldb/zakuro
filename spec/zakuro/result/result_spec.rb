# frozen_string_literal: true

require File.expand_path('../../../../zakuro/lib/zakuro/result/result',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Result' do
    describe 'SingleDay' do
      describe '#to_h' do
        context 'a instance' do
          let!(:instance) do
            Zakuro::Result::Data::SingleDay.new(
              year: Zakuro::Result::Data::Year.new(
                first_gengou: Zakuro::Result::Data::Gengou.new(name: '貞観', number: '4'),
                second_gengou: Zakuro::Result::Data::Gengou.new(name: '', number: ''),
                zodiac_name: '壬午',
                total_days: '354'
              ),
              month: Zakuro::Result::Data::Month.new(
                number: '1', leaped: false,
                days_name: '大',
                first_day: Zakuro::Result::Data::Day.new(
                  number: '1', zodiac_name: '庚午', remainder: '6-1282',
                  western_date: '0862-02-03'
                ),
                odd_solar_terms: [
                  Zakuro::Result::Data::SolarTerm.new(
                    index: '5', remainder: '34-5368'
                  )
                ],
                even_solar_terms: [
                  Zakuro::Result::Data::SolarTerm.new(
                    index: '4', remainder: '19-3532'
                  )
                ]
              ),
              day: Zakuro::Result::Data::Day.new(
                number: '1', zodiac_name: '庚午', remainder: '6-1282',
                western_date: '0862-02-03'
              )
            )
          end
          it 'should be hash' do
            expect(instance.to_h).to eq(
              {
                'year' => {
                  'first_gengou' => {
                    'name' => '貞観',
                    'number' => '4'
                  },
                  'second_gengou' => {
                    'name' => '',
                    'number' => ''
                  },
                  'zodiac_name' => '壬午',
                  'total_days' => '354'
                },
                'month' => {
                  'number' => '1',
                  'leaped' => false,
                  'days_name' => '大',
                  'first_day' => {
                    'number' => '1',
                    'zodiac_name' => '庚午',
                    'remainder' => '6-1282',
                    'western_date' => '0862-02-03'
                  },
                  'odd_solar_terms' => [
                    {
                      'index' => '5',
                      'remainder' => '34-5368'
                    }
                  ],
                  'even_solar_terms' => [
                    {
                      'index' => '4',
                      'remainder' => '19-3532'
                    }
                  ]
                },
                'day' => {
                  'number' => '1',
                  'zodiac_name' => '庚午',
                  'remainder' => '6-1282',
                  'western_date' => '0862-02-03'
                },
                'options' => {}
              }
            )
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
