# frozen_string_literal: true

require File.expand_path('../../../../../../' \
                         'lib/zakuro/calculation/era/gengou/internal/counter',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/era/japan/gengou/resource',
                         __dir__)
# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Counter' do
        describe '#invalid?' do
          context 'created instance' do
            it 'should be true with invalid gengou parameter' do
              gengou = Zakuro::Japan::Gengou::Resource::Gengou.new
              actual = Zakuro::Calculation::Gengou::Counter.new(gengou: gengou)

              expect(actual.invalid?).to be_truthy
            end
          end
        end
        describe '#next_year' do
          let(:japan_year) do
            1
          end
          let(:western_year) do
            1
          end
          let(:gengou) do
            Zakuro::Japan::Gengou::Resource::Gengou.new(
              name: '元号名',
              start_year: Zakuro::Japan::Gengou::Resource::Both::Year.new(
                japan: japan_year, western: western_year
              ),
              start_date: Zakuro::Japan::Gengou::Resource::SwitchDate.new(
                calculation: Zakuro::Japan::Gengou::Resource::Both::Date.new,
                operation: Zakuro::Japan::Gengou::Resource::Both::Date.new(
                  japan: Zakuro::Japan::Calendar.parse(text: "元号#{japan_year}年1月1日"),
                  western: Zakuro::Western::Calendar.new(year: western_year)
                ),
                operated: true
              ),
              last_date: Zakuro::Western::Calendar.new(year: 20)
            )
          end

          context 'japan year' do
            it 'should be next year' do
              actual = Zakuro::Calculation::Gengou::Counter.new(gengou: gengou)
              actual.next_year

              expect(actual.japan_year).to eql japan_year + 1
            end
          end
          context 'western year' do
            it 'should be next year' do
              actual = Zakuro::Calculation::Gengou::Counter.new(gengou: gengou)
              actual.next_year

              expect(actual.western_year).to eql western_year + 1
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
