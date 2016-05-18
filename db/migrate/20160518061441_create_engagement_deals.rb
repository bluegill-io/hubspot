class CreateEngagementDeals < ActiveRecord::Migration
  def change
    create_table :engagement_deals do |t|
      t.references :deal, index: true
      t.references :engagement, index: true

      t.timestamps null: false
    end
  end
end
