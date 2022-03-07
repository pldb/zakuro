# frozen_string_literal: true

require_relative './abstract_list'

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
        class NamedList < AbstractList
          # TODO: 継承

          #
          # 初期化
          #
          # @param [True, False] first true:1行目元号, false:2行目元号
          # @param [String] name 元号名
          #
          def initialize(first: true, name: INVALID_NAME)
            # TODO: name は開始日の元号・終了日の元号の二つを引数にする
            update(name: name)
            super(first: first, start_date: @start_date, last_date: @last_date)
          end

          def update(name:)
            # TODO: make
            @start_date = Western::Calendar.new
            @last_date = Western::Calendar.new
            @list |= line(name: name)

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
          def line(name:)
            Japan::Gengou.line_by_name(line: @index, name: name)
          end
        end
      end
    end
  end
end
