# frozen_string_literal: true

require File.expand_path('../../../../../../../zakuro/lib/zakuro/era/japan/gengou/resource/parser',
                         __dir__)
require 'yaml'

# :nodoc:
module Zakuro
  Zakuro::ACTUAL_YAML_PATH = File.expand_path(
    '../../../../../../lib/zakuro/era/japan/gengou/resource/yaml/set-001-until-south.yaml',
    __dir__
  )
  Zakuro::TEST_YAML_PATH = File.expand_path(
    './yaml/set-test-001.yaml',
    __dir__
  )
end

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Gengou' do
      describe 'Resource' do
        describe 'Parser' do
          describe '.validate' do
            context 'actual yaml path' do
              it 'should be no error' do
                yaml = YAML.load_file(Zakuro::ACTUAL_YAML_PATH)
                fails = Zakuro::Japan::Gengou::Resource::Validator.run(yaml_hash: yaml)
                expect(fails).to be_empty
              end
            end
          end
          describe '.run' do
            context 'actual file' do
              it 'should be no error' do
                expect do
                  Zakuro::Japan::Gengou::Resource::Parser.run(filepath: Zakuro::ACTUAL_YAML_PATH)
                end.to_not raise_error
              end
            end
            context 'test file' do
              it 'should be no error' do
                expect do
                  Zakuro::Japan::Gengou::Resource::Parser.run(filepath: Zakuro::TEST_YAML_PATH)
                end.to_not raise_error
              end
              it 'is created Set class' do
                actual = Zakuro::Japan::Gengou::Resource::Parser.run(
                  filepath: Zakuro::TEST_YAML_PATH
                )
                expect(actual).to be_a(Zakuro::Japan::Type::Base::GengouSet)
              end
            end
            context 'internal data' do
              let(:actual) do
                Zakuro::Japan::Gengou::Resource::Parser.run(filepath: Zakuro::TEST_YAML_PATH)
              end
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
              context 'western date in last_date' do
                it 'is the same data in file' do
                  expect(actual.last_date.western).to eq(
                    Zakuro::Western::Calendar.new(year: 555, month: 2, day: 3)
                  )
                end
              end
              context 'japan date in last_date' do
                it 'is the same data in file' do
                  expect(actual.last_date.japan.format).to eq(
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
                  expect(item).to be_a(Zakuro::Japan::Type::Base::Gengou)
                end
              end
              context 'first-list[0]' do
                let(:item) { actual.list[0] }
                context 'name' do
                  it 'is the same data in file' do
                    expect(item.name).to eq('元号名1')
                  end
                end
                context 'japan date in start_date' do
                  it 'is the same data in file' do
                    expect(item.start_date.japan.format).to eq(
                      Zakuro::Japan::Calendar.new(
                        gengou: '元号', year: 2, leaped: false, month: 1, day: 11
                      ).format
                    )
                  end
                end
                context 'westen date in start_date' do
                  it 'is the same data in file' do
                    expect(item.start_date.western).to eq(
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
                context 'japan year in start_year' do
                  it 'is the same data in file' do
                    expect(item.start_year.japan).to eq(11)
                  end
                end
                context 'western year in start_year' do
                  it 'is the same data in file' do
                    expect(item.start_year.western).to eq(1001)
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
                context 'japan date in start_date' do
                  it 'is the same data in file' do
                    expect(item.start_date.japan.format).to eq(
                      Zakuro::Japan::Calendar.new(
                        gengou: '元号', year: 2, leaped: false, month: 11, day: 13
                      ).format
                    )
                  end
                end
                context 'westen date in start_date' do
                  it 'is the same data in file' do
                    expect(item.start_date.western).to eq(
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
                context 'japan year in start_year' do
                  it 'is the same data in file' do
                    expect(item.start_year.japan).to eq(13)
                  end
                end
                context 'western year in start_year' do
                  it 'is the same data in file' do
                    expect(item.start_year.western).to eq(1005)
                  end
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
