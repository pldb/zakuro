# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/era/japan/gengou/alignment/linear_gengou',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/japan/gengou/alignment/line',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Alignment' do
      describe 'Line' do
        let!(:line) do
          line = Zakuro::Japan::Alignment::Line.new
          list = [
            Zakuro::Japan::Alignment::LinearGengou.new(
              gengou: Zakuro::Japan::Gengou.new(
                name: '安康天皇',
                both_start_year: Zakuro::Japan::Both::Year.new(
                  japan: 1,
                  western: 454
                ),
                both_start_date: Zakuro::Japan::Both::Date.new(
                  japan: Zakuro::Japan::Calendar.new(
                    gengou: '安康天皇', year: 1, leaped: false, month: 1, day: 1
                  ),
                  western: Zakuro::Western::Calendar.new(
                    year: 454, month: 2, day: 14
                  )
                ),
                last_date: Zakuro::Western::Calendar.new(year: 457, month: 2, day: 9)
              )
            ),
            Zakuro::Japan::Alignment::LinearGengou.new(
              gengou: Zakuro::Japan::Gengou.new(
                name: '雄略天皇',
                both_start_year: Zakuro::Japan::Both::Year.new(
                  japan: 1,
                  western: 457
                ),
                both_start_date: Zakuro::Japan::Both::Date.new(
                  japan: Zakuro::Japan::Calendar.new(
                    gengou: '雄略天皇', year: 1, leaped: false, month: 1, day: 1
                  ),
                  western: Zakuro::Western::Calendar.new(
                    year: 457, month: 2, day: 10
                  )
                ),
                last_date: Zakuro::Western::Calendar.new(year: 480, month: 1, day: 27)
              )
            )
          ]
          line.instance_variable_set(
            '@list', list
          )

          line
        end
        describe '#push' do
          context 'no duplication parameter' do
            context 'less than start date' do
              param = [
                Zakuro::Japan::Alignment::LinearGengou.new(
                  gengou: Zakuro::Japan::Gengou.new(
                    name: '允恭天皇',
                    both_start_year: Zakuro::Japan::Both::Year.new(
                      japan: 34,
                      western: 445
                    ),
                    both_start_date: Zakuro::Japan::Both::Date.new(
                      japan: Zakuro::Japan::Calendar.new(
                        gengou: '允恭天皇', year: 34, leaped: false, month: 1, day: 1
                      ),
                      western: Zakuro::Western::Calendar.new(
                        year: 445, month: 1, day: 24
                      )
                    ),
                    last_date: Zakuro::Western::Calendar.new(year: 454, month: 2, day: 13)
                  )
                )
              ]

              it 'should be empty array' do
                rest = line.push(list: param)

                expect(rest.size).to eq 0
              end
              it 'should be added list' do
                line.push(list: param)

                expect(line.list.size).to eq 3
              end
              it 'should be included parameters' do
                line.push(list: param)

                expect(line.list[2].gengou.name).to eq '允恭天皇'
              end
            end
          end
        end
        # TODO: make
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
