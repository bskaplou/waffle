require 'waffle/version'
require 'waffle/base'
require 'waffle/configuration'
require 'waffle/event'

module Waffle
  module Transports
    autoload :Rabbitmq, 'waffle/transports/rabbitmq'
  end

  module Encoders
    autoload :Json, 'waffle/encoders/json'
    autoload :Marshal, 'waffle/encoders/marshal'
  end
end
