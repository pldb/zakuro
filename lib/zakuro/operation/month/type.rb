# frozen_string_literal: true

require 'yaml'
require_relative '../../era/western'
require_relative './validator'

# :nodoc:
module Zakuro
  #
  # Operation 運用
  #
  module Operation
    #
    # 日（差分）無効値
    #
    INVALID_DAY_VALUE = -30

    #
    # MonthHistory 変更履歴
    #
    class MonthHistory
      # @return [String] ID
      attr_reader :id
      # @return [Reference] 参照
      attr_reader :reference
      # @return [Western::Calendar] 西暦日
      attr_reader :western_date
      # @return [Array<Annotation>] 注釈
      attr_reader :annotations
      # @return [Diffs] 総差分
      attr_reader :diffs

      #
      # 初期化
      #
      # @param [String] id ID
      # @param [Reference] reference 参照
      # @param [Western::Calendar] western_date 西暦日
      # @param [Array<Annotation>] annotations 注釈
      # @param [Diffs] diffs 総差分
      #
      def initialize(id: '', reference: Reference.new,
                     western_date: Western::Calendar.new, annotations: [], diffs: Diffs.new)
        @id = id
        @reference = reference
        @western_date = western_date
        @annotations = annotations
        @diffs = diffs
      end

      #
      # 無効か
      #
      # @return [True] 無効
      # @return [False] 有効
      #
      def invalid?
        id == ''
      end
    end

    #
    # Annotation 注釈
    #
    class Annotation
      # @return [String] ID
      attr_reader :id
      # @return [String] 内容
      attr_reader :description
      # @return [String] 正誤訂正（zakuro）
      attr_reader :note

      #
      # 初期化
      #
      # @param [String] id ID
      # @param [String] description 内容
      # @param [String] note 正誤訂正（zakuro）
      #
      def initialize(id: '', description: '', note: '')
        @id = id
        @description = description
        @note = note
      end

      #
      # 無効か
      #
      # @return [True] 無効
      # @return [False] 有効
      #
      def invalid?
        @id == ''
      end
    end

    #
    # Reference 参照
    #
    class Reference
      # @return [Integer] 頁数
      attr_reader :page
      # @return [Integer] 注釈番号
      attr_reader :number
      # @return [String] 和暦日
      attr_reader :japan_date

      #
      # 初期化
      #
      # @param [Integer] page 頁数
      # @param [Integer] number 注釈番号
      # @param [String] japan_date 和暦日
      #
      def initialize(page: -1, number: -1, japan_date: '')
        @page = page
        @number = number
        @japan_date = japan_date
      end

      #
      # 無効か
      #
      # @return [True] 無効
      # @return [False] 有効
      #
      def invalid?
        page == -1
      end
    end

    #
    # Diffs 総差分
    #
    class Diffs
      # @return [Month] 月差分
      attr_reader :month
      # @return [SolarTerm::Direction] 二十四節気差分
      attr_reader :solar_term
      # @return [Integer] 日差分
      attr_reader :days

      #
      # 初期化
      #
      # @param [Month] month 月差分
      # @param [SolarTerm::Direction] solar_term 二十四節気差分
      # @param [Integer] days 日差分
      #
      def initialize(month: Month.new, solar_term: SolarTerm::Direction.new,
                     days: INVALID_DAY_VALUE)
        @month = month
        @solar_term = solar_term
        @days = days
      end

      #
      # 日差分が無効か
      #
      # @return [True] 無効
      # @return [False] 有効
      #
      def invalid_days?
        @days == INVALID_DAY_VALUE
      end
    end

    #
    # Month 月差分
    #
    class Month
      # @return [Number] 月
      attr_reader :number
      # @return [Leaped] 閏有無
      attr_reader :leaped

      # :reek:BooleanParameter

      #
      # 初期化
      #
      # @param [Number] number 月
      # @param [Leaped] leaped 閏有無
      #
      def initialize(number: Number.new, leaped: Leaped.new)
        @number = number
        @leaped = leaped
      end

      #
      # 無効か
      #
      # @return [True] 無効
      # @return [False] 有効
      #
      def invalid?
        number == -1
      end
    end

    #
    # 二十四節気
    #
    module SolarTerm
      #
      # Direction 二十四節気（移動）
      #
      class Direction
        # @return [Source] 二十四節気（移動元）
        attr_reader :source
        # @return [Destination] 二十四節気（移動先）
        attr_reader :destination
        # @return [Integer] 大余差分
        attr_reader :days

        #
        # 初期化
        #
        # @param [Source] source 二十四節気（移動元）
        # @param [Destination] destination 二十四節気（移動先）
        # @param [Integer] day 大余差分
        #
        def initialize(source: Source.new, destination: Destination.new,
                       days: INVALID_DAY_VALUE)
          @source = source
          @destination = destination
          @days = days
        end

        #
        # 無効か（大余差分）
        #
        # @return [True] 無効
        # @return [False] 有効
        #
        def invalid_days?
          @days == INVALID_DAY_VALUE
        end

        #
        # 無効か
        #
        # @return [True] 無効
        # @return [False] 有効
        #
        def invalid?
          @source.invalid? && @destination.invalid?
        end
      end

      #
      # Source 二十四節気（移動元）
      #
      class Source
        # @return [Integer] 二十四節気番号
        attr_reader :index
        # @return [Western::Calendar] 移動先の月初日
        attr_reader :to
        # @return [String] 十干十二支
        attr_reader :zodiac_name

        #
        # 初期化
        #
        # @param [Integer] index 二十四節気番号
        # @param [Western::Calendar] to 移動先の月初日
        # @param [String] zodiac_name 十干十二支
        #
        def initialize(index: -1, to: Western::Calendar.new, zodiac_name: '')
          @index = index
          @to = to
          @zodiac_name = zodiac_name
        end

        #
        # 無効か
        #
        # @return [True] 無効
        # @return [False] 有効
        #
        def invalid?
          @index == -1
        end
      end

      #
      # Destination 二十四節気（移動先）
      #
      class Destination
        # @return [Integer] 二十四節気番号
        attr_reader :index
        # @return [Western::Calendar] 移動元の月初日
        attr_reader :from
        # @return [String] 十干十二支
        attr_reader :zodiac_name

        #
        # 初期化
        #
        # @param [Integer] index 二十四節気番号
        # @param [Western::Calendar] from 移動元の月初日
        # @param [String] zodiac_name 十干十二支
        #
        def initialize(index: -1, from: Western::Calendar.new, zodiac_name: '')
          @index = index
          @from = from
          @zodiac_name = zodiac_name
        end

        #
        # 無効か
        #
        # @return [True] 無効
        # @return [False] 有効
        #
        def invalid?
          @index == -1
        end
      end
    end

    #
    # Number 月
    #
    class Number
      # @return [Integer] 計算
      attr_reader :calc
      # @return [Integer] 運用
      attr_reader :actual

      #
      # 初期化
      #
      # @param [Integer] calc 計算
      # @param [Integer] actual 運用
      #
      def initialize(calc: -1, actual: -1)
        @calc = calc
        @actual = actual
      end

      #
      # 無効か
      #
      # @return [True] 無効
      # @return [False] 有効
      #
      def invalid?
        @calc == -1 || @actual == -1
      end
    end

    #
    # Leaped 閏有無
    #
    class Leaped
      # @return [True, False] 計算
      attr_reader :calc
      # @return [True, False] 運用
      attr_reader :actual

      # :reek:BooleanParameter

      #
      # 初期化
      #
      # @param [True, False] calc 計算
      # @param [True, False] actual 運用
      #
      def initialize(calc: false, actual: false)
        @calc = calc
        @actual = actual
      end

      #
      # 無効か
      #
      # @return [True] 無効（設定値なし）
      # @return [False] 有効
      #
      def invalid?
        !@calc && !@actual
      end
    end
  end
end
