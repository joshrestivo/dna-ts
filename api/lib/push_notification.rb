module Townsquare

  module PushNotification

    require 'pushmeup'

    def publish_ios(device_tokens, message, count, type, id, notification_id)
      APNS.port = 2195
      if Townsquare_ENV == 'development'
        APNS.host = 'gateway.sandbox.push.apple.com'
        APNS.pem = "config/apn_development.pem"
      else
        APNS.host = 'gateway.push.apple.com'
        APNS.pem = "config/apn_production.pem"
      end
      notifis = []
      device_tokens.each do |device_token|
        begin
          notif = APNS::Notification.new(device_token, :alert => message, :badge => count, :sound => 'default', :other => {:type => type, :id => id, :notification_id => notification_id})
          notifis.push notif
        rescue => ex #ingore the exception in this case
          LOG.fatal(ex)          
        end
      end
      
      APNS.send_notifications(notifis)      
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
