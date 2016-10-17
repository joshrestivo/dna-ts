module Townsquare

  module PushNotification

    require 'pushmeup'

    def publish_ios(device_tokens, message, count, type, id, notification_id)
      APNS.port = 2195
      if TOWNSQUARE_ENV == 'development' || TOWNSQUARE_ENV == 'staging' 
        APNS.host = 'gateway.sandbox.push.apple.com'
        APNS.pem = "config/apn_development.pem"
      else
        APNS.host = 'gateway.push.apple.com'
        APNS.pem = "config/apn_production.pem"
      end
      
      APNS.start_persistence
      device_tokens.each do |device_token|
        begin
          result = APNS.send_notification(device_token, :alert => message, :badge => count, :sound => 'default', :other => {:type => type, :id => id, :notification_id => notification_id})
          if APNS.feedback.length == 0
            APNS.stop_persistence
            APNS.start_persistence
          end
        rescue => ex #ingore the exception in this case
          LOG.fatal(ex)          
        end
      end
      APNS.stop_persistence
    end

    def publish_android(device_tokens, message, count, type, id, notification_id)
      GCM.host = 'https://android.googleapis.com/gcm/send'
      GCM.format = :json
      GCM.key = "AIzaSyC3GX3u8GJq6hCzLlt0ommgbXDKf8AQ9Zo"
      data = {:msg => message, :badge => count, :type => type, :id => id, :notification_id => notification_id} 
      GCM.send_notification(device_tokens, data)      
    end

  end

end
