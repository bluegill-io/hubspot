class CreateCompanyDeals < ActiveRecord::Migration
  def change
    create_table :company_deals do |t|
      t.references :company, index: true
      t.references :deal, index: true

      t.timestamps null: false
    end
  end
end
