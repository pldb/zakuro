# frozen_string_literal: true

require_relative '../../../western/calendar'

require_relative '../../calendar'

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
          # @return [Both::Year] 開始年（和暦/西暦）
          attr_reader :both_start_year
          # @return [Both::Date] 開始日（和暦/西暦）
          attr_reader :both_start_date
          # @return [Integer] 終了年
          attr_reader :last_year
          # @return [Western::Calendar] 終了日
          attr_reader :last_date

          #
          # 初期化
          #
          # @param [String] name 元号名
          # @param [Both::Year] both_start_year 開始年（和暦/西暦）
          # @param [Both::Date] both_start_date 開始日（和暦/西暦）
          # @param [Integer] last_date 終了年
          # @param [Western::Calendar] last_date 終了日
          #
          def initialize(name: '', both_start_year: Both::Year.new,
                         both_start_date: Both::Date.new,
                         last_date: Western::Calendar.new,
                         last_year: Both::Year::INVALID)
            @name = name
            @both_start_year = both_start_year
            @both_start_date = both_start_date
            @last_year = last_year
            @last_date = last_date
          end

          #
          # 終了年を更新する
          #
          # @param [Integer] last_year 終了年
          #
          def write_last_year(last_year:)
            unless Gengou.valid_year(year: last_year)
              raise ArgumentError, "invalid year format. [#{last_year}]"
            end

            @last_year = last_year
          end

          #
          # 終了日を更新する
          #
          # @param [Western::Calendar] last_date 終了日
          #
          def write_last_date(last_date:)
            unless Gengou.valid_date(date: last_date)
              raise ArgumentError, "invalid date format. [#{last_date}]"
            end

            @last_date = last_date
            nil
          end

          #
          # 年が不正なしかどうかを確認する
          #
          # @param [Integer] year 年
          #
          # @return [True] 不正なし
          # @return [False] 不正
          #
          def self.valid_year(year:)
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
          def self.valid_date(date:)
            return false unless date

            date.is_a?(Western::Calendar)
          end

          #
          # 次の元号の開始年から、元号の終了年に変換する
          #
          # @param [Integer] next_start_year 次回開始年
          #
          def convert_next_start_year_to_last_year(next_start_year:)
            if @both_start_year.western >= next_start_year
              @last_year = next_start_year
              return
            end

            @last_year = next_start_year - 1

            nil
          end

          #
          # 次の元号の開始日から、元号の終了日に変換する
          #
          # @param [String] next_start_date 次回開始日
          #
          def convert_next_start_date_to_last_date(next_start_date: '')
            raise ArgumentError, 'empty string cannot convert' if next_start_date.empty?

            start_date = Western::Calendar.parse(text: next_start_date)
            @last_date = start_date - 1

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
            date >= @both_start_date.western && date <= @last_date
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            @both_start_year.japan == -1 || @both_start_year.invalid? ||
              @both_start_date.invalid? || @last_date.invalid?
          end

          #
          # 1元号年を追加する
          #
          # def next_year
          #   @year += 1 unless invalid?
          #   nil
          # end

          def to_s
            "name: #{@name}, both_start_year: #{@both_start_year.format}, " \
            "both_start_date: #{@both_start_date.format}, last_date: #{@last_date.format}"
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
          # @return [Both::Date] 元号セットでの終了年
          attr_reader :both_last_year
          # @return [Both::Date] 元号セットでの終了日
          attr_reader :both_last_date
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
          def initialize(id: INVALID, name: '', both_last_year: Both::Year.new,
                         both_last_date: Both::Date.new, list: [])
            @id = id
            @name = name
            @both_last_year = both_last_year
            @both_last_date = both_last_date
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
            @list.each do |item|
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

        #
        # 和暦/西暦
        #
        module Both
          #
          # Year 年
          #
          class Year
            # @return [Integer] 不正値
            INVALID = -1
            # @return [Integer] 和暦元号年
            attr_reader :japan
            # @return [Integer] 西暦年
            attr_reader :western

            def initialize(japan: INVALID, western: INVALID)
              @japan = japan
              @western = western
            end

            #
            # 不正か
            #
            # @return [True] 不正
            # @return [False] 不正なし
            #
            def invalid?
              @japan == INVALID || @western == INVALID
            end
          end

          #
          # Date 日
          #
          class Date
            # @return [Japan::Calendar] 和暦日
            attr_reader :japan
            # @return [Western::Calendar] 西暦日
            attr_reader :western

            def initialize(japan: Japan::Calendar.new, western: Western::Calendar.new)
              @japan = japan
              @western = western
            end

            #
            # 不正か
            #
            # @return [True] 不正
            # @return [False] 不正なし
            #
            def invalid?
              @japan.invalid? || @western.invalid?
            end
          end
        end
      end
    end
  end
end
