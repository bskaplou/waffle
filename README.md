# Waffle

An abstract flow publisher and subscriber.

[![Build Status](https://secure.travis-ci.org/undr/waffle.png?branch=master)](http://travis-ci.org/undr/waffle)

It supports the following transports: 

- RabbitMQ.
- Redis. 

## Configuration

Insert in your Gemfile:

    gem 'waffle', :gem => 'git://github.com/undr/waffle.git'

and create config file:

    production:
      transport: rabbitmq
      encoder: marshal
      url: amqp://anyhost.com:5678

and load config file:

    Waffle.configure(:path => 'config/waffle.yml')

You also can configure Waffle programmatically:

    Waffle.configure({
      :transport => 'redis',
      :url => 'redis://localhost:6379/0',
      :encoder => 'json'
    })

or:

    Waffle.configure do |config|
      config.transport = 'redis'
      config.url = 'redis://localhost:6379/0'
      config.encoder = 'json'
    end

## Usage

### Event 

When you want to performan event, just insert this code in place, where it must occur:

    Waffle::Event.occurred 'index_page_load'

You can attach meta data to event like this:

    Waffle::Event.occurred 'index_page_load', {'user_id' => 13, 'user_name' => 'Joshua'}

or like this:

    Waffle::Event.occurred 'index_page_load', 'bingo!'

### Pub/Sub

    Waffle.publish('event.name', message_hash_or_string)
    
    Waffle.subscribe('event.name') do |message_type, message_hash_or_string|
      pp message_type
      pp message_hash_or_string
    end

### Reconnect

Don't care about any reconnects when transport server is down. Waffle just waits for server ready and reconnects automatically.
