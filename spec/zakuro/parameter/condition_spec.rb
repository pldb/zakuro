# frozen_string_literal: true

require File.expand_path('../../../lib/zakuro/parameter/condition',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Parameter' do
    describe 'Condition' do
      context 'date only as Date type' do
        it 'should be no error' do
          hash = { date: Date.new(1600, 1, 1, Date::JULIAN) }
          failed = Zakuro::Parameter::Condition.validate(hash: hash)
          expect(failed).to be_empty
        end
      end
      context 'invalid parameter' do
        context 'condition' do
          let!(:failed) do
            Zakuro::Parameter::Condition.validate(hash: [])
          end
          it 'should be a error' do
            expect(failed.size).to eq 1
          end
          it 'should be a specified code' do
            code = Zakuro::Exception::Case::Pattern::INVALID_CONDITION_TYPE.code
            expect(failed[0].code).to eq code
          end
        end
        context 'date' do
          let!(:failed) do
            hash = { date: 1 }
            Zakuro::Parameter::Condition.validate(hash: hash)
          end
          it 'should be a error' do
            expect(failed.size).to eq 1
          end
          it 'should be a specified code' do
            code = Zakuro::Exception::Case::Pattern::INVALID_DATE_TYPE.code
            expect(failed[0].code).to eq code
          end
        end
        context 'range' do
          let!(:failed) do
            hash = { range: [] }
            Zakuro::Parameter::Condition.validate(hash: hash)
          end
          it 'should be a error' do
            expect(failed.size).to eq 1
          end
          it 'should be a specified code' do
            code = Zakuro::Exception::Case::Pattern::INVALID_RANGE_TYPE.code
            expect(failed[0].code).to eq code
          end
        end
        context 'start date in range' do
          let!(:failed) do
            hash = { range: { start: 1, last: '0460-01-01' } }
            Zakuro::Parameter::Condition.validate(hash: hash)
          end
          it 'should be a error' do
            expect(failed.size).to eq 1
          end
          it 'should be a specified code' do
            code = Zakuro::Exception::Case::Pattern::INVALID_DATE_TYPE.code
            expect(failed[0].code).to eq code
          end
        end
        context 'last date in range' do
          let!(:failed) do
            hash = { range: { start: '0460-01-01', last: 1 } }
            Zakuro::Parameter::Condition.validate(hash: hash)
          end
          it 'should be a error' do
            expect(failed.size).to eq 1
          end
          it 'should be a specified code' do
            code = Zakuro::Exception::Case::Pattern::INVALID_DATE_TYPE.code
            expect(failed[0].code).to eq code
          end
        end
        context 'columns' do
          let!(:failed) do
            hash = { columns: {} }
            Zakuro::Parameter::Condition.validate(hash: hash)
          end
          it 'should be a error' do
            expect(failed.size).to eq 1
          end
          it 'should be a specified code' do
            code = Zakuro::Exception::Case::Pattern::INVALID_COLUMN_TYPE.code
            expect(failed[0].code).to eq code
          end
        end
        context 'options' do
          let!(:failed) do
            hash = { options: [] }
            Zakuro::Parameter::Condition.validate(hash: hash)
          end
          it 'should be a error' do
            expect(failed.size).to eq 1
          end
          it 'should be a specified code' do
            code = Zakuro::Exception::Case::Pattern::INVALID_OPTION_TYPE.code
            expect(failed[0].code).to eq code
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
