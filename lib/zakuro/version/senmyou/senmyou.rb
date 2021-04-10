# frozen_string_literal: true

require 'date'
require_relative '../abstract_version'
require_relative '../../era/western'
require_relative 'summary/single'

# :nodoc:
module Zakuro
  #
  # Senmyou 宣明暦
  #
  module Senmyou
    #
    # Gateway アクセサメソッド群
    #
    class Gateway < AbstractVersion
      # @return [True] リリースあり
      RELEASE = true

      #
      # 西暦日から和暦日に変換する
      #
      # @param [Date] western_date 西暦日
      #
      # @return [Result::SingleDay] 和暦日
      #
      def self.to_japan_date(western_date:)
        date = Western::Calendar.create(date: western_date)
        Single.get(date: date)
      end
    end
  end
end
