class CreateDeals < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :deals, id: false do |t|
      t.integer :id, null: false
      t.references :deal_stage, type: :uuid, index: true

      t.string :deal_name
      t.string :close_date
      t.string :project_year
      t.string :project_start_date
      t.string :project_end_date
      t.string :rooms
      t.string :floors
      t.string :project_manager
      t.string :project_superintendent
      t.string :bid_type
      t.string :amount
      t.string :margin_bid
      t.string :job_code
      t.string :win_loss
      t.string :description
      t.string :closed_lost_reason
      t.string :closed_lost_won_percentage
      t.string :final_contract_amount
      t.string :margin_close

      t.timestamps null: false
    end

    add_index :deals, :id, unique: true
  end
end
