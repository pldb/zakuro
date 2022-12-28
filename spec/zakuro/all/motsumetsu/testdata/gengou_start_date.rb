# frozen_string_literal: true

require_relative './japan_date'
require_relative './gengou'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Motsumetsu
      #
      # GengouStartDate 元号開始日
      #
      module GengouStartDate
        #
        # リストを取得する
        #
        # @return [Hash<String, JapanDate>] リスト
        #
        def self.get
          result = {}

          path = File.expand_path('./gengou_start_dates.yaml', __dir__)
          yaml = File.open(path, 'r') do |f|
            YAML.safe_load(f)
          end

          yaml.each do |gengou|
            start_date = gengou['start_date']
            date = JapanDate.new(
              leaped: start_date['leaped'], month: start_date['month'], day: start_date['day']
            )
            result[gengou['name']] = date
          end

          result
        end
      end
    end
  end
end
