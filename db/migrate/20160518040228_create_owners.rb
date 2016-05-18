class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners, id: false do |t|
      t.integer :id, null: false
      t.string :first
      t.string :last
      t.string :email

      t.timestamps null: false
    end

    add_index :owners, :id, unique: true
  end
end
