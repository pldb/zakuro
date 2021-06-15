# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/daien/monthly/lunar_phase',
                         __dir__)

DAIEN_NOVEMBER_1ST = {
  766 => '54-1622',
  767 => '49-431',
  768 => '43-1613',
  769 => '7-1272',
  770 => '1-1332',
  771 => '55-1422',
  772 => '19-1068',
  773 => '13-2237',
  774 => '8-1088',
  775 => '32-1494',
  776 => '27-155',
  777 => '51-157',
  778 => '45-635',
  779 => '39-606',
  780 => '3-54',
  781 => '57-569',
  782 => '51-2024',
  783 => '15-2336'
}.freeze

describe 'Zakuro' do
  describe 'Daien' do
    describe 'Monthly' do
      describe 'LunarPhase' do
        describe '.next_phase' do
          context 'november 1st every year' do
            DAIEN_NOVEMBER_1ST.each do |year, value|
              # 11月定朔
              lunar_phase = Zakuro::Daien::Monthly::LunarPhase.new(
                western_year: year
              )
              actual = lunar_phase.next_phase

              # TODO: it を DAIEN_NOVEMBER_1ST の前にする
              it 'should be expected values' do
                # TODO: テストケースを通す
                expect(actual.format).to eq value
              end
            end
          end
        end
      end
    end
  end
end
