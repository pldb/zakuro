# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative './testdata/current_date'

require_relative './testdata/parser'

require 'date'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Motsumetsu' do
      context 'all metsunichi' do
        it 'should be equal to a reference' do
          # |698/02/16|儀鳳暦|A|✓|-|-|
          # | | |B|-|-|-|
          # | | |C|-|-|-|
          # |764/02/07|大衍暦|A|✓|✓|✓|
          # | | |B|-|-|-|
          # | | |C|-|-|-|
          # |862/02/03|宣明暦| |✓|✓|✓|
          START_DATE = Date.new(764, 2, 7)
          # TODO: 試験的に動作確認しているため期間を短くする
          # LAST_DATE = Date.new(862, 2, 3)
          LAST_DATE = Date.new(766, 2, 3)

          current_date = START_DATE.clone

          days = (LAST_DATE - START_DATE).to_i

          current_date -= 1

          # TODO: refactor
          File.open('./temp.log', 'w') do |f|
            days.times.each do |_index|
              current_date += 1

              # TODO: 不具合箇所の分析
              # next unless current_date == Date.new(764, 8, 16)
              # next unless current_date == Date.new(764, 8, 26)

              actual = Zakuro::Merchant.new(
                condition: {
                  date: current_date.clone,
                  options: { 'dropped_date' => true, 'vanished_date' => true }
                }
              ).commit

              options = actual.data.options

              dropped_date = options['dropped_date']

              vanished_date = options['vanished_date']

              next unless dropped_date.matched || vanished_date.matched

              data = actual.data
              japan_date = "#{data.year.first_gengou.name}#{data.year.first_gengou.number}年" \
              "#{data.month.leaped ? '閏' : ''}#{data.month.number}月#{data.day.number}日"

              line = "western_date: #{actual.data.day.western_date.format}, japan_date: " \
              "#{japan_date}, dropped_date: #{dropped_date.matched}, " \
              "vanished_date: #{vanished_date.matched}\n"

              f.write(line)
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
