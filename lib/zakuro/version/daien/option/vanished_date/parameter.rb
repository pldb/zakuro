# frozen_string_literal: true

require_relative '../../../../calculation/option/vanished_date/abstract_parameter'

require_relative '../../const/number'
require_relative '../../const/remainder'
require_relative '../../cycle/remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Daien
    # :nodoc:
    module Option
      # :nodoc:
      module VanishedDate
        #
        # Parameter 引数
        #
        class Parameter < Calculation::Option::VanishedDate::AbstractParameter
          #
          # 初期化
          #
          def initialize
            super(valid: true,
                  limit: Const::Remainder::Solar::VANISHED_DATE_LIMIT,
                  remainder_class: Cycle::VanishedRemainder)
          end
        end
      end
    end
  end
end
