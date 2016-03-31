class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.text :root_url
    end
    add_column :payload_requests, :client_id, :integer  
  end
end
