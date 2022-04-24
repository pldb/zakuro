# frozen_string_literal: true

require File.expand_path('./testtools/const', __dir__)

require 'date'
require File.expand_path('../lib/zakuro',
                         __dir__)

describe 'Zakuro' do
  describe 'Merchant' do
    describe '#new' do
      context 'invalid parameter' do
        example 'date' do
          hash = { date: 1 }
          expect do
            Zakuro::Merchant.new(condition: hash)
          end.to raise_error(Zakuro::Exception::ZakuroError)
        end
      end
    end
    describe '#commit' do
      context '862-2-3' do
        example '貞観4年1月1日' do
          date = Date.new(862, 2, 3)
          actual = Zakuro::Merchant.new(condition: { date: date }).commit
          expect(actual.to_pretty_json).to eql(Const::SENMYOU_FIRST_DAY.to_pretty_json)
        end
      end
    end
  end
end
