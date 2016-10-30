class ChangeTitleToNameForBuilding < ActiveRecord::Migration

  def up
    
    rename_column :buildings, :title, :name

  end

  def down
    
  end

end
