class PromotionInfo
  attr_reader :expiration_date, :id, :name, :organization_id

  def initialize(data)
    @expiration_date = Date.parse(data['expiration_date'])
    @id = data['promotion_id']
    @organization_id = data['organization_id']
    @name = data['promotion_name']
    @code = data['promotion_code']
  end

end