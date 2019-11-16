class PromotionInfo
  attr_reader :expiration_date, :id, :name, :organization_id

  def initialize(data)
    @applicable = Date.parse(data['expiration_date'])
    @id = data['promotion_id']
    @organization_id = data['organization_id']
    @name = data['name']
    @code = data['code']
  end

end