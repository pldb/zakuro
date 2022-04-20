# frozen_string_literal: true

require File.expand_path('../../lib/zakuro/condition',
                         __dir__)

describe 'Zakuro' do
  describe 'Condition' do
    context 'date only as Date type' do
      it 'should be no error' do
        hash = { date: Date.new(1600, 1, 1, Date::JULIAN) }
        failed = Zakuro::Condition.validate(hash: hash)
        expect(failed).to be_empty
      end
    end
    context 'invalid parameter' do
      context 'date' do
        let!(:failed) do
          hash = { date: 1 }
          Zakuro::Condition.validate(hash: hash)
        end
        it 'should be a error' do
          expect(failed.size).to eq 1
        end
        it 'should be a specified code' do
          expect(failed[0].code).to eq Zakuro::Exception::Case::Pattern::INVALID_DATE_TYPE.code
        end
      end
    end
    # TODO: more test
  end
end
