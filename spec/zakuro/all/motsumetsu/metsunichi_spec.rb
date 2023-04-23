# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative './testdata/current_date'

require_relative './testdata/parser'

# NOTE: 現状は全て通っている
#
# 非常に重い試験のため通常は実施しない
#
# @return [Array<String>] 没日誤りのある和暦日文字列
METSUNICHI_FAILED_PATTERNS = %w[].freeze

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Motsumetsu' do
      context 'all metsunichi' do
        it 'should be equal to a reference' do
          years = Zakuro::All::Motsumetsu::Parser.get
          before_gengou = Zakuro::All::Motsumetsu::Gengou.new
          years.each do |year|
            gengou = year.gengou
            year.dates.each do |date|
              next unless date.vanished

              date_text = Zakuro::All::Motsumetsu::CurrentDate.get(
                date: date, current_gengou: gengou, before_gengou: before_gengou
              )

              next unless METSUNICHI_FAILED_PATTERNS.include?(date_text)

              actual = Zakuro::Merchant.new(
                condition: {
                  date: date_text,
                  options: { 'dropped_date' => date.dropped, 'vanished_date' => date.vanished }
                }
              ).commit

              options = actual.data.options

              vanished_date = options['vanished_date']

              # next if vanished_date.matched

              # TODO: refactor
              p '-------------'
              p "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"
              p date_text
              p actual.data.day.western_date.format

              p "【結果】: #{vanished_date.matched} / #{vanished_date.calculation.remainder}"
              p "経朔： #{vanished_date.calculation.average_remainder}"
            end
            before_gengou = gengou
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
