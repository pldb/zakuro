# frozen_string_literal: true

require_relative '../../const/const'
require_relative './localization'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :nodoc:
    module Solar
      #
      # Location 入定気
      #
      class Location
        # @return [Cycle::Remainder] 弦（1分=8秒）
        QUARTER = Cycle::Remainder.new(day: 7, minute: 3214, second: 2)

        # @return [True] 計算済み（前回計算あり）
        # @return [False] 未計算（初回計算）
        attr_reader :calculated
        # @return [Integer] 連番
        attr_reader :index
        # @return [Cycle::Remainder] 大余小余
        attr_reader :remainder

        #
        # 初期化
        #
        # @param [Cycle::Remainder] winter_solstice_age 天正閏余（大余小余）
        #
        def initialize(winter_solstice_age: Cycle::Remainder.new)
          @calculated = false
          @index = -1
          @remainder = winter_solstice_age.clone
        end

        def run
          return current if calculated

          first
        end

        def invalid?
          @index == -1
        end

        #
        # 弦の分だけ太陽地点を進める
        #
        def add_quarter
          @remainder.add!(QUARTER)
        end

        private

        #
        # 2回目以降の計算をする
        #
        def current
          decrease_recursively
        end

        #
        # 初回計算する
        #
        def first
          define_first
          @calculated = true
        end

        #
        # 初回の入定気を定める
        #
        def define_first
          # 入定気の起算方法
          # 概要:
          #  * 太陽の運行による補正値は、二十四節気の気ごとに定められる
          #  * 11月経朔の前にある気を求め、それから11月経朔との間隔を求める
          #  * 気ごとの補正値と、気から11月経朔までにかかる補正値を求める
          # 前提:
          #  * 11月経朔に関わる二十四節気は、時系列から順に、小雪・大雪・冬至である
          #  * 小雪〜大雪の間隔は小雪定数で、大雪〜冬至の間隔は大雪定数で決められている（24気損益眺朒（ちょうじく）数のこと）
          #  * 11月経朔は、この小雪〜冬至の間のいずれかにある
          # 計算:
          # 2パターンある
          #  (a) 大雪〜冬至にある場合
          #   *「大雪定数 >= 天正閏余」の場合を指す
          #   * * NOTE 資料では「より大きい（>）」とされるが、大雪そのものの場合は大雪から起算すべき
          #   * この場合は、大雪〜経朔の間隔を求める
          #  (b) 小雪〜大雪にある場合
          #   *「大雪定数 < 天正閏余」の場合を指す
          #   * この場合は、小雪〜経朔の間隔を求める

          # NOTE: 上記パターンとは別に、稀だが立冬のパターンも存在する
          # この場合は比較方法はそのままに立冬〜経朔の間隔を求める

          # 大雪（23）/小雪（22）/立冬（21）
          [23, 22, 21].each do |index|
            prev(index: index)

            break unless invalid?
          end

          # 立冬（21）を超える天正閏余は成立し得ない（1朔望月をはるかに超えることになる）
          if invalid?
            # TODO: エラー
            p 'pass'
            raise ArgumentError.new, 'invalid winster solstice age'
          end
        end

        def prev(index:)
          interval = Localization.index_of(index)
          if remainder > interval
            @remainder.sub(interval)
            return
          end

          # 入定気が確定する
          @remainder = interval.sub(@remainder)
          @index = index
        end

        def next_index
          @index += 1
          @index = 0 if @index >= Localization.size
        end

        def decrease_recursively
          interval = Localization.index_of(@index)
          # 現在の二十四節気に留まる
          return if remainder < interval

          @remainder.sub!(interval)

          next_index

          # 再帰
          decrease_recursively
        end
      end
    end
  end
end