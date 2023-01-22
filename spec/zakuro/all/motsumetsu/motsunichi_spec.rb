# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative './testdata/current_date'

require_relative './testdata/parser'

# TODO: 現状の没日の計算誤りを列記する
METSUNICHI_RAILED_PATTERNS = %w[
  延暦2年3月19日
  延暦2年8月10日
  延暦2年10月21日
  延暦4年11月19日
  延暦5年6月22日
  延暦6年4月4日
  延暦9年8月18日
  延暦11年3月14日
  延暦11年10月16日
  延暦11年閏11月26日
  延暦17年2月17日
  延暦18年1月11日
  延暦21年11月15日
  大同2年10月27日
  弘仁1年11月18日
  弘仁14年10月30日
  貞観4年9月25日
  貞観10年12月21日
  貞観12年7月18日
  天禄2年5月4日
  天喜5年3月11日
  治暦4年11月5日
  建保2年4月11日
  寛元1年11月4日
  文永4年7月15日
  弘安5年9月6日
  正応6年5月7日
  康永3年1月6日
  貞治6年4月5日
  至徳1年5月4日
  至徳4年3月8日
  明徳2年5月12日
  応永3年12月18日
  応永30年1月13日
  永享2年7月26日
  嘉吉1年5月7日
  長禄4年6月21日
  慶長8年9月5日
  元和3年3月19日
  元和6年5月21日
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

              p '-------------'
              # TODO: refactor
              p "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"

              date_text = Zakuro::All::Motsumetsu::CurrentDate.get(
                date: date, current_gengou: gengou, before_gengou: before_gengou
              )

              p date_text

              actual = Zakuro::Merchant.new(
                condition: {
                  date: date_text,
                  options: { 'dropped_date' => date.dropped, 'vanished_date' => date.vanished }
                }
              ).commit
              # TODO: expect
              options = actual.data.options
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
