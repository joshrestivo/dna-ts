class ReviseClientResource < ActiveRecord::Migration

  def up
    
    rename_column :client_resources, :country_code, :name
    remove_column :client_resources, :unique_name
    remove_column :client_resources, :display_text
    add_column :client_resources, :is_default, :boolean, :default => false
    add_column :client_resources, :created_by, :string
    add_column :client_resources, :updated_by, :string
    add_column :locations, :client_resource_id, :integer
    
    create_table :client_resource_details do |t|
      t.integer  :client_resource_id
      t.string  :unique_name
      t.string  :display_text
      t.string  :created_by
      t.string  :updated_by

      t.timestamps null:false
    end
        
    execute "ALTER TABLE locations ALTER COLUMN client_resource_id SET DATA TYPE bigint"
    execute "ALTER TABLE client_resource_details ALTER COLUMN id SET DATA TYPE bigint"
    execute "ALTER TABLE client_resource_details ALTER COLUMN client_resource_id SET DATA TYPE bigint"

  end

  def down
    
  end

end
