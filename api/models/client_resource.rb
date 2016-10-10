class ClientResource < ActiveRecord::Base

  def as_json(*)        
    {
      :country_code   => country_code,
      :unique_name    => unique_name,
      :display_text   => display_text
    }
  end

end
