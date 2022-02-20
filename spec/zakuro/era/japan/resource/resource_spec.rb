# frozen_string_literal: true

require File.expand_path('../../../../../../zakuro/lib/zakuro/era/japan/gengou/resource',
                         __dir__)
require 'yaml'

ACTUAL_YAML_PATH = File.expand_path(
  '../../../../../lib/zakuro/era/japan/gengou/resource/yaml/set-001-until-south.yaml',
  __dir__
)
TEST_YAML_PATH = File.expand_path(
  './yaml/set-test-001.yaml',
  __dir__
)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Resource' do
      describe 'Parser' do
        describe '.validate' do
          context 'actual yaml path' do
            it 'should be no error' do
              yaml = YAML.load_file(ACTUAL_YAML_PATH)
              fails = Zakuro::Japan::Resource::Validator.run(yaml_hash: yaml)
              expect(fails).to be_empty
            end
          end
        end
        describe '.run' do
          context 'actual file' do
            it 'should be no error' do
              expect { Zakuro::Japan::Resource::Parser.run(filepath: ACTUAL_YAML_PATH) }
                .to_not raise_error
            end
          end
          context 'test file' do
            it 'should be no error' do
              expect { Zakuro::Japan::Resource::Parser.run(filepath: TEST_YAML_PATH) }
                .to_not raise_error
            end
            it 'is created Set class' do
              actual = Zakuro::Japan::Resource::Parser.run(filepath: TEST_YAML_PATH)
              expect(actual).to be_a(Zakuro::Japan::Resource::Set)
            end
          end
          context 'internal data' do
            let(:actual) { Zakuro::Japan::Resource::Parser.run(filepath: TEST_YAML_PATH) }
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
            context 'western date in both_last_date' do
              it 'is the same data in file' do
                expect(actual.both_last_date.western).to eq(
                  Zakuro::Western::Calendar.new(year: 555, month: 2, day: 3)
                )
              end
            end
            context 'japan date in both_last_date' do
              it 'is the same data in file' do
                expect(actual.both_last_date.japan.format).to eq(
                  Zakuro::Japan::Calendar.new(
                    gengou: '元号', year: 2, leaped: false, month: 1, day: 10
                  ).format
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
                expect(item).to be_a(Zakuro::Japan::Resource::Gengou)
              end
            end
            context 'first-list[0]' do
              let(:item) { actual.list[0] }
              context 'name' do
                it 'is the same data in file' do
                  expect(item.name).to eq('元号名1')
                end
              end
              context 'japan date in both_start_date' do
                it 'is the same data in file' do
                  expect(item.both_start_date.japan.format).to eq(
                    Zakuro::Japan::Calendar.new(
                      gengou: '元号', year: 2, leaped: false, month: 1, day: 11
                    ).format
                  )
                end
              end
              context 'westen date in both_start_date' do
                it 'is the same data in file' do
                  expect(item.both_start_date.western).to eq(
                    Zakuro::Western::Calendar.new(year: 501, month: 1, day: 11)
                  )
                end
              end
              context 'last_year' do
                it 'is the same data in file' do
                  expect(item.last_year).to eq(
                    1001
                  )
                end
              end
              context 'last_date' do
                it 'is calculated by next gengou' do
                  expect(item.last_date).to eq(
                    Zakuro::Western::Calendar.new(year: 502, month: 10, day: 11)
                  )
                end
              end
              context 'japan year in both_start_year' do
                it 'is the same data in file' do
                  expect(item.both_start_year.japan).to eq(11)
                end
              end
              context 'western year in both_start_year' do
                it 'is the same data in file' do
                  expect(item.both_start_year.western).to eq(1001)
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
              context 'japan date in both_start_date' do
                it 'is the same data in file' do
                  expect(item.both_start_date.japan.format).to eq(
                    Zakuro::Japan::Calendar.new(
                      gengou: '元号', year: 2, leaped: false, month: 11, day: 13
                    ).format
                  )
                end
              end
              context 'westen date in both_start_date' do
                it 'is the same data in file' do
                  expect(item.both_start_date.western).to eq(
                    Zakuro::Western::Calendar.new(year: 505, month: 12, day: 13)
                  )
                end
              end
              context 'last_year' do
                it 'is the same data in file' do
                  expect(item.last_year).to eq(
                    1055
                  )
                end
              end
              context 'last_date' do
                it 'is the same data in file' do
                  expect(item.last_date).to eq(
                    Zakuro::Western::Calendar.new(year: 555, month: 2, day: 3)
                  )
                end
              end
              context 'japan year in both_start_year' do
                it 'is the same data in file' do
                  expect(item.both_start_year.japan).to eq(13)
                end
              end
              context 'western year in both_start_year' do
                it 'is the same data in file' do
                  expect(item.both_start_year.western).to eq(1005)
                end
              end
            end
          end
        end
      end
      # TODO: 該当メソッドは他モジュール。同等のテストケースを作成する
      # describe 'Resource' do
      #   context '.first_line' do
      #     context 'set-001 only' do
      #       it 'should be got a element' do
      #         date = Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
      #         item = Zakuro::Japan::Resource.first_line(start_date: date, last_date: date)
      #         expect(item.name).to eq('允恭天皇')
      #       end
      #     end
      #     context 'set-001 and set-002' do
      #       it 'should be got a element' do
      #         date = Zakuro::Western::Calendar.new(year: 1384, month: 5, day: 18)
      #         item = Zakuro::Japan::Resource.first_line(start_date: date, last_date: date)
      #         expect(item.name).to eq('元中')
      #       end
      #       it 'should be got a set-002 element instead of set-001 one' do
      #         date = Zakuro::Western::Calendar.new(year: 1393, month: 2, day: 12)
      #         item = Zakuro::Japan::Resource.first_line(start_date: date, last_date: date)
      #         expect(item.name).to eq('明徳')
      #       end
      #       it 'should be got a set-002 element instead of set-001 one' do
      #         date = Zakuro::Western::Calendar.new(year: 1868, month: 1, day: 24)
      #         item = Zakuro::Japan::Resource.first_line(start_date: date, last_date: date)
      #         expect(item.name).to eq('慶応')
      #       end
      #     end
      #     context 'set-003 only' do
      #       it 'should be got a set-003 element instead of set-001 one' do
      #         date = Zakuro::Western::Calendar.new(year: 1868, month: 10, day: 23)
      #         item = Zakuro::Japan::Resource.first_line(start_date: date, last_date: date)
      #         expect(item.name).to eq('明治')
      #       end
      #     end
      #     context 'gengou name on first lines' do
      #       let!(:first_line_path) do
      #         File.expand_path('./yaml/first-line.yaml', __dir__)
      #       end
      #       it 'should be applied historical name at boundary date' do
      #         yaml = YAML.load_file(first_line_path)
      #         yaml.each do |gengou|
      #           date = Zakuro::Western::Calendar.parse(str: gengou['start_date'])
      #           item = Zakuro::Japan::Resource.first_line(start_date: date, last_date: date)
      #           expect(gengou['name']).to eq(item.name)
      #         end
      #       end
      #     end
      #   end
      #   context '.second_line' do
      #     context 'set-001 and set-002' do
      #       it 'should be got a set-002 element' do
      #         date = Zakuro::Western::Calendar.new(year: 1384, month: 3, day: 19)
      #         item = Zakuro::Japan::Resource.second_line(start_date: date, last_date: date)
      #         expect(item.name).to eq('至徳')
      #       end
      #     end
      #     context 'set-002 only' do
      #       it 'should be got a invalid element' do
      #         date = Zakuro::Western::Calendar.new(year: 1393, month: 2, day: 12)
      #         item = Zakuro::Japan::Resource.second_line(start_date: date, last_date: date)
      #         expect(item.invalid?).to be_truthy
      #       end
      #     end
      #     context 'gengou name on second lines' do
      #       let!(:second_line_path) do
      #         File.expand_path('./yaml/second-line.yaml', __dir__)
      #       end
      #       it 'should be applied historical name at boundary date' do
      #         yaml = YAML.load_file(second_line_path)
      #         yaml.each do |gengou|
      #           date = Zakuro::Western::Calendar.parse(str: gengou['start_date'])
      #           item = Zakuro::Japan::Resource.second_line(start_date: date, last_date: date)
      #           expect(gengou['name']).to eq(item.name)
      #         end
      #       end
      #     end
      #   end
      # end
    end
  end
end
# rubocop:enable Metrics/BlockLength
