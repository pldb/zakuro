# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/calculation/era/gengou/internal/reserve/range',
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
            let(:last_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
            end
            let(:first_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
                first: false,
                start_date: Zakuro::Western::Calendar.new,
                last_date: Zakuro::Western::Calendar.new
              )
              list.instance_variable_set(
                '@list', [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '元号1',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 1,
                        western: 450
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.new(
                          gengou: '元号1', year: 1, leaped: false, month: 1, day: 1
                        ),
                        western: Zakuro::Western::Calendar.new(
                          year: 450, month: 1, day: 12
                        )
                      ),
                      last_date: Zakuro::Western::Calendar.new(year: 450, month: 3, day: 30)
                    )
                  )
                ]
              )
              list
            end
            let(:second_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
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
              range = Zakuro::Calculation::Gengou::Reserve::Range.new(
                start_date: start_date, last_date: last_date
              )
              range.instance_variable_set('@first_gengou', first_gengou)
              range.instance_variable_set('@second_gengou', second_gengou)
              range
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::Scroll.new(
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
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new
                )
              )
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1)
            end
            let(:last_date) do
              Zakuro::Western::Calendar.new(year: 451, month: 1, day: 1)
            end
            let(:first_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
                first: false,
                start_date: Zakuro::Western::Calendar.new,
                last_date: Zakuro::Western::Calendar.new
              )
              list.instance_variable_set(
                '@list', [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '元号1',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 1,
                        western: 450
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.new(
                          gengou: '元号1', year: 1, leaped: false, month: 1, day: 1
                        ),
                        western: Zakuro::Western::Calendar.new(
                          year: 450, month: 1, day: 1
                        )
                      ),
                      last_date: Zakuro::Western::Calendar.new(year: 450, month: 3, day: 30)
                    )
                  )
                ]
              )
              list
            end
            let(:second_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
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
              range = Zakuro::Calculation::Gengou::Reserve::Range.new(
                start_date: start_date, last_date: last_date
              )
              range.instance_variable_set('@first_gengou', first_gengou)
              range.instance_variable_set('@second_gengou', second_gengou)
              range
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::Scroll.new(
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
              expect(actual[0].name).to eq '元号1'
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
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new
                )
              )
            end
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1)
            end
            let(:last_date) do
              Zakuro::Western::Calendar.new(year: 451, month: 1, day: 1)
            end
            let(:first_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
                first: false,
                start_date: Zakuro::Western::Calendar.new,
                last_date: Zakuro::Western::Calendar.new
              )
              list.instance_variable_set(
                '@list', [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '元号1',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 1,
                        western: 450
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.new(
                          gengou: '元号1', year: 1, leaped: false, month: 1, day: 2
                        ),
                        western: Zakuro::Western::Calendar.new(
                          year: 450, month: 1, day: 2
                        )
                      ),
                      last_date: Zakuro::Western::Calendar.new(year: 450, month: 3, day: 30)
                    )
                  )
                ]
              )
              list
            end
            let(:second_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
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
              range = Zakuro::Calculation::Gengou::Reserve::Range.new(
                start_date: start_date, last_date: last_date
              )
              range.instance_variable_set('@first_gengou', first_gengou)
              range.instance_variable_set('@second_gengou', second_gengou)
              range
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::Scroll.new(
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
              expect(actual[1].name).to eq '元号1'
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
        describe '#ignite' do
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
            let(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 12, day: 3)
            end
            let(:last_date) do
              Zakuro::Western::Calendar.new(year: 451, month: 2, day: 3)
            end
            let(:first_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
                first: false,
                start_date: Zakuro::Western::Calendar.new,
                last_date: Zakuro::Western::Calendar.new
              )
              list.instance_variable_set(
                '@list', [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '元号1',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 1,
                        western: 450
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
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
            let(:second_gengou) do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
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
              range = Zakuro::Calculation::Gengou::Reserve::Range.new(
                start_date: start_date, last_date: last_date
              )
              range.instance_variable_set('@first_gengou', first_gengou)
              range.instance_variable_set('@second_gengou', second_gengou)
              range
            end
            let(:scroll) do
              scroll = Zakuro::Calculation::Gengou::Scroll.new(
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
        # describe '#run' do
        #   context 'range included second gengou' do
        #     let(:months) do
        #       [
        #         Zakuro::Calculation::Monthly::Month.new(
        #           context: context,
        #           month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
        #             number: 8, is_many_days: true, leaped: false
        #           ),
        #           first_day: Zakuro::Calculation::Monthly::FirstDay.new(
        #             western_date: Zakuro::Western::Calendar.new(year: 1331, month: 9, day: 3),
        #             remainder: Zakuro::Senmyou::Cycle::Remainder.new
        #           )
        #         ),
        #         Zakuro::Calculation::Monthly::Month.new(
        #           context: context,
        #           month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
        #             number: 9, is_many_days: false, leaped: false
        #           ),
        #           first_day: Zakuro::Calculation::Monthly::FirstDay.new(
        #             western_date: Zakuro::Western::Calendar.new(year: 1331, month: 10, day: 3),
        #             remainder: Zakuro::Senmyou::Cycle::Remainder.new
        #           )
        #         ),
        #         Zakuro::Calculation::Monthly::Month.new(
        #           context: context,
        #           month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
        #             number: 10, is_many_days: false, leaped: false
        #           ),
        #           first_day: Zakuro::Calculation::Monthly::FirstDay.new(
        #             western_date: Zakuro::Western::Calendar.new(year: 1331, month: 11, day: 1),
        #             remainder: Zakuro::Senmyou::Cycle::Remainder.new
        #           )
        #         ),
        #         Zakuro::Calculation::Monthly::Month.new(
        #           context: context,
        #           month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
        #             number: 11, is_many_days: true, leaped: false
        #           ),
        #           first_day: Zakuro::Calculation::Monthly::FirstDay.new(
        #             western_date: Zakuro::Western::Calendar.new(year: 1331, month: 11, day: 30),
        #             remainder: Zakuro::Senmyou::Cycle::Remainder.new
        #           )
        #         ),
        #         Zakuro::Calculation::Monthly::Month.new(
        #           context: context,
        #           month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
        #             number: 12, is_many_days: false, leaped: false
        #           ),
        #           first_day: Zakuro::Calculation::Monthly::FirstDay.new(
        #             western_date: Zakuro::Western::Calendar.new(year: 1331, month: 12, day: 30),
        #             remainder: Zakuro::Senmyou::Cycle::Remainder.new
        #           )
        #         ),
        #         Zakuro::Calculation::Monthly::Month.new(
        #           context: context,
        #           month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
        #             number: 1, is_many_days: true, leaped: false
        #           ),
        #           first_day: Zakuro::Calculation::Monthly::FirstDay.new(
        #             western_date: Zakuro::Western::Calendar.new(year: 1332, month: 1, day: 28),
        #             remainder: Zakuro::Senmyou::Cycle::Remainder.new
        #           )
        #         ),
        #         Zakuro::Calculation::Monthly::Month.new(
        #           context: context,
        #           month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
        #             number: 2, is_many_days: false, leaped: false
        #           ),
        #           first_day: Zakuro::Calculation::Monthly::FirstDay.new(
        #             western_date: Zakuro::Western::Calendar.new(year: 1332, month: 2, day: 27),
        #             remainder: Zakuro::Senmyou::Cycle::Remainder.new
        #           )
        #         ),
        #         Zakuro::Calculation::Monthly::Month.new(
        #           context: context,
        #           month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
        #             number: 3, is_many_days: true, leaped: false
        #           ),
        #           first_day: Zakuro::Calculation::Monthly::FirstDay.new(
        #             western_date: Zakuro::Western::Calendar.new(year: 1332, month: 3, day: 27),
        #             remainder: Zakuro::Senmyou::Cycle::Remainder.new
        #           )
        #         ),
        #         Zakuro::Calculation::Monthly::Month.new(
        #           context: context,
        #           month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
        #             number: 4, is_many_days: false, leaped: false
        #           ),
        #           first_day: Zakuro::Calculation::Monthly::FirstDay.new(
        #             western_date: Zakuro::Western::Calendar.new(year: 1332, month: 4, day: 26),
        #             remainder: Zakuro::Senmyou::Cycle::Remainder.new
        #           )
        #         )
        #       ]
        #     end
        #     let(:start_date) do
        #       Zakuro::Western::Calendar.new(year: 1332, month: 5, day: 22)
        #     end
        #     let(:last_date) do
        #       Zakuro::Western::Calendar.new(year: 1332, month: 5, day: 23)
        #     end
        #     let(:scroll) do
        #       Zakuro::Calculation::Gengou::Scroll.new(
        #         start_date: start_date, last_date: last_date
        #       )
        #     end
        #     let(:gengou) do
        #       months.each do |month|
        #         scroll.run(month: month)
        #       end
        #       scroll.to_gengou
        #     end

        #     context 'should be started second gengou' do
        #       example 'two element' do
        #         # FIXME: interval の中に2行目元号が一つもない
        #         expect(gengou.second_line.size).to eq 2
        #       end
        #     end
        #   end
        # end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
