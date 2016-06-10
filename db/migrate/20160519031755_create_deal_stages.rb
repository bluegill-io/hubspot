class CreateDealStages < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :deal_stages, id: :uuid do |t|
      t.string :human_readable

      t.timestamps null: false
    end
  end
end
