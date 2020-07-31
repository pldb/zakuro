# frozen_string_literal: true

require File.expand_path('../../lib/zakuro/condition',
                         __dir__)

describe 'Zakuro' do
  describe 'Condition' do
    context 'date only as Date type' do
      it 'should be no error' do
        failed = Zakuro::Condition.validate(hash: { date: Date.new(1600, 1, 1, Date::JULIAN) })
        expect(failed).to be_empty
      end
    end
  end
end
