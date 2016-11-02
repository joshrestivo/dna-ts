class RemoveGoogleUrlFromLocation < ActiveRecord::Migration

  def up
    
    remove_column :locations, :google_calendar_url

  end

  def down
    
  end

end
