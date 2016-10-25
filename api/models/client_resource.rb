class ClientResource < ActiveRecord::Base

  def as_json(*)        
    {
      :id           => id,
      :name         => name,
      :is_default   => is_default,
      :details => ClientResourceDetail.where(:client_resource_id => id)
    }
  end

end
