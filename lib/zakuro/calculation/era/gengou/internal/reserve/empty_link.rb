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
          def self.fill(counters:, start_date: Western::Calendar.new,
                        last_date: Western::Calendar.new)
            # TODO: make

            if counters.size.zero?
              counters.push(
                Gengou::Counter.new(
                  gengou: Japan::Gengou::Resource::Gengou.new(
                    both_start_date: Japan::Gengou::Resource::Both::Date.new(
                      western: start_date.clone
                    ),
                    last_date: last_date.clone
                  )
                )
              )
              return counters
            end

            cover_both_ends(counters: counters, start_date: start_date, last_date: last_date)

            counters
          end

          def self.cover_both_ends(counters:, start_date: Western::Calendar.new,
                                   last_date: Western::Calendar.new)
            # FIXME: 有効元号の前後しか見ていない
            if start_date < counters[0].start_date
              counters.unshift(
                Gengou::Counter.new(
                  gengou: Japan::Gengou::Resource::Gengou.new, start_date: start_date.clone,
                  last_date: counters[0].start_date.clone - 1
                )
              )
            end

            return unless last_date > counters[-1].last_date

            counters.push(
              Gengou::Counter.new(
                gengou: Japan::Gengou::Resource::Gengou.new,
                start_date: counters[-1].last_date.clone + 1, last_date: last_date.clone
              )
            )
          end
        end
      end
    end
  end
end
