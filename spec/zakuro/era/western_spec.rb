# frozen_string_literal: true

require 'date'
require File.expand_path('../../../../zakuro/lib/zakuro/era/western',
                         __dir__)

describe 'Zakuro' do
  describe 'Western' do
    describe 'Calendar' do
      describe '#format' do
        context 'julian date' do
          it 'is formatted string as julian date' do
            expect(
              Zakuro::Western::Calendar.new(year: 1582, month: 10, day: 4).format
            ).to eq '1582-10-04'
          end
        end

        context 'gregorian date' do
          # 1582-10-05 ~ 1582-10-14 の扱いを考える必要がある
          # Ruby では以下のような呼び出しでArgumentErrorが発生する
          # Date.new(1582, 10, 14)
          # Date.new(1582, 10, 14, Date::ITALY)
          #
          # ユリウス暦からグリゴレオ暦を連続した暦と捉える場合、上記のように
          # エラーを発生させるのは問題ない。
          # なぜなら1582-10-04（ユリウス暦）の翌日は1582-10-15（グレゴリオ暦）になるため。
          it 'is formatted string as gregorian date' do
            expect(
              Zakuro::Western::Calendar.new(year: 1582, month: 10, day: 15).format
            ).to eq '1582-10-15'
          end
        end
      end
    end
  end
end
