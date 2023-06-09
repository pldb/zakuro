# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/gihou/monthly/lunar_phase',
                         __dir__)

# :nodoc:
module Zakuro
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
    717 => '9-442', # 閏
    718 => '33-149',
    719 => '27-377',
    720 => '51-319',
    721 => '45-1049',
    722 => '40-642',
    723 => '4-737',
    724 => '58-1290',
    725 => '53-159',
    726 => '16-1197',
    727 => '10-1220',
    728 => '34-1042',
    729 => '29-192',
    730 => '23-1012',
    731 => '47-1181',
    732 => '42-628',
    733 => '36-1082',
    734 => '0-881',
    735 => '54-882',
    736 => '48-978',
    737 => '12-843',
    738 => '7-96',
    739 => '31-206',
    740 => '25-1134',
    741 => '20-494',
    742 => '44-415',
    743 => '38-602',
    744 => '32-584',
    745 => '56-333',
    746 => '50-676',
    747 => '14-678',
    748 => '9-170',
    749 => '3-1067',
    750 => '27-1109',
    751 => '22-199',
    752 => '16-302',
    753 => '39-1327',
    754 => '34-93',
    755 => '28-539', # 閏
    756 => '52-581',
    757 => '47-143',
    758 => '11-288',
    759 => '5-967',
    760 => '59-1300',
    761 => '23-1049'
  }.freeze
end

describe 'Zakuro' do
  describe 'Version' do
    describe 'Gihou' do
      describe 'Monthly' do
        describe 'LunarPhase' do
          describe '.next_phase' do
            context 'november 1st every year' do
              it 'should be expected values' do
                Zakuro::GIHOU_NOVEMBER_1ST.each do |year, value|
                  # 11月定朔
                  lunar_phase = Zakuro::Version::Gihou::Monthly::LunarPhase.new(
                    western_year: year
                  )
                  actual = lunar_phase.next_phase

                  expect(actual.format).to eq value
                end
              end
            end
          end
        end
      end
    end
  end
end
