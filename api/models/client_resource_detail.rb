class ClientResourceDetail < ActiveRecord::Base

  belongs_to :client_resource
  
  def as_json(*)        
    {
      :unique_name          => unique_name,
      :display_text         => display_text,
      :created_by           => created_by,
      :updated_by           => updated_by,
      :created_at           => created_at,
      :updated_at           => updated_at
    }
  end

end
