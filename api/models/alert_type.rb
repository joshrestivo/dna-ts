class AlertType < ActiveRecord::Base

  def as_json(*)        
    {
      :name           => name
    }
  end

end
