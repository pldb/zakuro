# frozen_string_literal: true

require File.expand_path('../../../../testtool/stringifier',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/summary/western/range',
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
      describe 'Western' do
        describe 'Range' do
          describe '.get' do
            context 'any parameter to specify one day' do
              let!(:context) do
                Zakuro::Context::Context.new(version: '')
              end
              let!(:start_date) do
                Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
              end
              let!(:last_date) do
                Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
              end
              let!(:actual) do
                Zakuro::Calculation::Summary::Western::Range.get(
                  context: context, start_date: start_date, last_date: last_date
                )
              end
              it 'should be a element in result list' do
                expect(actual.list.size).to eq 1
              end
              it 'should be start date in result array' do
                expect(actual.list[0].data.day.western_date.format).to eq start_date.format
              end
            end
            context 'any parameter to specify a year' do
              let!(:context) do
                Zakuro::Context::Context.new(version: '')
              end
              let!(:start_date) do
                Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
              end
              let!(:last_date) do
                Zakuro::Western::Calendar.new(year: 446, month: 2, day: 11)
              end
              let!(:actual) do
                Zakuro::Calculation::Summary::Western::Range.get(
                  context: context, start_date: start_date, last_date: last_date
                )
              end

              it 'should be a element in result list' do
                expect(actual.list.size).to eq 384
              end
              it 'should be start date in result array' do
                expect(actual.list[0].data.day.western_date.format).to eq start_date.format
              end
              it 'should be last date in result array' do
                expect(actual.list[-1].data.day.western_date.format).to eq last_date.format
              end
            end
            context 'all range data' do
              filepath = File.expand_path(
                '../testdata/yaml/range.yaml',
                __dir__
              )
              hash = YAML.load_file(filepath)

              hash.each do |test|
                western = test['western']
                start_date = western['start_date']
                last_date = western['last_date']
                list = []
                test['expected'].each do |day|
                  single_data = SingleDataFactory.create(hash: day)
                  list.push(single_data)
                end
                expected_range = Zakuro::Result::Range.new(list: list)

                note = "#{test['japan']['japan_date']}: #{test['description']}"
                it "#{start_date} - #{last_date}: #{note}" do
                  actual = Zakuro::Calculation::Summary::Western::Range.get(
                    context: Zakuro::Context::Context.new(version: ''),
                    start_date: Zakuro::Western::Calendar.parse(text: start_date),
                    last_date: Zakuro::Western::Calendar.parse(text: last_date)
                  )

                  TestTool::Stringifier.eql?(
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
