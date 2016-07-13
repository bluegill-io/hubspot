class CreateMasterContact < ActiveRecord::Migration
  def change
    create_table :master_contacts do |t|
      t.string :owner
      t.string :first
      t.string :last
      t.string :email
      t.string :phone
      t.string :m_phone
      t.string :industry
      t.string :company
      t.string :job_title
      t.string :engagements
      t.string :deals

      t.timestamps null: false
    end
  end
end
