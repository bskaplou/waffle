require 'waffle/version'
require 'waffle/producer'
require 'waffle/consumer'

module Waffle
  class Base

    def initialize(strategy = nil)
      @strategy = nil
    end

  end
end
