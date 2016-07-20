class CreateMasterDeal < ActiveRecord::Migration
  def change
    create_table :master_deals do |t|
      t.string :deal_stage
      t.string :deal_name
      t.string :close_date
      t.string :project_year
      t.string :project_start_date
      t.string :project_end_date
      t.integer :rooms
      t.integer :floors
      t.string :project_manager
      t.string :project_superintendent
      t.string :bid_type
      t.float :amount
      t.float :margin_bid
      t.string :job_code
      t.string :win_loss
      t.string :description
      t.string :closed_lost_reason
      t.string :closed_lost_won_percentage
      t.float :final_contract_amount
      t.float :margin_close
    end
  end
end
