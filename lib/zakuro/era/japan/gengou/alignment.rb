# frozen_string_literal: true

require_relative './alignment/aligner'

require_relative './resource'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Gengou
      #
      # Alignment 整列
      #
      module Alignment
        # @return [Integer] 1行目元号
        FIRST_LINE = Aligner::FIRST_LINE

        # @return [Integer] 2行目元号
        SECOND_LINE = Aligner::SECOND_LINE

        # @return [Aligner] 整列結果
        SUMMARY = Aligner.new(resources: Resource::LIST)

        # @return [Aligner] 整列結果（運用値）
        OPERATED_SUMMARY = Aligner.new(resources: Resource::OPERATED_LIST)

        class << self
          #
          # 指定した範囲内の元号を取得する
          #
          # @param [Integer] line 行
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] last_date 終了日
          # @param [True, False] operated 運用値設定
          # @param [True, False] restored 運用値から計算値に戻すか
          #
          # @return [Array<LinearGengou>] 元号
          #
          def get(line: FIRST_LINE,
                  start_date: Western::Calendar.new, last_date: Western::Calendar.new,
                  operated: false, restored: false)
            if operated
              result = OPERATED_SUMMARY.get(
                line: line, start_date: start_date, last_date: last_date
              )
              return result unless restored

              return restore(line: line, list: result)
            end

            SUMMARY.get(line: line, start_date: start_date, last_date: last_date)
          end

          #
          # 指定した範囲内の元号を取得する（元号名）
          #
          # @param [String] name 元号名
          # @param [Integer] line 行
          # @param [True, False] operated 運用値設定
          # @param [True, False] restored 運用値から計算値に戻すか
          #
          # @return [Array<LinearGengou>] 元号
          #
          def get_by_name(name:, line: FIRST_LINE, operated: false, restored: false)
            if operated
              result = OPERATED_SUMMARY.get_by_name(line: line, name: name)
              return result unless restored

              return restore(line: line, list: result)
            end

            SUMMARY.get_by_name(line: line, name: name)
          end

          #
          # 運用値から計算値に戻す
          #
          # @param [Integer] line 行
          # @param [Array<LinearGengou>] list 元号
          #
          # @return [Array<LinearGengou>] 元号
          #
          def restore(line: FIRST_LINE, list: [])
            result = []
            list.each do |gengou|
              calc = SUMMARY.get_by_name(line: line, name: gengou.name)
              result |= calc
            end

            result
          end
        end
      end
    end
  end
end
