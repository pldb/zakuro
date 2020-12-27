# frozen_string_literal: true

require 'json'
require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/summary/specifier',
                         __dir__)
# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'SingleDaySpecifier' do
      describe '.get' do
        # context 'ancient month from western date 862-2-3' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 4),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '壬午',
        #         total_days: 354
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 1,
        #         leaped: false,
        #         days_name: '大',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '庚午', remainder: '6-1282',
        #           western_date: '0862-02-03'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 5, remainder: '34-5368'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 4, remainder: '19-3532'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '庚午', remainder: '6-1282',
        #         western_date: '0862-02-03'
        #       )
        #     )
        #   end
        #   context 'as 貞観4年1月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 2, day: 3)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 2, day: 4)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '辛未',
        #                                 remainder: '7-1282', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #   end
        # end
        # context 'ancient month from western date 862-3-5' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 4),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '壬午',
        #         total_days: 354
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 2,
        #         leaped: false,
        #         days_name: '小',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '庚子', remainder: '36-6432',
        #           western_date: '0862-03-05'
        #         ),
        #         odd_solar_terms: [],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 6, remainder: '49-7203'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '庚子', remainder: '36-6432',
        #         western_date: '0862-03-05'
        #       )
        #     )
        #   end
        #   context 'as 貞観4年2月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 3, day: 5)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 3, day: 6)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '辛丑',
        #                                 remainder: '37-6432', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '29日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 4, day: 2)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 29, zodiac_name: '戊辰',
        #                                 remainder: '4-6432', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 862-11-25' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 4),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '壬午',
        #         total_days: 354
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 11,
        #         leaped: false,
        #         days_name: '大',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '乙丑', remainder: '1-5584',
        #           western_date: '0862-11-25'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 23, remainder: '8-4809'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 0, remainder: '23-6645'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '乙丑', remainder: '1-5584',
        #         western_date: '0862-11-25'
        #       )
        #     )
        #   end
        #   context 'as 貞観4年11月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 11, day: 25)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 11, day: 26)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '丙寅',
        #                                 remainder: '2-5584', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '30日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 12, day: 24)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 30, zodiac_name: '甲午',
        #                                 remainder: '30-5584', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 862-12-25' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 4),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '壬午',
        #         total_days: 354
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 12,
        #         leaped: false,
        #         days_name: '小',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '乙未', remainder: '31-941',
        #           western_date: '0862-12-25'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 1, remainder: '39-80'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 2, remainder: '54-1916'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '乙未', remainder: '31-941',
        #         western_date: '0862-12-25'
        #       )
        #     )
        #   end
        #   context 'as 貞観4年12月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 12, day: 25)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 862, month: 12, day: 26)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '丙申',
        #                                 remainder: '32-941', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '29日' do
        #       date = Zakuro::Western::Calendar.new(year: 863, month: 1, day: 22)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 29, zodiac_name: '癸亥',
        #                                 remainder: '59-941', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 863-1-23' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 5),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '癸未',
        #         total_days: 384
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 1,
        #         leaped: false,
        #         days_name: '大',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '甲子', remainder: '0-4964',
        #           western_date: '0863-01-23'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 3, remainder: '9-3751'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 4, remainder: '24-5587'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '甲子', remainder: '0-4964',
        #         western_date: '0863-01-23'
        #       )
        #     )
        #   end
        #   context 'as 貞観5年1月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 863, month: 1, day: 23)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 863, month: 1, day: 24)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '乙丑',
        #                                 remainder: '1-4964', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '30日' do
        #       date = Zakuro::Western::Calendar.new(year: 863, month: 2, day: 21)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 30, zodiac_name: '癸巳',
        #                                 remainder: '29-4964', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 863-7-20' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 5),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '癸未',
        #         total_days: 384
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 6,
        #         leaped: true,
        #         days_name: '小',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '壬戌', remainder: '58-8284',
        #           western_date: '0863-07-20'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 15, remainder: '12-579'
        #           )
        #         ],
        #         even_solar_terms: []
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '壬戌', remainder: '58-8284',
        #         western_date: '0863-07-20'
        #       )
        #     )
        #   end
        #   context 'as 貞観5年閏6月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 863, month: 7, day: 20)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 863, month: 7, day: 21)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '癸亥',
        #                                 remainder: '59-8284', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '29日' do
        #       date = Zakuro::Western::Calendar.new(year: 863, month: 8, day: 17)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 29, zodiac_name: '庚寅',
        #                                 remainder: '26-8284', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 876-1-30' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 18),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '丙申',
        #         total_days: 354
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 1,
        #         leaped: false,
        #         days_name: '大',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '己卯', remainder: '15-5502',
        #           western_date: '0876-01-30'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 3, remainder: '17-5266'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 4, remainder: '32-7102'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '己卯', remainder: '15-5502',
        #         western_date: '0876-01-30'
        #       )
        #     )
        #   end
        #   context 'as 貞観18年1月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 876, month: 1, day: 30)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 876, month: 1, day: 31)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '庚辰',
        #                                 remainder: '16-5502', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '29日' do
        #       date = Zakuro::Western::Calendar.new(year: 876, month: 2, day: 28)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 30, zodiac_name: '戊申',
        #                                 remainder: '44-5502', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 876-12-20' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 18),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '丙申',
        #         total_days: 354
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 12,
        #         leaped: false,
        #         days_name: '小',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '甲辰', remainder: '40-7755',
        #           western_date: '0876-12-20'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 1, remainder: '52-3650'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 2, remainder: '7-5486'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '甲辰', remainder: '40-7755',
        #         western_date: '0876-12-20'
        #       )
        #     )
        #   end
        #   context 'as 貞観18年12月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 876, month: 12, day: 20)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 876, month: 12, day: 21)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '乙巳',
        #                                 remainder: '41-7755', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '29日' do
        #       date = Zakuro::Western::Calendar.new(year: 877, month: 1, day: 17)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 29, zodiac_name: '壬申',
        #                                 remainder: '8-7755', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 877-5-31' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 19),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '丁酉',
        #         total_days: 384
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 4,
        #         leaped: false,
        #         days_name: '小',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '壬申', remainder: '8-1019',
        #           western_date: '0877-05-17'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 11, remainder: '24-5206'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 10, remainder: '9-3371'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 15, zodiac_name: '丙戌', remainder: '22-1019',
        #         western_date: '0877-05-31'
        #       )
        #     )
        #   end
        #   context 'as 貞観19年4月' do
        #     example '15日' do
        #       date = Zakuro::Western::Calendar.new(year: 877, month: 5, day: 31)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 877-6-1' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '元慶', number: 1),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '丁酉',
        #         total_days: 384
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 4,
        #         leaped: false,
        #         days_name: '小',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '壬申', remainder: '8-1019',
        #           western_date: '0877-05-17'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 11, remainder: '24-5206'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 10, remainder: '9-3371'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 16, zodiac_name: '丁亥', remainder: '23-1019',
        #         western_date: '0877-06-01'
        #       )
        #     )
        #   end
        #   context 'as 元慶1年4月' do
        #     example '16日' do
        #       date = Zakuro::Western::Calendar.new(year: 877, month: 6, day: 1)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #   end
        # end

        context 'ancient month from western date 937-2-14' do
          let!(:first_day) do
            Zakuro::Result::SingleDay.new(
              year: Zakuro::Result::Year.new(
                first_gengou: Zakuro::Result::Gengou.new(name: '承平', number: 7),
                second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
                zodiac_name: '丁酉',
                total_days: 354
              ),
              month: Zakuro::Result::Month.new(
                number: 1,
                leaped: false,
                days_name: '大',
                first_day: Zakuro::Result::Day.new(
                  number: 1, zodiac_name: '乙卯', remainder: '51-2479',
                  western_date: '0937-02-14'
                ),
                odd_solar_terms: [
                  Zakuro::Result::SolarTerm.new(
                    index: 5, remainder: '7-8293'
                  )
                ],
                even_solar_terms: [
                  Zakuro::Result::SolarTerm.new(
                    index: 4, remainder: '52-6457'
                  )
                ]
              ),
              day: Zakuro::Result::Day.new(
                number: 1, zodiac_name: '乙卯', remainder: '51-2479',
                western_date: '0937-02-14'
              )
            )
          end
          context 'as 承平7年1月' do
            example '1日' do
              date = Zakuro::Western::Calendar.new(year: 937, month: 2, day: 14)

              expect(
                Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
              ).to eql(first_day.to_pretty_json)
            end
          end
        end

        # context 'ancient month from western date 1332-1-28' do
        #   # 文字化け回避コメント（solargraph が日本語文字列 '正慶' を自動変換するため）
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '元弘', number: 2),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '壬申',
        #         total_days: 355
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 1,
        #         leaped: false,
        #         days_name: '大',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '辛未', remainder: '7-4787',
        #           western_date: '1332-01-28'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 3, remainder: '9-1546'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 4, remainder: '24-3382'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '辛未', remainder: '7-4787',
        #         western_date: '1332-01-28'
        #       )
        #     )
        #   end

        #   context 'as 元弘2年/正慶1年1月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 1332, month: 1, day: 28)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 1332, month: 1, day: 29)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '壬申',
        #                                 remainder: '8-4787', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '29日' do
        #       date = Zakuro::Western::Calendar.new(year: 1332, month: 2, day: 26)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 30, zodiac_name: '庚子',
        #                                 remainder: '36-4787', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 1392-1-25' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '元中', number: 9),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '明徳', number: 3),
        #         zodiac_name: '壬申',
        #         total_days: 384
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 1,
        #         leaped: false,
        #         days_name: '大',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '癸未', remainder: '19-2126',
        #           western_date: '1392-01-25'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 3, remainder: '23-7246'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 4, remainder: '39-682'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '癸未', remainder: '19-2126',
        #         western_date: '1392-01-25'
        #       )
        #     )
        #   end
        #   context 'as 元中9年/明徳3年1月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 1392, month: 1, day: 25)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 1392, month: 1, day: 26)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '甲申',
        #                                 remainder: '20-2126', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '30日' do
        #       date = Zakuro::Western::Calendar.new(year: 1392, month: 2, day: 23)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 30, zodiac_name: '壬子',
        #                                 remainder: '48-2126', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 1392-11-19' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '明徳', number: 3),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '壬申',
        #         total_days: 384
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         # 朔旦冬至による補正前（補正後は閏10月の小の月）
        #         number: 11,
        #         leaped: false,
        #         days_name: '大',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '戊寅', remainder: '14-3986',
        #           western_date: '1392-11-15'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 23, remainder: '28-1959'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 0, remainder: '43-3795'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 5, zodiac_name: '壬午', remainder: '18-3986',
        #         western_date: '1392-11-19'
        #       )
        #     )
        #   end
        #   context 'as 明徳3年閏10月' do
        #     example '5日' do
        #       # NOTE: 「明徳3年閏10月」としたが、11月を期待値とする（朔旦冬至による補正前）
        #       date = Zakuro::Western::Calendar.new(year: 1392, month: 11, day: 19)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 1393-2-12' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '明徳', number: 4),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '癸酉',
        #         total_days: 354
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 1,
        #         leaped: false,
        #         days_name: '小',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '丁未', remainder: '43-1067',
        #           western_date: '1393-02-12'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 5, remainder: '59-4573'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 4, remainder: '44-2737'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '丁未', remainder: '43-1067',
        #         western_date: '1393-02-12'
        #       )
        #     )
        #   end
        #   context 'as 明徳4年1月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 1393, month: 2, day: 12)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 1393, month: 2, day: 13)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '戊申',
        #                                 remainder: '44-1067', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '29日' do
        #       date = Zakuro::Western::Calendar.new(year: 1393, month: 3, day: 12)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 29, zodiac_name: '乙亥',
        #                                 remainder: '11-1067', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 1394-2-1' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '応永', number: 1),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '甲戌',
        #         total_days: 355
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 7,
        #         leaped: false,
        #         days_name: '小',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '己亥', remainder: '35-7979',
        #           western_date: '1394-07-29'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 15, remainder: '36-8184'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 16, remainder: '52-1620'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 5, zodiac_name: '癸卯', remainder: '39-7979',
        #         western_date: '1394-08-02'
        #       )
        #     )
        #   end
        #   context 'as 応永1年7年5月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 1394, month: 8, day: 2)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #   end
        # end

        # context 'ancient month from western date 1685-2-4' do
        #   let!(:first_day) do
        #     Zakuro::Result::SingleDay.new(
        #       year: Zakuro::Result::Year.new(
        #         first_gengou: Zakuro::Result::Gengou.new(name: '貞享', number: 2),
        #         second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
        #         zodiac_name: '乙丑',
        #         total_days: 354
        #       ),
        #       month: Zakuro::Result::Month.new(
        #         number: 1,
        #         leaped: false,
        #         days_name: '小',
        #         first_day: Zakuro::Result::Day.new(
        #           number: 1, zodiac_name: '壬戌', remainder: '58-588',
        #           western_date: '1685-02-04'
        #         ),
        #         odd_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 3, remainder: '0-4561'
        #           )
        #         ],
        #         even_solar_terms: [
        #           Zakuro::Result::SolarTerm.new(
        #             index: 4, remainder: '15-6397'
        #           )
        #         ]
        #       ),
        #       day: Zakuro::Result::Day.new(
        #         number: 1, zodiac_name: '壬戌', remainder: '58-588',
        #         western_date: '1685-02-04'
        #       )
        #     )
        #   end
        #   context 'as 貞享2年1月' do
        #     example '1日' do
        #       date = Zakuro::Western::Calendar.new(year: 1685, month: 2, day: 4)

        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(first_day.to_pretty_json)
        #     end
        #     example '2日' do
        #       date = Zakuro::Western::Calendar.new(year: 1685, month: 2, day: 5)

        #       second_day = first_day
        #       second_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 2, zodiac_name: '癸亥',
        #                                 remainder: '59-588', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(second_day.to_pretty_json)
        #     end
        #     example '29日' do
        #       date = Zakuro::Western::Calendar.new(year: 1685, month: 3, day: 4)

        #       last_day = first_day
        #       last_day.instance_variable_set(
        #         :@day,
        #         Zakuro::Result::Day.new(number: 29, zodiac_name: '庚寅',
        #                                 remainder: '26-588', western_date: date.format)
        #       )
        #       expect(
        #         Zakuro::Senmyou::SingleDaySpecifier.get(date: date).to_pretty_json
        #       ).to eql(last_day.to_pretty_json)
        #     end
        #   end
        # end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
