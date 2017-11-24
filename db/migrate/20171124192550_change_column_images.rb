class ChangeColumnImages < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :event_tm_id, :event_id
  end
end
