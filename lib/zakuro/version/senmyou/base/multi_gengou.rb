# frozen_string_literal: true

require_relative '../../../era/japan/gengou'
require_relative '../../../era/western'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # MultiGengou 複数元号
    #
    class MultiGengou
      # @return [Japan::Gengou] 元号（1行目）
      attr_reader :first_line
      # @return [Japan::Gengou] 元号（2行目）
      attr_reader :second_line
      # @return [Western::Calendar] 元旦
      attr_reader :new_year_date

      def initialize(first_line: Japan::Gengou.new, second_line: Japan::Gengou.new,
                     new_year_date: Western::Calendar.new)
        @first_line = first_line
        @second_line = second_line
        @new_year_date = new_year_date
      end

      # :reek:TooManyStatements { max_statements: 7 }

      #
      # 改元する
      #
      # @param [Japan::Gengou] first_line 元号（1行目）
      # @param [Japan::Gengou] second_line 元号（2行目）
      #
      # @return [MultiGengou] 自身
      #
      def transfer(first_line: Japan::Gengou.new, second_line: Japan::Gengou.new)
        cloned_first_line = first_line.clone
        cloned_second_line = second_line.clone

        if integrated?(first_line: cloned_first_line, second_line: cloned_second_line)
          @first_line = @second_line.clone
          @second_line = cloned_second_line
        end

        @first_line = cloned_first_line if @first_line.name != first_line.name
        @second_line = cloned_second_line if @second_line.name != second_line.name

        self
      end

      #
      # 次年にする
      #
      # @param [Japan::Gengou] first_line 元号（1行目）
      # @param [Japan::Gengou] second_line 元号（2行目）
      #
      # @return [MultiGengou] 自身
      #
      def next_year
        @first_line.next_year
        @second_line.next_year

        self
      end

      #
      # ディープコピー
      #
      # @param [MultiGengou] obj 自身
      #
      def initialize_copy(obj)
        @first_line = obj.first_line.clone
        @second_line = obj.second_line.clone
      end

      private

      #
      # 複数元号を統一するかどうか
      #
      # @param [Japan::Gengou] first_line 元号（1行目）
      # @param [Japan::Gengou] second_line 元号（2行目）
      #
      # @return [True] 統一する
      # @return [False] 統一しない
      #
      def integrated?(first_line: Japan::Gengou.new, second_line: Japan::Gengou.new)
        return false if @second_line.name != first_line.name

        return false unless second_line.invalid?

        true
      end
    end
  end
end
