# frozen_string_literal: true

require_relative './medieval_month'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Rekijitsu
      # MedievalLine 行データ（中世）
      class MedievalLine
        # @return [Integer] 行番号
        attr_reader :num
        # @return [MedievalGengou] 元号
        attr_reader :gengou
        # @return [MedievalMonth] 月
        attr_reader :month

        #
        # 初期化
        #
        # @param [Integer] num 行番号
        # @param [MedievalGengou] gengou 元号
        # @param [MedievalMonth] month 月
        #
        def initialize(num: -1, gengou: MedievalGengou.new,
                       month: MedievalMonth.new)
          @num = num
          @gengou = gengou
          @month = month
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          @num == -1
        end

        #
        # ハッシュ化する
        #
        # @return [Hash<String, Objcet>] ハッシュ
        #
        def to_h
          {
            num: num,
            month: month.to_h
          }
        end
      end
    end
  end
end
