# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/base/gengou',
                         __dir__)

require 'json'
# 元号年データ
# rubocop:disable Layout/LineLength
year_list = [
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, zodiac_name: '壬午', total_days: 354 },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, zodiac_name: '癸未', total_days: 384 },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, zodiac_name: '甲申', total_days: 355 },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, zodiac_name: '乙酉', total_days: 355 },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, zodiac_name: '丙戌', total_days: 384 },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, zodiac_name: '丁亥', total_days: 354 },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, zodiac_name: '戊子', total_days: 383 },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, zodiac_name: '己丑', total_days: 355 },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, zodiac_name: '庚寅', total_days: 354 },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, zodiac_name: '辛卯', total_days: 384 },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, zodiac_name: '壬辰', total_days: 355 },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, zodiac_name: '癸巳', total_days: 355 },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, zodiac_name: '甲午', total_days: 383 },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, zodiac_name: '乙未', total_days: 354 },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, zodiac_name: '丙申', total_days: 354 }
]

# solargraph 文字化け回避コメント
jougan = [
  # 一部使用していない項目があるが参考値として残す
  # * first_line: 1要素目のみ
  # * first_year: 使用
  # * second_line / second_year: 不使用
  # * is_many_days: 使用
  # * month / leaped: 不使用
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: true, month: 1, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: false, month: 2, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: true, month: 3, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: true, month: 5, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: true, month: 6, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: false, month: 7, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: true, month: 8, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: false, month: 9, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: false, month: 10, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 4, second_line: '', second_year: -1, is_many_days: false, month: 12, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: true, month: 1, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: false, month: 2, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: true, month: 3, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: true, month: 4, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: false, month: 5, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: true, month: 6, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: false, month: 6, leaped: true },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: false, month: 8, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: true, month: 9, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: false, month: 11, leaped: false },
  { first_line: '貞観', first_year: 5, second_line: '', second_year: -1, is_many_days: false, month: 12, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: true, month: 1, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: false, month: 2, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: true, month: 3, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: true, month: 5, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: false, month: 6, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: true, month: 8, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: false, month: 9, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 6, second_line: '', second_year: -1, is_many_days: false, month: 12, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: true, month: 1, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: false, month: 2, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: false, month: 3, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: true, month: 4, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: false, month: 5, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: true, month: 6, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: false, month: 7, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: true, month: 8, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: true, month: 9, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: false, month: 10, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 7, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: false, month: 1, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: true, month: 2, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: false, month: 3, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: false, month: 3, leaped: true },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: true, month: 5, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: false, month: 6, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: true, month: 8, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: false, month: 9, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 8, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: false, month: 1, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: true, month: 2, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: false, month: 3, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: false, month: 5, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: true, month: 6, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: false, month: 7, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: true, month: 8, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: false, month: 9, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 9, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: false, month: 1, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: true, month: 2, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: true, month: 3, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: false, month: 5, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: false, month: 6, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: false, month: 8, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: true, month: 9, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: false, month: 10, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 10, second_line: '', second_year: -1, is_many_days: false, month: 12, leaped: true },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: true, month: 1, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: true, month: 2, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: false, month: 3, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: true, month: 4, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: false, month: 5, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: true, month: 6, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: false, month: 7, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: false, month: 8, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: true, month: 9, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: false, month: 10, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 11, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: false, month: 1, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: true, month: 2, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: true, month: 3, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: true, month: 5, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: false, month: 6, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: false, month: 8, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: false, month: 9, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: false, month: 11, leaped: false },
  { first_line: '貞観', first_year: 12, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: false, month: 1, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: true, month: 2, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: true, month: 3, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: true, month: 5, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: false, month: 6, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: false, month: 8, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: true, month: 8, leaped: true },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: false, month: 9, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: false, month: 11, leaped: false },
  { first_line: '貞観', first_year: 13, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: false, month: 1, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: true, month: 2, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: false, month: 3, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: true, month: 4, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: true, month: 5, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: false, month: 6, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: false, month: 8, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: true, month: 9, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: false, month: 10, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 14, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: false, month: 1, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: false, month: 2, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: true, month: 3, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: true, month: 5, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: false, month: 6, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: true, month: 8, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: false, month: 9, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 15, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: false, month: 1, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: false, month: 2, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: false, month: 3, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: true, month: 4, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: true },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: false, month: 5, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: true, month: 6, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: false, month: 8, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: true, month: 9, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: false, month: 11, leaped: false },
  { first_line: '貞観', first_year: 16, second_line: '', second_year: -1, is_many_days: true, month: 12, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: true, month: 1, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: false, month: 2, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: false, month: 3, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: true, month: 5, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: false, month: 6, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: true, month: 7, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: false, month: 8, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: true, month: 9, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 17, second_line: '', second_year: -1, is_many_days: false, month: 12, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: true, month: 1, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: true, month: 2, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: false, month: 3, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: false, month: 4, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: false, month: 5, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: true, month: 6, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: false, month: 7, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: true, month: 8, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: false, month: 9, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: true, month: 10, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: true, month: 11, leaped: false },
  { first_line: '貞観', first_year: 18, second_line: '', second_year: -1, is_many_days: false, month: 12, leaped: false }
]
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Gengou' do
      describe '#initialize' do
        context 'no param' do
          it 'no error' do
            expect(Zakuro::Senmyou::Gengou.new).not_to be_nil
          end
        end
        context 'jougan' do
          context 'first date' do
            it 'should be expected value' do
              year = Zakuro::Senmyou::Gengou.new(
                date: Zakuro::Western::Calendar.new(year: 862, month: 2, day: 3)
              )
              jougan.each do |j|
                if j[:first_year] == 4
                  days = j[:is_many_days] ? 30 : 29
                  year.add_days(days: days)
                end
              end
              expect(year.total_days).to be year_list[0][:total_days]
            end
          end
          context 'all years' do
            # :reek:UtilityFunction
            def error_message(fails:)
              message = ''
              fails.each do |fail|
                message += JSON.generate(fail) + '\n'
              end
              message
            end

            it 'should be expected value' do
              year = Zakuro::Senmyou::Gengou.new
              actuals = []
              # 貞観各月の合算値を各年単位にまとめる
              first_year = jougan[0][:first_year]
              jougan.each do |j|
                if j[:first_year] != first_year
                  actuals.push(year)
                  year = year.next_year
                  first_year = year.first_line.year
                end
                days = j[:is_many_days] ? 30 : 29
                year.add_days(days: days)
              end
              actuals.push(year)

              fails = []
              year_list.each_with_index do |expect_year, idx|
                actual = actuals[idx]
                hash = {
                  first_line: actual.first_line.name,
                  first_year: actual.first_line.year,
                  second_line: actual.second_line.name,
                  second_year: actual.second_line.year,
                  zodiac_name: actual.zodiac_name,
                  total_days: actual.total_days
                }
                fails.push(hash) unless hash == expect_year
              end

              expect(fails).to be_empty, error_message(fails: fails)
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
