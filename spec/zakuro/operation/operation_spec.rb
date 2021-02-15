# frozen_string_literal: true

require File.expand_path('../../../' \
                         'lib/zakuro/operation/operation',
                         __dir__)

describe 'Zakuro' do
  describe 'Operation' do
    describe 'month' do
      context 'default month file' do
        it 'should be loaded' do
          result = Zakuro::Operation.month_histories
          # 124(全行) - 9（無効行）
          expect(result.size).to eq 115
        end
      end
    end
  end
end
