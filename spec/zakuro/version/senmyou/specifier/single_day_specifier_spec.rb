# frozen_string_literal: true

require File.expand_path('../../../../testtools/stringifier',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/summary/single',
                         __dir__)
describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Single' do
      describe '.get' do
        context 'ancient month from western date 862-2-3' do
          date = Zakuro::Western::Calendar.new(year: 862, month: 2, day: 3)

          puts Zakuro::Senmyou::Single.get(date: date).to_pretty_json
          # TODO: expect values
        end
      end
    end
  end
end
