module Townsquare
  module Image

    require 'dragonfly'
    
    def process(out_folder, file_path)
      image = Dragonfly.app.fetch_file(file_path)
      thumbnail_image = image.thumb(THUMBNAIL_SIZE + "#")
      resize_image = image.convert('-quality 60 -resize 720x', 'format' => 'jpg', 'frame' => 0)
      
      file_name = "#{Time.now.to_i}_#{SecureRandom.uuid}.jpg"
      resize_file_path = "#{out_folder}/#{file_name}"
      resize_image.to_file(resize_file_path, :mode => 0666, :mkdirs => true)
      
      thumbnail_file_path = "#{out_folder}/#{THUMBNAIL_SIZE}_#{file_name}"
      thumbnail_image.to_file(thumbnail_file_path, :mode => 0666, :mkdirs => true)
      
      [file_name, "#{THUMBNAIL_SIZE}_#{file_name}"]
    end
  
  end
end