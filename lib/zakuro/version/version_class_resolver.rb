# frozen_string_literal: true

require_relative './genka/cycle/remainder'
require_relative './genka/cycle/solar_term'
require_relative './genka/range/annual_range'
require_relative './genka/option/dropped_date/parameter'

require_relative './gihou/cycle/remainder'
require_relative './gihou/cycle/solar_term'
require_relative './gihou/range/annual_range'
require_relative './gihou/option/dropped_date/parameter'

require_relative './daien/cycle/remainder'
require_relative './daien/cycle/solar_term'
require_relative './daien/range/annual_range'
require_relative './daien/option/dropped_date/parameter'

require_relative './senmyou/cycle/remainder'
require_relative './senmyou/cycle/solar_term'
require_relative './senmyou/range/annual_range'
require_relative './senmyou/option/dropped_date/parameter'

# :nodoc:
module Zakuro
  #
  # VersionClassResolver 暦リゾルバー
  #
  class VersionClassResolver
    # @return [String] 暦名
    attr_reader :version_name

    # @return [Hash<String, String>] 関連
    CLASSES = {
      'remainder' => 'Zakuro::$VERSION::Cycle::Remainder',
      'solar_term' => 'Zakuro::$VERSION::Cycle::SolarTerm',
      'annual_range' => 'Zakuro::$VERSION::Range::AnnualRange',
      'dropped_date_parameter' => 'Zakuro::$VERSION::Option::DroppedDate::Parameter',
    }.freeze

    #
    # 初期化
    #
    # @param [String] version_name 暦名
    #
    def initialize(version_name:)
      @version_name = version_name
    end

    #
    # 該当の暦のクラスを取得する
    #
    # @param [String] version_name 暦名
    # @param [String] class_name クラス名
    #
    # @return [Object] 該当クラス
    #
    # @raise [ArgumentError] 引数エラー
    #
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

    #
    # 没日引数を返す
    #
    # @return [Class] 没日引数クラス
    #
    def dropped_date_parameter
      VersionClassResolver.get_class(
        version_name: @version_name, class_name: 'dropped_date_parameter'
      )
    end
  end
end
