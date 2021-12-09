# frozen_string_literal: true

require File.expand_path('../../../../lib/zakuro/calculation/gengou/reserve/interval',
                         __dir__)

require File.expand_path('../../../../lib/zakuro/calculation/gengou/reserve/list',
                         __dir__)

require File.expand_path('../../../../lib/zakuro/calculation/gengou/scroll',
                         __dir__)

require File.expand_path('../../../../lib/zakuro/calculation/monthly/month',
                         __dir__)

require File.expand_path('../../../../lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../lib/zakuro/era/western/calendar',
                         __dir__)
# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Scroll' do
        describe '#run' do
          let(:context) { Zakuro::Context.new(version_name: 'Senmyou') }
          let(:month) do
            Zakuro::Calculation::Monthly::Month.new(
              context: context,
              month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                number: 3, is_many_days: false, leaped: false
              ),
              first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                remainder: Zakuro::Senmyou::Cycle::Remainder.new
              )
            )
          end
          context 'a month has no gengou' do
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
            end
            let(:end_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
            end
            let(:first_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
                first: false,
                start_date: Zakuro::Western::Calendar.new,
                end_date: Zakuro::Western::Calendar.new
              )
              list.instance_variable_set(
                '@list', [
                  Zakuro::Japan::Gengou.new(
                    name: '元号1',
                    both_start_year: Zakuro::Japan::Both::Year.new(
                      japan: 1,
                      western: 450
                    ),
                    both_start_date: Zakuro::Japan::Both::Date.new(
                      japan: Zakuro::Japan::Calendar.new(
                        gengou: '元号1', year: 1, leaped: false, month: 1, day: 1
                      ),
                      western: Zakuro::Western::Calendar.new(
                        year: 450, month: 1, day: 12
                      )
                    ),
                    end_date: Zakuro::Western::Calendar.new(year: 450, month: 3, day: 30)
                  )
                ]
              )
              list
            end
            let(:second_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
                first: false,
                start_date: Zakuro::Western::Calendar.new,
                end_date: Zakuro::Western::Calendar.new
              )
              list.instance_variable_set(
                '@list', []
              )
              list
            end
            let(:interval) do
              interval = Zakuro::Calculation::Gengou::Reserve::Interval.new(
                start_date: start_date, end_date: end_date
              )
              interval.instance_variable_set('@first_gengou', first_gengou)
              interval.instance_variable_set('@second_gengou', second_gengou)
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::Scroll.new(
                start_date: start_date, end_date: end_date
              )
              scroll.instance_variable_set('@interval', interval)
              scroll
            end

            it 'should be empty array on first gengou' do
              scroll.run(month: month)
              expect(scroll.current_first_gengou).to eq []
            end
            it 'should be empty array on second gengou' do
              scroll.run(month: month)
              expect(scroll.current_second_gengou).to eq []
            end
          end
          # TODO: more tests
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
