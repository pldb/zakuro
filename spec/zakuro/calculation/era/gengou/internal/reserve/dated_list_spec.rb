# frozen_string_literal: true

require File.expand_path('../../../../../../../' \
                         'lib/zakuro/calculation/era/gengou/internal/reserve/dated_list',
                         __dir__)

require File.expand_path('../../../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

require File.expand_path('../../../../../../../lib/zakuro/era/japan/gengou/resource',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Reserve' do
        describe 'DatedList' do
          context 'first line' do
            context 'western date has a gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: true,
                  start_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2),
                  last_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
                )
              end
              it 'should be a element in result array' do
                actual = list.list
                expect(actual.size).to eq 1
              end
              it 'should be target gengou' do
                actual = list.list
                expect(actual[0].name).to eq '允恭天皇'
              end
              it 'should be start year on target gengou' do
                actual = list.western_start_year
                expect(actual).to eq 445
              end
              it 'should be end year on target gengou' do
                actual = list.western_last_year
                expect(actual).to eq 453
              end
            end
            context 'western date has two gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: true,
                  start_date: Zakuro::Western::Calendar.new(year: 454, month: 2, day: 13),
                  last_date: Zakuro::Western::Calendar.new(year: 454, month: 2, day: 14)
                )
              end
              it 'should be two elements in result array' do
                actual = list.list
                expect(actual.size).to eq 2
              end
              it 'should be a gengou to include start date' do
                actual = list.list
                expect(actual[0].name).to eq '允恭天皇'
              end
              it 'should be a gengou to include end date' do
                actual = list.list
                expect(actual[1].name).to eq '安康天皇'
              end
              it 'should be start year on a first element' do
                actual = list.western_start_year
                expect(actual).to eq 445
              end
              it 'should be end year on a last element' do
                actual = list.western_last_year
                expect(actual).to eq 456
              end
            end
            context 'western date has a gengou and previous gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: true,
                  start_date: Zakuro::Western::Calendar.new(year: 454, month: 3, day: 13),
                  last_date: Zakuro::Western::Calendar.new(year: 454, month: 3, day: 13)
                )
              end
              it 'should be two elements in result array' do
                actual = list.list
                expect(actual.size).to eq 2
              end
              it 'should be a previous gengou' do
                actual = list.list
                expect(actual[0].name).to eq '允恭天皇'
              end
              it 'should be a gengou between start date and end date' do
                actual = list.list
                expect(actual[1].name).to eq '安康天皇'
              end
            end
            context 'western date has a gengou and next gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: true,
                  start_date: Zakuro::Western::Calendar.new(year: 454, month: 1, day: 14),
                  last_date: Zakuro::Western::Calendar.new(year: 454, month: 1, day: 14)
                )
              end
              it 'should be two elements in result array' do
                actual = list.list
                expect(actual.size).to eq 2
              end
              it 'should be a gengou between start date and end date' do
                actual = list.list
                expect(actual[0].name).to eq '允恭天皇'
              end
              it 'should be a next gengou' do
                actual = list.list
                expect(actual[1].name).to eq '安康天皇'
              end
            end
          end
          context 'second line' do
            context 'western date has a gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: false,
                  start_date: Zakuro::Western::Calendar.new(year: 1332, month: 5, day: 23),
                  last_date: Zakuro::Western::Calendar.new(year: 1332, month: 5, day: 23)
                )
              end
              it 'should be a element in result array' do
                actual = list.list
                expect(actual.size).to eq 1
              end
              it 'should be target gengou' do
                actual = list.list
                expect(actual[0].name).to eq '正慶'
              end
              it 'should be start year on target gengou' do
                actual = list.western_start_year
                expect(actual).to eq 1332
              end
              it 'should be end year on target gengou' do
                actual = list.western_last_year
                expect(actual).to eq 1333
              end
            end
            context 'western date has two gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: false,
                  start_date: Zakuro::Western::Calendar.new(year: 1334, month: 3, day: 4),
                  last_date: Zakuro::Western::Calendar.new(year: 1334, month: 3, day: 5)
                )
              end
              it 'should be two elements in result array' do
                actual = list.list
                expect(actual.size).to eq 2
              end
              it 'should be a gengou to include start date' do
                actual = list.list
                expect(actual[0].name).to eq '正慶'
              end
              it 'should be a gengou to include end date' do
                actual = list.list
                expect(actual[1].name).to eq '建武'
              end
              it 'should be start year on a first element' do
                actual = list.western_start_year
                expect(actual).to eq 1332
              end
              it 'should be end year on a last element' do
                actual = list.western_last_year
                expect(actual).to eq 1337
              end
            end
            context 'western date has a gengou and previous gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: false,
                  start_date: Zakuro::Western::Calendar.new(year: 1334, month: 4, day: 4),
                  last_date: Zakuro::Western::Calendar.new(year: 1334, month: 4, day: 4)
                )
              end
              it 'should be two elements in result array' do
                actual = list.list
                expect(actual.size).to eq 2
              end
              it 'should be a previous gengou' do
                actual = list.list
                expect(actual[0].name).to eq '正慶'
              end
              it 'should be a gengou between start date and end date' do
                actual = list.list
                expect(actual[1].name).to eq '建武'
              end
            end
            context 'western date has a gengou and next gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: false,
                  start_date: Zakuro::Western::Calendar.new(year: 1334, month: 2, day: 6),
                  last_date: Zakuro::Western::Calendar.new(year: 1334, month: 2, day: 6)
                )
              end
              it 'should be two elements in result array' do
                actual = list.list
                expect(actual.size).to eq 2
              end
              it 'should be a gengou between start date and end date' do
                actual = list.list
                expect(actual[0].name).to eq '正慶'
              end
              it 'should be a next gengou' do
                actual = list.list
                expect(actual[1].name).to eq '建武'
              end
            end
          end
          context '#collect' do
            context 'no gengou in range' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: false,
                  start_date: Zakuro::Western::Calendar.new,
                  last_date: Zakuro::Western::Calendar.new
                )
              end
              it 'should be only invalid gengou' do
                actual = list.collect(
                  start_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2),
                  last_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
                )
                expect(actual[0].invalid?).to be_truthy
              end
            end
            context 'valid gengou from the middle' do
              let(:list) do
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
              let(:actual) do
                list.collect(
                  start_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2),
                  last_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 30)
                )
              end
              it 'should be included invalid gengou' do
                expect(actual[0].invalid?).to be_truthy
              end
              it 'should be included valid gengou' do
                expect(actual[1].invalid?).to be_falsey
              end
            end
            context 'valid two gengou' do
              let(:list) do
                result = Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: false,
                  start_date: Zakuro::Western::Calendar.new,
                  last_date: Zakuro::Western::Calendar.new
                )
                result.instance_variable_set(
                  :@list, [
                    Zakuro::Japan::Gengou::Alignment::LinearGengou.new(
                      gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                        name: '元号1',
                        both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                          japan: 1,
                          western: 450
                        ),
                        both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.new(
                            gengou: '元号1', year: 1, leaped: false, month: 1, day: 1
                          ),
                          western: Zakuro::Western::Calendar.new(
                            year: 450, month: 1, day: 1
                          )
                        ),
                        last_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 20)
                      )
                    ),
                    Zakuro::Japan::Gengou::Alignment::LinearGengou.new(
                      gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                        name: '元号2',
                        both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                          japan: 1,
                          western: 450
                        ),
                        both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.new(
                            gengou: '元号2', year: 1, leaped: false, month: 1, day: 1
                          ),
                          western: Zakuro::Western::Calendar.new(
                            year: 450, month: 1, day: 21
                          )
                        ),
                        last_date: Zakuro::Western::Calendar.new(year: 450, month: 3, day: 30)
                      )
                    )
                  ]
                )
                result
              end
              let(:actual) do
                list.collect(
                  start_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2),
                  last_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 30)
                )
              end
              it 'should be two elements' do
                expect(actual.size).to eq 2
              end
              it 'should be valid gengou on first element' do
                expect(actual[0].invalid?).to be_falsey
              end
              it 'should be valid gengou name on first element' do
                expect(actual[0].name).to eq '元号1'
              end
              it 'should be valid gengou on second element' do
                expect(actual[1].invalid?).to be_falsey
              end
              it 'should be valid gengou name on second element' do
                expect(actual[1].name).to eq '元号2'
              end
            end
            context 'valid three gengou' do
              let(:list) do
                result = Zakuro::Calculation::Gengou::Reserve::DatedList.new(
                  first: false,
                  start_date: Zakuro::Western::Calendar.new,
                  last_date: Zakuro::Western::Calendar.new
                )
                result.instance_variable_set(
                  :@list, [
                    Zakuro::Japan::Gengou::Alignment::LinearGengou.new(
                      gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                        name: '元号1',
                        both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                          japan: 1,
                          western: 450
                        ),
                        both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.new(
                            gengou: '元号1', year: 1, leaped: false, month: 1, day: 1
                          ),
                          western: Zakuro::Western::Calendar.new(
                            year: 450, month: 1, day: 1
                          )
                        ),
                        last_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 20)
                      )
                    ),
                    Zakuro::Japan::Gengou::Alignment::LinearGengou.new(
                      gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                        name: '元号2',
                        both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                          japan: 1,
                          western: 450
                        ),
                        both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.new(
                            gengou: '元号2', year: 1, leaped: false, month: 1, day: 1
                          ),
                          western: Zakuro::Western::Calendar.new(
                            year: 450, month: 1, day: 21
                          )
                        ),
                        last_date: Zakuro::Western::Calendar.new(year: 450, month: 3, day: 31)
                      )
                    ),
                    Zakuro::Japan::Gengou::Alignment::LinearGengou.new(
                      gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                        name: '元号3',
                        both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                          japan: 1,
                          western: 450
                        ),
                        both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.new(
                            gengou: '元号3', year: 1, leaped: false, month: 1, day: 1
                          ),
                          western: Zakuro::Western::Calendar.new(
                            year: 450, month: 4, day: 1
                          )
                        ),
                        last_date: Zakuro::Western::Calendar.new(year: 450, month: 4, day: 30)
                      )
                    )
                  ]
                )
                result
              end
              let(:actual) do
                list.collect(
                  start_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2),
                  last_date: Zakuro::Western::Calendar.new(year: 450, month: 4, day: 2)
                )
              end
              it 'should be three elements' do
                expect(actual.size).to eq 3
              end
              it 'should be valid gengou on first element' do
                expect(actual[0].invalid?).to be_falsey
              end
              it 'should be valid gengou name on first element' do
                expect(actual[0].name).to eq '元号1'
              end
              it 'should be valid gengou on second element' do
                expect(actual[1].invalid?).to be_falsey
              end
              it 'should be valid gengou name on second element' do
                expect(actual[1].name).to eq '元号2'
              end
              it 'should be valid gengou on third element' do
                expect(actual[2].invalid?).to be_falsey
              end
              it 'should be valid gengou name on third element' do
                expect(actual[2].name).to eq '元号3'
              end
            end
            context 'invalid gengou from the middle' do
              let(:list) do
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
              let(:actual) do
                list.collect(
                  start_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 21),
                  last_date: Zakuro::Western::Calendar.new(year: 450, month: 4, day: 30)
                )
              end
              it 'should be two element' do
                expect(actual.size).to eq 2
              end
              it 'should be included valid gengou' do
                expect(actual[0].invalid?).to be_falsey
              end
              it 'should be included invalid gengou' do
                expect(actual[1].invalid?).to be_truthy
              end
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
