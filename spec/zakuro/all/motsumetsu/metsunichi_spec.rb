# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative './testdata/current_date'

require_relative './testdata/parser'

require_relative './single_date_printer'

# @return [True] 滅日チェックを実施する
# @return [False] 滅日チェックを実施しない
#
# 非常に重い試験のため通常は実施しない
METSUNICHI_ENABLED = false

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Motsumetsu' do
      context 'all metsunichi' do
        it 'should be equal to a reference' do
          years = Zakuro::All::Motsumetsu::Parser.get
          before_gengou = Zakuro::All::Motsumetsu::Gengou.new

          File.open('./metsunichi.log', 'w') do |f|
            break unless METSUNICHI_ENABLED

            years.each do |year|
              gengou = year.gengou
              year.dates.each do |date|
                next unless date.vanished

                date_text = Zakuro::All::Motsumetsu::CurrentDate.get(
                  date: date, current_gengou: gengou, before_gengou: before_gengou
                )

                actual = Zakuro::Merchant.new(
                  condition: {
                    date: date_text,
                    options: { 'dropped_date' => date.dropped, 'vanished_date' => date.vanished }
                  }
                ).commit

                actual_printer = SingleDatePrinter.new(date: actual)

                # TODO: 対象日が没日でなかった場合はテスト失敗にする

                # next if vanished_date.matched

                f.puts('-------------')
                f.puts(
                  "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"
                )
                f.puts(date_text)
                f.puts(actual_printer.western_date)

                f.puts("【結果】: #{actual_printer.vanished_date_result}")
                f.puts("経朔： #{actual_printer.vanished_date_average_remainder}")
              end
              before_gengou = gengou
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
