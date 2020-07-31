# frozen_string_literal: true

require_relative './era/japan'
require_relative './era/western'
require_relative './version/genka/genka'
require_relative './version/gihou/gihou'
require_relative './version/taien/taien'
require_relative './version/senmyou/senmyou'
require_relative './version/joukyou/joukyou'
require_relative './version/houryaku/houryaku'
require_relative './version/kansei/kansei'
require_relative './version/tenpou/tenpou'
require_relative './version/gregorio/gregorio'

# :nodoc:
module Zakuro
  #
  # VersionFactory 暦生成
  #
  class VersionFactory
    # :reek:TooManyStatements { max_statements: 6 }
    # :reek:UncommunicativeVariableName {accept: e}

    #
    # 実行可能な暦を取得する
    #
    # @param [Date] date 西暦日
    #
    # @return [AbstractVersion] 暦クラス
    #
    def self.get_runnable_constant(date:)
      class_name = Japan::Reki.class_name(
        date: Western::Calendar.create(date: date)
      )
      constant = Object.const_get(class_name)
      raise ArgumentError, 'unreleased version' unless constant::RELEASE

      constant
    rescue StandardError => e
      raise e
    end

    # :reek:UncommunicativeVariableName {accept: e}

    #
    # 西暦日から和暦日に変換する
    #
    # @param [Date] western_date 西暦日
    #
    # @return [Result::SingleDay] 和暦日
    #
    def self.to_japan_date(western_date:)
      runnable = VersionFactory.get_runnable_constant(date: western_date)
      runnable.to_japan_date(western_date: western_date)
    rescue StandardError => e
      raise ZakuroError, e.message
    end
  end
end
