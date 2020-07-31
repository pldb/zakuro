# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # AbstractVersion 暦インターフェース
  #
  # @abstract 暦日を引き当てるためのインターフェース
  #
  class AbstractVersion
    # @return [True] 暦の使用可
    # @return [False] 暦の使用不可
    RELEASE = false

    #
    # 西暦日から和暦日に変換する
    #
    # @param [Date] western_date 西暦日
    #
    # @return [Result::SingleDay] 和暦日
    #
    # @raise [NotImplementedError] オーバーライドなし
    #
    def self.to_japan_date(western_date:)
      raise NotImplementedError,
            "must be implemented on #{self.class}##{__method__}(#{western_date})"
    end
  end
end
