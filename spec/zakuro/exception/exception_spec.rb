# frozen_string_literal: true

require File.expand_path('../../../lib/zakuro/exception/exception',
                         __dir__)

require File.expand_path('../../../lib/zakuro/exception/case/pattern',
                         __dir__)

require File.expand_path('../../../lib/zakuro/exception/case/preset',
                         __dir__)

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
    end
  end
end
