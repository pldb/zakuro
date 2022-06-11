# frozen_string_literal: true

require_relative '../../../../calculation/option/dropped_date/abstract_parameter'

require_relative '../../const/number'
require_relative '../../const/remainder'
require_relative '../../cycle/remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Genka
    # :nodoc:
    module Option
      # :nodoc:
      module DroppedDate
        #
        # Parameter 引数
        #
        class Parameter < Calculation::Option::DroppedDate::AbstractParameter
          #
          # 初期化
          #
          def initialize
            super(valid: false)
          end
        end
      end
    end
  end
end
