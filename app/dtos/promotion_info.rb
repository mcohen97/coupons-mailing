require './lib/error/invalid_promotion_data_error.rb'

class PromotionInfo
  attr_reader :expiration_date, :id, :name, :organization_id, :code

  def initialize(data)
    validate_data(data)
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

  def validate_data(data)
    if data.nil?
      raise InvalidPromotionDataError, 'No data provided'
    end

    if data['expiration_date'].nil?
      raise InvalidPromotionDataError, 'Missing expiration date'
    end
    if data['promotion_id'].nil?
      raise InvalidPromotionDataError, 'Missing promotion id'
    end
    if data['organization_id'].nil?
      raise InvalidPromotionDataError, 'Missing organization id'
    end
    if data['promotion_name'].nil?
      raise InvalidPromotionDataError, 'Missing promotion name'
    end
    if data['promotion_code'].nil?
      raise InvalidPromotionDataError, 'Missing promotion code'
    end
  end

end