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
            # TODO: more test
          end
        end
      end
    end
  end
end
