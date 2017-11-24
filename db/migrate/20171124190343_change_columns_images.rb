class ChangeColumnsImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :image_tm_id, :string
    remove_column :images, :event_tm_id, :string
    add_column :images, :event_tm_id, :integer
  end
end
