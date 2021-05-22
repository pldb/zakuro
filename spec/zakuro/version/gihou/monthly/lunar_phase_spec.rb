# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/gihou/monthly/lunar_phase',
                         __dir__)

GIHOU_NOVEMBER_1ST = {
  700 => '47-1041',
  701 => '11-808',
  702 => '5-1179',
  703 => '0-556',
  704 => '24-715',
  705 => '19-251',
  706 => '13-827',
  707 => '37-680',
  708 => '31-753',
  709 => '55-445',
  710 => '49-577',
  711 => '43-1051',
  712 => '7-1110',
  713 => '2-682',
  714 => '57-150',
  715 => '21-129',
  716 => '15-430',
  717 => '9-442',
  718 => '33-149',
  719 => '27-377',
  720 => '51-319',
  721 => '45-1049',
  722 => '40-642',
  723 => '4-737',
  724 => '58-1290'
}.freeze

describe 'Zakuro' do
  describe 'Gihou' do
    describe 'Monthly' do
      describe 'LunarPhase' do
        describe '.next_phase' do
          context 'november 1st every year' do
            it 'should be expected values' do
              GIHOU_NOVEMBER_1ST.each do |year, value|
                # 11月定朔
                lunar_phase = Zakuro::Gihou::Monthly::LunarPhase.new(
                  western_year: year
                )
                actual = lunar_phase.next_phase

                # TODO: pass test case
                expect(actual.format).to eq value
              end
            end
          end
        end
      end
    end
  end
end
