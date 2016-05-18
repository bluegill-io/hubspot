class CreateDealContacts < ActiveRecord::Migration
  def change
    create_table :deal_contacts do |t|
      t.references :deal, index: true
      t.references :contact, index: true

      t.timestamps null: false
    end
  end
end
