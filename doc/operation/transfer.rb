# frozen_string_literal: true

require 'csv'
require 'yaml'

table = CSV.read('csv/month.csv', headers: true)

def month_str_to_number(str)
  return str if str == '-'

  str.match('([0-9]{1,2})')[0]
end

def month_str_to_leaped(str)
  return str if str == '-'

  /.*閏.*/.match?(str).to_s
end

result = []

# rubocop:disable Metrics/BlockLength
table.each do |row|
  hash = {
    'id' => row['ID'],
    'relation_id' => row['関連注釈ID'],
    'parent_id' => row['親注釈ID'],
    'page' => row['頁数'],
    'number' => row['注番'],
    'japan_date' => row['和暦'],
    'western_date' => row['西暦'],
    'description' => row['内容'],
    'note' => row['補足（zakuro）'],
    'modified' => row['有効行'],
    'diffs' => {
      'month' => {
        'number' => {
          'calc' => month_str_to_number(row['月（計）']),
          'actual' => month_str_to_number(row['月（実）'])
        },
        'leaped' => {
          'calc' => month_str_to_leaped(row['月（計）']),
          'actual' => month_str_to_leaped(row['月（実）'])
        },
        'days' => {
          'calc' => row['月大小（計）'],
          'actual' => row['月大小（実）']
        }
      },
      'solar_term' => {
        'calc' => {
          'index' => row['中気番号（計）'],
          'to' => row['中気移動先'],
          'zodiac_name' => row['中気（計）']
        },
        'actual' => {
          'index' => row['中気番号（実）'],
          'from' => row['中気移動元'],
          'zodiac_name' => row['中気（実）']
        },
        'days' => row['中気差分']
      },
      'days' => row['日差分']
    }
  }

  result.push(hash)
end
# rubocop:enable Metrics/BlockLength

File.open('../../lib/zakuro/operation/yaml/month.yaml', 'w+') do |f|
  f.write(YAML.dump(result))
end
