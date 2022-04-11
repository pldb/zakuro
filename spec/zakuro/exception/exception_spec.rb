# frozen_string_literal: true

require File.expand_path('../../../lib/zakuro/exception/exception',
                         __dir__)

describe 'Zakuro' do
  describe 'Exception' do
    context 'a valid error code' do
      it 'should have a cause' do
        exception = Zakuro::Exception.get(codes: [:ERROR_0001])
        expect(exception.causes.size).to eq 1
      end
    end
    context 'a invalid error code' do
      it 'should have a cause' do
        exception = Zakuro::Exception.get(codes: [:ERROR_XXXX])
        expect(exception.causes.size).to eq 1
      end
      it 'should a code means a failure to specify cause' do
        exception = Zakuro::Exception.get(codes: [:ERROR_XXXX])
        expect(exception.causes[0].code).to eq 'ERROR_NOCODE'
      end
    end
  end
end
