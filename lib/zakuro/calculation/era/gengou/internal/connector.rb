# frozen_string_literal: true

require_relative '../../../../era/japan/gengou/resource'
require_relative '../../../../era/japan/calendar'
require_relative '../../../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      #
      # Connector 元号接続器
      #
      # 現在は"明徳"のみを解決している
      #   元中1年4月28日                  元中9年閏10月4日        明徳5年7月4日
      #   1384-05-18                     1392-11-18              1394-8-1
      #  [1] |-------------元中---------------|---------明徳------------|
      #  [2]            |---------明徳--------|
      #             明徳1年3月26日
      #             1390-04-12
      #
      #  * 明徳は2行目元号から始まる
      #  * 1392-11-19より1行目元号に移行する
      #  * 移行のタイミングで元号年を引き継げるようにする
      #
      class Connector
        # @return [Array<Counter>] 未解決元号
        attr_reader :unsolved_list

        #
        # 初期化
        #
        def initialize
          @unsolved_list = []
        end

        #
        # 元号を更新する
        #
        # @param [Array<Array<Counter>>] lines 全行元号
        #
        def update(lines: [])
          lines.each do |line|
            line.each_with_index do |gengou, index|
              next unless gengou.changed?

              line[index] = replace(gengou: gengou)
            end
          end
        end

        #
        # 元号を年を更新した元号に入れ替える
        #
        # @param [Counter] gengou 元号
        #
        # @return [Counter] 元号/更新済元号
        #
        def replace(gengou:)
          matched_index = -1
          @unsolved_list.each_with_index do |unsolved, index|
            next unless unsolved.name == gengou.name

            matched_index = index
            break
          end

          if matched_index == -1
            @unsolved_list.push(gengou)
            return gengou
          end

          matched = @unsolved_list[matched_index]

          result = recreate(gengou: gengou, unsolved: matched)

          @unsolved_list[matched_index] = result

          # 分離した元号の末尾まで到達した
          @unsolved_list.delete_at(matched_index) unless result.change_last_date?

          result
        end

        #
        # 年を更新した元号を生成する
        #
        # @param [Counter] gengou 元号
        # @param [Counter] unsolved 未解決元号
        #
        # @return [Counter] 更新済元号
        #
        def recreate(gengou:, unsolved:)
          japan_year = gengou.japan_year
          japan_year = unsolved.japan_year if unsolved.japan_year > gengou.japan_year

          Counter.new(
            gengou: gengou.gengou, start_date: gengou.start_date,
            last_date: gengou.last_date, japan_year: japan_year
          )
        end
      end
    end
  end
end
