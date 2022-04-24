# frozen_string_literal: true

require 'json'
require_relative './cause'

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    #
    # ZakuroError ライブラリ内エラー
    #
    class ZakuroError < StandardError
      # @return [Array<ErrorMessage>] エラーメッセージ
      attr_reader :causes

      #
      # 初期化
      #
      # @param [String] msg メッセージ
      # @param [Array<Cause>] causes 原因
      #
      def initialize(msg: '', causes: [])
        @causes = causes
        out = "#{msg}:#{text}"
        super(out)
      end

      #
      # 原因をJSON文字列にする
      #
      # @return [String] JSON文字列
      #
      def text
        list = []
        @causes.each do |cause|
          list.push(Tools::Stringifier.to_h(obj: cause, class_prefix: 'Zakuro'))
        end

        JSON.generate(list)
      end
    end
  end
end
