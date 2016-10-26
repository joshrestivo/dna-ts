class ClientResource < ActiveRecord::Base

  has_many :client_resource_details
  
  def as_json(*)        
    {
      :id           => id,
      :name         => name,
      :is_default   => is_default,
      :details => ClientResourceDetail.where(:client_resource_id => id)
    }
  end

end
