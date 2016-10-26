module Townsquare
  module Utils
    
    def get_file_name(link)
      start = link.rindex('/') + 1
      file_name = link[start..-1]
    end

  end
end
