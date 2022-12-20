# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative './abstract/current_date'

require_relative './abstract/parser'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'All' do
    describe 'Motsumetsu' do
      context 'all motsunichi and metsunichi' do
        it 'should be equal to a reference' do
          years = Zakuro::All::Motsumetsu::Parser.get
          before_gengou = Zakuro::All::Motsumetsu::Gengou.new
          years.each do |year|
            gengou = year.gengou
            year.dates.each do |date|
              # TODO: refactor
              p "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"
              p "没日: #{date.dropped}"
              p "滅日: #{date.vanished}"

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
              p "【結果】没日: #{actual.data.options['dropped_date'].matched}" if date.dropped
              p "【結果】滅日: #{actual.data.options['vanished_date'].matched}" if date.vanished
            end
            before_gengou = gengou
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
