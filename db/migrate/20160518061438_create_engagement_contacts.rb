class CreateEngagementContacts < ActiveRecord::Migration
  def change
    create_table :engagement_contacts do |t|
      t.references :engagement, index: true
      t.references :contact, index: true

      t.timestamps null: false
    end
  end
end
