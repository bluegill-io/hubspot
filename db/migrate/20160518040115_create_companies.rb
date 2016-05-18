class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies, id: false do |t|
      t.integer :id, null: false
      t.string :name
      t.string :industry
      t.string :phone

      t.timestamps null: false
    end

    add_index :companies, :id, unique: true
  end
end
