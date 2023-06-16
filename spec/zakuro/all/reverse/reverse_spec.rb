# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative '../../../testtool/setting'

require_relative './single_date_printer'

require 'date'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Reverse' do
      context 'all date' do
        def to_western_date(japan_date:)
          actual = Zakuro::Merchant.new(condition: { date: japan_date }).commit

          actual_printer = Zakuro::All::Reverse::SingleDatePrinter.new(date: actual)

          actual_printer.western_date
        end

        it 'should be equal to a reverse resolution' do
          # TODO: malti thread

          # |764/02/07|大衍暦|A|✓|✓|✓|
          # | | |B|-|-|-|
          # | | |C|-|-|-|
          # |862/02/03|宣明暦| |✓|✓|✓|
          # |1685/02/04|貞享暦| |-|-|-|
          start_date = Date.new(764, 2, 7)
          # # last_date = Date.new(766, 2, 3)
          last_date = Date.new(1685, 2, 3)

          # start_date = Date.new(1350, 1, 1)
          # last_date = Date.new(1350, 2, 1)

          current_date = start_date.clone

          days = (last_date - start_date).to_i

          current_date -= 1

          File.open('./reverse.log', 'w') do |f|
            break unless Zakuro::TestTool::Setting::REVERSE_ENABLED

            days.times.each do |_index|
              current_date += 1
              matched = true

              # next unless current_date == Date.new(764, 8, 16)

              line = "western_date: #{current_date} "

              actual = Zakuro::Merchant.new(condition: { date: current_date.clone }).commit

              actual_printer = Zakuro::All::Reverse::SingleDatePrinter.new(date: actual)

              line += '[result:first_gengou]:'
              line += "japan_date: #{actual_printer.first_japan_date} / "

              western_date = to_western_date(japan_date: actual_printer.first_japan_date)

              line += "western_date: #{western_date}"

              matched = false unless current_date.to_s == western_date

              if actual_printer.second?
                line += ' [result:second_gengou]:'
                line += "japan_date: #{actual_printer.second_japan_date} / "

                western_date = to_western_date(japan_date: actual_printer.second_japan_date)

                line += "western_date: #{western_date}"

                matched = false unless current_date.to_s == western_date
              end

              line += " / matched : #{matched}"

              f.puts(line)
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
