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
          # @return [String] 不正元号名
          INVALID_NAME = Japan::Calendar::EMPTY

          #
          # 初期化
          #
          # @param [True, False] first true:1行目元号, false:2行目元号
          # @param [String] start_name 開始元号名
          # @param [String] last_name 終了元号名
          #
          def initialize(first: true, start_name: INVALID_NAME, last_name: INVALID_NAME)
            @index = parse_index(first: first)
            @start_date = Western::Calendar.new
            @last_date = Western::Calendar.new

            position(start_name: start_name, last_name: last_name)
            super(index: @index, start_date: @start_date, last_date: @last_date)
          end

          private

          #
          # 開始日・終了日を配置する
          #
          # @param [String] start_name 開始元号名
          # @param [String] last_name 終了元号名
          #
          def position(start_name:, last_name:)
            start = start_name
            last = last_name
            last = start if last == INVALID_NAME

            return if start == INVALID_NAME

            [start, last].each do |name|
              gengou_list = line_by_name(name: name)

              next if gengou_list.size.zero?

              choise_start_date(
                date: gengou_list[0].start_date.clone
              )
              choise_last_date(
                date: gengou_list[-1].last_date.clone
              )
            end
          end

          #
          # 最古の開始日を選択する
          #
          # @param [Western::Calendar] date 西暦日
          #
          def choise_start_date(date:)
            return if date.invalid?

            if @start_date.invalid?
              @start_date = date
              return
            end

            return if date > @start_date

            @start_date = date
          end

          #
          # 最新の終了日を選択する
          #
          # @param [Western::Calendar] date 西暦日
          #
          def choise_last_date(date:)
            return if date.invalid?

            if @last_date.invalid?
              @last_date = date
              return
            end

            return if date < @last_date

            @last_date = date
          end

          #
          # 元号を取得する（元号名）
          #
          # @param [String] name 元号名
          #
          # @return [Array<Japan::Alignment::LinearGengou>] 元号
          #
          def line_by_name(name:)
            Japan::Gengou.line_by_name(line: @index, name: name)
          end
        end
      end
    end
  end
end
