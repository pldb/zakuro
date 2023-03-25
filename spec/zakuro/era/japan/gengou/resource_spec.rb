# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/era/japan/gengou/resource',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Gengou' do
      describe 'Resource' do
        describe '#LIST' do
          def get_start_date_by_name(name: '', list: [])
            list.each do |set|
              set.list.each do |gengou|
                return gengou.start_date.western if gengou.name == name
              end
            end

            Zakuro::Western::Calendar.new
          end

          def get_last_date_by_name(name: '', list: [])
            list.each do |set|
              set.list.each do |gengou|
                return gengou.last_date if gengou.name == name
              end
            end

            Zakuro::Western::Calendar.new
          end
          context 'gengou with operation effects' do
            it 'start date should be changed' do
              name = '天応'

              start_date = get_start_date_by_name(
                name: name, list: Zakuro::Japan::Gengou::Resource::LIST
              )

              operated_start_date = get_start_date_by_name(
                name: name, list: Zakuro::Japan::Gengou::Resource::OPERATED_LIST
              )

              expect(operated_start_date > start_date).to be_truthy
            end
            it 'last date should be changed' do
              # 後の元号の開始日変更により最終日が変更される
              name = '宝亀'

              last_date = get_last_date_by_name(
                name: name, list: Zakuro::Japan::Gengou::Resource::LIST
              )

              operated_last_date = get_last_date_by_name(
                name: name, list: Zakuro::Japan::Gengou::Resource::OPERATED_LIST
              )

              expect(operated_last_date > last_date).to be_truthy
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
