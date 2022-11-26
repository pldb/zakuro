# frozen_string_literal: true

require 'yaml'
require_relative '../../era/western/calendar'

# :nodoc:
module Zakuro
  #
  # Operation 運用
  #
  module Operation
    #
    # Validator バリデーション
    #
    module Validator
      #
      # Types 型判定
      #
      module Types
        EMPTY_STRING = '-'
        BOOLEANS = %w[true false].freeze

        class << self
          #
          # 有効文字列か
          #
          # @param [String] str 対象文字列
          #
          # @return [True] 有効
          # @return [False] 無効
          #
          def string?(str: '')
            return false if str == ''

            return false unless str

            str.is_a?(String)
          end

          #
          # 有効文字列（空文字許容）か
          #
          # @param [String] str 対象文字列
          #
          # @return [True] 有効
          # @return [False] 無効
          #
          def empiable_string?(str: '')
            return false unless str

            str.is_a?(String)
          end

          #
          # 正数か
          #
          # @param [String] str 対象文字列
          #
          # @return [True] 正数
          # @return [False] 負数
          #
          def positive?(str: '')
            return true if str == EMPTY_STRING

            return false unless str

            /^[0-9]+$/.match?(str)
          end

          #
          # 数値か
          #
          # @param [String] str 対象文字列
          #
          # @return [True] 数値
          # @return [False] 非数値
          #
          def num?(str: '')
            return true if str == EMPTY_STRING

            return false unless str

            /^[-0-9]+$/.match?(str)
          end

          #
          # booleanか
          #
          # @param [String] str 対象文字列
          #
          # @return [True] boolean
          # @return [False] 非boolean
          #
          def bool?(str: '')
            BOOLEANS.include?(str)
          end

          #
          # boolean（空許容）か
          #
          # @param [String] str 対象文字列
          #
          # @return [True] boolean
          # @return [False] 非boolean
          #
          def empiable_bool?(str: '')
            return true if str == EMPTY_STRING

            bool?(str: str)
          end

          #
          # 月差分か
          #
          # @param [String] str 対象文字列
          #
          # @return [True] 有効
          # @return [False] 無効
          #
          def month_days?(str: '')
            return true if str == EMPTY_STRING

            return false unless str

            /^[大小]$/.match?(str)
          end

          #
          # 西暦日か
          #
          # @param [String] str 対象文字列
          #
          # @return [True] 有効
          # @return [False] 無効
          #
          def western_date?(str: '')
            return Western::Calendar.new if str == EMPTY_STRING

            # 1316-11-16/1317-4-13
            dates = str.split('/')
            dates.each do |date|
              return true if Western::Calendar.valid_date_text(text: date)
            end

            false
          end
        end
      end

      # :reek:TooManyInstanceVariables { max_instance_variables: 5 }

      #
      # MonthHistory 変更履歴
      #
      class MonthHistory
        # @return [Integer] 連番
        attr_reader :index
        # @return [String] ID
        attr_reader :id
        # @return [String] 親ID
        attr_reader :parent_id
        # @return [String] 西暦日
        attr_reader :western_date
        # @return [String] 有効行
        attr_reader :modified

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Hash<String, String>] yaml_hash yaml
        # @option yaml_hash [String] :id ID
        # @option yaml_hash [String] :parent_id 親ID
        # @option yaml_hash [String] :western_date 西暦日
        # @option yaml_hash [String] :modified 有効行
        #
        def initialize(index:, yaml_hash: {})
          @index = index
          @id = yaml_hash['id']
          @parent_id = yaml_hash['parent_id']
          @western_date = yaml_hash['western_date']
          @modified = yaml_hash['modified']
        end

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 検証する
        #
        # @return [Array<String>] エラーメッセージ
        #
        def validate
          failed = []

          prefix = "[#{@index}] invalid"

          failed.push("#{prefix} 'id'. #{@id}") unless id?

          failed.push("#{prefix} 'parent_id'. #{@id}") unless parent_id?

          failed.push("#{prefix} 'western_date'. #{@western_date}") unless western_date?

          failed.push("#{prefix} 'modified'. #{@modified}") unless modified?

          failed
        end

        def id?
          Types.string?(str: @id)
        end

        def parent_id?
          Types.string?(str: @parent_id)
        end

        def western_date?
          Types.western_date?(str: @western_date)
        end

        def modified?
          Types.bool?(str: @modified)
        end
      end

      #
      # Annotation 注釈
      #
      class Annotation
        # @return [Integer] 連番
        attr_reader :index
        # @return [String] ID
        attr_reader :id
        # @return [String] 注釈内容
        attr_reader :description
        # @return [String] 補足
        attr_reader :note

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Hash<String, String>] yaml_hash yaml
        # @option yaml_hash [String] :id ID
        # @option yaml_hash [String] :description 注釈内容
        # @option yaml_hash [String] :note 補足
        #
        def initialize(index:, yaml_hash: {})
          @index = index
          @id = yaml_hash['id']
          @description = yaml_hash['description']
          @note = yaml_hash['note']
        end

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 検証する
        #
        # @return [Array<String>] エラーメッセージ
        #
        def validate
          failed = []

          prefix = "[#{@index}] invalid"

          failed.push("#{prefix} 'id'. #{@id}") unless id?

          failed.push("#{prefix} 'description'. #{@description}") unless description?

          failed.push("#{prefix} 'note'. #{@note}") unless note?

          failed
        end

        def id?
          Types.string?(str: @id)
        end

        def description?
          Types.empiable_string?(str: @description)
        end

        def note?
          Types.string?(str: @note)
        end
      end

      #
      # Reference 参照
      #
      class Reference
        # @return [Integer] 連番
        attr_reader :index
        # @return [String] 原文頁数
        attr_reader :page
        # @return [String] 原文注釈番号
        attr_reader :number
        # @return [String] 和暦日
        attr_reader :japan_date

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Hash<String, String>] yaml_hash yaml
        # @option yaml_hash [String] :page 原文頁数
        # @option yaml_hash [String] :number 原文注釈番号
        # @option yaml_hash [String] :japan_date 和暦日
        #
        def initialize(index:, yaml_hash: {})
          @index = index
          @page = yaml_hash['page']
          @number = yaml_hash['number']
          @japan_date = yaml_hash['japan_date']
        end

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 検証する
        #
        # @return [Array<String>] エラーメッセージ
        #
        def validate
          failed = []

          prefix = "[#{@index}] invalid"

          failed.push("#{prefix} 'page'. #{@page}") unless page?

          failed.push("#{prefix} 'number'. #{@number}") unless number?

          failed.push("#{prefix} 'japan_date'. #{@japan_date}") unless japan_date?

          failed
        end

        def page?
          Types.positive?(str: @page)
        end

        def number?
          Types.positive?(str: @number)
        end

        def japan_date?
          Types.string?(str: @japan_date)
        end
      end

      #
      # Diffs 総差分
      #
      class Diffs
        # @return [Integer] 連番
        attr_reader :index
        # @return [Hash] 月差分
        attr_reader :month
        # @return [Hash] 二十四節気差分
        attr_reader :solar_term
        # @return [String] 日差分
        attr_reader :days

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Hash] yaml_hash yaml
        # @option yaml_hash [Hash] :month 月差分
        # @option yaml_hash [Hash] :solar_term 二十四節気差分
        # @option yaml_hash [String] :days 日差分
        #
        def initialize(index:, yaml_hash: {})
          @index = index
          @month = Month.new(index: index, yaml_hash: yaml_hash['month'])
          @solar_term = SolarTerm::Direction.new(index: index, yaml_hash: yaml_hash['solar_term'])
          @days = yaml_hash['days']
        end

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 検証する
        #
        # @return [Array<String>] エラーメッセージ
        #
        def validate
          failed = []

          prefix = "[#{@index}] invalid"

          failed += month.validate

          failed += solar_term.validate

          failed.push("#{prefix} 'days'. #{@days}") unless days?

          failed
        end

        def days?
          Types.num?(str: @days)
        end
      end

      #
      # Month 月
      #
      class Month
        # @return [Integer] 連番
        attr_reader :index
        # @return [Hash] 月差分
        attr_reader :number
        # @return [Hash] 閏有無差分
        attr_reader :leaped
        # @return [String] 中気差分
        attr_reader :days

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Hash<String, Object>] yaml_hash yaml
        # @option yaml_hash [Hash] :number 月差分
        # @option yaml_hash [Hash] :leaped 閏有無差分
        # @option yaml_hash [String] :days 中気差分
        #
        def initialize(index:, yaml_hash: {})
          @index = index
          @number = Number.new(index: index, yaml_hash: yaml_hash['number'])
          @leaped = Leaped.new(index: index, yaml_hash: yaml_hash['leaped'])
          @days = Days.new(index: index, yaml_hash: yaml_hash['days'])
        end

        #
        # 検証する
        #
        # @return [Array<String>] エラーメッセージ
        #
        def validate
          failed = []

          failed += number.validate

          failed += leaped.validate

          failed += days.validate

          failed
        end
      end

      module SolarTerm
        #
        # Direction 二十四節気（移動）
        #
        class Direction
          # @return [Integer] 連番
          attr_reader :index
          # @return [Source] 移動元
          attr_reader :source
          # @return [Destination] 移動先
          attr_reader :destination
          # @return [String] 中気差分
          attr_reader :days

          #
          # 初期化
          #
          # @param [Integer] index 連番
          # @param [Hash<String, Object>] yaml_hash yaml
          # @option yaml_hash [Hash] :src 移動元
          # @option yaml_hash [Hash] :dest 移動先
          # @option yaml_hash [String] :days 中気差分
          #
          def initialize(index:, yaml_hash: {})
            @index = index
            @source = Source.new(diff_index: index, yaml_hash: yaml_hash['src'])
            @destination = Destination.new(diff_index: index, yaml_hash: yaml_hash['dest'])
            @days = yaml_hash['days']
          end

          def days?
            Types.positive?(str: days)
          end

          # :reek:TooManyStatements { max_statements: 6 }

          #
          # 検証する
          #
          # @return [Array<String>] エラーメッセージ
          #
          def validate
            failed = []

            prefix = "[#{index}][solar_term] invalid"

            failed += source.validate

            failed += destination.validate

            failed.push("#{prefix} 'days'. #{@days}") unless days?

            failed
          end
        end

        #
        # Source 二十四節気（移動元）
        #
        class Source
          # @return [Integer] 連番
          attr_reader :diff_index
          # @return [String] 移動対象の二十四節気番号
          attr_reader :index
          # @return [String] 移動先の月初日
          attr_reader :to
          # @return [String] 十干十二支
          attr_reader :zodiac_name

          #
          # 初期化
          #
          # @param [Integer] diff_index 連番
          # @param [Hash<String, String>] yaml_hash yaml
          # @option yaml_hash [String] :index 移動対象の二十四節気番号
          # @option yaml_hash [String] :to 移動先の月初日
          # @option yaml_hash [String] :zodiac_name 十干十二支
          #
          def initialize(diff_index:, yaml_hash: {})
            @diff_index = diff_index
            @index = yaml_hash['index']
            @to = yaml_hash['to']
            @zodiac_name = yaml_hash['zodiac_name']
          end

          # :reek:TooManyStatements { max_statements: 6 }

          #
          # 検証する
          #
          # @return [Array<String>] エラーメッセージ
          #
          def validate
            failed = []

            prefix = "[#{diff_index}][solar_term.src] invalid"

            failed.push("#{prefix} 'index'. #{index}") unless index?

            failed.push("#{prefix} 'to'. #{to}") unless to?

            failed.push("#{prefix} 'zodiac_name'. #{zodiac_name}") unless zodiac_name?

            failed
          end

          def index?
            Types.positive?(str: index)
          end

          def to?
            Types.western_date?(str: to)
          end

          def zodiac_name?
            Types.string?(str: zodiac_name)
          end
        end

        #
        # Destination 二十四節気（移動先）
        #
        class Destination
          # @return [Integer] 連番
          attr_reader :diff_index
          # @return [String] 移動対象の二十四節気番号
          attr_reader :index
          # @return [String] 移動元の月初日
          attr_reader :from
          # @return [String] 十干十二支
          attr_reader :zodiac_name

          #
          # 初期化
          #
          # @param [Integer] diff_index 連番
          # @param [Hash<String, String>] yaml_hash yaml
          # @option yaml_hash [String] :index 移動対象の二十四節気番号
          # @option yaml_hash [String] :from 移動元の月初日
          # @option yaml_hash [String] :zodiac_name 十干十二支
          #
          def initialize(diff_index:, yaml_hash: {})
            @diff_index = diff_index
            @index = yaml_hash['index']
            @from = yaml_hash['from']
            @zodiac_name = yaml_hash['zodiac_name']
          end

          # :reek:TooManyStatements { max_statements: 6 }

          #
          # 検証する
          #
          # @return [Array<String>] エラーメッセージ
          #
          def validate
            failed = []

            prefix = "[#{diff_index}][solar_term.dest] invalid"

            failed.push("#{prefix} 'index'. #{index}") unless index?

            failed.push("#{prefix} 'from'. #{from}") unless from?

            failed.push("#{prefix} 'zodiac_name'. #{zodiac_name}") unless zodiac_name?

            failed
          end

          def index?
            Types.positive?(str: index)
          end

          def from?
            Types.western_date?(str: from)
          end

          def zodiac_name?
            Types.string?(str: zodiac_name)
          end
        end
      end

      #
      # Number 月
      #
      class Number
        NAME = 'number'

        # @return [Integer] 連番
        attr_reader :index
        # @return [String] 移動元
        attr_reader :src
        # @return [String] 移動先
        attr_reader :dest

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Hash<String, String>] yaml_hash yaml
        # @option yaml_hash [String] :src 移動元
        # @option yaml_hash [String] :dest 移動先
        #
        def initialize(index:, yaml_hash: {})
          @index = index
          @src = yaml_hash['src']
          @dest = yaml_hash['dest']
        end

        #
        # 検証する
        #
        # @return [Array<String>] エラーメッセージ
        #
        def validate
          failed = []

          prefix = "[#{index}][#{NAME}] invalid"

          failed.push("#{prefix} 'src'. #{src}") unless src?

          failed.push("#{prefix} 'dest'. #{dest}") unless dest?

          failed
        end

        def src?
          Types.positive?(str: src)
        end

        def dest?
          Types.positive?(str: dest)
        end
      end

      #
      # Leaped 閏有無
      #
      class Leaped
        NAME = 'leaped'

        # @return [Integer] 連番
        attr_reader :index
        # @return [String] 移動元
        attr_reader :src
        # @return [String] 移動先
        attr_reader :dest

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Hash<String, String>] yaml_hash yaml
        # @option yaml_hash [String] :src 移動元
        # @option yaml_hash [String] :dest 移動先
        #
        def initialize(index:, yaml_hash: {})
          @index = index
          @src = yaml_hash['src']
          @dest = yaml_hash['dest']
        end

        #
        # 検証する
        #
        # @return [Array<String>] エラーメッセージ
        #
        def validate
          failed = []

          prefix = "[#{index}][#{NAME}] invalid"

          failed.push("#{prefix} 'src'. #{src}") unless src?

          failed.push("#{prefix} 'dest'. #{dest}") unless dest?

          failed
        end

        def src?
          Types.empiable_bool?(str: src)
        end

        def dest?
          Types.empiable_bool?(str: dest)
        end
      end

      #
      # Days 月日数（大小）
      #
      class Days
        NAME = 'days'

        # @return [Integer] 連番
        attr_reader :index
        # @return [String] 移動元
        attr_reader :src
        # @return [String] 移動先
        attr_reader :dest

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Hash<String, String>] yaml_hash yaml
        # @option yaml_hash [String] :src 移動元
        # @option yaml_hash [String] :dest 移動先
        #
        def initialize(index:, yaml_hash: {})
          @index = index
          @src = yaml_hash['src']
          @dest = yaml_hash['dest']
        end

        #
        # 検証する
        #
        # @return [Array<String>] エラーメッセージ
        #
        def validate
          failed = []

          prefix = "[#{index}][#{NAME}] invalid"

          failed.push("#{prefix} 'src'. #{src}") unless src?

          failed.push("#{prefix} 'dest'. #{dest}") unless dest?

          failed
        end

        def src?
          Types.month_days?(str: src)
        end

        def dest?
          Types.month_days?(str: dest)
        end
      end

      # :reek:TooManyStatements { max_statements: 7 }

      class << self
        def run(yaml_hash: {})
          failed = []
          yaml_hash.each_with_index do |history, index|
            failed += MonthHistory.new(index: index, yaml_hash: history).validate
            failed += Annotation.new(index: index, yaml_hash: history).validate
            failed += Reference.new(index: index, yaml_hash: history).validate
            failed += Diffs.new(index: index, yaml_hash: history['diffs']).validate
          end

          failed
        end
      end
    end
  end
end
