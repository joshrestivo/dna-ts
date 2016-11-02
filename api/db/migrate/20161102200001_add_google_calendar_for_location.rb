class AddGoogleCalendarForLocation < ActiveRecord::Migration

  def up
    
    add_column :locations, :google_calendar_url, :string
    add_column :locations, :google_calendar_id, :string
    add_column :locations, :google_calendar_api_key, :string

  end

  def down
    
  end

end
