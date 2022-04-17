# frozen_string_literal: true

require File.expand_path('../../../lib/zakuro/exception/exception',
                         __dir__)

require File.expand_path('../../../lib/zakuro/exception/case/pattern',
                         __dir__)

require File.expand_path('../../../lib/zakuro/exception/case/preset',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Exception' do
    describe 'get' do
      context 'a valid error code' do
        it 'should have a cause' do
          presets = [
            Zakuro::Exception::Case::Preset.new(
              template: Zakuro::Exception::Case::Pattern::INTERNAL_ERROR
            )
          ]
          exception = Zakuro::Exception.get(presets: presets)
          expect(exception.causes.size).to eq 1
        end
      end
      context 'a valid error code with message' do
        let!(:exception) do
          presets = [
            Zakuro::Exception::Case::Preset.new(
              1,
              template: Zakuro::Exception::Case::Template.new(
                code: 'dummy',
                message: 'test %d',
                length: 1
              )
            )
          ]
          Zakuro::Exception.get(presets: presets)
        end
        it 'should have a cause' do
          expect(exception.causes.size).to eq 1
        end
        it 'should have a formatted message' do
          expect(exception.causes[0].message).to eq 'test 1'
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
