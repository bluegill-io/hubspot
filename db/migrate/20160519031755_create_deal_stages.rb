class CreateDealStages < ActiveRecord::Migration
  def change
    create_table :deal_stages do |t|
      t.string :uuid
      t.string :stage_name

      t.timestamps null: false
    end
  end
end
