# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative '../../../testtool/setting'

require_relative './testdata/current_date'

require_relative './testdata/parser'

require_relative './single_date_printer'

require 'date'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Motsumetsu' do
      context 'all metsunichi' do
        it 'should be equal to a reference' do
          # |764/02/07|大衍暦|A|✓|✓|✓|
          # | | |B|-|-|-|
          # | | |C|-|-|-|
          # |862/02/03|宣明暦| |✓|✓|✓|
          # |1685/02/04|貞享暦| |-|-|-|
          start_date = Date.new(764, 2, 7)
          # last_date = Date.new(766, 2, 3)
          last_date = Date.new(1685, 2, 3)

          current_date = start_date.clone

          days = (last_date - start_date).to_i

          current_date -= 1

          File.open('./motsumetsu.log', 'w') do |f|
            break unless Zakuro::TestTool::Setting::MOTSUMETSU_ENABLED

            days.times.each do |_index|
              current_date += 1

              # next unless current_date == Date.new(764, 8, 16)

              actual = Zakuro::Merchant.new(
                condition: {
                  date: current_date.clone,
                  options: { 'dropped_date' => true, 'vanished_date' => true }
                }
              ).commit

              actual_printer = Zakuro::All::Motsumetsu::SingleDatePrinter.new(date: actual)

              next unless actual_printer.event?

              line = "western_date: #{actual_printer.western_date} / japan_date: " \
              "#{actual_printer.japan_date} / dropped_date: #{actual_printer.dropped_date?} / " \
              "vanished_date: #{actual_printer.vanished_date?}"

              f.puts(line)
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
