# frozen_string_literal: true

require_relative '../../../era/western'
require_relative 'annual_data'
require_relative '../../../output/response'
require_relative '../base/era'
require_relative '../base/gengou'
require_relative '../base/year'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # GengouData 元号の年情報
    #
    module GengouData
      def self.get_ancient_date(date: Western::Calendar.new)
        SingleDay.get_ancient_date(date: date)
      end

      #
      # SingleDay 1日データ
      #
      module SingleDay
        #
        # 1日データを取得する
        #
        # @param [Western::Calendar] date 年月日情報（西暦）
        #
        # @return [Response::SingleDay] 1日データ
        #
        def self.get_ancient_date(date: Western::Calendar.new)
          raise ArgumentError, 'invalid senmyou date' unless Era.include?(date: date)

          target = get_target(year_list: get_year_list(date: date), date: date)

          Response::SingleDay.save_single_day(
            param: Response::SingleDay::Param.new(
              year: target.year, month: target.month,
              date: target.date, days: target.days
            )
          )
        end

        #
        # Target 対象
        #
        class Target
          # @return [Year] 年
          attr_reader :year
          # @return [Month] 月
          attr_reader :month
          # @return [Western::Calendar] 日
          attr_reader :date
          # @return [Integer] 月初からの日数
          attr_reader :days

          #
          # 初期化
          #
          # @param [Year] year 年
          # @param [Month] month 月
          # @param [Western::Calendar] date 日
          # @param [Integer] days 月初からの日数
          #
          def initialize(year:, month:, date:, days:)
            @year = year
            @month = month
            @date = date
            @days = days
          end
        end

        #
        # MonthSearchResult 1年内に該当する月を検索した結果
        #
        class MonthSearchResult
          # @return [Month] 月
          attr_reader :target_month
          # @return [Western::Calendar] 月初日
          attr_reader :first_date
          # @return [True] 該当データ引き当て済
          # @return [False] 該当データ引き当てなし
          attr_reader :breaked

          #
          # 初期化
          #
          # @param [Month] target_month 月
          # @param [Western::Calendar] first_date 月初日
          # @param [True, False] breaked 該当データ引き当て
          #
          def initialize(target_month: Month.new,
                         first_date: Western::Calendar.new, breaked:)
            @target_month = target_month
            @first_date = first_date
            @breaked = breaked
          end
        end

        #
        # 指定日に関連する暦の範囲だけ年データを生成する
        #
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Array<Year>] 年データ
        #
        def self.get_year_list(date:)
          # 元号の最初の年月日を取る
          gengou = Gengou.new(date: date.clone)

          # 南北朝には元号が2つ並び、必ずしも範囲が重ならないケースもある
          # 対象日付に重なる元号から論理和の範囲を取り、処理漏れがないようにする
          start_date = gengou.first_date.clone
          # 最後の年は翌年から今年の冬至を求めるため範囲を1年広げる
          newest_date = gengou.choise_newest_gengou_date.next_year

          Series.get_year_list(
            start_gengou: gengou, start_date: start_date, end_date: newest_date
          )
        end

        #
        # 対象を引き当てる
        #
        # @param [Array<Year>] year_list 年データ
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Target] 対象
        #
        def self.get_target(year_list:, date:)
          # 対象年/対象月を引き当てる
          year_list.each do |year|
            result = get_target_month(date: date, year: year)

            next unless result.breaked

            return Target.new(
              year: year, month: result.target_month, date: date,
              # 対象日に調整する
              days: date - result.first_date
            )
          end

          raise ArgumentError, "invalid range: #{date.format}"
        end

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 対象の月を引き当てる
        #
        # @param [Western::Calendar] date 西暦日
        # @param [Year] year 年
        #
        # @return [MonthSearchResult] 1年内に該当する月を検索した結果
        #
        def self.get_target_month(date:, year:)
          first_date = year.gengou.first_date.clone
          year.months.each do |month|
            # 月末の日付を超える場合
            next_first_date = first_date.clone + month.days
            if date < next_first_date
              return MonthSearchResult.new(target_month: month,
                                           first_date: first_date, breaked: true)
            end
            first_date = next_first_date
          end
          MonthSearchResult.new(breaked: false)
        end
      end

      #
      # Series 和暦時系列データ
      #
      module Series
        # :reek:TooManyInstanceVariables { max_instance_variables: 6 }

        #
        # TimeAdvance 時間進行
        #
        class TimeAdvance
          #
          # 初期化
          #
          # @param [Gengou] start_gengou 開始元号
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] end_date 終了日
          #
          def initialize(start_gengou:, start_date:, end_date:)
            @current_date = start_date.clone
            @end_date = end_date
            @year_list = []
            @western_year = start_date.year
            @year = Year.new(gengou: start_gengou)
          end

          #
          # 年データを収集する
          #
          # @return [Array<Year>] 年データ
          #
          def collect_year_list
            push_current_year

            # 2年目以降
            while @current_date <= @end_date
              compensate_last_year

              push_current_year
            end

            @year_list
          end

          private

          #
          # 1年データを収集する
          #
          # @return [Array<Month>] 1年データ
          #
          def collect_annual_data
            AnnualData.collect_annual_data_after_last_november_1st(
              western_year: @western_year
            )
          end

          #
          # 昨年データの不足分を補完する
          # 昨年11月1日から今年1月1日の前日のデータを1年前データとする
          #
          # @return [<Type>] <description>
          #
          def compensate_last_year
            last_year = @year_list[@year_list.size - 1]
            collect_annual_data.each do |month|
              next unless month.is_last_year

              # 昨年の月データのみ
              last_year.push(month: month)
              @current_date += month.days
            end
          end

          # :reek:TooManyStatements { max_statements: 7 }

          #
          # 当年データを生成する
          #
          def push_current_year
            next_year
            collect_annual_data.each do |month|
              next if month.is_last_year

              @year.push(month: month)
              @current_date += month.days
            end
            @year_list.push(@year)

            @western_year += 1
          end

          #
          # 次の元号年を取得する
          #
          def next_year
            return if @year_list.empty?

            @year = Year.new(gengou: @year.gengou.next_year)
          end
        end

        #
        # 期間内の年データ全てを返す
        #
        # @param [Gengou] start_gengou 開始元号
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] end_date 終了日
        #
        # @return [Array<Year>] 年データ
        #
        def self.get_year_list(start_gengou:, start_date:, end_date:)
          advance = TimeAdvance.new(
            start_gengou: start_gengou, start_date: start_date, end_date: end_date
          )

          advance.collect_year_list
        end
      end
    end
  end
end
