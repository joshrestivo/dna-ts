class Customer < ActiveRecord::Base

  def as_json(*)        
    {
      :name           => name,
      :phone          => phone,
      :address        => address,
      :secret_key     => secret_key,
      :created_by     => created_by,
      :updated_by     => updated_by,
      :created_at     => created_at,
      :updated_at     => updated_at
    }
  end

end
