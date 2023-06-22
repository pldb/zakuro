# frozen_string_literal: true

require_relative '../../../../output/logger'

require_relative '../../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Version
    # :nodoc:
    module Gihou
      # :nodoc:
      module Origin
        #
        # WinterSolstice 冬至
        #
        module WinterSolstice
          # @return [Integer] 通余
          REMAINDER_ALL_YEAR = Const::Number::Derivation::REMAINDER_ALL_YEAR
          # @return [Integer] 60日
          SIXTY_DAYS = Const::Number::Derivation::SIXTY_DAYS
          # @return [Integer] 積年
          TOTAL_YEAR = Const::Number::Stack::TOTAL_YEAR
          # @return [Integer] 暦の開始年
          BEGIN_YEAR = Const::Number::Stack::BEGIN_YEAR

          # @return [Output::Logger] ロガー
          LOGGER = Output::Logger.new(location: 'winter_solstice')

          class << self
            # :reek:TooManyStatements { max_statements: 6 }

            #
            # 対象年の前年の冬至を求める
            #
            # @param [Integer] western_year 西暦年
            #
            # @return [Remainder] 前年の冬至
            #
            def get(western_year:)
              # 積年の開始から対象年までの年数
              total = TOTAL_YEAR + western_year - BEGIN_YEAR
              remainder_year = total % SIXTY_DAYS

              LOGGER.debug("[01]:#{remainder_year}")

              # 通余を使う
              winter_solstice_minute = (remainder_year * REMAINDER_ALL_YEAR) % SIXTY_DAYS

              LOGGER.debug("[02]:#{winter_solstice_minute}")

              Cycle::Remainder.new(total: winter_solstice_minute)
            end
          end
        end
      end
    end
  end
end
