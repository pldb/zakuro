# frozen_string_literal: true

require_relative './senmyou/cycle/remainder'
require_relative './senmyou/cycle/solar_term'
require_relative './senmyou/range/annual_range'

# :nodoc:
module Zakuro
  #
  # VersionClassResolver 暦リゾルバー
  #
  class VersionClassResolver
    attr_reader :version_name

    CLASSES = {
      'remainder' => 'Zakuro::$VERSION::Remainder',
      'solar_term' => 'Zakuro::$VERSION::SolarTerm',
      'annual_range' => 'Zakuro::$VERSION::AnnualRange'
    }.freeze

    def initialize(version_name:)
      @version_name = version_name
    end

    def self.get_class(version_name:, class_name:)
      constant = CLASSES.fetch(class_name, '')

      raise ArgumentError.new, 'invalid class name' if constant == ''

      resolved_constant = constant.gsub('$VERSION', version_name)

      Object.const_get(resolved_constant)
    end

    #
    # 大余小余（暦別）クラスを返す
    #
    # @return [Class] 大余小余（暦別）クラス
    #
    def remainder
      VersionClassResolver.get_class(version_name: @version_name, class_name: 'remainder')
    end

    #
    # 二十四節気クラスを返す
    #
    # @return [Class] 二十四節気クラス
    #
    def solar_term
      VersionClassResolver.get_class(version_name: @version_name, class_name: 'solar_term')
    end

    #
    # 年間範囲クラスを返す
    #
    # @return [Class] 年間範囲クラス
    #
    def annual_range
      VersionClassResolver.get_class(version_name: @version_name, class_name: 'annual_range')
    end
  end
end
