# frozen_string_literal: true

require_relative './reference'

require_relative './medieval_month'
require_relative './medieval_gengou'
require_relative './medieval_line'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Rekijitsu
      # MedievalVersion 中世暦の期待値生成
      module MedievalVersion # rubocop:disable Metrics/ModuleLength
        # @return [Array<MedievalGengou>] 11月開始
        #
        # 閏10月開始を標準とするが、暦算値によっては11月開始となる
        #
        NOVEMBER_FIRST_GENGOU = [
          MedievalGengou.new(text: '天平神護 1年'),
          MedievalGengou.new(text: '延暦 22年'),
          MedievalGengou.new(text: '元慶 3年'),
          MedievalGengou.new(text: '昌泰 1年'),
          MedievalGengou.new(text: '延喜 17年'),
          MedievalGengou.new(text: '天延 2年'),
          MedievalGengou.new(text: '正暦 4年'),
          MedievalGengou.new(text: '長和 1年'),
          MedievalGengou.new(text: '正応 2年'),
          MedievalGengou.new(text: '応永 10年'),
          MedievalGengou.new(text: '応永 29年'),
          MedievalGengou.new(text: '明応 7年'),
          MedievalGengou.new(text: '永正 14年'),
          MedievalGengou.new(text: '天文 5年'),
          MedievalGengou.new(text: '弘治 1年'),
          MedievalGengou.new(text: '慶長 17年'),
          MedievalGengou.new(text: '寛永 8年'),
          MedievalGengou.new(text: '慶安 3年'),
          MedievalGengou.new(text: '寛文 9年')
        ].freeze

        # @return [Array<MedievalGengou>] 閏11月開始
        #
        # 閏10月開始を標準とするが、暦算値によっては閏11月開始となる
        #
        LEAPED_NOVEMBER_FIRST_GENGOU = [
          MedievalGengou.new(text: '承平 6年'),
          MedievalGengou.new(text: '天正 2年')
        ].freeze

        class << self # rubocop:disable Metrics/ClassLength
          #
          # データを取得する
          #
          # @return [Array<Integer, Hash>] テストデータ
          #
          def get(range:)
            lines = to_line(range: range)

            result = {}

            current_index = to_first_result(lines: lines, result: result)

            to_result(lines: lines, result: result, current_index: current_index)

            result
          end

          private

          def to_first_result(lines: [], result: {})
            value = []
            lines.each_with_index do |line, index|
              month = line.month
              if index.zero?
                value = [line.to_h]
                # 11月ではないので1年前倒しする
                result[month.western_year - 1] = value
                next
              end

              return index if month.month == 11

              value.push(line.to_h)
            end

            0
          end

          def to_result(lines:, result:, current_index:)
            value = []
            lines.each_with_index do |line, index|
              next if index < current_index

              value, matched = first(result: result, line: line, value: value)

              next if matched

              value.push(line.to_h)
            end
          end

          def first(result:, line:, value:)
            if leaped_october?(line: line)
              value.push(line.to_h)
              # 閏10月開始にする
              value = start_year(result: result, line: line)
              return value, true
            end

            if november?(line: line, value: value)
              # 11月自体は前年にも足す
              value.push(line.to_h)
              # 11月開始にする
              value = start_year(result: result, line: line)
              return value, true
            end

            if leaped_november?(line: line, value: value)
              # 11月開始にする
              value = start_year(result: result, line: line)
              return value, true
            end

            [value, false]
          end

          def start_year(result:, line:)
            month = line.month

            update_value = [line.to_h]
            result[month.western_year] = update_value

            update_value
          end

          def leaped_october?(line:)
            return false unless line.month.leaped_october?

            return false if NOVEMBER_FIRST_GENGOU.include?(line.gengou)

            true
          end

          def november?(line:, value:)
            return false unless line.month.november?

            return false if value.size == 1

            true
          end

          def leaped_november?(line:, value:)
            return false unless line.month.leaped_november?

            return false unless LEAPED_NOVEMBER_FIRST_GENGOU.include?(line.gengou)

            return false unless value.size == 1

            true
          end

          def to_line(range:) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
            lines = []

            gengou = MedievalGengou.new
            num = 0
            in_range = false
            path = fullpath

            if path == ''
              p 'test data does not exist.skip test.'
              return lines
            end

            File.open(path, 'r') do |f|
              f.each_line do |line|
                num += 1

                month = MedievalMonth.new(text: line)

                next if month.invalid?

                gengou = MedievalGengou.new(text: line) if month.first?

                in_range = range?(in_range: in_range, gengou: gengou, range: range)

                next unless in_range

                lines.push(MedievalLine.new(num: num, gengou: gengou, month: month))
              end
            end

            lines
          end

          def fullpath
            Reference.path
          end

          def range?(in_range:, gengou:, range:)
            # 開始
            return true if !in_range && range.start?(gengou: gengou)

            # 終了
            return false if in_range && range.last?(gengou: gengou)

            in_range
          end
        end
      end
    end
  end
end
