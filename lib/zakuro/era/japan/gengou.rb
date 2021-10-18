# frozen_string_literal: true

require_relative '../western/calendar'
require_relative './gengou/parser'
require_relative './gengou/type'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # GengouResource 元号情報
    #
    module GengouResource
      # @return [Array<Set>] 元号セット情報リスト
      LIST = [
        Parser.run(filepath: File.expand_path(
          './gengou/yaml/set-001-until-south.yaml',
          __dir__
        )),
        Parser.run(filepath: File.expand_path(
          './gengou/yaml/set-002-from-north.yaml',
          __dir__
        )),
        Parser.run(filepath: File.expand_path(
          './gengou/yaml/set-003-modern.yaml',
          __dir__
        ))
      ].freeze

      # :reek:TooManyStatements { max_statements: 9 }

      #
      # 元号（1行目,2行目）を引き当てる
      #
      # * LINE配列の元号情報を配列順で「x行目」（1始まり）とする
      # * 1行目にデータがあれば、第一要素に1行目のデータが設定される
      # * 1行目と2行目にデータがあれば、第二要素に2行目のデータが設定される
      # * 1行目にデータがなく、2行目以降に1つだけデータがあれば、第一要素にそのデータを設定してそれ以外の要素は未設定
      # * 1行目にデータがなく、2行目以降に2つ以上のデータがあれば、第一要素に末尾行に一番近いデータを設定してそれ以外の要素は未設定
      #
      # @param [Western::Calendar] date 日
      #
      # @return [Array<Gengou>] 元号情報（1行目, 2行目）
      #
      def self.lines(date:)
        lines = native_lines(date: date)
        return lines unless lines[0].invalid?

        first = Japan::Gengou.new
        lines[1..].each.with_index(1) do |item, index|
          next if item.invalid?

          first = item
          lines[index] = Japan::Gengou.new
        end
        lines[0] = first
        lines
      end

      #
      # 元号を引き当てる
      #
      # * LISTから単純に元号を引き当てる
      # * 1行目,2行目といった概念は無視する
      #
      # @param [Western::Calendar] date 日
      #
      # @return [Array<Gengou>] 元号情報
      #
      def self.native_lines(date:)
        result = Array.new(LIST.size)
        LIST.each_with_index do |set, index|
          result[index] = set.include_item(date: date)
        end
        result
      end

      #
      # 「日本暦日原典」1行目の元号を返す
      #
      # @param [Western::Calendar] date 日
      #
      # @return [Gengou] 元号情報（1行目）
      #
      def self.first_line(date:)
        lines = lines(date: date)
        lines[0].clone
      end

      #
      # 「日本暦日原典」2行目の元号を返す
      #
      # @param [Western::Calendar] date 日
      #
      # @return [Gengou] 元号情報（2行目）
      #
      def self.second_line(date:)
        lines = lines(date: date)
        lines[1].clone
      end
    end
  end
end
