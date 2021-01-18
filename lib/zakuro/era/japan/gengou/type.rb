# frozen_string_literal: true

require_relative '../../western'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    # :reek:TooManyInstanceVariables { max_instance_variables: 5 }

    #
    # Gengou 元号情報
    #
    class Gengou
      # @return [String] 元号名
      attr_reader :name
      # @return [Western::Calendar] 開始日
      attr_reader :start_date
      # @return [Western::Calendar] 元旦
      attr_reader :new_year_date
      # @return [Western::Calendar] 終了日
      attr_reader :end_date
      # @return [Integer] 元号年
      attr_reader :year

      #
      # 初期化
      #
      # @param [String] name 元号名
      # @param [Western::Calendar] start_date 開始日
      # @param [Western::Calendar] new_year_date 元旦
      # @param [Western::Calendar] end_date 終了日
      # @param [Integer] year 元号年
      #
      def initialize(name: '', start_date: Western::Calendar.new,
                     new_year_date: Western::Calendar.new,
                     end_date: Western::Calendar.new, year: -1)
        @name = name
        @start_date = start_date
        @new_year_date = new_year_date
        @end_date = end_date
        @year = year
      end

      #
      # 終了日を更新する
      #
      # @param [Western::Calendar] end_date 終了日
      #
      def write_end_date(end_date:)
        unless Gengou.valid_date(date: end_date)
          raise ArgumentError, "invalid date format. [#{end_date}]"
        end

        @end_date = end_date
        nil
      end

      # :reek:NilCheck

      #
      # 日付が有効かどうかを確認する
      #
      # @param [Western::Calendar] date 日付
      #
      # @return [True] 有効
      # @return [False] 無効
      #
      def self.valid_date(date:)
        !date.nil? && date.is_a?(Western::Calendar)
      end

      #
      # 次の元号の開始日から、元号の終了日に変換する
      #
      # @param [String] next_start_date_string 次回開始日
      #
      def convert_next_start_date_to_end_date(next_start_date_string: '')
        raise ArgumentError, 'empty string cannot convert' if next_start_date_string.empty?

        start_date = Western::Calendar.parse(str: next_start_date_string)
        @end_date = start_date - 1
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
        date >= @start_date && date <= @end_date
      end

      #
      # 不正な元号データかを確認する
      #
      # @return [True] 正しくない
      # @return [True] 正しい
      #
      def invalid?
        @year == -1
      end

      #
      # 1元号年を追加する
      #
      def next_year
        @year += 1 unless invalid?
        nil
      end

      def to_s
        "name: #{@name}, start_date: #{@start_date.format}, " \
        "end_date: #{@end_date.format}, year: #{@year}"
      end
    end

    #
    # Set 元号セット
    #
    class Set
      # @return [Integer] 元号セットID
      attr_reader :id
      # @return [String] 元号セット名
      attr_reader :name
      # @return [Western::Calendar] 元号セットでの終了日
      attr_reader :end_date
      # @return [Array<Gengou>] 元号リスト
      attr_reader :list

      #
      # 初期化
      #
      # @param [Integer] id 元号セットID
      # @param [String] name 元号セット名
      # @param [Western::Calendar] end_date 元号セットでの終了日
      # @param [Array<Gengou>] list 元号リスト
      #
      def initialize(id: -1, name: '', end_date: Western::Calendar.new, list: [])
        @id = id
        @name = name
        @end_date = end_date
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
        @id == -1
      end
    end
  end
end
