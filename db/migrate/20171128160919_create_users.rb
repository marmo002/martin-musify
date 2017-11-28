class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, uniqueness: true, index: true
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
