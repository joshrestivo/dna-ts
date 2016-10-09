module Townsquare  
  module CustomErrorFormatter
    
    def self.call message, backtrace, options, env
      LOG.fatal(message.to_s)
      LOG.fatal(backtrace.join("\n"))
      {success:false, data: "SYSTEM_ERROR", details: message}.to_json
    end

  end
end
