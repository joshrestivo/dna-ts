class User < ActiveRecord::Base
  
  attr_accessor :access_token

  before_create do
    self.uuid = SecureRandom.uuid
  end

  def as_json(*)        
    ret = {
      :id             => id,
      :name           => name,
      :username       => username,
      :email          => email,
      :created_by     => created_by,
      :updated_by     => updated_by,
      :created_at     => created_at,
      :updated_at     => updated_at
    }
    
    if access_token
      ret["access_token"] = access_token
    end
    ret
  end

end
