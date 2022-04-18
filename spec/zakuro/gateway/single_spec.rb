# frozen_string_literal: true

require File.expand_path('../../../lib/zakuro/gateway/single',
                         __dir__)

describe 'Zakuro' do
  describe 'Gateway' do
    describe 'Single' do
      context 'valid date type paramter' do
        it 'should be no error' do
          context = Zakuro::Context.new
          date = '0460-01-01'

          range = Zakuro::Gateway::Single.new(context: context, date: date)
          actual = range.get

          expect(actual.class).to eq Zakuro::Result::Single
        end
      end
      context 'invalid date type paramter' do
        it 'should be raised error' do
          context = Zakuro::Context.new
          date = 'xxxx-xx-xx'

          range = Zakuro::Gateway::Single.new(context: context, date: date)
          expect { range.get }.to raise_error(Zakuro::Exception::ZakuroError)
        end
      end
    end
  end
end
