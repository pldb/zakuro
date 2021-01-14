# frozen_string_literal: true

require File.expand_path('../../../../../zakuro/lib/zakuro/era/japan/gengou',
                         __dir__)
require 'yaml'

ACTUAL_YAML_PATH = File.expand_path(
  '../../../../lib/zakuro/era/japan/yaml/set-001-until-south.yaml',
  __dir__
)
TEST_YAML_PATH = File.expand_path(
  './yaml/set-test-001.yaml',
  __dir__
)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Parser' do
      describe '.validate' do
        context 'actual yaml path' do
          it 'should be no error' do
            yaml = YAML.load_file(ACTUAL_YAML_PATH)
            fails = Zakuro::Japan::Parser.validate(yaml)
            expect(fails).to be_empty
          end
        end
      end
      describe '.run' do
        context 'actual file' do
          it 'should be no error' do
            expect { Zakuro::Japan::Parser.run(filepath: ACTUAL_YAML_PATH) }
              .to_not raise_error
          end
        end
        context 'test file' do
          it 'should be no error' do
            expect { Zakuro::Japan::Parser.run(filepath: TEST_YAML_PATH) }
              .to_not raise_error
          end
          it 'is created Set class' do
            actual = Zakuro::Japan::Parser.run(filepath: TEST_YAML_PATH)
            expect(actual).to be_a(Zakuro::Japan::Set)
          end
        end
        context 'internal data' do
          let(:actual) { Zakuro::Japan::Parser.run(filepath: TEST_YAML_PATH) }
          context 'id' do
            it 'is the same data in file' do
              expect(actual.id).to eq(1)
            end
          end
          context 'name' do
            it 'is the same data in file' do
              expect(actual.name).to eq('test-001')
            end
          end
          context 'end_date' do
            it 'is the same data in file' do
              expect(actual.end_date).to eq(
                Zakuro::Western::Calendar.new(year: 555, month: 2, day: 3)
              )
            end
          end
          context 'list size' do
            it 'is the same data in file' do
              expect(actual.list.size).to eq(3)
            end
          end
          context 'list item data type' do
            it 'is created gengou class' do
              item = actual.list[0]
              expect(item).to be_a(Zakuro::Japan::Gengou)
            end
          end
          context 'first-list[0]' do
            let(:item) { actual.list[0] }
            context 'name' do
              it 'is the same data in file' do
                expect(item.name).to eq('元号名1')
              end
            end
            context 'start_date' do
              it 'is the same data in file' do
                expect(item.start_date).to eq(
                  Zakuro::Western::Calendar.new(year: 501, month: 1, day: 10)
                )
              end
            end
            context 'end_date' do
              it 'is the same data in file' do
                expect(item.end_date).to eq(
                  Zakuro::Western::Calendar.new(year: 510, month: 10, day: 10)
                )
              end
            end
            context 'year' do
              it 'is the same data in file' do
                expect(item.year).to eq(11)
              end
            end
          end
          context 'last-list[3]' do
            let(:item) { actual.list[2] }
            context 'name' do
              it 'is the same data in file' do
                expect(item.name).to eq('元号名3')
              end
            end
            context 'start_date' do
              it 'is the same data in file' do
                expect(item.start_date).to eq(
                  Zakuro::Western::Calendar.new(year: 550, month: 1, day: 2)
                )
              end
            end
            context 'end_date' do
              it 'is the same data in file' do
                expect(item.end_date).to eq(
                  Zakuro::Western::Calendar.new(year: 555, month: 2, day: 3)
                )
              end
            end
            context 'year' do
              it 'is the same data in file' do
                expect(item.year).to eq(1)
              end
            end
          end
        end
      end
    end
    describe 'GengouResource' do
      context '.first_line' do
        context 'set-001 only' do
          it 'should be got a element' do
            date = Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
            item = Zakuro::Japan::GengouResource.first_line(date: date)
            expect(item.name).to eq('允恭')
          end
        end
        context 'set-001 and set-002' do
          it 'should be got a element' do
            date = Zakuro::Western::Calendar.new(year: 1384, month: 5, day: 18)
            item = Zakuro::Japan::GengouResource.first_line(date: date)
            expect(item.name).to eq('元中')
          end
          it 'should be got a set-002 element instead of set-001 one' do
            date = Zakuro::Western::Calendar.new(year: 1393, month: 2, day: 12)
            item = Zakuro::Japan::GengouResource.first_line(date: date)
            expect(item.name).to eq('明徳')
          end
          it 'should be got a set-002 element instead of set-001 one' do
            date = Zakuro::Western::Calendar.new(year: 1868, month: 1, day: 24)
            item = Zakuro::Japan::GengouResource.first_line(date: date)
            expect(item.name).to eq('慶応')
          end
        end
        context 'set-003 only' do
          it 'should be got a set-003 element instead of set-001 one' do
            date = Zakuro::Western::Calendar.new(year: 1868, month: 10, day: 23)
            item = Zakuro::Japan::GengouResource.first_line(date: date)
            expect(item.name).to eq('明治')
          end
        end
        context 'gengou name on first lines' do
          let!(:first_line_path) do
            File.expand_path('./yaml/first-line.yaml', __dir__)
          end
          it 'should be applied historical name at boundary date' do
            yaml = YAML.load_file(first_line_path)
            yaml.each do |gengou|
              date = Zakuro::Western::Calendar.parse(str: gengou['start_date'])
              item = Zakuro::Japan::GengouResource.first_line(date: date)
              expect(gengou['name']).to eq(item.name)
            end
          end
        end
      end
      context '.second_line' do
        context 'set-001 and set-002' do
          it 'should be got a set-002 element' do
            date = Zakuro::Western::Calendar.new(year: 1384, month: 3, day: 19)
            item = Zakuro::Japan::GengouResource.second_line(date: date)
            expect(item.name).to eq('至徳')
          end
        end
        context 'set-002 only' do
          it 'should be got a invalid element' do
            date = Zakuro::Western::Calendar.new(year: 1393, month: 2, day: 12)
            item = Zakuro::Japan::GengouResource.second_line(date: date)
            expect(item.invalid?).to be_truthy
          end
        end
        context 'gengou name on second lines' do
          let!(:second_line_path) do
            File.expand_path('./yaml/second-line.yaml', __dir__)
          end
          it 'should be applied historical name at boundary date' do
            yaml = YAML.load_file(second_line_path)
            yaml.each do |gengou|
              date = Zakuro::Western::Calendar.parse(str: gengou['start_date'])
              item = Zakuro::Japan::GengouResource.second_line(date: date)
              expect(gengou['name']).to eq(item.name)
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
