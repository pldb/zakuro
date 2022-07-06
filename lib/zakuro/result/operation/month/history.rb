# frozen_string_literal: true

require_relative './annotation'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # 運用情報
    #
    class Operation
      #
      # Month 運用情報（月）
      #
      class Month
        #
        # History 月別履歴情報
        #
        class History
          # @return [String] ID
          attr_reader :id
          # @return [String] 月初日の西暦日
          attr_reader :western_date
          # @return [Integer] 原文頁数
          attr_reader :page
          # @return [Integer] 原文注釈番号
          attr_reader :number
          # @return [Array<Annotation>] 注釈
          attr_reader :annotations

          #
          # 初期化
          #
          # @param [String] id ID
          # @param [String] western_date 月初日の西暦日
          # @param [Integer] page 原文頁数
          # @param [Integer] number 原文注釈番号
          # @param [Array<Annotation>] annotations 注釈
          #
          def initialize(id: '', western_date: '', page: -1, number: -1, annotations: [])
            @id = id
            @western_date = western_date
            @page = page
            @number = number
            @annotations = annotations
          end
        end
      end
    end
  end
end
