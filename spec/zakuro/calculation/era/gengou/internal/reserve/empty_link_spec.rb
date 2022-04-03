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
                      both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                        japan: 1, western: 446
                      ),
                      both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.parse(text: '元号甲1年1月1日'),
                        western: Zakuro::Western::Calendar.parse(text: '0446-02-12')
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
                      both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                        japan: 1, western: 446
                      ),
                      both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.parse(text: '元号甲1年1月1日'),
                        western: Zakuro::Western::Calendar.parse(text: '0446-02-12')
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
                      both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                        japan: 1, western: 446
                      ),
                      both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.parse(text: '元号甲1年3月1日'),
                        western: Zakuro::Western::Calendar.parse(text: '0446-04-12')
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
                      both_start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                        japan: 1, western: 446
                      ),
                      both_start_date: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.parse(text: '元号甲1年5月1日'),
                        western: Zakuro::Western::Calendar.parse(text: '0446-06-12')
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

              it 'should be three elements' do
                expect(actual.size).to eq 7
              end
              # TODO: more test
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
