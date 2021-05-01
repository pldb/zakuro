# frozen_string_literal: true

require File.expand_path('../../../testtools/stringifier',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/calculation/summary/single',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('./single_data_factory',
                         __dir__)

# rubocop:disable Metrics/BlockLength

describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Single' do
      describe '.get' do
        # :reek:UnityFunction
        def eql?(date:, expected:)
          actual = Zakuro::Calculation::Summary::Single.get(
            context: Zakuro::Context.new(version_name: 'Senmyou'),
            date: date
          )

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
            expected = SingleDataFactory.create(hash: test['expected'])

            it "#{western_date}: #{test['test_case_name']}" do
              # if test['test_case_name'] == '明徳3年閏10月1日（明徳3年11月1日）'
              #   p western_date
              #   p "use on debug mode"
              # end
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
