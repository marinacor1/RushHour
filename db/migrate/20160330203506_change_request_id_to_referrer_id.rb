class ChangeRequestIdToReferrerId < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :request_id, :referrer_id
  end
end
