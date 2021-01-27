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
      # 運用情報
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
        # @return [Integer] 原文頁数
        attr_reader :page
        # @return [Integer] 原文注釈番号
        attr_reader :number
        # @return [Array<Zakuro::Result::Operation::Annotation>] 注釈
        attr_reader :annotations

        #
        # 初期化
        #
        # @param [Integer] page 原文頁数
        # @param [Integer] number 原文注釈番号
        # @param [Array<Zakuro::Result::Operation::Annotation>] annotations 注釈
        #
        def initialize(page:, number:, annotations:)
          @page = page
          @number = number
          @annotations = annotations
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
