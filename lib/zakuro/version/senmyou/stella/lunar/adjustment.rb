# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :nodoc:
    module Lunar
      #
      # Adjustment 補正値情報
      #
      module Adjustment
        #
        # Item 補正値
        #
        class Item
          # @return [Integer] 損益率
          attr_reader :per
          # @return [Integer] 眺朒（ちょうじく）積
          attr_reader :stack

          #
          # 初期化
          #
          # @param [Integer] per 損益率
          # @param [Integer] stack 眺朒（ちょうじく）積
          #
          def initialize(per:, stack:)
            @per = per
            @stack = stack
          end

          #
          # 文字化
          #
          # @return [String] 文字
          #
          def to_s
            "per:#{@per}, stack:#{@stack}"
          end
        end

        # @return [Array<Item>] 月の補正値
        # @note キーは複合キーであり、以下のパターンに対応する
        #   * 進退
        #     * forward: 進（遠地点より数える）
        #     * back: 退（近地点より数える）
        #  * 入暦（1-14）
        #  * 小余（0-8400）
        MAP = {
          forward_01_0000_8400: Item.new(per: +830, stack: 0),
          forward_02_0000_8400: Item.new(per: +726, stack: +830),
          forward_03_0000_8400: Item.new(per: +606, stack: +1556),
          forward_04_0000_8400: Item.new(per: +471, stack: +2162),
          forward_05_0000_8400: Item.new(per: +337, stack: +2633),
          forward_06_0000_8400: Item.new(per: +202, stack: +2970),
          forward_07_0000_7465: Item.new(per: +53, stack: +3172),
          forward_07_7465_8400: Item.new(per: -7, stack: +3225),  # +3172 + 53（初益）
          forward_08_0000_8400: Item.new(per: -82, stack: +3218),
          forward_09_0000_8400: Item.new(per: -224, stack: +3136),
          forward_10_0000_8400: Item.new(per: -366, stack: +2912),
          forward_11_0000_8400: Item.new(per: -509, stack: +2546),
          forward_12_0000_8400: Item.new(per: -643, stack: +2037),
          forward_13_0000_8400: Item.new(per: -748, stack: +1394),
          forward_14_0000_6529: Item.new(per: -646, stack: +646), # 14日の小余は常に6529以下
          back_01_0000_8400: Item.new(per: -830, stack: 0),
          back_02_0000_8400: Item.new(per: -726, stack: -830),
          back_03_0000_8400: Item.new(per: -598, stack: -1556),
          back_04_0000_8400: Item.new(per: -464, stack: -2154),
          back_05_0000_8400: Item.new(per: -329, stack: -2618),
          back_06_0000_8400: Item.new(per: -195, stack: -2947),
          back_07_0000_7465: Item.new(per: -53, stack: -3142),
          back_07_7465_8400: Item.new(per: +7, stack: -3195), # -3142 - 53（初益）
          back_08_0000_8400: Item.new(per: +82, stack: -3188),
          back_09_0000_8400: Item.new(per: +225, stack: -3106),
          back_10_0000_8400: Item.new(per: +366, stack: -2881),
          back_11_0000_8400: Item.new(per: +501, stack: -2515),
          back_12_0000_8400: Item.new(per: +628, stack: -2014),
          back_13_0000_8400: Item.new(per: +740, stack: -1386),
          back_14_0000_6529: Item.new(per: +646, stack: -646) # 14日の小余は常に6529以下
        }.freeze
      end

      # TODO: orbit 側の下記の処理をこのモジュールに移行させること

      # # :reek:TooManyStatements { max_statements: 9 }

      # #
      # # 月軌道の補正に必要な基本値を引き当てる
      # #
      # # @note 戻り値は run で使用する
      # #
      # # @param [True, False] forward 進（遠地点より数える）/退（近地点より数える）
      # # @param [Integer] day 大余
      # # @param [Integer] minute 小余
      # #
      # # @return [Adjustment::Item] 補正値
      # # @return [Integer] （小余を処理する時の）分母
      # # @return [Integer] 小余の下げ幅
      # #
      # def self.specify_adjustment(forward:, day:, minute:)
      #   prefix = { true => 'forward', false => 'back' }[forward]

      #   targets = Adjustment::MAP.select \
      #     { |key, _| key.match(/^#{prefix}_#{format('%<day>02d', day: day)}_.*/) }

      #   targets.each do |key, value|
      #     # NOTE: 境界値は上から順に引き当てた方を返す
      #     matched, diff = \
      #       extract_data_from_moon_adjustment_key(key, minute)

      #     next unless matched

      #     # 小余の下げ幅
      #     calc_minute = get_adjustment_minute(day: day, minute: minute)
      #     return value, diff, calc_minute
      #   end

      #   raise ArgumentError.new, "invalid parameter: #{forward}/#{day}/#{minute}"
      # end
      # private_class_method :specify_adjustment

      # # :reek:ControlParameter

      # #
      # # 小余の下げ幅を求める
      # #
      # # @param [Integer] day 大余
      # # @param [Integer] minute 小余
      # #
      # # @return [Integer] 小余の下げ幅
      # #
      # def self.get_adjustment_minute(day:, minute:)
      #   return minute unless day == 7

      #   return minute unless minute > 7465

      #   minute - 7465
      # end

      # #
      # # 補正値を引き当てる
      # #
      # # @param [String] key 補正値のキー
      # # @param [Integer] minute 小余
      # #
      # # @return [Adjustment::Item] 補正値
      # # @return [Integer] （小余を処理する時の）分母
      # #
      # def self.extract_data_from_moon_adjustment_key(key, minute)
      #   matched = key.match(/([0-9]{4})_([0-9]{4})$/)
      #   start = matched[1].to_i
      #   finish = matched[2].to_i

      #   matched = minute >= start && minute <= finish
      #   [matched, (finish - start)]
      # end
      # private_class_method :extract_data_from_moon_adjustment_key
    end
  end
end
