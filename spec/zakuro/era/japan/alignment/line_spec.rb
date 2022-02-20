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
              gengou: Zakuro::Japan::Resource::Gengou.new(
                name: '安康天皇',
                both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                  japan: 1,
                  western: 454
                ),
                both_start_date: Zakuro::Japan::Resource::Both::Date.new(
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
              gengou: Zakuro::Japan::Resource::Gengou.new(
                name: '雄略天皇',
                both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                  japan: 1,
                  western: 457
                ),
                both_start_date: Zakuro::Japan::Resource::Both::Date.new(
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
            # [list]              |----安康天皇----|----雄略天皇----|
            # [param]  |-允恭天皇-|
            context 'less than start date' do
              let(:param) do
                [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '允恭天皇',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 34,
                        western: 445
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
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
              end

              context 'return value' do
                it 'should be empty array' do
                  rest = line.push(list: param)

                  expect(rest.size).to eq 0
                end
              end
              context 'list field value' do
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
            # [list]   |----安康天皇----|----雄略天皇----|
            # [param]                                   |-清寧天皇-|
            context 'more than last date' do
              let!(:param) do
                [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '清寧天皇',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 1,
                        western: 480
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.new(
                          gengou: '清寧天皇', year: 1, leaped: false, month: 1, day: 1
                        ),
                        western: Zakuro::Western::Calendar.new(
                          year: 480, month: 1, day: 28
                        )
                      ),
                      last_date: Zakuro::Western::Calendar.new(year: 485, month: 2, day: 1)
                    )
                  )
                ]
              end

              context 'return value' do
                it 'should be empty array' do
                  rest = line.push(list: param)

                  expect(rest.size).to eq 0
                end
              end
              context 'list field value' do
                it 'should be added list' do
                  line.push(list: param)

                  expect(line.list.size).to eq 3
                end
                it 'should be included parameters' do
                  line.push(list: param)

                  expect(line.list[2].gengou.name).to eq '清寧天皇'
                end
              end
            end
          end
          context 'partially duplicated parameter' do
            # [list]           |----安康天皇----|----雄略天皇----|
            # [param]   |--元号1--|
            context 'beyond start date' do
              let!(:param) do
                [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '元号1',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 34,
                        western: 445
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.new(
                          gengou: '元号1', year: 34, leaped: false, month: 1, day: 1
                        ),
                        western: Zakuro::Western::Calendar.new(
                          year: 445, month: 1, day: 24
                        )
                      ),
                      last_date: Zakuro::Western::Calendar.new(year: 454, month: 3, day: 13)
                    )
                  )
                ]
              end

              context 'return value' do
                it 'should be a element' do
                  rest = line.push(list: param)

                  expect(rest.size).to eq 1
                end
                it 'should be included parameters' do
                  rest = line.push(list: param)

                  expect(rest[0].gengou.name).to eq '元号1'
                end
                it 'should have start date without duplication' do
                  rest = line.push(list: param)

                  expect(rest[0].start_date.format).to eq '0454-02-14'
                end
                it 'should have last date like parameter' do
                  rest = line.push(list: param)

                  expect(rest[0].last_date.format).to eq '0454-03-13'
                end
              end
              context 'list field value' do
                it 'should be added list' do
                  line.push(list: param)

                  expect(line.list.size).to eq 3
                end
                it 'should be included parameters' do
                  line.push(list: param)

                  expect(line.list[2].gengou.name).to eq '元号1'
                end
                it 'should have start date like parameter' do
                  line.push(list: param)

                  expect(line.list[2].start_date.format).to eq '0445-01-24'
                end
                it 'should have last date without duplication' do
                  line.push(list: param)

                  expect(line.list[2].last_date.format).to eq '0454-02-13'
                end
              end
            end
            # [list]    |----安康天皇----|----雄略天皇----|
            # [param]                                 |--元号2--|
            context 'beyond last date' do
              let!(:param) do
                [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '元号2',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 1,
                        western: 480
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.new(
                          gengou: '元号2', year: 1, leaped: false, month: 1, day: 1
                        ),
                        western: Zakuro::Western::Calendar.new(
                          year: 480, month: 1, day: 1
                        )
                      ),
                      last_date: Zakuro::Western::Calendar.new(year: 485, month: 1, day: 31)
                    )
                  )
                ]
              end

              context 'return value' do
                it 'should be a element' do
                  rest = line.push(list: param)

                  expect(rest.size).to eq 1
                end
                it 'should be included parameters' do
                  rest = line.push(list: param)

                  expect(rest[0].gengou.name).to eq '元号2'
                end
                it 'should have start date like parameter' do
                  rest = line.push(list: param)

                  expect(rest[0].start_date.format).to eq '0480-01-01'
                end
                it 'should have last date without duplication' do
                  rest = line.push(list: param)

                  expect(rest[0].last_date.format).to eq '0480-01-27'
                end
              end
              context 'list field value' do
                it 'should be added list' do
                  line.push(list: param)

                  expect(line.list.size).to eq 3
                end
                it 'should be included parameters' do
                  line.push(list: param)

                  expect(line.list[2].gengou.name).to eq '元号2'
                end
                it 'should have start date without duplication' do
                  line.push(list: param)

                  expect(line.list[2].start_date.format).to eq '0480-01-28'
                end
                it 'should have last date like parameter' do
                  line.push(list: param)

                  expect(line.list[2].last_date.format).to eq '0485-01-31'
                end
              end
            end
          end
          context 'covered parameter' do
            # [list]    |----安康天皇----|----雄略天皇----|
            # [param]  |------元号1------|
            context 'covered a gengou' do
              let!(:param) do
                [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '元号1',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 1,
                        western: 453
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.new(
                          gengou: '元号1', year: 1, leaped: false, month: 1, day: 1
                        ),
                        western: Zakuro::Western::Calendar.new(
                          year: 453, month: 1, day: 1
                        )
                      ),
                      last_date: Zakuro::Western::Calendar.new(year: 457, month: 3, day: 10)
                    )
                  )
                ]
              end
              context 'return value' do
                it 'should be a element' do
                  rest = line.push(list: param)

                  expect(rest.size).to eq 1
                end
                it 'should be included parameters' do
                  rest = line.push(list: param)

                  expect(rest[0].gengou.name).to eq '元号1'
                end
                it 'should have start date like parameter' do
                  rest = line.push(list: param)

                  expect(rest[0].start_date.format).to eq '0454-02-14'
                end
                it 'should have last date without duplication' do
                  rest = line.push(list: param)

                  expect(rest[0].last_date.format).to eq '0457-03-10'
                end
              end

              context 'list field value' do
                it 'should be added list' do
                  line.push(list: param)

                  expect(line.list.size).to eq 3
                end
                it 'should be included parameters' do
                  line.push(list: param)

                  expect(line.list[2].gengou.name).to eq '元号1'
                end
                it 'should have start date without duplication' do
                  line.push(list: param)

                  expect(line.list[2].start_date.format).to eq '0453-01-01'
                end
                it 'should have last date like parameter' do
                  line.push(list: param)

                  expect(line.list[2].last_date.format).to eq '0454-02-13'
                end
              end
            end
            # [list]    |----安康天皇----|----雄略天皇----|
            # [param]  |----------------元号2----------------|
            context 'covered two gengou' do
              let!(:param) do
                [
                  Zakuro::Japan::Alignment::LinearGengou.new(
                    gengou: Zakuro::Japan::Resource::Gengou.new(
                      name: '元号2',
                      both_start_year: Zakuro::Japan::Resource::Both::Year.new(
                        japan: 1,
                        western: 453
                      ),
                      both_start_date: Zakuro::Japan::Resource::Both::Date.new(
                        japan: Zakuro::Japan::Calendar.new(
                          gengou: '元号2', year: 1, leaped: false, month: 1, day: 1
                        ),
                        western: Zakuro::Western::Calendar.new(
                          year: 453, month: 1, day: 1
                        )
                      ),
                      last_date: Zakuro::Western::Calendar.new(year: 480, month: 2, day: 1)
                    )
                  )
                ]
              end
              context 'return value' do
                it 'should be a element' do
                  rest = line.push(list: param)

                  expect(rest.size).to eq 1
                end
                it 'should be included parameters' do
                  rest = line.push(list: param)

                  expect(rest[0].gengou.name).to eq '元号2'
                end
                it 'should have start date like parameter' do
                  rest = line.push(list: param)

                  expect(rest[0].start_date.format).to eq '0454-02-14'
                end
                it 'should have last date without duplication' do
                  rest = line.push(list: param)

                  expect(rest[0].last_date.format).to eq '0480-01-27'
                end
              end

              context 'list field value' do
                it 'should be added list' do
                  line.push(list: param)

                  expect(line.list.size).to eq 4
                end
                context 'first element' do
                  it 'should be included parameters' do
                    line.push(list: param)

                    expect(line.list[2].gengou.name).to eq '元号2'
                  end
                  it 'should have start date like parameter' do
                    line.push(list: param)

                    expect(line.list[2].start_date.format).to eq '0453-01-01'
                  end
                  it 'should have last date without duplication' do
                    line.push(list: param)

                    expect(line.list[2].last_date.format).to eq '0454-02-13'
                  end
                end
                context 'second element' do
                  it 'should be included parameters' do
                    line.push(list: param)

                    expect(line.list[3].gengou.name).to eq '元号2'
                  end
                  it 'should have start date like parameter' do
                    line.push(list: param)

                    expect(line.list[3].start_date.format).to eq '0480-01-28'
                  end
                  it 'should have last date without duplication' do
                    line.push(list: param)

                    expect(line.list[3].last_date.format).to eq '0480-02-01'
                  end
                end
              end
            end
          end
          # TODO: make
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
