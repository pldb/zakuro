# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # SolarTerm 二十四節気
    #
    class SolarTerm
      # @return [Integer] 連番
      attr_reader :index
      # @return [Remainder] 時刻情報（大余小余）
      attr_reader :remainder

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

      #
      # 初期化
      #
      # @param [Integer] index 連番
      # @param [Remainder] remainder 時刻情報（大余小余）
      #
      def initialize(index: -1, remainder: Remainder.new)
        @index = index
        @remainder = remainder
      end

      #
      # 不正かどうか検証する
      #
      # @return [True] 正しくない
      # @return [False] 正しい
      #
      def invalid?
        (@index == -1 || @remainder.invalid?)
      end

      #
      # データなしかを検証する
      #
      # @return [True] データなし
      # @return [False] データあり
      #
      def empty?
        (@index == -1 && @remainder.invalid?)
      end
    end
  end
end
