# frozen_string_literal: true

require_relative './abstract_remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Cycle
      #
      # AbstractSolarTerm 二十四節気
      #
      class AbstractSolarTerm
        # @return [Integer] 連番
        attr_reader :index
        # @return [AbstractRemainder] 時刻情報（大余小余）
        attr_reader :remainder
        # @return [AbstractRemainder] 気策（24分の1年）
        attr_reader :average

        # @return [Hash<Integer, Symbol>] 順序
        ORDER = {
          0 => :touji,
          1 => :shoukan,
          2 => :daikan,
          3 => :risshun,
          4 => :usui,
          5 => :keichitsu,
          6 => :shunbun,
          7 => :seimei,
          8 => :kokuu,
          9 => :rikka,
          10 => :shouman,
          11 => :boushu,
          12 => :geshi,
          13 => :shousho,
          14 => :taisho,
          15 => :risshuu,
          16 => :shosho,
          17 => :hakuro,
          18 => :shuubun,
          19 => :kanro,
          20 => :soukou,
          21 => :rittou,
          22 => :shousetsu,
          23 => :taisetsu
        }.freeze

        # @return [Integer] 開始番号
        FIRST_INDEX = 0

        # @return [Integer] 終了番号
        LAST_INDEX = 23

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [AbstractRemainder] remainder 時刻情報（大余小余）
        #
        def initialize(index: -1, remainder: AbstractRemainder.new,
                       average: AbstractRemainder.new)
          @index = index
          @remainder = remainder
          @average = average
        end

        #
        # 不正かどうか検証する
        #
        # @return [True] 正しくない
        # @return [False] 正しい
        #
        def invalid?
          (index == -1 || remainder.invalid?)
        end

        #
        # データなしかを検証する
        #
        # @return [True] データなし
        # @return [False] データあり
        #
        def empty?
          (index == -1 && remainder.invalid?)
        end

        #
        # 次の二十四節気に進める
        #
        def next_term!
          @remainder = next_term
        end

        #
        # 次の二十四節気に進める
        #
        def next_term
          @index += 1
          @index = 0 if index >= ORDER.size

          remainder.add(average)
        end

        #
        # 指定した連番の二十四節気まで進める
        #
        # @param [Integer] index 連番
        #
        def next_by_index(index)
          return ArgumentError.new, 'invalid index' unless AbstractSolarTerm.index?(index)

          (0..(ORDER.size - 1)).each do |_index|
            inner_index = @index
            break if inner_index == index

            next!
          end
        end

        #
        # 指定した連番の二十四節気まで戻す
        #
        # @param [Integer] index 連番
        #
        def prev_by_index(index)
          return ArgumentError.new, 'invalid index' unless AbstractSolarTerm.index?(index)

          (0..(ORDER.size - 1)).each do |_index|
            inner_index = @index
            break if inner_index == index

            prev_term!
          end
        end

        #
        # 前の二十四節気に戻る
        #
        def prev_term!
          @remainder = prev_term
        end

        #
        # 前の二十四節気に戻る
        #
        def prev_term
          @index -= 1
          @index = ORDER.size - 1 if index.negative?

          remainder.sub(average)
        end

        #
        # ディープコピー
        #
        # @param [SolarTerm] obj 自身
        #
        def initialize_copy(obj)
          @index = obj.index.clone
          @remainder = obj.remainder.clone
        end

        class << self
          #
          # 有効な二十四節気番号か
          #
          # @param [Integer] index 連番
          #
          # @return [True] 有効
          # @return [False] 無効
          #
          def index?(index)
            result = ORDER.fetch(index, -1)

            result != -1
          end
        end
      end
    end
  end
end
