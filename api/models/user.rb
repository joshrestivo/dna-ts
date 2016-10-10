class User < ActiveRecord::Base

  def as_json(*)        
    {
      :name           => name,
      :username       => username,
      :email          => email,
      :created_by     => created_by,
      :updated_by     => updated_by,
      :created_at     => created_at,
      :updated_at     => updated_at
    }
  end

end
