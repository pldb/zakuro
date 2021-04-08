# frozen_string_literal: true

require File.expand_path('../../../../testtools/stringifier',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/summary/single',
                         __dir__)

require File.expand_path('./single_day_factory',
                         __dir__)

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
        it 'all single data' do
          filepath = File.expand_path(
            './yaml/testdata.yaml',
            __dir__
          )
          hash = YAML.load_file(filepath)

          hash.each do |test|
            p test['western_date']
            p test['test_case_name']

            expected = SingleDayFactory.create(hash: test['expected'])

            # TODO: テスト方法
            eql?(
              date: Zakuro::Western::Calendar.parse(str: test['western_date']),
              expected: expected
            )
          end
        end
      end
    end
  end
end
