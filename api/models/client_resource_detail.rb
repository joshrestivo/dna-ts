class ClientResourceDetail < ActiveRecord::Base

  def as_json(*)        
    {
      :unique_name => unique_name,
      :display_text => display_text
    }
  end

end
