# frozen_string_literal: true

require_relative '../version/genka/cycle/remainder'
require_relative '../version/genka/cycle/solar_term'
require_relative '../version/genka/range/annual_range'
require_relative '../version/genka/option/dropped_date/parameter'
require_relative '../version/genka/option/vanished_date/parameter'

require_relative '../version/gihou/cycle/remainder'
require_relative '../version/gihou/cycle/solar_term'
require_relative '../version/gihou/range/annual_range'
require_relative '../version/gihou/option/dropped_date/parameter'
require_relative '../version/gihou/option/vanished_date/parameter'

require_relative '../version/daien/cycle/remainder'
require_relative '../version/daien/cycle/solar_term'
require_relative '../version/daien/range/annual_range'
require_relative '../version/daien/option/dropped_date/parameter'
require_relative '../version/daien/option/vanished_date/parameter'

require_relative '../version/senmyou/cycle/remainder'
require_relative '../version/senmyou/cycle/solar_term'
require_relative '../version/senmyou/range/annual_range'
require_relative '../version/senmyou/option/dropped_date/parameter'
require_relative '../version/senmyou/option/vanished_date/parameter'

# :nodoc:
module Zakuro
  # :nodoc:
  module Context
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
        'vanished_date_parameter' => 'Zakuro::$VERSION::Option::VanishedDate::Parameter'
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
      # 大余小余（暦別）クラスを返す
      #
      # @return [Class] 大余小余（暦別）クラス
      #
      def remainder
        self.class.get_class(version_name: @version_name, class_name: 'remainder')
      end

      #
      # 二十四節気クラスを返す
      #
      # @return [Class] 二十四節気クラス
      #
      def solar_term
        self.class.get_class(version_name: @version_name, class_name: 'solar_term')
      end

      #
      # 年間範囲クラスを返す
      #
      # @return [Class] 年間範囲クラス
      #
      def annual_range
        self.class.get_class(version_name: @version_name, class_name: 'annual_range')
      end

      #
      # 没日引数を返す
      #
      # @return [Class] 没日引数クラス
      #
      def dropped_date_parameter
        self.class.get_class(
          version_name: @version_name, class_name: 'dropped_date_parameter'
        )
      end

      #
      # 滅日引数を返す
      #
      # @return [Class] 没日引数クラス
      #
      def vanished_date_parameter
        self.class.get_class(
          version_name: @version_name, class_name: 'vanished_date_parameter'
        )
      end

      class << self
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
        def get_class(version_name:, class_name:)
          constant = CLASSES.fetch(class_name, '')

          raise ArgumentError.new, 'invalid class name' if constant == ''

          resolved_constant = constant.gsub('$VERSION', version_name)

          Object.const_get(resolved_constant)
        end
      end
    end
  end
end
