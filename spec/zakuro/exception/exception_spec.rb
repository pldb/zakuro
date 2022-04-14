# frozen_string_literal: true

require File.expand_path('../../../lib/zakuro/exception/exception',
                         __dir__)

require File.expand_path('../../../lib/zakuro/exception/cause_pattern',
                         __dir__)

require File.expand_path('../../../lib/zakuro/exception/cause_preset',
                         __dir__)

describe 'Zakuro' do
  describe 'Exception' do
    context 'a valid error code' do
      it 'should have a cause' do
        cause_presets = [
          Zakuro::Exception::CausePreset.new(
            template: Zakuro::Exception::CausePattern::INTERNAL_ERROR
          )
        ]
        exception = Zakuro::Exception.get(cause_presets: cause_presets)
        expect(exception.causes.size).to eq 1
      end
    end
  end
end
