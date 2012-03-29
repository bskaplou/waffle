# Waffle

An abstract flow publisher and subscriber.

[![Build Status](https://secure.travis-ci.org/peanut/waffle.png?branch=master)](http://travis-ci.org/peanut/waffle)

## Integration into Rails

Insert in your Rails Gemfile:

    gem 'waffle'

and create config file:

    production:
      transport: rabbitmq
      encoder: marshal
      url: amqp://anyhost.com:5678

## Usage

When you want to performan event, just insert this code in place, where it must occur:

    Waffle::Event.occurred 'index_page_load'

You can attach meta data to event like this:

    Waffle::Event.occurred 'index_page_load', {'user_id' => 13, 'user_name' => 'Joshua'}

or like this:

    Waffle::Event.occurred 'index_page_load', 'bingo!'
