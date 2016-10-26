module Townsquare  
  module CDN

    require 'aws-sdk-v1'
    
    def list_files(folder)
      begin
        s3 = AWS::S3.new(:access_key_id     => AWS_CDN_ACCESS_KEY_ID, 
                         :secret_access_key => AWS_CDN_SECRET_ACCESS_KEY)
        create_bucket()
        bucket = s3.buckets[CDN_BUCKET]
        files = bucket.objects.with_prefix("#{folder}").collect(&:key)
        file_names = []
        files.each do |file|
          file_name = Anti::Utils.get_file_name(file)
          if file_name != ""
            file_names << file_name
          end
        end
        
        file_names
      end
    end
    
    def store_to(file, folder, file_name, access_level)
      begin
        s3 = AWS::S3.new(:access_key_id     => AWS_CDN_ACCESS_KEY_ID, 
                         :secret_access_key => AWS_CDN_SECRET_ACCESS_KEY)
        create_bucket()
        bucket = s3.buckets[CDN_BUCKET]
        obj = bucket.objects["#{folder}/#{file_name}"]
        obj.write(:file => file, :acl => access_level)
        
        "https://s3.amazonaws.com/#{CDN_BUCKET}/#{folder}/#{file_name}"
      end
    end

    def store(file, file_name, access_level)
      begin
        store_to(file, CDN_UPLOAD, file_name, access_level)
      end
    end
    
    def build_url(file_name)
      "https://s3.amazonaws.com/#{CDN_BUCKET}/#{CDN_UPLOAD}/#{file_name}"
    end
    
    def exists_to(name, folder)
      begin
        s3 = AWS::S3.new(:access_key_id     => AWS_CDN_ACCESS_KEY_ID, 
                         :secret_access_key => AWS_CDN_SECRET_ACCESS_KEY)
        create_bucket()
        bucket = s3.buckets[CDN_BUCKET]
        bucket.objects["#{folder}/#{name}"].exists?
      end
    end

    def exists(name)
      begin
        exists_to(name, CDN_UPLOAD)
      end
    end
    
    def delete_from(file_name, folder)
      begin
        s3 = AWS::S3.new(:access_key_id     => AWS_CDN_ACCESS_KEY_ID, 
                         :secret_access_key => AWS_CDN_SECRET_ACCESS_KEY)
        create_bucket()
        bucket = s3.buckets[CDN_BUCKET]
        obj = bucket.objects["#{folder}/#{file_name}"]
        if obj.exists?
          obj.delete
        end
      end
    end
    
    def delete(file_name)
      begin
        delete_from(file_name, CDN_UPLOAD)
      end
    end
    
    def create_bucket()
      begin
        s3 = AWS::S3.new(:access_key_id     => AWS_CDN_ACCESS_KEY_ID, 
                         :secret_access_key => AWS_CDN_SECRET_ACCESS_KEY)
        bucket = s3.buckets[CDN_BUCKET]
        if bucket
          s3.buckets.create(CDN_BUCKET)
        end
      end
    end
    
  end
end