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
              it 'should be included target gengou and neighborhood gengou' do
                actual = Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: true, start_name: '允恭天皇'
                )
                expect(actual.list.size).to eq 2
              end
              it 'should be included target gengou' do
                actual = Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: true, start_name: '允恭天皇'
                )
                expect(actual.list[0].name).to eq '允恭天皇'
              end
              it 'should be included neighborhood gengou' do
                actual = Zakuro::Calculation::Gengou::Reserve::NamedList.new(
                  first: true, start_name: '允恭天皇'
                )
                expect(actual.list[1].name).to eq '安康天皇'
              end
            end
            # TODO: make
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
