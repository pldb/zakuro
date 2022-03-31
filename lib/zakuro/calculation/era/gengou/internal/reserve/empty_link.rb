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
        module EmptyLink
          #
          # 空元号で満たす
          #
          # @param [Array<Gengou::Counter>] counters 加算元号リスト
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] last_date 終了日
          #
          def self.fill(counters:, start_date: Western::Calendar.new,
                        last_date: Western::Calendar.new)
            # TODO: make

            if counters.size.zero?
              counters.push(
                Gengou::Counter.new(
                  gengou: Japan::Gengou::Resource::Gengou.new,
                  start_date: start_date.clone,
                  last_date: last_date.clone
                )
              )
              return counters
            end

            # FIXME: 有効元号の前後しか見ていない

            fill_both_ends(counters: counters, start_date: start_date, last_date: last_date)
          end

          #
          # リストの両端を空元号で満たす
          #
          # @param [Array<Gengou::Counter>] counters 加算元号リスト
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] last_date 終了日
          #
          def self.fill_both_ends(counters:, start_date: Western::Calendar.new,
                                  last_date: Western::Calendar.new)
            fill_by_start(counters: counters, start_date: start_date)

            fill_by_last(counters: counters, last_date: last_date)
          end
          private_class_method :fill_both_ends

          #
          # 先頭要素の手前を空元号で満たす
          #
          # @param [Array<Gengou::Counter>] counters 加算元号リスト
          # @param [Western::Calendar] start_date 開始日
          #
          def self.fill_by_start(counters:, start_date:)
            return unless start_date < counters[0].start_date

            counters.unshift(
              Gengou::Counter.new(
                gengou: Japan::Gengou::Resource::Gengou.new, start_date: start_date.clone,
                last_date: counters[0].start_date.clone - 1
              )
            )
          end
          private_class_method :fill_by_start

          #
          # 最終要素の手前を空元号で満たす
          #
          # @param [Array<Gengou::Counter>] counters 加算元号リスト
          # @param [Western::Calendar] last_date 終了日
          #
          def self.fill_by_last(counters:, last_date:)
            return unless last_date > counters[-1].last_date

            counters.push(
              Gengou::Counter.new(
                gengou: Japan::Gengou::Resource::Gengou.new,
                start_date: counters[-1].last_date.clone + 1, last_date: last_date.clone
              )
            )
          end
          private_class_method :fill_by_last
        end
      end
    end
  end
end
