# frozen_string_literal: true

require File.expand_path('../testtools/const', __dir__)

require 'date'
require File.expand_path('../../' \
                         'lib/zakuro/output/error',
                         __dir__)
require File.expand_path('../../' \
                         'lib/zakuro/version_factory',
                         __dir__)
require File.expand_path('../../' \
                         'lib/zakuro/version/senmyou/senmyou',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'VersionFactory' do
    describe '.get_runnable_constant' do
      context 'out of range' do
        it 'should be raised ArgumentError' do
          date = Date.new(445, 1, 23)
          expect do
            Zakuro::VersionFactory.get_runnable_constant(date: date)
          end.to raise_error(ArgumentError)
        end
      end
      context 'genka' do
        it 'should be raised ArgumentError' do
          date = Date.new(445, 1, 24)
          expect do
            Zakuro::VersionFactory.get_runnable_constant(date: date)
          end.to raise_error(ArgumentError)
        end
      end
      context 'gihou' do
        it 'should be raised ArgumentError' do
          date = Date.new(698, 2, 16)
          actual = Zakuro::VersionFactory.get_runnable_constant(date: date)
          expect(actual).to eq(Zakuro::Gihou::Gateway)
        end
      end
      context 'taien' do
        it 'should be raised ArgumentError' do
          date = Date.new(764, 2, 7)
          expect do
            Zakuro::VersionFactory.get_runnable_constant(date: date)
          end.to raise_error(ArgumentError)
        end
      end
      context 'senmyou' do
        it 'should be raised ArgumentError' do
          date = Date.new(862, 2, 3)
          actual = Zakuro::VersionFactory.get_runnable_constant(date: date)
          expect(actual).to eq(Zakuro::Senmyou::Gateway)
        end
      end
      context 'joukyou' do
        it 'should be raised ArgumentError' do
          date = Date.new(1685, 2, 4)
          expect do
            Zakuro::VersionFactory.get_runnable_constant(date: date)
          end.to raise_error(ArgumentError)
        end
      end
      context 'houryaku' do
        it 'should be raised ArgumentError' do
          date = Date.new(1755, 2, 11)
          expect do
            Zakuro::VersionFactory.get_runnable_constant(date: date)
          end.to raise_error(ArgumentError)
        end
      end
      context 'kansei' do
        it 'should be raised ArgumentError' do
          date = Date.new(1798, 2, 16)
          expect do
            Zakuro::VersionFactory.get_runnable_constant(date: date)
          end.to raise_error(ArgumentError)
        end
      end
      context 'tenpou' do
        it 'should be raised ArgumentError' do
          date = Date.new(1844, 2, 18)
          expect do
            Zakuro::VersionFactory.get_runnable_constant(date: date)
          end.to raise_error(ArgumentError)
        end
      end
      context 'gregorio' do
        it 'should be raised ArgumentError' do
          date = Date.new(1872, 12, 9)
          expect do
            Zakuro::VersionFactory.get_runnable_constant(date: date)
          end.to raise_error(ArgumentError)
        end
      end
    end
    describe '.to_japan_date' do
      context '862-2-3' do
        example '貞観4年1月1日' do
          date = Date.new(862, 2, 3)
          actual = Zakuro::VersionFactory.to_japan_date(western_date: date)
          expect(actual.to_pretty_json).to eql(Const::SENMYOU_FIRST_DAY.to_pretty_json)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
