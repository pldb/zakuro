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
          p result.size
        end
      end
    end
  end
end
