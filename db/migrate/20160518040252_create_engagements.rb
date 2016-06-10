class CreateEngagements < ActiveRecord::Migration
  def change
    create_table :engagements, id: false, force: true do |t|
      t.integer  :id, null: false
      t.references :owner, index: true
      t.string   :post_at
      t.text     :body

      t.timestamps null: false
    end

    add_index :engagements, :id, unique: true
  end
end
