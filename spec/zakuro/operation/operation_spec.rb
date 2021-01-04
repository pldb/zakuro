# frozen_string_literal: true

require File.expand_path('../../../' \
                         'lib/zakuro/operation/operation',
                         __dir__)

describe 'Zakuro' do
  describe 'Operation' do
    describe 'MonthParser' do
      context 'run' do
        it 'default month file should be running' do
          result = Zakuro::Operation::MonthParser.run
          # 124(全行) - 9（無効行）
          expect(result.size).to eq 115
          p result.size
        end
      end
    end
  end
end
