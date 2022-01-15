# frozen_string_literal: true

require File.expand_path('../../../../../zakuro/lib/zakuro/era/japan/version',
                         __dir__)
require 'yaml'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Version' do
      describe '.get_class_name' do
        context 'out of range' do
          it 'should be raised ArgumentError' do
            expect do
              Zakuro::Japan::Version.class_name(
                date: Zakuro::Western::Calendar.new(year: 445, month: 1, day: 23)
              )
            end.to raise_error(ArgumentError)
          end
        end
        context 'date in first reki' do
          example '元嘉' do
            expect(
              Zakuro::Japan::Version.class_name(
                date: Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
              )
            ).to eq('Zakuro::Genka::Gateway')
          end
        end
        context 'date in second reki' do
          example '儀鳳' do
            expect(
              Zakuro::Japan::Version.class_name(
                date: Zakuro::Western::Calendar.new(year: 698, month: 2, day: 16)
              )
            ).to eq('Zakuro::Gihou::Gateway')
          end
        end
        context 'date in last reki' do
          example 'グレゴリオ' do
            expect(
              Zakuro::Japan::Version.class_name(
                date: Zakuro::Western::Calendar.new(year: 1872, month: 12, day: 9)
              )
            ).to eq('Zakuro::Gregorio::Gateway')
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
