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
      t.string :property_address
      t.string :property_state
      t.string :property_zip
      t.string :renovation_type
      t.string :brand
      t.string :schedule_logistics
      t.string :bid_team
      t.string :owner
      t.string :companies
      t.string :contacts
    end
  end
end
