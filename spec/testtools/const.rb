# frozen_string_literal: true

require File.expand_path('../../lib/zakuro/result/result',
                         __dir__)

module Const # rubocop:disable Metrics/ModuleLength
  SENMYOU_FIRST_DAY = Zakuro::Result::Single.new(
    data: Zakuro::Result::Data::SingleDay.new(
      year: Zakuro::Result::Data::Year.new(
        first_gengou: Zakuro::Result::Data::Gengou.new(
          name: '貞観',
          number: 4
        ),
        second_gengou: Zakuro::Result::Data::Gengou.new(
          name: '',
          number: -1
        ),
        zodiac_name: '壬午',
        total_days: 354
      ),
      month: Zakuro::Result::Data::Month.new(
        number: 1,
        leaped: false,
        days_name: '大',
        first_day: Zakuro::Result::Data::Day.new(
          number: 1, zodiac_name: '庚午', remainder: '6-1282',
          western_date: '0862-02-03'
        ),
        odd_solar_terms: [
          Zakuro::Result::Data::SolarTerm.new(
            index: 5, remainder: '34-5368'
          )
        ],
        even_solar_terms: [
          Zakuro::Result::Data::SolarTerm.new(
            index: 4, remainder: '19-3532'
          )
        ]
      ),
      day: Zakuro::Result::Data::Day.new(
        number: 1, zodiac_name: '庚午', remainder: '6-1282',
        western_date: '0862-02-03'
      )
    ),
    operation: Zakuro::Result::Operation.new(
      operated: false,
      month: Zakuro::Result::Operation::Month.new,
      original: Zakuro::Result::Data::SingleDay.new(
        year: Zakuro::Result::Data::Year.new(
          first_gengou: Zakuro::Result::Data::Gengou.new(
            name: '貞観',
            number: 4
          ),
          second_gengou: Zakuro::Result::Data::Gengou.new(
            name: '',
            number: -1
          ),
          zodiac_name: '壬午',
          total_days: 354
        ),
        month: Zakuro::Result::Data::Month.new(
          number: 1,
          leaped: false,
          days_name: '大',
          first_day: Zakuro::Result::Data::Day.new(
            number: 1, zodiac_name: '庚午', remainder: '6-1282',
            western_date: '0862-02-03'
          ),
          odd_solar_terms: [
            Zakuro::Result::Data::SolarTerm.new(
              index: 5, remainder: '34-5368'
            )
          ],
          even_solar_terms: [
            Zakuro::Result::Data::SolarTerm.new(
              index: 4, remainder: '19-3532'
            )
          ]
        ),
        day: Zakuro::Result::Data::Day.new(
          number: 1, zodiac_name: '庚午', remainder: '6-1282',
          western_date: '0862-02-03'
        )
      )
    )
  )
  SENMYOU_RANGE = Zakuro::Result::Range.new(list: [SENMYOU_FIRST_DAY])

  DAY_WITH_DROPPED_DATE = Zakuro::Result::Single.new(
    data: Zakuro::Result::Data::SingleDay.new(
      year: Zakuro::Result::Data::Year.new(
        first_gengou: Zakuro::Result::Data::Gengou.new(
          name: '貞観',
          number: 4
        ),
        second_gengou: Zakuro::Result::Data::Gengou.new(
          name: '',
          number: -1
        ),
        zodiac_name: '壬午',
        total_days: 354
      ),
      month: Zakuro::Result::Data::Month.new(
        number: 2,
        leaped: false,
        days_name: '小',
        first_day: Zakuro::Result::Data::Day.new(
          number: 1, zodiac_name: '庚子', remainder: '36-6432',
          western_date: '0862-03-05'
        ),
        odd_solar_terms: [],
        even_solar_terms: [
          Zakuro::Result::Data::SolarTerm.new(
            index: 6, remainder: '49-7203'
          )
        ]
      ),
      day: Zakuro::Result::Data::Day.new(
        number: 24, zodiac_name: '癸亥', remainder: '59-6432',
        western_date: '0862-03-28'
      ),
      options: {
        'dropped_date' => Zakuro::Result::Data::Option::DroppedDate::Option.new(
          matched: true,
          calculation: Zakuro::Result::Data::Option::DroppedDate::Calculation.new(
            remainder: '59-34155',
            solar_term: Zakuro::Result::Data::Option::DroppedDate::SolarTerm.new(
              index: 6,
              remainder: '49-7203'
            )
          )
        )
      }
    ),
    operation: Zakuro::Result::Operation.new(
      operated: false,
      month: Zakuro::Result::Operation::Month.new,
      original: Zakuro::Result::Data::SingleDay.new(
        year: Zakuro::Result::Data::Year.new(
          first_gengou: Zakuro::Result::Data::Gengou.new(
            name: '貞観',
            number: 4
          ),
          second_gengou: Zakuro::Result::Data::Gengou.new(
            name: '',
            number: -1
          ),
          zodiac_name: '壬午',
          total_days: 354
        ),
        month: Zakuro::Result::Data::Month.new(
          number: 2,
          leaped: false,
          days_name: '小',
          first_day: Zakuro::Result::Data::Day.new(
            number: 1, zodiac_name: '庚子', remainder: '36-6432',
            western_date: '0862-03-05'
          ),
          odd_solar_terms: [],
          even_solar_terms: [
            Zakuro::Result::Data::SolarTerm.new(
              index: 6, remainder: '49-7203'
            )
          ]
        ),
        day: Zakuro::Result::Data::Day.new(
          number: 24, zodiac_name: '癸亥', remainder: '59-6432',
          western_date: '0862-03-28'
        ),
        options: {
          'dropped_date' => Zakuro::Result::Data::Option::DroppedDate::Option.new(
            matched: true,
            calculation: Zakuro::Result::Data::Option::DroppedDate::Calculation.new(
              remainder: '59-34155',
              solar_term: Zakuro::Result::Data::Option::DroppedDate::SolarTerm.new(
                index: 6,
                remainder: '49-7203'
              )
            )
          )
        }
      )
    )
  )
end
