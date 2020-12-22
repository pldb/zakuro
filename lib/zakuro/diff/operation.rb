# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # Operation 運用
  #
  module Operation
    #
    # History 変更履歴
    #
    class History
      attr_reader :id, :reference, :western_date, :annotations, :diffs

      def initialize; end
    end

    #
    # Annotation 注釈
    #
    class Annotation
      attr_reader :id, :description, :note

      def initialize; end
    end

    #
    # Reference 参照
    #
    class Reference
      attr_reader :page, :number, :japan_date

      def initialize; end
    end

    #
    # Diffs 全差分
    #
    class Diffs
      attr_reader :month, :even_term, :day

      def initialize; end
    end

    #
    # Month 月差分
    #
    class Month
      attr_reader :number, :leaped

      def initialize; end
    end

    #
    # Diffs 差分
    #
    class Diff
      attr_reader :calc, :actual

      def initialize; end
    end
  end
end
