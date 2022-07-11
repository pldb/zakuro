# frozen_string_literal: true

require File.expand_path('../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/calculation/range/operated_solar_term',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/calculation/monthly/operated_month',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/calculation/monthly/first_day',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/calculation/monthly/month_label',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/calculation/base/operated_year',
                         __dir__)

require File.expand_path('../../../../' \
                          'lib/zakuro/version/senmyou/cycle/remainder',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Base' do
      describe 'OperatedYear' do
        let(:context) { Zakuro::Context::Context.new(version: 'Senmyou') }
        let(:first_day) do
          Zakuro::Calculation::Monthly::FirstDay.new(
            remainder: Zakuro::Senmyou::Cycle::Remainder.new
          )
        end
        let(:operated_solar_term) do
          Zakuro::Calculation::Range::OperatedSolarTerm.new(context: context)
        end
        let(:months) do
          [
            Zakuro::Calculation::Monthly::OperatedMonth.new(
              context: context, operated_solar_term: operated_solar_term,
              month_label: Zakuro::Calculation::Monthly::MonthLabel.new(number: 3),
              first_day: first_day
            ),
            Zakuro::Calculation::Monthly::OperatedMonth.new(
              context: context, operated_solar_term: operated_solar_term,
              month_label: Zakuro::Calculation::Monthly::MonthLabel.new(number: 4),
              first_day: first_day
            )
          ]
        end
        describe '.unshift_months' do
          context 'a parameter' do
            it 'should be added to start of months' do
              year = Zakuro::Calculation::Base::OperatedYear.new(months: months)
              first_months = [
                Zakuro::Calculation::Monthly::OperatedMonth.new(
                  context: context, operated_solar_term: operated_solar_term,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(number: 2),
                  first_day: first_day
                )
              ]
              year.unshift_months(first_months)

              expect(year.months[0].month_label.number).to eq 2
            end
          end
        end
        describe '.push_months' do
          context 'a parameter' do
            it 'should be added to end of months' do
              year = Zakuro::Calculation::Base::OperatedYear.new(months: months)
              first_months = [
                Zakuro::Calculation::Monthly::OperatedMonth.new(
                  context: context, operated_solar_term: operated_solar_term,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(number: 5),
                  first_day: first_day
                )
              ]
              year.push_months(first_months)

              expect(year.months[-1].month_label.number).to eq 5
            end
          end
        end
        describe '.shift_last_year_months' do
          context 'a parameter' do
            it 'should be removed months on last year' do
              jan = double('Jan')
              allow(jan).to receive(:last_year?).and_return(true)
              allow(jan).to receive(:moved?).and_return(false)
              feb = double('Feb')
              allow(feb).to receive(:last_year?).and_return(false)
              allow(feb).to receive(:moved?).and_return(false)
              months = [jan, feb]
              year = Zakuro::Calculation::Base::OperatedYear.new(months: months)
              year.shift_last_year_months

              expect(year.months.size).to eq 1
            end
          end
        end
        describe '.pop_next_year_months' do
          context 'a parameter' do
            it 'should be removed months on next year' do
              nov = double('Nov')
              allow(nov).to receive(:next_year?).and_return(false)
              allow(nov).to receive(:moved?).and_return(false)
              dec = double('Dec')
              allow(dec).to receive(:next_year?).and_return(true)
              allow(dec).to receive(:moved?).and_return(false)
              months = [nov, dec]
              year = Zakuro::Calculation::Base::OperatedYear.new(months: months)
              year.pop_next_year_months

              expect(year.months.size).to eq 1
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
