# frozen_string_literal: true

require_relative './gengou_start_date'
require_relative './japan_date'
require_relative './gengou'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Motsumetsu
      #
      # CurrentDate 現在日
      #
      module CurrentDate
        # @return [Hash<String, JapanDate>] 元号別の開始日
        GENGOU_START_DATES = GengouStartDate.get

        # @return [Hash<String, String>] 元号名（『日本暦日便覧』=>『日本史年表』）
        GENGOU_OTHER_NAMES = {
          '斉衡' => '斎衡',
          '永礑' => '永祚'
        }.freeze

        # @return [Hash<String, Hash<String, Object>>] 元号範囲
        # 日本暦日便覧：
        #   元徳1(1329)    元徳2(1330)    元徳3(1331)    正慶1(1332)    正慶2(1333)
        # 日本暦日原典：
        #   元徳1(1329)    元徳2(1330)    元弘1(1331)    正慶1(1332)    正慶2(1333)
        #
        #  * 元徳|1|1329-1-31|1年8月29日
        #  * 元弘|1331-2-8|1年8月9日
        #  * 正慶|1|1332-1-28|1年4月28日
        #
        #  元徳3年のうち、1331-2-8 ～ 1332-1-27 を元弘に差し替える必要がある
        #   1. 元徳3年8月8日
        #   2. 元弘1年8月9日
        #   3. 元弘2年4月27日
        #   4. 正慶1年4月28日
        #
        GENGOU_RANGE = {
          '元徳3年' => {
            'from' => JapanDate.new(leaped: false, month: 8, day: 9),
            'to' => JapanDate.new,
            'gengou' => Gengou.new(name: '元弘', year: 1, western_year: 1331)
          },
          '元徳4年' => {
            'from' => JapanDate.new,
            'to' => JapanDate.new(leaped: false, month: 4, day: 27),
            'gengou' => Gengou.new(name: '元弘', year: 2, western_year: 1332)
          }
        }.freeze

        #
        # 『日本暦日原典』初版と第四版のずれを補正する
        #
        #  計算結果から『日本暦日便覧』は初版に準拠しているものと考える。
        #  第四版の注釈に合わせて日付ずれを補正する
        #
        #  * 0807-11-29 : 大同2年10月27日（第四版のみ注釈あり）
        #  * 0810-12-17 : 弘仁1年11月18日（第四版のみ注釈あり）
        #  * 0823-12-05 : 弘仁14年10月30日（初版のみ注釈あり）
        #
        DATE_DIFF = {
          '大同2年10月27日' => '大同2年10月26日',
          '弘仁1年11月18日' => '弘仁1年11月17日',
          '弘仁14年10月30日' => '弘仁14年10月29日'
        }.freeze

        class << self
          #
          # 取得する
          #
          # @param [JapanDate] date 現在和暦日
          # @param [Gengou] current_gengou 現在元号
          # @param [Gengou] before_gengou 前回元号
          #
          # @return [String] 和暦日文字列
          #
          def get(date:, current_gengou:, before_gengou:)
            current = rename(gengou: current_gengou)

            before = rename(gengou: before_gengou)

            gengou = gengou(
              date: date, current_gengou: current, before_gengou: before
            )

            gengou = range(date: date, gengou: gengou)

            formatted_date = to_s(gengou: gengou, date: date)

            replace(date: formatted_date)
          end

          private

          #
          # 和暦日文字列を生成する
          #
          # @param [Gengou] gengou 元号
          # @param [JapanDate] date 現在和暦日
          #
          # @return [String] 和暦日文字列
          #
          def to_s(gengou:, date:)
            "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"
          end

          #
          # 元号を取得する
          #
          #  『日本暦日便覧』は元号年なので、『日本史年表』による開始日を考慮する
          #
          # @param [JapanDate] date 現在和暦日
          # @param [Gengou] current_gengou 現在元号
          # @param [Gengou] before_gengou 前回元号
          #
          # @return [Gengou] 元号
          #
          def gengou(date:, current_gengou:, before_gengou:)
            return current_gengou if before_gengou.invalid?

            start_date = nil

            start_date = GENGOU_START_DATES[current_gengou.name] if current_gengou.year == 1

            return current_gengou unless start_date

            return current_gengou if date > start_date

            # 当年の元号1年目が開始していない。前年元号に+1年した年を採用する
            Gengou.new(
              name: before_gengou.name, year: before_gengou.year + 1,
              western_year: before_gengou.western_year + 1
            )
          end

          #
          # 元号名を変更する
          #
          # @param [Gengou] gengou 元号
          #
          # @return [Gengou] 変更後元号
          #
          def rename(gengou:)
            name = GENGOU_OTHER_NAMES[gengou.name]

            return gengou unless name

            Gengou.new(
              name: name, year: gengou.year,
              western_year: gengou.western_year
            )
          end

          #
          # 一定の範囲内で元号を差し替える
          #
          # @param [JapanDate] date 和暦日
          # @param [Gengou] gengou 元号
          #
          # @return [Gengou] 変更後元号
          #
          def range(date:, gengou:)
            range = GENGOU_RANGE[gengou.to_s]

            return gengou unless range

            from = range['from']
            unless from.invalid?
              return range['gengou'] if date > from
            end

            to = range['to']
            unless to.invalid?
              return range['gengou'] if to > date
            end

            gengou
          end

          #
          # 和暦日差し替え
          #
          # @param [String] date 和暦日文字列
          #
          # @return [String] 和暦日文字列
          #
          def replace(date:)
            result = DATE_DIFF[date]

            return result if result

            date
          end
        end
      end
    end
  end
end
