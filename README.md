# Waffle

An abstract flow publisher and subscriber.

[![Build Status](https://secure.travis-ci.org/peanut/waffle.png?branch=master)](http://travis-ci.org/peanut/waffle)

## Integration into Rails

Insert in your Rails Gemfile:

    gem 'waffle', '~> 0.1.1'

and create config file:

    # production.waffle.yml
    strategy: rabbitmq
    url: amqp://anyhost.com:5678

or if RabbitMQ local machine

    # production.waffle.yml
    strategy: rabbitmq
