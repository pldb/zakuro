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
      class Connector
        # @return [Array<Counter>] 未解決元号
        attr_reader :unsolved_gengou

        # TODO: refactor

        #
        # 初期化
        #
        def initialize
          @unsolved_gengou = []
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

        def replace(gengou:)
          matched_index = -1
          @unsolved_gengou.each_with_index do |unsolved, index|
            next unless unsolved.name == gengou.name

            matched_index = index
            break
          end

          if matched_index == -1
            @unsolved_gengou.push(gengou)
            return gengou
          end

          matched = @unsolved_gengou[matched_index]

          japan_year = matched.japan_year > gengou.japan_year ? matched.japan_year : gengou.japan_year
          result = Counter.new(
            gengou: gengou.gengou, start_date: gengou.start_date,
            last_date: gengou.last_date, japan_year: japan_year
          )

          @unsolved_gengou[matched_index] = result

          # 分離した元号の末尾まで到達した
          @unsolved_gengou.delete_at(matched_index) unless result.change_last_date?

          result
        end
      end
    end
  end
end
