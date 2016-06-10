class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts, id: false do |t|
      t.integer :id, null: false
      t.references :owner, index: true

      t.string :first
      t.string :last
      t.string :email
      t.string :phone
      t.string :m_phone
      t.string :industry
      t.string :company
      t.string :job_title

      t.timestamps null: false
    end

    add_index :contacts, :id, unique: true
  end
end
