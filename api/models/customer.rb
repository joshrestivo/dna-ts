class Customer < ActiveRecord::Base

  before_create do
    self.secret_key = SecureRandom.uuid
  end

  def as_json(*)        
    {
      :id             => id,
      :name           => name,
      :phone          => phone,
      :address        => address,
      :email          => email,
      :secret_key     => secret_key,
      :created_by     => created_by,
      :updated_by     => updated_by,
      :created_at     => created_at,
      :updated_at     => updated_at
    }
  end

end
