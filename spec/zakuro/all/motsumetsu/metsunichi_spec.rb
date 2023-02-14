# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative './testdata/current_date'

require_relative './testdata/parser'

# TODO: エラーの和暦日一覧
METSUNICHI_FAILED_PATTERNS = %w[
  天平神護3年3月1日
  宝亀6年2月1日
  延暦13年5月19日
  天長9年10月25日
  承和2年12月1日
  承和10年11月1日
  仁寿1年10月1日
  貞観1年9月1日
  貞観9年8月1日
  貞観17年7月1日
  元慶7年6月1日
  寛平3年5月1日
  天延3年12月1日
  永観1年11月1日
  正暦2年10月1日
  長保1年9月1日
  寛弘4年8月1日
  長和4年7月1日
  康平3年7月1日
  治暦4年6月1日
  長寛2年11月1日
  仁安3年11月1日
  安元2年10月1日
  元久1年7月1日
  建暦2年6月1日
  延慶1年11月1日
  正和1年11月1日
  正和5年閏10月1日
  元応2年10月1日
  貞治4年閏9月1日
  応安6年9月1日
  永徳1年8月1日
  至徳2年9月1日
  康応1年7月1日
  応永4年6月1日
  応永12年5月1日
  応永20年4月1日
  延徳1年12月1日
  明応6年11月1日
  永正2年10月1日
  永正10年9月1日
  天文11年10月1日
  天文19年9月1日
  永禄1年8月1日
  永禄9年8月1日
  天正2年7月1日
  天正10年6月1日
  天正18年5月1日
  寛文7年1月1日
  延宝2年12月1日
  天和2年11月1日
].freeze

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

              next if vanished_date.matched

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
