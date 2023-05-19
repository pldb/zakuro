# frozen_string_literal: true

require_relative '../../../western/calendar'

require_relative '../../calendar'

require_relative '../../type/base/switch_date'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Gengou
      #
      # Resource yaml解析結果
      #
      module Resource
        #
        # Gengou 元号情報
        #
        class Gengou
          # @return [String] 元号名
          attr_reader :name
          # @return [Type::Base::Both::Year] 開始年（和暦/西暦）
          attr_reader :start_year
          # @return [Type::Base::SwitchDate] 開始日（和暦/西暦）
          attr_reader :start_date
          # @return [Integer] 終了年
          attr_reader :last_year
          # @return [Western::Calendar] 終了日
          attr_reader :last_date

          #
          # 初期化
          #
          # @param [String] name 元号名
          # @param [Type::Base::Both::Year] start_year 開始年（和暦/西暦）
          # @param [Type::Base::SwitchDate] start_date 開始日（和暦/西暦）
          # @param [Integer] last_date 終了年
          # @param [Western::Calendar] last_date 終了日
          #
          def initialize(name: '', start_year: Type::Base::Both::Year.new,
                         start_date: Type::Base::SwitchDate.new,
                         last_date: Western::Calendar.new,
                         last_year: Type::Base::Both::Year::INVALID)
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

        #
        # Set 元号セット
        #
        class Set
          # @return [Integer] 不正値
          INVALID = -1
          # @return [Integer] 元号セットID
          attr_reader :id
          # @return [String] 元号セット名
          attr_reader :name
          # @return [Type::Base::Both::Year] 元号セットでの終了年
          attr_reader :last_year
          # @return [Type::Base::Both::Date] 元号セットでの終了日
          attr_reader :last_date
          # @return [Array<Gengou>] 元号リスト
          attr_reader :list

          #
          # 初期化
          #
          # @param [Integer] id 元号セットID
          # @param [String] name 元号セット名
          # @param [Western::Calendar] last_date 元号セットでの終了日
          # @param [Array<Gengou>] list 元号リスト
          #
          def initialize(id: INVALID, name: '', last_year: Type::Base::Both::Year.new,
                         last_date: Type::Base::Both::Date.new, list: [])
            @id = id
            @name = name
            @last_year = last_year
            @last_date = last_date
            @list = list
          end

          #
          # 指定した日付を含む元号を返す
          #
          # @param [Western::Calendar] date 日
          #
          # @return [Gengou] 元号
          #
          def include_item(date:)
            list.each do |item|
              return item if item.include?(date: date)
            end

            Gengou.new
          end

          #
          # 元号セットが不正かどうかを確認する
          #
          # @return [True] 正しくない
          # @return [False] 正しい
          #
          def invalid?
            @id == INVALID
          end
        end
      end
    end
  end
end
