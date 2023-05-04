# frozen_string_literal: true

require File.expand_path('../../../../lib/zakuro/era/japan/gengou',
                         __dir__)

require File.expand_path('../../../../lib/zakuro/era/western/calendar',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Gengou' do
      describe '.line' do
        context 'first_line' do
          def first_line(date:)
            line = Zakuro::Japan::Gengou::FIRST_LINE
            Zakuro::Japan::Gengou.line(line: line, start_date: date, last_date: date)
          end
          context 'set-001 only' do
            it 'should be got a element' do
              date = Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
              item = first_line(date: date)
              expect(item[0].name).to eq('允恭天皇')
            end
          end
          context 'set-001 and set-002' do
            it 'should be got a element' do
              date = Zakuro::Western::Calendar.new(year: 1384, month: 5, day: 18)
              item = first_line(date: date)
              expect(item[0].name).to eq('元中')
            end
            it 'should be got a set-002 element instead of set-001 one' do
              date = Zakuro::Western::Calendar.new(year: 1393, month: 2, day: 12)
              item = first_line(date: date)
              expect(item[0].name).to eq('明徳')
            end
            it 'should be got a set-002 element instead of set-001 one' do
              date = Zakuro::Western::Calendar.new(year: 1868, month: 1, day: 24)
              item = first_line(date: date)
              expect(item[0].name).to eq('慶応')
            end
          end
          context 'set-003 only' do
            it 'should be got a set-003 element instead of set-001 one' do
              date = Zakuro::Western::Calendar.new(year: 1868, month: 10, day: 23)
              item = first_line(date: date)
              expect(item[0].name).to eq('明治')
            end
          end
          context 'gengou name on first lines' do
            let!(:first_line_path) do
              File.expand_path('./yaml/first-line.yaml', __dir__)
            end
            it 'should be applied historical name at boundary date' do
              yaml = YAML.load_file(first_line_path)
              yaml.each do |gengou|
                date = Zakuro::Western::Calendar.parse(text: gengou['start_date'])
                item = first_line(date: date)
                expect(gengou['name']).to eq(item[0].name)
              end
            end
          end
        end
        context 'second_line' do
          def second_line(date:)
            line = Zakuro::Japan::Gengou::SECOND_LINE
            Zakuro::Japan::Gengou.line(line: line, start_date: date, last_date: date)
          end
          context 'set-001 and set-002' do
            it 'should be got a set-002 element' do
              date = Zakuro::Western::Calendar.new(year: 1384, month: 3, day: 19)
              item = second_line(date: date)
              expect(item[0].name).to eq('至徳')
            end
          end
          context 'set-002 only' do
            it 'should be got a invalid element' do
              date = Zakuro::Western::Calendar.new(year: 1393, month: 2, day: 12)
              item = second_line(date: date)
              expect(item.empty?).to be_truthy
            end
          end
          context 'gengou name on second lines' do
            let!(:second_line_path) do
              File.expand_path('./yaml/second-line.yaml', __dir__)
            end
            it 'should be applied historical name at boundary date' do
              yaml = YAML.load_file(second_line_path)
              yaml.each do |gengou|
                date = Zakuro::Western::Calendar.parse(text: gengou['start_date'])
                item = second_line(date: date)
                if gengou['name'] == ''
                  expect(item.size).to eq 0
                  next
                end
                expect(gengou['name']).to eq(item[0].name)
              end
            end
          end
        end
      end
      describe '.line_by_name' do
        context 'first_line' do
          def first_line(name:)
            line = Zakuro::Japan::Gengou::FIRST_LINE
            Zakuro::Japan::Gengou.line_by_name(line: line, name: name)
          end
          context 'set-001 only' do
            it 'should be got a element' do
              name = '允恭天皇'
              item = first_line(name: name)
              expect(item[0].name).to eq(name)
            end
            context 'set-001 and set-002' do
              it 'should be got a element' do
                name = '元中'
                item = first_line(name: name)
                expect(item[0].name).to eq(name)
              end
            end
            context 'set-003 only' do
              it 'should be got a set-003 element instead of set-001 one' do
                name = '明治'
                item = first_line(name: name)
                expect(item[0].name).to eq(name)
              end
            end
          end
        end
        context 'second_line' do
          def second_line(name:)
            line = Zakuro::Japan::Gengou::SECOND_LINE
            Zakuro::Japan::Gengou.line_by_name(line: line, name: name)
          end
          context 'set-001 and set-002' do
            it 'should be got a set-002 element' do
              name = '至徳'
              item = second_line(name: name)
              expect(item[0].name).to eq(name)
            end
          end
          context 'set-002 only' do
            it 'should be got a invalid element' do
              item = second_line(name: '允恭天皇')
              expect(item.empty?).to be_truthy
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
