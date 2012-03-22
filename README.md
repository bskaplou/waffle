# Waffle

An abstract flow publisher and subscriber.

[![Build Status](https://secure.travis-ci.org/peanut/waffle.png?branch=master)](http://travis-ci.org/peanut/waffle)

## Integration into Rails

Insert in your Rails Gemfile:

    gem 'waffle', '~> 0.2.1'

and create config file:

    # production.waffle.yml
    transport: rabbitmq
    encoder: marshal
    url: amqp://anyhost.com:5678

or if RabbitMQ on local machine

    # production.waffle.yml
    transport: rabbitmq
    encoder: marshal

## Usage

When you want to performan event, just insert this code in place, where it must occur:

    Waffle::Event.occured 'index_page_load'

You can attach meta data to event like this:

    Waffle::Event.occured 'index_page_load', {'user_id' => 13, 'user_name' => 'Joshua'}

or like this:

    Waffle::Event.occured 'index_page_load', 'bingo!'
