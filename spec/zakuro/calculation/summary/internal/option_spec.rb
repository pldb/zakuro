# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/summary/internal/option',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/base/day',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/monthly/month',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Summary' do
      describe 'Option' do
        describe '.create' do
          context 'nothing option setting' do
            it 'should be empty result' do
              options = {}
              context = Zakuro::Context::Context.new(options: options)

              month = Zakuro::Calculation::Monthly::Month.new
              day = Zakuro::Calculation::Base::Day.new
              actual = Zakuro::Calculation::Summary::Option.create(
                context: context, month: month, day: day
              )
              expect(actual.size).to eq 0
            end
          end
          context 'motsunichi option setting with empty solar terms' do
            let!(:actual) do
              options = {
                'dropped_date' => true
              }
              context = Zakuro::Context::Context.new(options: options)

              month = Zakuro::Calculation::Monthly::Month.new
              day = Zakuro::Calculation::Base::Day.new
              Zakuro::Calculation::Summary::Option.create(
                context: context, month: month, day: day
              )
            end
            it 'should be a result' do
              expect(actual.size).to eq 1
            end
            it 'should be a result' do
              expect(actual['dropped_date'].matched).to be_falsey
            end
            # TODO: more test
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
