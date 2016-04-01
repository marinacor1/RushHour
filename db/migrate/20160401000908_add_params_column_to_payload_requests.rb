class AddParamsColumnToPayloadRequests < ActiveRecord::Migration
  def change
    add_column :payload_requests, :param, :text
  end
end
