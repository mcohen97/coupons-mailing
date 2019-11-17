class PromotionInfo
  attr_reader :expiration_date, :id, :name, :organization_id, :code

  def initialize(data)
    @expiration_date = format_date(data['expiration_date'])
    @id = data['promotion_id']
    @organization_id = data['organization_id']
    @name = data['promotion_name']
    @code = data['promotion_code']
  end
private
  def format_date(the_string)
    string_elements = the_string.split /[-T:+]+/
    string_elements.pop
    date = Time.new *(string_elements.map(&:to_i))
    puts date
    return date
  end

end