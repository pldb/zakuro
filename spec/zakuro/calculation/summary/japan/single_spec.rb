# frozen_string_literal: true

require File.expand_path('../../../../testtool/stringifier',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/summary/japan/single',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../testdata/single_data_factory',
                         __dir__)

# rubocop:disable Metrics/BlockLength

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Summary' do
      describe 'Western' do
        describe 'Single' do
          describe '.get' do
            # :reek:UnityFunction
            def eql?(date:, version:, expected:)
              actual = Zakuro::Calculation::Summary::Japan::Single.get(
                context: Zakuro::Context::Context.new(version: version),
                date: date
              )

              TestTool::Stringifier.eql?(
                expected: expected,
                actual: actual,
                class_prefix: 'Zakuro::Result'
              )
            end
            context 'all single data' do
              filepath = File.expand_path(
                '../testdata/yaml/single.yaml',
                __dir__
              )
              hash = YAML.load_file(filepath)

              hash.each do |test|
                japan_date = test['japan_date']
                # TODO: 暦を指定できるようになった段階で使用する
                # version = test['version']
                expected = SingleDataFactory.create(hash: test['expected'])

                message = "#{test['western_date']}[#{test['operation']}]: #{test['description']}"
                it "#{japan_date}: #{message}" do
                  # if test['japan_date'] == '明徳3年閏10月1日（明徳3年11月1日）'
                  #   p western_date
                  #   p "use on debug mode"
                  # end
                  eql?(
                    date: Zakuro::Japan::Calendar.parse(text: japan_date),
                    version: '',
                    expected: expected
                  )
                end
              end
            end
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
