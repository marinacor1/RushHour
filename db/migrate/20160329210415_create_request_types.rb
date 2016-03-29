class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.text :verb
    end
    remove_column :payload_requests, :requestType
    add_column :payload_requests, :request_type_id, :integer
  end
end
