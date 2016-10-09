module Townsquare

  module SESHelper

    def send_email(subject, template_name, params, tos)
      @ses = AWS::SimpleEmailService.new(:access_key_id => 'AKIAJ5LYU3Y4TB2LLKIA',
                                         :secret_access_key => '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')
      file = File.open("res/email_templates/#{template_name}", :encoding => "UTF-8")
      email_content = file.read
      file.close
      email_content.gsub! "{HOST}", BASE_HOST
      email_content.gsub! "{HOST_WEB}", BASE_WEB_HOST
      params.keys.each do |param|
        email_content.gsub! param, params[param]
      end
      
      @ses.send_email(:subject => subject,
                      :from => EMAIL_FROM,
                      :to => tos,
                      :body_html => email_content)
    end

  end

end
