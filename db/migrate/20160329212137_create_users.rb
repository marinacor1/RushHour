class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text  :browser
      t.text  :os
    end
    remove_column :payload_requests, :userAgent
    add_column :payload_requests, :user_id, :integer
  end
end
