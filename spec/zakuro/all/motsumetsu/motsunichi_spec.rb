# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative '../../../testtool/setting'

require_relative './testdata/current_date'

require_relative './testdata/parser'

require_relative './single_date_printer'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Motsumetsu' do
      context 'all motsunichi' do
        it 'should be equal to a reference' do
          years = Zakuro::All::Motsumetsu::Parser.get
          before_gengou = Zakuro::All::Motsumetsu::Gengou.new

          log_file_path = './motsunichi.log'
          failed = false

          File.open(log_file_path, 'w') do |f|
            break unless Zakuro::TestTool::Setting::MOTSUNICHI_ENABLED

            years.each do |year|
              gengou = year.gengou
              year.dates.each do |date|
                next unless date.dropped

                date_text = Zakuro::All::Motsumetsu::CurrentDate.get(
                  date: date, current_gengou: gengou, before_gengou: before_gengou
                )

                actual = Zakuro::Merchant.new(
                  condition: {
                    date: date_text,
                    options: { 'dropped_date' => date.dropped, 'vanished_date' => date.vanished }
                  }
                ).commit

                actual_printer = Zakuro::All::Motsumetsu::SingleDatePrinter.new(date: actual)

                failed = true unless actual_printer.dropped_date?

                f.puts('-------------')
                f.puts(
                  "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"
                )
                f.puts(date_text)
                f.puts(actual_printer.western_date)

                f.puts("【結果】没日: #{actual_printer.dropped_date_result}")
              end
              before_gengou = gengou
            end
          end

          expect(failed).to be_falsey, "invalid valished date. please read [#{log_file_path}]"
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
