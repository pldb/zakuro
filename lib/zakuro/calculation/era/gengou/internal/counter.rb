# frozen_string_literal: true

require_relative '../../../../era/japan/gengou/resource'
require_relative '../../../../era/japan/calendar'
require_relative '../../../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      #
      # Counter 加算元号
      #
      class Counter
        # @return [Integer] 不正値
        INVALID_YEAR = -1

        # @return [Japan::Resource::Gengou] 元号
        attr_reader :gengou
        # @return [Integer] 元号年
        attr_reader :japan_year
        # @return [Integer] 西暦年
        attr_reader :western_year
        # @return [Western::Calendar] 西暦開始年
        attr_reader :start_date
        # @return [Western::Calendar] 西暦終了年
        attr_reader :last_date

        #
        # 初期化
        #
        # @param [Japan::Resource::Gengou] gengou 元号
        #
        def initialize(gengou: Japan::Resource::Gengou.new,
                       start_date: Western::Calendar.new, last_date: Western::Calendar.new)
          @gengou = gengou
          @japan_year = gengou.both_start_year.japan
          @western_year = gengou.both_start_year.western

          @start_date = start_date.clone
          @last_date = last_date.clone

          select_valid_date
        end

        #
        # 和暦開始日を取得する
        #
        # @return [Japan::Calendar] 和暦開始日
        #
        def japan_start_date
          return Japan::Calendar.new if @gengou.invalid?

          @gengou.both_start_date.japan
        end

        #
        # 西暦開始日を取得する
        #
        # @return [Western::Calendar] 西暦開始日
        #
        def western_start_date
          return Western::Calendar.new if @gengou.invalid?

          @start_date
        end

        #
        # 西暦終了日を取得する
        #
        # @return [Western::Calendar] 西暦終了日
        #
        def western_last_date
          return Western::Calendar.new if @gengou.invalid?

          @gengou.last_date
        end

        #
        # 次年にする
        #
        # @return [MultiGengou] 自身
        #
        def next_year
          @japan_year += 1
          @western_year += 1

          self
        end

        #
        # 元号名を取得する
        #
        # @return [String] 元号名
        #
        def name
          return '' unless @gengou

          @gengou.name
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          @gengou.invalid? || @japan_year == INVALID_YEAR || @western_year == INVALID_YEAR
        end

        #
        # 指定した日が元号に含まれるか
        #
        # @param [Western::Calendar] date 日
        #
        # @return [True] 含まれる
        # @return [False] 含まれない
        #
        def include?
          @gengou.include?
        end

        #
        # ディープコピー
        #
        # @param [MultiGengou] obj 自身
        #
        def initialize_copy(obj)
          @gengou = obj.gengou.clone
          @japan_year = obj.japan_year
          @western_year = obj.western_year
        end

        private

        #
        # 有効な日付範囲を選択する
        #
        def select_valid_date
          return if @gengou.invalid?

          @start_date = @gengou.both_start_date.western.clone if @start_date.invalid?
          @last_date = @gengou.last_date.clone if @last_date.invalid?
        end
      end
    end
  end
end
