class ChangeRequestTableToReferrer < ActiveRecord::Migration
  def change
    rename_table :requests, :referrers
  end
end
