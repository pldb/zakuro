# frozen_string_literal: true

require_relative '../../../../../era/japan/gengou'
require_relative '../../../../../era/japan/calendar'
require_relative '../../../../../era/western/calendar'

require_relative '../counter'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # :nodoc:
      module Reserve
        # List
        #
        # 予約元号一覧
        #
        class List
          # TODO: refactor

          # @return [Integer] 不正年
          INVALID_YEAR = -1
          # @return [Integer] 最大試行数
          MAX_SEARCH_COUNT = 10_000
          # @return [Integer] 最大月日数
          MAX_MONTH_DAYS = 30

          # @return [Symbol] メソッド名
          attr_reader :method_name
          # @return [Western::Calendar] 開始日
          attr_reader :start_date
          # @return [Western::Calendar] 終了日
          attr_reader :end_date
          # @return [Array<Japan::Gengou>] 予約元号一覧
          attr_reader :list

          #
          # 初期化
          #
          # @param [True, False] first true:1行目元号, false:2行目元号
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] end_date 終了日
          #
          def initialize(first: true, start_date: Western::Calendar.new,
                         end_date: Western::Calendar)
            @method_name = first ? :first_line : :second_line
            @start_date = start_date
            @end_date = end_date
            @list = []

            update
          end

          #
          # 元号を取得する
          #
          # @param [Western::Calendar] western_date 西暦日
          #
          # @return [Gengou::Counter] 加算元号
          #
          def get(western_date: Western::Calendar.new)
            @list.each do |gengou|
              if gengou.include?(date: western_date)
                return Gengou::Counter.new(gengou: gengou).clone
              end
            end

            Gengou::Counter.new
          end

          #
          # 範囲内元号を取得する
          #
          #   次のパターンが考えられる
          #   1. 元号の開始日から終了日まで該当元号なし（無効な元号）
          #   2. 元号の開始日までは該当元号なし（無効な元号、開始日以降の元号）
          #   3. 元号の開始日と月初日が合致し、末日まで同一元号（開始日以降の元号のみ）
          #   4. 月の途中で有効な元号が切り替わる（有効な元号、有効な元号...）
          #   5. 途中から該当元号なし（開始日以降の元号、無効な元号）
          #
          # FIXME: 有効な元号、無効な元号、有効な元号のようなストライプのパターンに対応していない
          #
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] end_date 西暦終了日
          #
          # @return [Array<Gengou::Counter>] 範囲内元号
          #
          def collect(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
            result = []

            # 開始チェック
            current_gengou = get(western_date: start_date)
            result.push(current_gengou)

            ## 範囲内に次の有効元号があるか
            if current_gengou.invalid?
              current_gengou = proceed(western_date: start_date)

              return result if suspend?(current_gengou: current_gengou, end_date: end_date)

              result.push(current_gengou)
            end

            return result if suspend?(current_gengou: current_gengou, end_date: end_date)

            # 有効元号チェック
            continue(result: result, current_date: current_gengou.western_end_date.clone,
                     end_date: end_date)
          end

          #
          # 元号を進めて取得する
          #
          # @param [Western::Calendar] western_date 西暦日
          #
          # @return [Gengou::Counter] 加算元号
          #
          def proceed(western_date: Western::Calendar.new)
            current_gengou = get(western_date: western_date)

            # 無効な元号
            if current_gengou.invalid?
              @list.each do |gengou|
                next if gengou.invalid?

                # すでに超過している場合
                break if western_date > gengou.end_date

                return Gengou::Counter.new(gengou: gengou).clone
              end

              return Gengou::Counter.new
            end

            # 有効な元号
            proceed_valid_gengou(current_gengou: current_gengou)
          end

          #
          # 有効な元号を進めて取得する
          #
          # @param [Gengou::Counter] current_gengou 加算元号
          #
          # @return [Gengou::Counter] 加算元号
          #
          def proceed_valid_gengou(current_gengou:)
            @list.each do |gengou|
              next if gengou.invalid?

              if gengou.both_start_date.western > current_gengou.western_end_date
                return Gengou::Counter.new(gengou: gengou).clone
              end
            end

            Gengou::Counter.new
          end

          #
          # 和暦開始日を取得する
          #
          # @return [Japan::Calendar] 和暦開始日
          #
          def japan_start_date
            return Japan::Calendar.new if invalid?

            @list[0].both_start_date.japan.clone
          end

          #
          # 西暦開始日を取得する
          #
          # @return [Western::Calendar] 西暦開始日
          #
          def western_start_date
            return Western::Calendar.new if invalid?

            @list[0].both_start_date.western.clone
          end

          #
          # 西暦開始年を取得する
          #
          # @return [Integer] 西暦開始年
          #
          def western_start_year
            return INVALID_YEAR if invalid?

            @list[0].both_start_year.western.clone
          end

          #
          # 西暦終了年を取得する
          #
          # @return [Integer] 西暦終了年
          #
          def western_end_year
            return INVALID_YEAR if invalid?

            return INVALID_YEAR if @list.size.zero?

            @list[-1].end_year
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            return true unless @list

            return true if @list.size.zero?

            false
          end

          private

          #
          # 予約元号一覧を更新する
          #
          def update
            result = internal

            return result if result.size.zero?

            prev_gengou(list: result)

            next_gengou(list: result)

            @list = result
          end

          #
          # 開始日・終了日に対応する予約元号一覧を取得する
          #
          # @return [Array<Japan::Gengou>] 予約元号一覧
          #
          def internal
            current_gengou = line(date: start_date)
            result = []

            return result if current_gengou.invalid?

            result.push(current_gengou)
            (0..MAX_SEARCH_COUNT).each do |_index|
              current_end_date = current_gengou.end_date.clone
              break if current_end_date > end_date

              current_gengou = line(date: current_end_date + 1)
              result.push(current_gengou)
            end

            result
          end

          #
          # 前の元号を設定する
          #
          # @note 開始日の30日前に前の元号がある場合は、前の元号を設定する
          #
          # @param [Array<Japan::Gengou>] list 元号一覧
          #
          def prev_gengou(list:)
            return unless list

            return if list.size.zero?

            first_gengou_date = list[0].both_start_date.western.clone

            border_date = start_date.clone - MAX_MONTH_DAYS

            return if first_gengou_date < border_date

            gengou = line(date: first_gengou_date - 1)

            return if gengou.invalid?

            list.unshift(gengou)
          end

          #
          # 次の元号を設定する
          #
          # @note 開始日の30日後に次の元号がある場合は、次の元号を設定する
          #
          # @param [Array<Japan::Gengou>] list 元号一覧
          #
          def next_gengou(list:)
            return unless list

            return if list.size.zero?

            last_gengou_date = list[-1].end_date.clone

            border_date = end_date.clone + MAX_MONTH_DAYS

            return if border_date < last_gengou_date

            gengou = line(date: last_gengou_date + 1)

            return if gengou.invalid?

            list.push(gengou)
          end

          #
          # 元号
          #
          # @param [Western::Calendar] date 日付
          #
          # @return [Japan::Gengou] 元号
          #
          def line(date:)
            List.send(method_name, **{ date: date })
          end

          #
          # 有効元号を継続する
          #
          # @param [Array<Gengou::Counter>] result 範囲内元号
          # @param [Gengou::Counter] current_gengou 現在元号
          # @param [Western::Calendar] end_date 終了日
          #
          # @return [Array<Gengou::Counter>] 範囲内元号
          #
          def continue(result:, current_date:, end_date:)
            (0..MAX_SEARCH_COUNT).each do |_index|
              current_gengou = proceed(western_date: current_date)

              return result if suspend?(current_gengou: current_gengou, end_date: end_date)

              # 範囲内元号
              result.push(current_gengou)

              current_date = current_gengou.western_end_date.clone
            end

            # 終了
            result
          end

          #
          # 中断する
          #
          # @param [Gengou::Counter] current_gengou 現在元号
          # @param [Western::Calendar] end_date 終了日
          #
          # @return [True] 中断
          # @return [False] 継続
          #
          def suspend?(current_gengou:, end_date:)
            ## 有効元号なし
            return true if current_gengou.invalid?

            ## 範囲内元号なし
            return true if current_gengou.western_start_date > end_date

            false
          end

          #
          # 1行目元号
          #
          # @param [Western::Calendar] date 日付
          #
          # @return [Japan::Gengou] 1行目元号
          #
          def self.first_line(date:)
            Zakuro::Japan::GengouResource.first_line(date: date)
          end
          private_class_method :first_line

          #
          # 2行目元号
          #
          # @param [Western::Calendar] date 日付
          #
          # @return [Japan::Gengou] 2行目元号
          #
          def self.second_line(date:)
            Zakuro::Japan::GengouResource.second_line(date: date)
          end
          private_class_method :second_line
        end
      end
    end
  end
end
