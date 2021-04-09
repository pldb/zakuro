# frozen_string_literal: true

require File.expand_path('../../../../testtools/stringifier',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/summary/single',
                         __dir__)

require File.expand_path('./single_day_factory',
                         __dir__)

# rubocop:disable Metrics/BlockLength

describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Single' do
      describe '.get' do
        # :reek:UnityFunction
        def eql?(date:, expected:)
          actual = Zakuro::Senmyou::Single.get(date: date)

          TestTools::Stringifier.eql?(
            expected: expected,
            actual: actual,
            class_prefix: 'Zakuro::Result'
          )
        end
        context 'all single data' do
          filepath = File.expand_path(
            './yaml/testdata.yaml',
            __dir__
          )
          hash = YAML.load_file(filepath)

          hash.each do |test|
            western_date = test['western_date']
            expected = SingleDayFactory.create(hash: test['expected'])

            it "#{western_date}: #{test['test_case_name']}" do
              eql?(
                date: Zakuro::Western::Calendar.parse(str: western_date),
                expected: expected
              )
            end
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
