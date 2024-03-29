# frozen_string_literal: true

require_relative './lunar_age'
require_relative './winter_solstice'

# :nodoc:
module Zakuro
  # :nodoc:
  module Version
    # :nodoc:
    module Gihou
      # :nodoc:
      module Origin
        #
        # AverageNovember 11月経
        #
        module AverageNovember
          class << self
            #
            # 11月経朔（冬至が含まれる月の1日）を求める
            #
            # @param [Integer] western_year 西暦年
            #
            # @return [Remainder] 11月経朔
            #
            def get(western_year:)
              # 冬至
              winter_solstice = WinterSolstice.get(western_year: western_year)
              # 天正閏余
              lunar_age = LunarAge.get(western_year: western_year)

              winter_solstice.sub(lunar_age)
            end
          end
        end
      end
    end
  end
end
