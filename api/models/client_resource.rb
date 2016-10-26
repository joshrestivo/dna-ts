class ClientResource < ActiveRecord::Base

  has_many :client_resource_details
  
  def as_json(*)        
    {
      :id                   => id,
      :name                 => name,
      :is_default           => is_default,
      :details              => ClientResourceDetail.where(:client_resource_id => id),
      :created_by           => created_by,
      :updated_by           => updated_by,
      :created_at           => created_at,
      :updated_at           => updated_at
    }
  end

end
