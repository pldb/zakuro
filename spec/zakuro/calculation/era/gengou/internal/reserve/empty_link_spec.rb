# frozen_string_literal: true

require File.expand_path('../../../../../../../' \
                         'lib/zakuro/calculation/era/gengou/internal/reserve/empty_link',
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
        describe 'EmptyLink' do
          context '.fill' do
            #
            #  start_date                                        last_date
            #      |--------------------------------------------------|
            #                    |--------- 元号甲 ----------|
            #
            context 'a valid gengou is included in mid-range' do
              let!(:start_date) do
                Zakuro::Western::Calendar.parse(text: '0446-01-12')
              end
              let!(:last_date) do
                Zakuro::Western::Calendar.parse(text: '0446-04-12')
              end
              let!(:counters) do
                [
                  Zakuro::Calculation::Gengou::Counter.new(
                    gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                      name: '元号甲',
                      start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                        japan: 1, western: 446
                      ),
                      start_date: Zakuro::Japan::Gengou::Resource::SwitchDate.new(
                        calculation: Zakuro::Japan::Gengou::Resource::Both::Date.new,
                        operation: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.parse(text: '元号甲1年1月1日'),
                          western: Zakuro::Western::Calendar.parse(text: '0446-02-12')
                        ),
                        operated: true
                      ),
                      last_year: 1,
                      last_date: Zakuro::Western::Calendar.parse(text: '0446-03-12')
                    ),
                    start_date: Zakuro::Western::Calendar.parse(text: '0446-02-12'),
                    last_date: Zakuro::Western::Calendar.parse(text: '0446-03-12')
                  )
                ]
              end
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::EmptyLink.fill(
                  counters: counters, start_date: start_date, last_date: last_date
                )
                counters
              end

              it 'should be three elements' do
                expect(actual.size).to eq 3
              end
              it 'should be invalid gengou at first index' do
                expect(actual[0].invalid?).to be_truthy
              end
              it 'should be valid gengou at second index' do
                expect(actual[1].invalid?).to be_falsey
              end
              it 'should be invalid gengou at third index' do
                expect(actual[2].invalid?).to be_truthy
              end
            end
            #
            #  start_date                                        last_date
            #      |--------------------------------------------------|
            #         |-- 元号甲 --|   |-- 元号乙 --|   |-- 元号丙 --|
            #
            context 'a valid gengou is included in mid-range' do
              let!(:start_date) do
                Zakuro::Western::Calendar.parse(text: '0446-01-12')
              end
              let!(:last_date) do
                Zakuro::Western::Calendar.parse(text: '0446-12-12')
              end
              let!(:counters) do
                [
                  Zakuro::Calculation::Gengou::Counter.new(
                    gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                      name: '元号甲',
                      start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                        japan: 1, western: 446
                      ),
                      start_date: Zakuro::Japan::Gengou::Resource::SwitchDate.new(
                        calculation: Zakuro::Japan::Gengou::Resource::Both::Date.new,
                        operation: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.parse(text: '元号甲1年1月1日'),
                          western: Zakuro::Western::Calendar.parse(text: '0446-02-12')
                        ),
                        operated: true
                      ),
                      last_year: 1,
                      last_date: Zakuro::Western::Calendar.parse(text: '0446-03-12')
                    ),
                    start_date: Zakuro::Western::Calendar.parse(text: '0446-02-12'),
                    last_date: Zakuro::Western::Calendar.parse(text: '0446-03-12')
                  ),
                  Zakuro::Calculation::Gengou::Counter.new(
                    gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                      name: '元号乙',
                      start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                        japan: 1, western: 446
                      ),
                      start_date: Zakuro::Japan::Gengou::Resource::SwitchDate.new(
                        calculation: Zakuro::Japan::Gengou::Resource::Both::Date.new,
                        operation: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.parse(text: '元号甲1年3月1日'),
                          western: Zakuro::Western::Calendar.parse(text: '0446-04-12')
                        ),
                        operated: true
                      ),
                      last_year: 1,
                      last_date: Zakuro::Western::Calendar.parse(text: '0446-05-12')
                    ),
                    start_date: Zakuro::Western::Calendar.parse(text: '0446-04-12'),
                    last_date: Zakuro::Western::Calendar.parse(text: '0446-05-12')
                  ),
                  Zakuro::Calculation::Gengou::Counter.new(
                    gengou: Zakuro::Japan::Gengou::Resource::Gengou.new(
                      name: '元号丙',
                      start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                        japan: 1, western: 446
                      ),
                      start_date: Zakuro::Japan::Gengou::Resource::SwitchDate.new(
                        calculation: Zakuro::Japan::Gengou::Resource::Both::Date.new,
                        operation: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                          japan: Zakuro::Japan::Calendar.parse(text: '元号甲1年5月1日'),
                          western: Zakuro::Western::Calendar.parse(text: '0446-06-12')
                        ),
                        operated: true
                      ),
                      last_year: 1,
                      last_date: Zakuro::Western::Calendar.parse(text: '0446-07-12')
                    ),
                    start_date: Zakuro::Western::Calendar.parse(text: '0446-06-12'),
                    last_date: Zakuro::Western::Calendar.parse(text: '0446-07-12')
                  )
                ]
              end
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::EmptyLink.fill(
                  counters: counters, start_date: start_date, last_date: last_date
                )
                counters
              end

              it 'should be seven elements' do
                expect(actual.size).to eq 7
              end
              context 'first index' do
                let!(:element) do
                  actual[0]
                end

                it 'should be invalid' do
                  expect(element.invalid?).to be_truthy
                end
                it 'should have same start date as parameter' do
                  expect(element.start_date.format).to eq '0446-01-12'
                end
                it 'should have last date that the day before first gengou has' do
                  expect(element.last_date.format).to eq '0446-02-11'
                end
              end
              context 'second index' do
                let!(:element) do
                  actual[1]
                end

                it 'should be valid' do
                  expect(element.invalid?).to be_falsey
                end
                it 'should have conventional start date' do
                  expect(element.start_date.format).to eq '0446-02-12'
                end
                it 'should have conventional last date' do
                  expect(element.last_date.format).to eq '0446-03-12'
                end
              end
              context 'third index' do
                let!(:element) do
                  actual[2]
                end

                it 'should be invalid' do
                  expect(element.invalid?).to be_truthy
                end
                it 'should have start date that the day after last date first gengou has' do
                  expect(element.start_date.format).to eq '0446-03-13'
                end
                it 'should have last date that the day before start date second gengou has' do
                  expect(element.last_date.format).to eq '0446-04-11'
                end
              end
              context 'fourth index' do
                let!(:element) do
                  actual[3]
                end

                it 'should be valid' do
                  expect(element.invalid?).to be_falsey
                end
                it 'should have conventional start date' do
                  expect(element.start_date.format).to eq '0446-04-12'
                end
                it 'should have conventional last date' do
                  expect(element.last_date.format).to eq '0446-05-12'
                end
              end
              context 'fifth index' do
                let!(:element) do
                  actual[4]
                end

                it 'should be invalid' do
                  expect(element.invalid?).to be_truthy
                end
                it 'should have start date that the day after last date second gengou has' do
                  expect(element.start_date.format).to eq '0446-05-13'
                end
                it 'should have last date that the day before start date third gengou has' do
                  expect(element.last_date.format).to eq '0446-06-11'
                end
              end
              context 'sixth index' do
                let!(:element) do
                  actual[5]
                end

                it 'should be valid' do
                  expect(element.invalid?).to be_falsey
                end
                it 'should have conventional start date' do
                  expect(element.start_date.format).to eq '0446-06-12'
                end
                it 'should have conventional last date' do
                  expect(element.last_date.format).to eq '0446-07-12'
                end
              end
              context 'seventh index' do
                let!(:element) do
                  actual[6]
                end

                it 'should be invalid' do
                  expect(element.invalid?).to be_truthy
                end
                it 'should have start date that the day after third gengou has' do
                  expect(element.start_date.format).to eq '0446-07-13'
                end
                it 'should have same last date as parameter' do
                  expect(element.last_date.format).to eq '0446-12-12'
                end
              end
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
