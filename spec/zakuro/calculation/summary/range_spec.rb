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
            it 'should be a element in result list' do
              actual = Zakuro::Calculation::Summary::Range.get(
                context: context, start_date: start_date, last_date: last_date
              )

              expect(actual.list.size).to eq 1
            end
            it 'should be start date in result array' do
              actual = Zakuro::Calculation::Summary::Range.get(
                context: context, start_date: start_date, last_date: last_date
              )

              expect(actual.list[0].data.day.western_date.format).to eq start_date.format
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

              it "#{start_date} - #{last_date}: #{test['japan_date']}: #{test['description']}" do
                # TODO: more test
              end
            end
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
