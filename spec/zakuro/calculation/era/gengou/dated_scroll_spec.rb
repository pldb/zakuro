# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/era/gengou/internal/reserve/dated_range',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/era/gengou/internal/reserve/dated_list',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/calculation/era/gengou/dated_scroll',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/calculation/monthly/month',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/western/calendar',
                         __dir__)
# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'DatedScroll' do
        let(:context) { Zakuro::Context::Context.new(version: 'Senmyou') }
        describe '#ignite' do
          context 'a month has no gengou' do
            let(:month) do
              Zakuro::Calculation::Monthly::Month.new(
                context: context,
                month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                  number: 3, is_many_days: false, leaped: false
                ),
                first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                  remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                )
              )
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
            end
            let(:last_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
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
                    gengou: Zakuro::Japan::Type::Base::Gengou.new(
                      name: '元号',
                      start_year: Zakuro::Japan::Type::Base::Both::Year.new(
                        japan: 1,
                        western: 450
                      ),
                      start_date: Zakuro::Japan::Type::Base::SwitchDate.new(
                        calculation: Zakuro::Japan::Type::Base::Both::Date.new,
                        operation: Zakuro::Japan::Type::Base::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.parse(text: '元号1年1月1日'),
                          western: Zakuro::Western::Calendar.parse(text: '0450-01-12')
                        ),
                        operated: true
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
              range = Zakuro::Calculation::Gengou::Reserve::DatedRange.new(
                start_date: start_date, last_date: last_date
              )
              range.instance_variable_set('@first_list', first_list)
              range.instance_variable_set('@second_list', second_list)
              range
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::DatedScroll.new(
                start_date: start_date, last_date: last_date
              )
              scroll.instance_variable_set('@range', range)
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
                  remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                )
              )
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1)
            end
            let(:last_date) do
              Zakuro::Western::Calendar.new(year: 451, month: 1, day: 1)
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
                    gengou: Zakuro::Japan::Type::Base::Gengou.new(
                      name: '元号',
                      start_year: Zakuro::Japan::Type::Base::Both::Year.new(
                        japan: 1,
                        western: 450
                      ),
                      start_date: Zakuro::Japan::Type::Base::SwitchDate.new(
                        calculation: Zakuro::Japan::Type::Base::Both::Date.new,
                        operation: Zakuro::Japan::Type::Base::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.parse(text: '元号1年1月1日'),
                          western: Zakuro::Western::Calendar.parse(text: '0450-01-01')
                        ),
                        operated: true
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
              range = Zakuro::Calculation::Gengou::Reserve::DatedRange.new(
                start_date: start_date, last_date: last_date
              )
              range.instance_variable_set('@first_list', first_list)
              range.instance_variable_set('@second_list', second_list)
              range
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::DatedScroll.new(
                start_date: start_date, last_date: last_date
              )
              scroll.instance_variable_set('@range', range)
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
              expect(actual[0].name).to eq '元号'
            end
            it 'should be first day on a month' do
              actual = gengou.first_line
              expect(actual[0].start_date.format).to eq '0450-01-01'
            end
            it 'should be last day on a month' do
              actual = gengou.first_line
              expect(actual[0].last_date.format).to eq '0450-01-29'
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
                  remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                )
              )
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1)
            end
            let(:last_date) do
              Zakuro::Western::Calendar.new(year: 451, month: 1, day: 1)
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
                    gengou: Zakuro::Japan::Type::Base::Gengou.new(
                      name: '元号',
                      start_year: Zakuro::Japan::Type::Base::Both::Year.new(
                        japan: 1,
                        western: 450
                      ),
                      start_date: Zakuro::Japan::Type::Base::SwitchDate.new(
                        calculation: Zakuro::Japan::Type::Base::Both::Date.new,
                        operation: Zakuro::Japan::Type::Base::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.parse(text: '元号1年1月2日'),
                          western: Zakuro::Western::Calendar.parse(text: '0450-01-02')
                        ),
                        operated: true
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
              range = Zakuro::Calculation::Gengou::Reserve::DatedRange.new(
                start_date: start_date, last_date: last_date
              )
              range.instance_variable_set('@first_list', first_list)
              range.instance_variable_set('@second_list', second_list)
              range
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::DatedScroll.new(
                start_date: start_date, last_date: last_date
              )
              scroll.instance_variable_set('@range', range)
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
              expect(actual[1].name).to eq '元号'
            end
            it 'should be first day on a month' do
              actual = gengou.first_line
              expect(actual[1].start_date.format).to eq '0450-01-02'
            end
            it 'should be last day on a month' do
              actual = gengou.first_line
              expect(actual[1].last_date.format).to eq '0450-01-29'
            end
            it 'should be invalid element on second gengou' do
              actual = gengou.second_line
              expect(actual[0].invalid?).to be_truthy
            end
          end
        end
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
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 1, is_many_days: false, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                )
              ]
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 12, day: 3)
            end
            let(:last_date) do
              Zakuro::Western::Calendar.new(year: 451, month: 2, day: 3)
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
                    gengou: Zakuro::Japan::Type::Base::Gengou.new(
                      name: '元号',
                      start_year: Zakuro::Japan::Type::Base::Both::Year.new(
                        japan: 1,
                        western: 450
                      ),
                      start_date: Zakuro::Japan::Type::Base::SwitchDate.new(
                        calculation: Zakuro::Japan::Type::Base::Both::Date.new,
                        operation: Zakuro::Japan::Type::Base::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.parse(text: '元号1年12月1日'),
                          western: Zakuro::Western::Calendar.parse(text: '0449-12-02')
                        ),
                        operated: true
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
              range = Zakuro::Calculation::Gengou::Reserve::DatedRange.new(
                start_date: start_date, last_date: last_date
              )
              range.instance_variable_set('@first_list', first_list)
              range.instance_variable_set('@second_list', second_list)
              range
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::DatedScroll.new(
                start_date: start_date, last_date: last_date
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
              expect(actual[0].name).to eq '元号'
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
        describe '#run' do
          context 'range included second gengou' do
            let(:months) do
              [
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 8, is_many_days: true, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 1331, month: 9, day: 3),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 9, is_many_days: false, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 1331, month: 10, day: 3),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 10, is_many_days: false, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 1331, month: 11, day: 1),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 11, is_many_days: true, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 1331, month: 11, day: 30),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 12, is_many_days: false, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 1331, month: 12, day: 30),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 1, is_many_days: true, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 1332, month: 1, day: 28),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 2, is_many_days: false, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 1332, month: 2, day: 27),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 3, is_many_days: true, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 1332, month: 3, day: 27),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                ),
                Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 4, is_many_days: false, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 1332, month: 4, day: 26),
                    remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new
                  )
                )
              ]
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 1332, month: 5, day: 22)
            end
            let(:last_date) do
              Zakuro::Western::Calendar.new(year: 1332, month: 5, day: 23)
            end
            let(:scroll) do
              Zakuro::Calculation::Gengou::DatedScroll.new(
                start_date: start_date, last_date: last_date
              )
            end
            let(:gengou) do
              months.each do |month|
                scroll.run(month: month)
              end
              scroll.to_gengou
            end

            context 'should be started second gengou' do
              example 'two element' do
                expect(gengou.second_line.size).to eq 2
              end
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
