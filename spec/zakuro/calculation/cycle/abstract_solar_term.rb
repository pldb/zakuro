# frozen_string_literal: true

require File.expand_path('../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../' \
                          'lib/zakuro/version/senmyou/const/remainder',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/version/senmyou/cycle/solar_term',
                         __dir__)

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Cycle' do
      describe 'AbstractSolarTerm' do
        # 抽象クラスのため宣明暦のクラスを使用する
        let(:context) { Zakuro::Context::Context.new(version: 'Senmyou') }
        describe '.prev_term' do
          let(:solar_term_remainder) do
            Zakuro::Senmyou::Cycle::Remainder.new(day: 0, minute: 0, second: 0)
          end
          context 'solar term that remainder go back and advance' do
            it 'should be same as before ' do
              solar_term = Zakuro::Senmyou::Cycle::SolarTerm.new(
                index: 0,
                remainder: solar_term_remainder
              )
              solar_term.prev_term!
              solar_term.next_term!

              actual = solar_term.remainder.format(form: '%d-%d.%d')
              expect(solar_term_remainder.format(form: '%d-%d.%d')).to eq actual
            end
          end
        end
      end
    end
  end
end
