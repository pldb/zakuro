# frozen_string_literal: true

# TODO: require
# TODO: 共通処理として利用する
# TODO: コメント

module Eq
  module JSON
    def self.eql?(expected:, actual:, class_prefix: '', formatted: true)
      expected_json = generate_pretty_json(obj: expected, class_prefix: class_prefix , formatted: formatted)
      actual_json = generate_pretty_json(obj: actual, class_prefix: class_prefix , formatted: formatted)

      expect(actual_json).to eql(expected_json)
    end

    def self.generate_pretty_json(obj:, class_prefix:, formatted:)
      hash = Zakuro::Result::Stringifier.to_h(
        obj: obj, class_prefix: class_prefix, formatted: formatted
      )
      JSON.pretty_generate(hash)
    end
  end
end
