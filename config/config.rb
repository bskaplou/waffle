Waffle.configure do
  default do |config|
    config.transport = 'rabbitmq'
    config.url = 'amqp://localhost:5672'
    config.encoder = 'json'
  end

  queue(:rabbitmq_name) do |config|
    config.transport = 'rabbitmq'
    config.url = 'amqp://localhost:5673'
    config.encoder = 'json'
  end

  queue(:redis_name) do |config|
    config.transport = 'redis'
    config.url = 'redis://localhost:6379/0'
    config.encoder = 'json'
  end
end
