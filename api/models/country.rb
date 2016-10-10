class Country < ActiveRecord::Base

  def as_json(*)        
    {
      :country_code   => country_code,
      :name           => name
    }
  end

end
