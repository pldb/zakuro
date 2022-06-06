# frozen_string_literal: true

require File.expand_path('../../../lib/zakuro/gateway/range',
                         __dir__)

describe 'Zakuro' do
  describe 'Gateway' do
    describe 'Range' do
      context 'valid date type paramter' do
        it 'should be no error' do
          context = Zakuro::Context::Context.new
          param = { start: '0460-01-01', last: '0460-01-02' }

          range = Zakuro::Gateway::Range.new(context: context, range: param)
          actual = range.get

          expect(actual.class).to eq Zakuro::Result::Range
        end
      end
      context 'invalid date type paramter' do
        it 'should be raised error' do
          context = Zakuro::Context::Context.new
          param = { start: '0460-01-01', last: '貞観1年1月1日' }

          range = Zakuro::Gateway::Range.new(context: context, range: param)
          expect { range.get }.to raise_error(Zakuro::Exception::ZakuroError)
        end
      end
    end
  end
end
