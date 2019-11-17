class UsersService

  def initialize
    @connection = create_connection
  end

  def get_organization_administrators(organization_id)
    return [{email: 'diegomarcel27@hotmail.com'}]

    #get '/v1/PedidosYa/users', ''
    
  end
private
    
  def create_connection
      
    conn = Faraday.new(url: ENV['USERS_SERVICE_URL']) do |c|
      c.response :logger
      c.request :json
      c.use Faraday::Adapter::NetHttp
    end
  
    return conn
  end
  
  def get(url, authorization)
  
    resp = @connection.get url do |request|
      request.headers["Authorization"] = authorization
      request.headers['Content-Type'] = 'application/json'
    end
  
    return JSON.parse resp.body
  end
  
end