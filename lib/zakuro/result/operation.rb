# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # 運用情報
    #
    module Operation
      #
      # Bundle 運用情報
      #
      class Bundle
        # @return [True] 運用あり
        # @return [False] 運用なし
        attr_reader :operated
        # @return [Month] 月別履歴情報
        attr_reader :month
        # @return [Data::SingleDay] 計算値
        attr_reader :original

        #
        # 初期化
        #
        # @param [True, False] operated 運用有無
        # @param [Month] month 月別履歴情報
        # @param [Data::SingleDay] original 計算値
        #
        def initialize(operated:, month:, original:)
          @operated = operated
          @month = month
          @original = original
        end
      end

      #
      # Month 月別履歴情報
      #
      class Month
        # @return [String] ID
        attr_reader :id
        # @return [String] 親注釈
        attr_reader :parent
        # @return [Integer] 原文頁数
        attr_reader :page
        # @return [Integer] 原文注釈番号
        attr_reader :number
        # @return [Array<Zakuro::Result::Operation::Annotation>] 注釈
        attr_reader :annotations

        #
        # 初期化
        #
        # @param [String] id ID
        # @param [Parent] parent 親注釈
        # @param [Integer] page 原文頁数
        # @param [Integer] number 原文注釈番号
        # @param [Array<Zakuro::Result::Operation::Annotation>] annotations 注釈
        #
        def initialize(id: '', parent: Parent.new, page: -1, number: -1, annotations: [])
          @id = id
          @parent = parent
          @page = page
          @number = number
          @annotations = annotations
        end
      end

      #
      # Parent 親注釈
      #
      class Parent
        # @return [String] ID
        attr_reader :id
        # @return [String] 月初日の西暦日（計算値）
        attr_reader :western_date

        #
        # 初期化
        #
        # @param [String] id ID
        # @param [String] western_date 月初日の西暦日（計算値）
        #
        def initialize(id: '', western_date: '')
          @id = id
          @western_date = western_date
        end
      end

      #
      # Annotation 注釈
      #
      class Annotation
        # @return [String] 注釈内容
        attr_reader :description
        # @return [String] 注釈補記
        attr_reader :note

        #
        # 初期化
        #
        # @param [String] description 注釈内容
        # @param [<Type>] note 注釈補記
        #
        def initialize(description:, note:)
          @description = description
          @note = note
        end
      end
    end
  end
end
