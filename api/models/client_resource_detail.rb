class ClientResourceDetail < ActiveRecord::Base

  belongs_to :client_resource
  
  def as_json(*)        
    {
      :unique_name => unique_name,
      :display_text => display_text
    }
  end

end
