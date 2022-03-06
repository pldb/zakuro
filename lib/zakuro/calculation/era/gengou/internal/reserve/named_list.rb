# frozen_string_literal: true

require_relative '../../../../../era/japan/gengou/resource'
require_relative '../../../../../era/japan/gengou'
require_relative '../../../../../era/japan/calendar'
require_relative '../../../../../era/western/calendar'

require_relative '../counter'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # :nodoc:
      module Reserve
        # NamedList
        #
        # 予約元号一覧（元号名）
        #
        class NamedList
          # TODO: 継承

          #
          # 初期化
          #
          # @param [True, False] first true:1行目元号, false:2行目元号
          # @param [String] name 元号名
          #
          def initialize(first: true, name: INVALID_NAME)
            @index = first ? Japan::Gengou::FIRST_LINE : Japan::Gengou::SECOND_LINE

            @list = []

            @start_date = Western::Calendar.new
            @last_date = Western::Calendar.new
            @list |= line_by_name(name: name)

            return if @list.size.zero?

            @start_date = @list[0].start_date.clone
            @last_date = @list[-1].last_date.clone
          end

          #
          # 元号を取得する（元号名）
          #
          # @param [String] name 元号名
          #
          # @return [Array<Japan::Alignment::LinearGengou>] 元号
          #
          def line_(name:)
            Japan::Gengou.line_by_name(line: @index, name: name)
          end
        end
      end
    end
  end
end
