class CreateCompanyEngagements < ActiveRecord::Migration
  def change
    create_table :company_engagements do |t|
      t.references :company, index: true
      t.references :engagement, index: true

      t.timestamps null: false
    end
  end
end
