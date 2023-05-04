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
        # EmptyLink
        #
        # 空元号連結
        #
        #  * 開始日と終了日の間は常に元号で満たす必要がある
        #  * もし元号が存在しない期間があれば、空の元号を生成する
        #
        module EmptyLink
          class << self
            #
            # 空元号で満たす
            #
            # @param [Array<Gengou::Counter>] counters 加算元号リスト
            # @param [Western::Calendar] start_date 開始日
            # @param [Western::Calendar] last_date 終了日
            #
            def fill(counters:, start_date: Western::Calendar.new,
                     last_date: Western::Calendar.new)
              if counters.empty?
                counters.push(
                  create_empty_counter(
                    start_date: start_date.clone,
                    last_date: last_date.clone
                  )
                )
                return counters
              end

              fill_both_ends(counters: counters, start_date: start_date, last_date: last_date)

              fill_middle(counters: counters)
            end

            private

            #
            # リストの両端を空元号で満たす
            #
            # @param [Array<Gengou::Counter>] counters 加算元号リスト
            # @param [Western::Calendar] start_date 開始日
            # @param [Western::Calendar] last_date 終了日
            #
            def fill_both_ends(counters:, start_date: Western::Calendar.new,
                               last_date: Western::Calendar.new)
              fill_by_start(counters: counters, start_date: start_date)

              fill_by_last(counters: counters, last_date: last_date)
            end

            #
            # 先頭要素の手前を空元号で満たす
            #
            # @param [Array<Gengou::Counter>] counters 加算元号リスト
            # @param [Western::Calendar] start_date 開始日
            #
            def fill_by_start(counters:, start_date:)
              return unless start_date < counters[0].start_date

              counters.unshift(
                create_empty_counter(
                  start_date: start_date.clone,
                  last_date: counters[0].start_date.clone - 1
                )
              )
            end

            #
            # 最終要素の手前を空元号で満たす
            #
            # @param [Array<Gengou::Counter>] counters 加算元号リスト
            # @param [Western::Calendar] last_date 終了日
            #
            def fill_by_last(counters:, last_date:)
              return unless last_date > counters[-1].last_date

              counters.push(
                create_empty_counter(
                  start_date: counters[-1].last_date.clone + 1,
                  last_date: last_date.clone
                )
              )
            end

            #
            # 元号間を空元号で満たす
            #
            # @param [Array<Gengou::Counter>] counters 加算元号リスト
            #
            def fill_middle(counters:)
              return if counters.empty?

              size = counters.size - 1
              (0..size).reverse_each do |index|
                break if index <= 0

                insert(counters: counters, index: index)
              end
            end

            #
            # 対象要素に空元号を追加する
            #
            # @param [Array<Gengou::Counter>] counters 加算元号リスト
            # @param [Integer] index 要素番号
            #
            def insert(counters:, index:)
              before_last_date = counters[index - 1].last_date.clone
              current_start_date = counters[index].start_date.clone

              return if (before_last_date.clone + 1) == current_start_date

              counters.insert(
                index,
                create_empty_counter(
                  start_date: before_last_date + 1, last_date: current_start_date - 1
                )
              )
            end

            #
            # 空元号を生成する
            #
            # @param [Western::Calendar] start_date 西暦開始日
            # @param [Western::Calendar] last_date 西暦終了日
            #
            # @return [Gengou::Counter] 加算元号（空元号）
            #
            def create_empty_counter(start_date:, last_date:)
              Gengou::Counter.new(
                gengou: Japan::Gengou::Resource::Gengou.new,
                start_date: start_date, last_date: last_date
              )
            end
          end
        end
      end
    end
  end
end
