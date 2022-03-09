# frozen_string_literal: true

require File.expand_path('../../../../../../../' \
                         'lib/zakuro/calculation/era/gengou/internal/reserve/named_list',
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
        describe 'NamedList' do
          context 'first line' do
            context 'parameter with only start name' do
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: true, start_name: '允恭天皇'
                )
              end
              it 'should be included target gengou and neighborhood gengou' do
                expect(actual.list.size).to eq 2
              end
              it 'should be included target gengou' do
                expect(actual.list[0].name).to eq '允恭天皇'
              end
              it 'should be included neighborhood gengou' do
                expect(actual.list[1].name).to eq '安康天皇'
              end
            end
            context 'parameter with start name and last name' do
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: true, start_name: '雄略天皇', last_name: '顕宗天皇'
                )
              end
              it 'should be included target gengou and neighborhood gengou' do
                expect(actual.list.size).to eq 5
              end
              it 'should be included neighborhood gengou for "start name"' do
                expect(actual.list[0].name).to eq '安康天皇'
              end
              it 'should be included "start name" gengou' do
                expect(actual.list[1].name).to eq '雄略天皇'
              end
              it 'should be included gengou in the middle of range' do
                expect(actual.list[2].name).to eq '清寧天皇'
              end
              it 'should be included "last name" gengou' do
                expect(actual.list[3].name).to eq '顕宗天皇'
              end
              it 'should be included neighborhood gengou for "last name"' do
                expect(actual.list[4].name).to eq '仁賢天皇'
              end
            end
            context 'invalid parameter with only start name' do
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: true, start_name: '正慶'
                )
              end
              it 'should be no element' do
                expect(actual.list.size).to eq 0
              end
            end
            context 'no parameter' do
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: true
                )
              end
              it 'should be no element' do
                expect(actual.list.size).to eq 0
              end
            end
          end
          context 'second line' do
            context 'parameter with only start name' do
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: false, start_name: '正慶'
                )
              end
              it 'should be included target gengou and neighborhood gengou' do
                expect(actual.list.size).to eq 2
              end
              it 'should be included target gengou' do
                expect(actual.list[0].name).to eq '正慶'
              end
              it 'should be included neighborhood gengou' do
                expect(actual.list[1].name).to eq '建武'
              end
            end
            context 'parameter with start name and last name' do
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: false, start_name: '暦応', last_name: '貞和'
                )
              end
              it 'should be included target gengou and neighborhood gengou' do
                expect(actual.list.size).to eq 5
              end
              it 'should be included neighborhood gengou for "start name"' do
                expect(actual.list[0].name).to eq '建武'
              end
              it 'should be included "start name" gengou' do
                expect(actual.list[1].name).to eq '暦応'
              end
              it 'should be included gengou in the middle of range' do
                expect(actual.list[2].name).to eq '康永'
              end
              it 'should be included "last name" gengou' do
                expect(actual.list[3].name).to eq '貞和'
              end
              it 'should be included neighborhood gengou for "last name"' do
                expect(actual.list[4].name).to eq '観応'
              end
            end
            context 'invalid parameter with only start name' do
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: false, start_name: '允恭天皇'
                )
              end
              it 'should be no element' do
                expect(actual.list.size).to eq 0
              end
            end
            context 'no parameter' do
              let!(:actual) do
                Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: false
                )
              end
              it 'should be no element' do
                expect(actual.list.size).to eq 0
              end
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
