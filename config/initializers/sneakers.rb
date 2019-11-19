Sneakers.configure :amqp => ENV['PROMOTIONS_QUEUE_SERVER_URL'],
                   :exchange => ENV['EXCHANGE_TOPIC'],
                   :exchange_type => :topic,
                   :durable => false

Sneakers.logger.level = Logger::INFO # the default DEBUG is too noisy