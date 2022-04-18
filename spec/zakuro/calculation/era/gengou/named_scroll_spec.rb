# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/era/gengou/internal/reserve/named_range',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/era/gengou/internal/reserve/dated_list',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/calculation/era/gengou/named_scroll',
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
      describe 'NamedScroll' do
        let(:context) { Zakuro::Context.new(version_name: 'Senmyou') }
        describe '#advance' do
          context 'a month beyond year' do
            let(:months) do
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
            let(:start_name) do
              '元号1'
            end
            let(:last_name) do
              '元号1'
            end
            let(:first_list) do
              list = Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                first: false,
                start_date: Zakuro::Western::Calendar.new,
                last_date: Zakuro::Western::Calendar.new
              )
              list.instance_variable_set(
                '@list', [
                  Zakuro::Japan::Gengou::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                      name: '元号1',
                      both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                        japan: 1,
                        western: 450
                      ),
                      both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.new(
                          gengou: '元号1', year: 1, leaped: false, month: 12, day: 1
                        ),
                        western: Zakuro::Western::Calendar.new(
                          year: 449, month: 12, day: 2
                        )
                      ),
                      last_date: Zakuro::Western::Calendar.new(year: 450, month: 3, day: 30)
                    )
                  )
                ]
              )
              list
            end
            let(:second_list) do
              list = Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                first: false,
                start_date: Zakuro::Western::Calendar.new,
                last_date: Zakuro::Western::Calendar.new
              )
              list.instance_variable_set(
                '@list', []
              )
              list
            end
            let(:range) do
              range = Zakuro::Calculation::Gengou::Reserve::NamedRange.new(
                start_name: start_name, last_name: last_name
              )
              range.instance_variable_set('@first_list', first_list)
              range.instance_variable_set('@second_list', second_list)
              range
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::NamedScroll.new(
                start_name: start_name, last_name: last_name
              )
              scroll.instance_variable_set('@range', range)
              scroll
            end
            let(:gengou) do
              scroll.ignite(month: months[0])
              scroll.advance(month: months[1])
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
            it 'should be valid last date' do
              actual = gengou.first_line
              expect(actual[0].last_date.format).to eq '0450-01-29'
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
