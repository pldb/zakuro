# frozen_string_literal: true

require File.expand_path('../../../testtools/stringifier',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/calculation/summary/range',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Summary' do
      describe 'Range' do
        describe '.get' do
          context 'any parameter to specify one day' do
            it 'should be a element in result list' do
              context = Zakuro::Context.new(version_name: '')
              start_date = Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
              last_date = Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)

              actual = Zakuro::Calculation::Summary::Range.get(
                context: context, start_date: start_date, last_date: last_date
              )

              expect(actual.list.size).to eq 1
            end
          end
          # TODO: more test
        end
      end
    end
  end
end
