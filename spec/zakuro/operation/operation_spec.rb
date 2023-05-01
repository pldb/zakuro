# frozen_string_literal: true

require File.expand_path('../../testtool/stringifier',
                         __dir__)

require File.expand_path('../../../' \
                         'lib/zakuro/operation/operation',
                         __dir__)

require File.expand_path('../../../' \
                          'lib/zakuro/era/western/calendar',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Operation' do
    describe 'month' do
      context 'default month file' do
        it 'should be loaded' do
          result = Zakuro::Operation.month_histories
          # 487(全行) - 91（無効行）
          expect(result.size).to eq 396
        end
        it 'should be loaded any elements' do
          id = '156-1-1'
          result = Zakuro::Operation.month_histories
          expect = result.select { |history| history.id == id }
          TestTool::Stringifier.eql?(
            expected: Zakuro::Operation::MonthHistory.new(
              id: id,
              reference: Zakuro::Operation::Reference.new(
                page: 156, number: 1, japan_date: '貞観15年 1  小 丁卯 2-5359'
              ),
              western_date: Zakuro::Western::Calendar.new(year: 873, month: 2, day: 1),
              annotations: [
                Zakuro::Operation::Annotation.new(
                  id: '156-1-1',
                  description: '計算では2丙寅である, 三代実録に正月丁卯朔とある。従って正月朔のユリウス暦日は2月2日。',
                  note: ''
                )
              ],
              diffs: Zakuro::Operation::Diffs.new(
                month: Zakuro::Operation::Month.new(
                  number: Zakuro::Operation::Number.new,
                  leaped: Zakuro::Operation::Leaped.new,
                  is_many_days: Zakuro::Operation::Days.new(src: '大', dest: '小')
                ),
                solar_term: Zakuro::Operation::SolarTerm::Direction.new,
                days: 1
              )
            ),
            actual: expect[0],
            class_prefix: 'Zakuro::Operation'
          )
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
