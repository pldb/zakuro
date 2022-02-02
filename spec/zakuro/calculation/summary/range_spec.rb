# frozen_string_literal: true

require File.expand_path('../../../testtools/stringifier',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/calculation/summary/range',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('./single_data_factory',
                         __dir__)

# rubocop:disable Metrics/BlockLength

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Summary' do
      describe 'Range' do
        describe '.get' do
          context 'any parameter to specify one day' do
            let!(:context) do
              Zakuro::Context.new(version_name: '')
            end
            let!(:start_date) do
              Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
            end
            let!(:last_date) do
              Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
            end
            let!(:actual) do
              Zakuro::Calculation::Summary::Range.get(
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
              Zakuro::Context.new(version_name: '')
            end
            let!(:start_date) do
              Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
            end
            let!(:last_date) do
              Zakuro::Western::Calendar.new(year: 446, month: 2, day: 11)
            end
            let!(:actual) do
              Zakuro::Calculation::Summary::Range.get(
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
              './yaml/range.yaml',
              __dir__
            )
            hash = YAML.load_file(filepath)

            hash.each do |test|
              start_date = test['start_date']
              last_date = test['last_date']
              list = []
              test['expected'].each do |day|
                single_data = SingleDataFactory.create(hash: day)
                list.push(single_data)
              end
              expected_range = Zakuro::Result::Range.new(list: list)

              # TODO: 下記テストに失敗する
              # * id: 3
              # * id: 4
              it "#{start_date} - #{last_date}: #{test['japan_date']}: #{test['description']}" do
                actual = Zakuro::Calculation::Summary::Range.get(
                  context: Zakuro::Context.new(version_name: ''),
                  start_date: Zakuro::Western::Calendar.parse(str: start_date),
                  last_date: Zakuro::Western::Calendar.parse(str: last_date)
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

# rubocop:enable Metrics/BlockLength
