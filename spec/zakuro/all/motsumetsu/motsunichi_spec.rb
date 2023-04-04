# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative './testdata/current_date'

require_relative './testdata/parser'

# TODO: 没日有無判定を変更した後に通らなくなった和暦日
MOTSUNICHI_FAILED_PATTERNS = %w[
  弘仁8年9月15日
  永承5年11月16日
].freeze

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Motsumetsu' do
      context 'all motsunichi' do
        it 'should be equal to a reference' do
          years = Zakuro::All::Motsumetsu::Parser.get
          before_gengou = Zakuro::All::Motsumetsu::Gengou.new
          years.each do |year|
            gengou = year.gengou
            year.dates.each do |date|
              next unless date.dropped

              date_text = Zakuro::All::Motsumetsu::CurrentDate.get(
                date: date, current_gengou: gengou, before_gengou: before_gengou
              )

              # TODO: refactor

              next unless MOTSUNICHI_FAILED_PATTERNS.include?(date_text)

              p '-------------'

              actual = Zakuro::Merchant.new(
                condition: {
                  date: date_text,
                  options: { 'dropped_date' => date.dropped, 'vanished_date' => date.vanished }
                }
              ).commit
              # TODO: expect
              options = actual.data.options
              p "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"
              p date_text
              p actual.data.day.western_date.format
              dropped_date = options['dropped_date']

              p "【結果】没日: #{dropped_date.matched} / #{dropped_date.calculation.remainder}"
              actual.data.month.odd_solar_terms.each do |solar_term|
                p "二十四節気（節気）: #{solar_term.index} / #{solar_term.remainder}"
              end
              actual.data.month.even_solar_terms.each do |solar_term|
                p "二十四節気（中気）: #{solar_term.index} / #{solar_term.remainder}"
              end
            end
            before_gengou = gengou
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
