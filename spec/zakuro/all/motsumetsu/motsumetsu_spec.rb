# frozen_string_literal: true

require_relative '../../../../lib/zakuro/merchant'

require_relative './testdata/current_date'

require_relative './testdata/parser'

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
              # TODO: 没日の計算が誤っている
              #  現状はその月が属する二十四節気から「有没之気」を求めているが、
              #  本来はその日がどの二十四節気に属するかを求め、その後にそれが「有没之気」かを判定する
              #  前月または来月に属する二十四節気を適切に拾えていないパターンで誤りがある
              #  （逆に誤って「有没之気」ではない日を没日にしているパターンもありうる）
              p '-------------'
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
              options = actual.data.options
              dropped_date = options['dropped_date']
              vanished_date = options['vanished_date']
              if date.dropped
                p "【結果】没日: #{dropped_date.matched} / #{dropped_date.calculation.remainder}"
                actual.data.month.odd_solar_terms.each do |solar_term|
                  p "二十四節気（節気）: #{solar_term.index} / #{solar_term.remainder}"
                end
                actual.data.month.even_solar_terms.each do |solar_term|
                  p "二十四節気（中気）: #{solar_term.index} / #{solar_term.remainder}"
                end
              end
              next unless date.vanished

              p "【結果】滅日: #{vanished_date.matched} / #{vanished_date.calculation.remainder}"
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
