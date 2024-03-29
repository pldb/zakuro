# frozen_string_literal: true

require_relative '../../../western/calendar'
require_relative './switch_date'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Type
      # :nodoc:
      module Base
        #
        # Gengou 元号情報
        #
        class Gengou
          # @return [String] 元号名
          attr_reader :name
          # @return [Both::Year] 開始年（和暦/西暦）
          attr_reader :start_year
          # @return [SwitchDate] 開始日（和暦/西暦）
          attr_reader :start_date
          # @return [Integer] 終了年
          attr_reader :last_year
          # @return [Western::Calendar] 終了日
          attr_reader :last_date

          #
          # 初期化
          #
          # @param [String] name 元号名
          # @param [Both::Year] start_year 開始年（和暦/西暦）
          # @param [SwitchDate] start_date 開始日（和暦/西暦）
          # @param [Integer] last_date 終了年
          # @param [Western::Calendar] last_date 終了日
          #
          def initialize(name: '', start_year: Both::Year.new,
                         start_date: SwitchDate.new,
                         last_date: Western::Calendar.new,
                         last_year: Both::Year::INVALID)
            @name = name
            @start_year = start_year
            @start_date = start_date
            @last_year = last_year
            @last_date = last_date
          end

          #
          # 終了年を更新する
          #
          # @param [Integer] last_year 終了年
          #
          # @raise [ArgumentError] 引数エラー
          #
          def write_last_year(last_year:)
            unless self.class.valid_year(year: last_year)
              raise ArgumentError, "invalid year format. [#{last_year}]"
            end

            @last_year = last_year
          end

          #
          # 終了日を更新する
          #
          # @param [Western::Calendar] last_date 終了日
          #
          # @raise [ArgumentError] 引数エラー
          #
          def write_last_date(last_date:)
            unless self.class.valid_date(date: last_date)
              raise ArgumentError, "invalid date format. [#{last_date}]"
            end

            @last_date = last_date
            nil
          end

          #
          # 次の元号の開始年から、元号の終了年に変換する
          #
          # @param [Integer] next_start_year 次回開始年
          #
          def convert_next_start_year_to_last_year(next_start_year:)
            if start_year.western >= next_start_year
              @last_year = next_start_year
              return
            end

            @last_year = next_start_year - 1

            nil
          end

          #
          # 次の元号の開始日から、元号の終了日に変換する
          #
          # @param [Western::Calendar] next_start_date 次回開始日
          #
          # @raise [ArgumentError] 引数エラー
          #
          def convert_next_start_date_to_last_date(next_start_date: Western::Calendar.new)
            raise ArgumentError, 'invalid value. cannot convert' if next_start_date.invalid?

            @last_date = next_start_date.clone - 1

            nil
          end

          #
          # 指定した日が元号に含まれるか
          #
          # @param [Western::Calendar] date 日
          #
          # @return [True] 含まれる
          # @return [False] 含まれない
          #
          def include?(date:)
            date >= start_date.western && date <= last_date
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            start_year.japan == -1 || start_year.invalid? ||
              start_date.invalid? || last_date.invalid?
          end

          #
          # インスタンス値（文字列）を取得する
          #
          # @return [String] インスタンス値（文字列）
          #
          def to_s
            "name: #{@name}, start_year: #{start_year.format}, " \
            "start_date: #{start_date.format}, last_date: #{last_date.format}"
          end

          class << self
            #
            # 年が不正なしかどうかを確認する
            #
            # @param [Integer] year 年
            #
            # @return [True] 不正なし
            # @return [False] 不正
            #
            def valid_year(year:)
              return false unless year

              year.is_a?(Integer)
            end

            #
            # 日付が不正なしかどうかを確認する
            #
            # @param [Western::Calendar] date 日付
            #
            # @return [True] 不正なし
            # @return [False] 不正
            #
            def valid_date(date:)
              return false unless date

              date.is_a?(Western::Calendar)
            end
          end
        end
      end
    end
  end
end
