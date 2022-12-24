# frozen_string_literal: true

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
        GENGOU_START_DATES = {
          '神護景雲' => JapanDate.new(leaped: false, month: 8, day: 16),
          '宝亀' => JapanDate.new(leaped: false, month: 10, day: 1),
          '天応' => JapanDate.new(leaped: false, month: 1, day: 1),
          '延暦' => JapanDate.new(leaped: false, month: 8, day: 19),
          '大同' => JapanDate.new(leaped: false, month: 5, day: 18),
          '弘仁' => JapanDate.new(leaped: false, month: 9, day: 19),
          '天長' => JapanDate.new(leaped: false, month: 1, day: 5),
          '承和' => JapanDate.new(leaped: false, month: 1, day: 3),
          '嘉祥' => JapanDate.new(leaped: false, month: 6, day: 13),
          '仁寿' => JapanDate.new(leaped: false, month: 4, day: 28),
          '斎衡' => JapanDate.new(leaped: false, month: 11, day: 30),
          '天安' => JapanDate.new(leaped: false, month: 2, day: 21),
          '貞観' => JapanDate.new(leaped: false, month: 4, day: 15),
          '元慶' => JapanDate.new(leaped: false, month: 4, day: 16),
          '仁和' => JapanDate.new(leaped: false, month: 2, day: 21),
          '寛平' => JapanDate.new(leaped: false, month: 4, day: 27),
          '昌泰' => JapanDate.new(leaped: false, month: 4, day: 26),
          '延喜' => JapanDate.new(leaped: false, month: 7, day: 15),
          '延長' => JapanDate.new(leaped: true, month: 4, day: 11),
          '承平' => JapanDate.new(leaped: false, month: 4, day: 26),
          '天慶' => JapanDate.new(leaped: false, month: 5, day: 22),
          '天暦' => JapanDate.new(leaped: false, month: 4, day: 22),
          '天徳' => JapanDate.new(leaped: false, month: 10, day: 27),
          '応和' => JapanDate.new(leaped: false, month: 2, day: 16),
          '康保' => JapanDate.new(leaped: false, month: 7, day: 10),
          '安和' => JapanDate.new(leaped: false, month: 8, day: 13),
          '天禄' => JapanDate.new(leaped: false, month: 3, day: 25),
          '天延' => JapanDate.new(leaped: false, month: 12, day: 20),
          '貞元' => JapanDate.new(leaped: false, month: 7, day: 13),
          '天元' => JapanDate.new(leaped: false, month: 11, day: 29),
          '永観' => JapanDate.new(leaped: false, month: 4, day: 15),
          '寛和' => JapanDate.new(leaped: false, month: 4, day: 27),
          '永延' => JapanDate.new(leaped: false, month: 4, day: 5),
          '永祚' => JapanDate.new(leaped: false, month: 8, day: 8),
          '正暦' => JapanDate.new(leaped: false, month: 11, day: 7),
          '長徳' => JapanDate.new(leaped: false, month: 2, day: 22),
          '長保' => JapanDate.new(leaped: false, month: 1, day: 13),
          '寛弘' => JapanDate.new(leaped: false, month: 7, day: 20),
          '長和' => JapanDate.new(leaped: false, month: 12, day: 25),
          '寛仁' => JapanDate.new(leaped: false, month: 4, day: 23),
          '治安' => JapanDate.new(leaped: false, month: 2, day: 2),
          '万寿' => JapanDate.new(leaped: false, month: 7, day: 13),
          '長元' => JapanDate.new(leaped: false, month: 7, day: 25),
          '長暦' => JapanDate.new(leaped: false, month: 4, day: 21),
          '長久' => JapanDate.new(leaped: false, month: 11, day: 10),
          '寛徳' => JapanDate.new(leaped: false, month: 11, day: 24),
          '永承' => JapanDate.new(leaped: false, month: 4, day: 14),
          '天喜' => JapanDate.new(leaped: false, month: 1, day: 11),
          '康平' => JapanDate.new(leaped: false, month: 8, day: 29),
          '治暦' => JapanDate.new(leaped: false, month: 8, day: 2),
          '延久' => JapanDate.new(leaped: false, month: 4, day: 13),
          '承保' => JapanDate.new(leaped: false, month: 8, day: 23),
          '承暦' => JapanDate.new(leaped: false, month: 11, day: 17),
          '永保' => JapanDate.new(leaped: false, month: 2, day: 10),
          '応徳' => JapanDate.new(leaped: false, month: 2, day: 7),
          '寛治' => JapanDate.new(leaped: false, month: 4, day: 7),
          '嘉保' => JapanDate.new(leaped: false, month: 12, day: 15),
          '永長' => JapanDate.new(leaped: false, month: 12, day: 17),
          '承徳' => JapanDate.new(leaped: false, month: 11, day: 21),
          '康和' => JapanDate.new(leaped: false, month: 8, day: 28),
          '長治' => JapanDate.new(leaped: false, month: 2, day: 10),
          '嘉承' => JapanDate.new(leaped: false, month: 4, day: 9),
          '天仁' => JapanDate.new(leaped: false, month: 8, day: 3),
          '天永' => JapanDate.new(leaped: false, month: 7, day: 13),
          '永久' => JapanDate.new(leaped: false, month: 7, day: 13),
          '元永' => JapanDate.new(leaped: false, month: 4, day: 3),
          '保安' => JapanDate.new(leaped: false, month: 4, day: 10),
          '天治' => JapanDate.new(leaped: false, month: 4, day: 3),
          '大治' => JapanDate.new(leaped: false, month: 1, day: 22),
          '天承' => JapanDate.new(leaped: false, month: 1, day: 29),
          '長承' => JapanDate.new(leaped: false, month: 8, day: 11),
          '保延' => JapanDate.new(leaped: false, month: 4, day: 27),
          '永治' => JapanDate.new(leaped: false, month: 7, day: 10),
          '康治' => JapanDate.new(leaped: false, month: 4, day: 28),
          '天養' => JapanDate.new(leaped: false, month: 2, day: 23),
          '久安' => JapanDate.new(leaped: false, month: 7, day: 22),
          '仁平' => JapanDate.new(leaped: false, month: 1, day: 26),
          '久寿' => JapanDate.new(leaped: false, month: 10, day: 28),
          '保元' => JapanDate.new(leaped: false, month: 4, day: 27),
          '平治' => JapanDate.new(leaped: false, month: 4, day: 20),
          '永暦' => JapanDate.new(leaped: false, month: 1, day: 10),
          '応保' => JapanDate.new(leaped: false, month: 9, day: 4),
          '長寛' => JapanDate.new(leaped: false, month: 3, day: 29),
          '永万' => JapanDate.new(leaped: false, month: 6, day: 5),
          '仁安' => JapanDate.new(leaped: false, month: 8, day: 27),
          '嘉応' => JapanDate.new(leaped: false, month: 4, day: 8),
          '承安' => JapanDate.new(leaped: false, month: 4, day: 21),
          '安元' => JapanDate.new(leaped: false, month: 7, day: 28),
          '治承' => JapanDate.new(leaped: false, month: 8, day: 4),
          '養和' => JapanDate.new(leaped: false, month: 7, day: 14),
          '寿永' => JapanDate.new(leaped: false, month: 5, day: 27),
          '元暦' => JapanDate.new(leaped: false, month: 4, day: 16),
          '文治' => JapanDate.new(leaped: false, month: 8, day: 14),
          '建久' => JapanDate.new(leaped: false, month: 4, day: 11),
          '正治' => JapanDate.new(leaped: false, month: 4, day: 27),
          '建仁' => JapanDate.new(leaped: false, month: 2, day: 13),
          '元久' => JapanDate.new(leaped: false, month: 2, day: 20),
          '建永' => JapanDate.new(leaped: false, month: 4, day: 27),
          '承元' => JapanDate.new(leaped: false, month: 10, day: 25),
          '建暦' => JapanDate.new(leaped: false, month: 3, day: 9),
          '建保' => JapanDate.new(leaped: false, month: 12, day: 6),
          '承久' => JapanDate.new(leaped: false, month: 4, day: 12),
          '貞応' => JapanDate.new(leaped: false, month: 4, day: 13),
          '元仁' => JapanDate.new(leaped: false, month: 11, day: 20),
          '嘉禄' => JapanDate.new(leaped: false, month: 4, day: 20),
          '安貞' => JapanDate.new(leaped: false, month: 12, day: 10),
          '寛喜' => JapanDate.new(leaped: false, month: 3, day: 5),
          '貞永' => JapanDate.new(leaped: false, month: 4, day: 2),
          '天福' => JapanDate.new(leaped: false, month: 4, day: 15),
          '文暦' => JapanDate.new(leaped: false, month: 11, day: 5),
          '嘉禎' => JapanDate.new(leaped: false, month: 9, day: 19),
          '暦仁' => JapanDate.new(leaped: false, month: 11, day: 23),
          '延応' => JapanDate.new(leaped: false, month: 2, day: 7),
          '仁治' => JapanDate.new(leaped: false, month: 7, day: 16),
          '寛元' => JapanDate.new(leaped: false, month: 2, day: 26),
          '宝治' => JapanDate.new(leaped: false, month: 2, day: 28),
          '建長' => JapanDate.new(leaped: false, month: 3, day: 18),
          '康元' => JapanDate.new(leaped: false, month: 10, day: 5),
          '正嘉' => JapanDate.new(leaped: false, month: 3, day: 14),
          '正元' => JapanDate.new(leaped: false, month: 3, day: 26),
          '文応' => JapanDate.new(leaped: false, month: 4, day: 13),
          '弘長' => JapanDate.new(leaped: false, month: 2, day: 20),
          '文永' => JapanDate.new(leaped: false, month: 2, day: 28),
          '建治' => JapanDate.new(leaped: false, month: 4, day: 25),
          '弘安' => JapanDate.new(leaped: false, month: 2, day: 29),
          '正応' => JapanDate.new(leaped: false, month: 4, day: 28),
          '永仁' => JapanDate.new(leaped: false, month: 8, day: 5),
          '正安' => JapanDate.new(leaped: false, month: 4, day: 25),
          '乾元' => JapanDate.new(leaped: false, month: 11, day: 21),
          '嘉元' => JapanDate.new(leaped: false, month: 8, day: 5),
          '徳治' => JapanDate.new(leaped: false, month: 12, day: 14),
          '延慶' => JapanDate.new(leaped: false, month: 10, day: 9),
          '応長' => JapanDate.new(leaped: false, month: 4, day: 28),
          '正和' => JapanDate.new(leaped: false, month: 3, day: 20),
          '文保' => JapanDate.new(leaped: false, month: 2, day: 3),
          '元応' => JapanDate.new(leaped: false, month: 4, day: 28),
          '元亨' => JapanDate.new(leaped: false, month: 2, day: 23),
          '正中' => JapanDate.new(leaped: false, month: 12, day: 9),
          '嘉暦' => JapanDate.new(leaped: false, month: 4, day: 26),
          '元徳' => JapanDate.new(leaped: false, month: 8, day: 29),
          # TODO: error
          # --- Caused by: ---
          # ArgumentError:
          #   invalid year range. date: 正慶01年05月11日
          #   /home/pldb/ruby/zakuro/lib/zakuro/calculation/summary/japan/specifier/single_day.rb:72:in `specify'
          #
          '正慶' => JapanDate.new(leaped: false, month: 4, day: 28),
          '建武' => JapanDate.new(leaped: false, month: 1, day: 29),
          '暦応' => JapanDate.new(leaped: false, month: 8, day: 28),
          '康永' => JapanDate.new(leaped: false, month: 4, day: 27),
          '貞和' => JapanDate.new(leaped: false, month: 10, day: 21),
          '観応' => JapanDate.new(leaped: false, month: 2, day: 27),
          '文和' => JapanDate.new(leaped: false, month: 9, day: 27),
          '延文' => JapanDate.new(leaped: false, month: 3, day: 28),
          '康安' => JapanDate.new(leaped: false, month: 3, day: 29),
          '貞治' => JapanDate.new(leaped: false, month: 9, day: 23),
          '応安' => JapanDate.new(leaped: false, month: 2, day: 18),
          '永和' => JapanDate.new(leaped: false, month: 2, day: 27),
          '康暦' => JapanDate.new(leaped: false, month: 3, day: 22),
          '永徳' => JapanDate.new(leaped: false, month: 2, day: 24),
          '至徳' => JapanDate.new(leaped: false, month: 2, day: 27),
          '嘉慶' => JapanDate.new(leaped: false, month: 8, day: 23),
          '康応' => JapanDate.new(leaped: false, month: 2, day: 9),
          '明徳' => JapanDate.new(leaped: false, month: 3, day: 26),
          '応永' => JapanDate.new(leaped: false, month: 7, day: 5),
          '正長' => JapanDate.new(leaped: false, month: 4, day: 27),
          '永享' => JapanDate.new(leaped: false, month: 9, day: 5),
          '嘉吉' => JapanDate.new(leaped: false, month: 2, day: 17),
          '文安' => JapanDate.new(leaped: false, month: 2, day: 5),
          '宝徳' => JapanDate.new(leaped: false, month: 7, day: 28),
          '享徳' => JapanDate.new(leaped: false, month: 7, day: 25),
          '康正' => JapanDate.new(leaped: false, month: 7, day: 25),
          '長禄' => JapanDate.new(leaped: false, month: 9, day: 28),
          '寛正' => JapanDate.new(leaped: false, month: 12, day: 21),
          '文正' => JapanDate.new(leaped: false, month: 2, day: 28),
          '応仁' => JapanDate.new(leaped: false, month: 3, day: 5),
          '文明' => JapanDate.new(leaped: false, month: 4, day: 28),
          '長享' => JapanDate.new(leaped: false, month: 7, day: 20),
          '延徳' => JapanDate.new(leaped: false, month: 8, day: 21),
          '明応' => JapanDate.new(leaped: false, month: 7, day: 19),
          '文亀' => JapanDate.new(leaped: false, month: 2, day: 29),
          '永正' => JapanDate.new(leaped: false, month: 2, day: 30),
          '大永' => JapanDate.new(leaped: false, month: 8, day: 23),
          '享禄' => JapanDate.new(leaped: false, month: 8, day: 20),
          '天文' => JapanDate.new(leaped: false, month: 7, day: 29),
          '弘治' => JapanDate.new(leaped: false, month: 10, day: 23),
          '永禄' => JapanDate.new(leaped: false, month: 2, day: 28),
          '元亀' => JapanDate.new(leaped: false, month: 4, day: 23),
          '天正' => JapanDate.new(leaped: false, month: 7, day: 28),
          '文禄' => JapanDate.new(leaped: false, month: 12, day: 8),
          '慶長' => JapanDate.new(leaped: false, month: 10, day: 27),
          '元和' => JapanDate.new(leaped: false, month: 7, day: 13),
          '寛永' => JapanDate.new(leaped: false, month: 2, day: 30),
          '正保' => JapanDate.new(leaped: false, month: 12, day: 16),
          '慶安' => JapanDate.new(leaped: false, month: 2, day: 15),
          '承応' => JapanDate.new(leaped: false, month: 9, day: 18),
          '明暦' => JapanDate.new(leaped: false, month: 4, day: 13),
          '万治' => JapanDate.new(leaped: false, month: 7, day: 23),
          '寛文' => JapanDate.new(leaped: false, month: 4, day: 25),
          '延宝' => JapanDate.new(leaped: false, month: 9, day: 21),
          '天和' => JapanDate.new(leaped: false, month: 9, day: 29),
          '貞享' => JapanDate.new(leaped: false, month: 2, day: 21)
        }.freeze

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

            "#{gengou.name}#{gengou.year}年#{date.leaped ? '閏' : ''}#{date.month}月#{date.day}日"
          end

          private

          #
          # 元号を取得する
          #
          #  『日本暦日便覧』は元号年なの、開始日を考慮する
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
        end
      end
    end
  end
end
