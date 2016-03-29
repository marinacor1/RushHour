class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :address
    end
    remove_column :payload_requests, :url
    add_column :payload_requests, :url_id, :integer
  end
end
