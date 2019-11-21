Sneakers.configure :amqp => ENV['PROMOTIONS_QUEUE_SERVER_URL'],
                   :durable => false

Sneakers.logger.level = Logger::INFO # the default DEBUG is too noisy