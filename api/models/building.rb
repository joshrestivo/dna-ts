class Building < ActiveRecord::Base

  def as_json(*)        
    {
      :id                   => id,
      :location_id          => location_id,
      :title                => title,
      :address              => address,
      :zipcode              => zipcode,
      :image_url            => image_url,
      :image_width          => image_width,
      :image_height         => image_height,
      :thumbnail_url        => thumbnail_url,
      :thumbnail_width      => thumbnail_width,
      :thumbnail_height     => thumbnail_height,
      :created_by           => created_by,
      :updated_by           => updated_by,
      :created_at           => created_at,
      :updated_at           => updated_at
    }
  end

end
