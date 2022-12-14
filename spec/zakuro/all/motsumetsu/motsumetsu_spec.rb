# frozen_string_literal: true

require_relative './abstract/parser'

describe 'Zakuro' do
  describe 'All' do
    describe 'Motsumetsu' do
      context 'all motsunichi and metsunichi' do
        it 'should be equal to a reference' do
          years = Zakuro::All::Motsumetsu::Parser.get
          years.each do |year|
            gengou = year.gengou
            year.dates.each do |date|
              # TODO: use
              p "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"
              p "没日: #{date.dropped}"
              p "滅日: #{date.vanished}"
            end
          end
        end
      end
    end
  end
end
