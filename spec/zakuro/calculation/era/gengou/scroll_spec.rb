# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/calculation/era/gengou/internal/reserve/interval',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/calculation/era/gengou/internal/reserve/list',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/calculation/era/gengou/scroll',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/calculation/monthly/month',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/western/calendar',
                         __dir__)
# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Scroll' do
        let(:context) { Zakuro::Context.new(version_name: 'Senmyou') }
        describe '#ignite' do
          context 'a month has no gengou' do
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
              interval
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::Scroll.new(
                start_date: start_date, end_date: end_date
              )
              scroll.instance_variable_set('@interval', interval)
              scroll
            end
            let(:gengou) do
              scroll.ignite(month: month)
              scroll.to_gengou
            end

            it 'should be empty array on first gengou' do
              expect(gengou.first_line).to eq []
            end
            it 'should be empty array on second gengou' do
              expect(gengou.second_line).to eq []
            end
          end
          context 'a month has a first gengou with same start date' do
            let(:month) do
              Zakuro::Calculation::Monthly::Month.new(
                context: context,
                month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                  number: 1, is_many_days: false, leaped: false
                ),
                first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                  western_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1),
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new
                )
              )
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1)
            end
            let(:end_date) do
              Zakuro::Western::Calendar.new(year: 451, month: 1, day: 1)
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
                        year: 450, month: 1, day: 1
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
              interval
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::Scroll.new(
                start_date: start_date, end_date: end_date
              )
              scroll.instance_variable_set('@interval', interval)
              scroll
            end
            let(:gengou) do
              scroll.ignite(month: month)
              scroll.to_gengou
            end

            it 'should be a element on first gengou' do
              expect(gengou.first_line.size).to eq 1
            end
            it 'should be a specified element on first gengou' do
              actual = gengou.first_line
              expect(actual[0].name).to eq '元号1'
            end
            it 'should be first day on a month' do
              actual = gengou.first_line
              expect(actual[0].start_date.format).to eq '0450-01-01'
            end
            it 'should be last day on a month' do
              actual = gengou.first_line
              expect(actual[0].end_date.format).to eq '0450-01-29'
            end
            it 'should be invalid element on second gengou' do
              actual = gengou.second_line
              expect(actual[0].invalid?).to be_truthy
            end
          end
          context 'a month has a first gengou with different start date' do
            let(:month) do
              Zakuro::Calculation::Monthly::Month.new(
                context: context,
                month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                  number: 1, is_many_days: false, leaped: false
                ),
                first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                  western_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1),
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new
                )
              )
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1)
            end
            let(:end_date) do
              Zakuro::Western::Calendar.new(year: 451, month: 1, day: 1)
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
                        gengou: '元号1', year: 1, leaped: false, month: 1, day: 2
                      ),
                      western: Zakuro::Western::Calendar.new(
                        year: 450, month: 1, day: 2
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
              interval
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::Scroll.new(
                start_date: start_date, end_date: end_date
              )
              scroll.instance_variable_set('@interval', interval)
              scroll
            end
            let(:gengou) do
              scroll.ignite(month: month)
              scroll.to_gengou
            end
            it 'should be a element on first gengou' do
              expect(gengou.first_line.size).to eq 2
            end
            it 'should be included a invalid element on first gengou' do
              actual = gengou.first_line
              expect(actual[0].invalid?).to be_truthy
            end
            it 'should be included a specified element on first gengou' do
              actual = gengou.first_line
              expect(actual[1].name).to eq '元号1'
            end
            it 'should be first day on a month' do
              actual = gengou.first_line
              expect(actual[1].start_date.format).to eq '0450-01-02'
            end
            it 'should be last day on a month' do
              actual = gengou.first_line
              expect(actual[1].end_date.format).to eq '0450-01-29'
            end
            it 'should be invalid element on second gengou' do
              actual = gengou.second_line
              expect(actual[0].invalid?).to be_truthy
            end
          end
        end
        describe '#ignite' do
          context 'xxx' do
            let(:monthes) do
              [
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 12, is_many_days: true, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 449, month: 12, day: 2),
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 1, is_many_days: false, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1),
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new
                  )
                )
              ]
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 12, day: 3)
            end
            let(:end_date) do
              Zakuro::Western::Calendar.new(year: 451, month: 2, day: 3)
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
                        gengou: '元号1', year: 1, leaped: false, month: 12, day: 1
                      ),
                      western: Zakuro::Western::Calendar.new(
                        year: 449, month: 12, day: 2
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
              interval
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::Scroll.new(
                start_date: start_date, end_date: end_date
              )
              scroll.instance_variable_set('@interval', interval)
              scroll
            end
            let(:gengou) do
              scroll.ignite(month: monthes[0])
              scroll.advance(month: monthes[1])
              scroll.to_gengou
            end

            it 'should be a element on first gengou' do
              expect(gengou.first_line.size).to eq 1
            end
            it 'should be included a specified element on first gengou' do
              actual = gengou.first_line
              expect(actual[0].name).to eq '元号1'
            end
            it 'should be valid start date' do
              actual = gengou.first_line
              expect(actual[0].start_date.format).to eq '0450-01-01'
            end
            it 'should be valid end date' do
              actual = gengou.first_line
              expect(actual[0].end_date.format).to eq '0450-01-29'
            end
            it 'should be counted up' do
              actual = gengou.first_line
              expect(actual[0].year).to eq 2
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
