class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :referred_by
    end
    remove_column :payload_requests, :referredBy
    add_column :payload_requests, :request_id, :integer
  end
end
