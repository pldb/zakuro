# frozen_string_literal: true

require_relative './linear_gengou'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Alignment
      #
      # Division 元号区分
      #
      module Division
        #
        # 重複した範囲を返す
        #
        # @param [LinearGengou] this 残り元号
        # @param [LinearGengou] other 比較元号
        #
        # @return [Array<LinearGengou>] 重複分
        #
        def self.match(this:, other:)
          result = []
          if other.in?(start_date: this.start_date, last_date: this.last_date)
            result.push(this)
            return result
          end

          if other.out?(start_date: this.start_date, last_date: this.last_date)
            # 該当なし
            return result
          end

          if other.covered?(start_date: this.start_date, last_date: this.last_date)
            # 範囲内のみ返す
            result.push(trim_gengou(this: this, other: other))
            return result
          end

          result.push(narrow_gengou(this: this, other: other))

          result
        end

        #
        # 範囲が重複しない差分を返す
        #
        # @param [LinearGengou] this 積元号
        # @param [LinearGengou] other 比較元号
        #
        # @return [Array<LinearGengou>] 差分
        #
        def self.mismatch(this:, other:)
          result = []
          if other.in?(start_date: this.start_date, last_date: this.last_date)
            # 該当なし
            return result
          end

          if other.out?(start_date: this.start_date, last_date: this.last_date)
            result.push(this)
            return result
          end

          if other.covered?(start_date: this.start_date, last_date: this.last_date)
            result |= split_gengou(this: this, other: other)
            return result
          end

          result.push(shave_gengou(this: this, other: other))
          result
        end

        #
        # 比較により分離した元号をつなげる
        #
        # @param [Array<LinearGengou>] list 元号
        #
        # @return [Array<LinearGengou>] 同一元号がつながった元号
        #
        def self.connect(list: [])
          result = []
          list.each do |linear_gengou|
            if result.size.zero?
              result.push(linear_gengou)
              next
            end

            before = result[-1]

            if unconnectable?(current: linear_gengou, before: before)
              result.push(linear_gengou)
              next
            end

            result[-1] = LinearGengou.new(
              start_date: before.start_date, last_date: linear_gengou.last_date,
              gengou: linear_gengou.gengou
            )
          end

          result
        end

        def self.unconnectable?(current:, before:)
          return true unless current.gengou.name == before.gengou.name

          return true unless (before.last_date.clone + 1) == current.start_date

          false
        end

        def self.split_gengou(this:, other:)
          [
            LinearGengou.new(
              start_date: this.start_date.clone, last_date: other.start_date.clone - 1,
              gengou: this.gengou
            ),
            LinearGengou.new(
              start_date: other.last_date.clone + 1, last_date: this.last_date.clone,
              gengou: this.gengou
            )
          ]
        end
        private_class_method :split_gengou

        def self.trim_gengou(this:, other:)
          LinearGengou.new(
            start_date: other.start_date, last_date: other.last_date,
            gengou: this.gengou
          )
        end
        private_class_method :trim_gengou

        def self.narrow_gengou(this:, other:)
          start = this.start_date > other.start_date ? this.start_date : other.start_date
          last = this.last_date < other.last_date ? this.last_date : other.last_date

          LinearGengou.new(
            start_date: start.clone, last_date: last.clone, gengou: this.gengou
          )
        end
        private_class_method :narrow_gengou

        def self.shave_gengou(this:, other:)
          start = this.start_date
          last = this.last_date

          # 開始日が比較元号の開始日より前の範囲
          last = other.start_date.clone - 1 if this.start_date < other.start_date

          # 終了日が比較元号の開始日より後の範囲
          start = other.last_date.clone + 1 if this.last_date > other.last_date

          LinearGengou.new(
            start_date: start.clone, last_date: last.clone, gengou: this.gengou
          )
        end
      end
    end
  end
end
