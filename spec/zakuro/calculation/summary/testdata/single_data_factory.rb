# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/summary/western/single',
                         __dir__)

#
# SingleDataFactory テストデータ（一日データ）生成
#
module SingleDataFactory
  class << self
    def create(hash:)
      single(hash: hash)
    end

    def gengou(str:)
      return Zakuro::Result::Data::Gengou.new if str == ''

      _, name, number = * /([一-龥]+)([0-9]{1,2})年/.match(str)

      Zakuro::Result::Data::Gengou.new(name: name, number: number.to_i)
    end

    def year(hash:)
      Zakuro::Result::Data::Year.new(
        first_gengou: gengou(str: hash['first_gengou']),
        second_gengou: gengou(str: hash['second_gengou']),
        zodiac_name: hash['zodiac_name'],
        total_days: hash['total_days'].to_i
      )
    end

    def solar_term(hash:)
      return [] unless hash

      # TODO: 複数対応
      [
        Zakuro::Result::Data::SolarTerm.new(
          index: hash['index'],
          remainder: hash['remainder']
        )
      ]
    end

    def month(hash:)
      Zakuro::Result::Data::Month.new(
        number: hash['number'],
        leaped: hash['leaped'],
        days_name: hash['days_name'],
        first_day: day(hash: hash['first_day']),
        odd_solar_terms: solar_term(hash: hash['odd_solar_terms']),
        even_solar_terms: solar_term(hash: hash['even_solar_terms'])
      )
    end

    def day(hash:)
      Zakuro::Result::Data::Day.new(
        number: hash['number'].to_i,
        zodiac_name: hash['zodiac_name'],
        remainder: hash['remainder'],
        western_date: hash['western_date']
      )
    end

    def single_day(hash:)
      Zakuro::Result::Data::SingleDay.new(
        year: year(hash: hash['year']),
        month: month(hash: hash['month']),
        day: day(hash: hash['day'])
      )
    end

    def annocations(hash:)
      return [] unless hash

      annotations = []
      hash.each do |annocation|
        annotations.push(
          Zakuro::Result::Operation::Month::Annotation.new(
            description: annocation['description'],
            note: annocation['note']
          )
        )
      end

      annotations
    end

    def operation_month(hash:)
      Zakuro::Result::Operation::Month::Bundle.new(
        current: operation_month_history(hash: hash['current']),
        parent: operation_month_history(hash: hash['parent'])
      )
    end

    def operation_month_history(hash:)
      Zakuro::Result::Operation::Month::History.new(
        id: hash['id'],
        western_date: hash['western_date'],
        page: hash['page'],
        number: hash['number'],
        annotations: annocations(hash: hash['annotations'])
      )
    end

    def operation(hash:)
      Zakuro::Result::Operation::Bundle.new(
        operated: hash['operated'],
        month: operation_month(hash: hash['month']),
        original: single_day(hash: hash['original'])
      )
    end

    def single(hash:)
      Zakuro::Result::Single.new(
        data: single_day(hash: hash['data']),
        operation: operation(hash: hash['operation'])
      )
    end
  end
end
