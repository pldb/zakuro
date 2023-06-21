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

        def output(index:, start_date:, last_date:)
          # TODO: refactor
          current_date = start_date.clone

          days = (last_date - start_date).to_i + 1

          current_date -= 1

          file_name = "./reverse-#{format('%<index>03d', { index: index })}" \
            "-#{start_date}-#{last_date}.log"
          File.open(file_name, 'w') do |f|
            days.times.each do |_index|
              current_date += 1
              matched = true

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

        it 'should be equal to a reverse resolution' do
          # パターン数が多いためスレッド制御とする
          thread_size = 10

          # |764/02/07|大衍暦|A|✓|✓|✓|
          # | | |B|-|-|-|
          # | | |C|-|-|-|
          # |862/02/03|宣明暦| |✓|✓|✓|
          # |1685/02/04|貞享暦| |-|-|-|
          start_date = Date.new(764, 2, 7)
          last_date = Date.new(1685, 2, 3)

          # start_date = Date.new(1350, 1, 1)
          # last_date = Date.new(1350, 2, 1)

          total = (last_date - start_date).to_i

          interval = total / thread_size
          mod = total % thread_size

          current_date = start_date.clone

          File.open('./reverse.log', 'w') do |f|
            break unless Zakuro::TestTool::Setting::REVERSE_ENABLED

            threads = []
            (1..thread_size).each do |index|
              diff = interval
              diff -= 1 unless index == 1
              diff += mod if index == thread_size

              last_date = current_date.clone + diff

              thread = Thread.start(index, current_date, last_date) do |num, start, last|
                output(index: num, start_date: start, last_date: last)
              end
              threads.push(thread)
              current_date = last_date.clone + 1
            end

            f.puts('begin')
            threads.each(&:join)
            f.puts('end')
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
