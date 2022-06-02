# frozen_string_literal: true

require File.expand_path('../../../../testtools/stringifier',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/summary/japan/range',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../testdata/single_data_factory',
                         __dir__)

# rubocop:disable Metrics/BlockLength

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Summary' do
      describe 'Japan' do
        describe 'Range' do
          describe '.get' do
            context 'any parameter to specify one day' do
              let!(:context) do
                Zakuro::Context.new(version_name: '')
              end
              let!(:start_date) do
                # Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
                Zakuro::Japan::Calendar.parse(text: '允恭天皇34年1月1日')
              end
              let!(:last_date) do
                # Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
                Zakuro::Japan::Calendar.parse(text: '允恭天皇34年1月1日')
              end
              let!(:actual) do
                Zakuro::Calculation::Summary::Japan::Range.get(
                  context: context, start_date: start_date, last_date: last_date
                )
              end
              it 'should be a element in result list' do
                expect(actual.list.size).to eq 1
              end
              it 'should be start date in result array' do
                expect(actual.list[0].data.day.western_date.format).to eq '0445-01-24'
              end
            end
            context 'any parameter to specify a year' do
              let!(:context) do
                Zakuro::Context.new(version_name: '')
              end
              let!(:start_date) do
                # Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
                Zakuro::Japan::Calendar.parse(text: '允恭天皇34年1月1日')
              end
              let!(:last_date) do
                # Zakuro::Western::Calendar.new(year: 446, month: 2, day: 11)
                Zakuro::Japan::Calendar.parse(text: '允恭天皇34年12月30日')
              end
              let!(:actual) do
                Zakuro::Calculation::Summary::Japan::Range.get(
                  context: context, start_date: start_date, last_date: last_date
                )
              end

              it 'should be a element in result list' do
                expect(actual.list.size).to eq 384
              end
              it 'should be start date in result array' do
                expect(actual.list[0].data.day.western_date.format).to eq '0445-01-24'
              end
              it 'should be last date in result array' do
                expect(actual.list[-1].data.day.western_date.format).to eq '0446-02-11'
              end
            end
            context 'all range data' do
              filepath = File.expand_path(
                '../testdata/yaml/range.yaml',
                __dir__
              )
              hash = YAML.load_file(filepath)

              hash.each do |test|
                japan = test['japan']
                start_date = japan['start_date']
                last_date = japan['last_date']
                list = []
                test['expected'].each do |day|
                  single_data = SingleDataFactory.create(hash: day)
                  list.push(single_data)
                end
                expected_range = Zakuro::Result::Range.new(list: list)

                it "#{start_date} - #{last_date}: #{japan['all']}: #{test['description']}" do
                  actual = Zakuro::Calculation::Summary::Japan::Range.get(
                    context: Zakuro::Context.new(version_name: ''),
                    start_date: Zakuro::Japan::Calendar.parse(text: start_date),
                    last_date: Zakuro::Japan::Calendar.parse(text: last_date)
                  )

                  TestTools::Stringifier.eql?(
                    expected: expected_range,
                    actual: actual,
                    class_prefix: 'Zakuro::Result'
                  )
                end
              end
            end
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
