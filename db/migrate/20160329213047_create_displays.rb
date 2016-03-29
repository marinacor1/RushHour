class CreateDisplays < ActiveRecord::Migration
  def change
    create_table :displays do |t|
      t.text    :width
      t.text    :height
    end
    remove_column :payload_requests, :resolutionWidth
    remove_column :payload_requests, :resolutionHeight
    add_column :payload_requests, :display_id, :integer
  end
end
