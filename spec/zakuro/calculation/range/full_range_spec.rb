# frozen_string_literal: true

require File.expand_path('../../../testtools/stringifier', __dir__)

require File.expand_path('../../../../' \
                        'lib/zakuro/calculation/monthly/month',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../' \
                       'lib/zakuro/calculation/range/full_range',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/tools/stringifier',
                         __dir__)

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Range' do
      describe 'FullRange' do
        describe '.get' do
          let(:context) { Zakuro::Context.new(version_name: 'Senmyou') }
          context 'specified "貞観" gengou' do
            it 'should be 18 year' do
              date = Zakuro::Western::Calendar.new(year: 873, month: 2, day: 1)
              range = Zakuro::Calculation::Range::FullRange.new(
                context: context, start_date: date
              )
              actual = range.get
              expect(actual.size).to eq 18
            end
          end
        end
      end
    end
  end
end
