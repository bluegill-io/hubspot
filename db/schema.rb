# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160713224700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "companies", id: false, force: :cascade do |t|
    t.integer  "id",         null: false
    t.string   "name"
    t.string   "industry"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "companies", ["id"], name: "index_companies_on_id", unique: true, using: :btree

  create_table "company_deals", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "company_deals", ["company_id"], name: "index_company_deals_on_company_id", using: :btree
  add_index "company_deals", ["deal_id"], name: "index_company_deals_on_deal_id", using: :btree

  create_table "company_engagements", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "engagement_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "company_engagements", ["company_id"], name: "index_company_engagements_on_company_id", using: :btree
  add_index "company_engagements", ["engagement_id"], name: "index_company_engagements_on_engagement_id", using: :btree

  create_table "contacts", id: false, force: :cascade do |t|
    t.integer  "id",         null: false
    t.integer  "owner_id"
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "phone"
    t.string   "m_phone"
    t.string   "industry"
    t.string   "company"
    t.string   "job_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contacts", ["id"], name: "index_contacts_on_id", unique: true, using: :btree
  add_index "contacts", ["owner_id"], name: "index_contacts_on_owner_id", using: :btree

  create_table "deal_contacts", force: :cascade do |t|
    t.integer  "deal_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "deal_contacts", ["contact_id"], name: "index_deal_contacts_on_contact_id", using: :btree
  add_index "deal_contacts", ["deal_id"], name: "index_deal_contacts_on_deal_id", using: :btree

  create_table "deal_stages", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "human_readable"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "deals", id: false, force: :cascade do |t|
    t.integer  "id",                         null: false
    t.uuid     "deal_stage_id"
    t.string   "deal_name"
    t.string   "close_date"
    t.string   "project_year"
    t.string   "project_start_date"
    t.string   "project_end_date"
    t.string   "rooms"
    t.string   "floors"
    t.string   "project_manager"
    t.string   "project_superintendent"
    t.string   "bid_type"
    t.string   "amount"
    t.string   "margin_bid"
    t.string   "job_code"
    t.string   "win_loss"
    t.string   "description"
    t.string   "closed_lost_reason"
    t.string   "closed_lost_won_percentage"
    t.string   "final_contract_amount"
    t.string   "margin_close"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "deals", ["deal_stage_id"], name: "index_deals_on_deal_stage_id", using: :btree
  add_index "deals", ["id"], name: "index_deals_on_id", unique: true, using: :btree

  create_table "engagement_contacts", force: :cascade do |t|
    t.integer  "engagement_id"
    t.integer  "contact_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "engagement_contacts", ["contact_id"], name: "index_engagement_contacts_on_contact_id", using: :btree
  add_index "engagement_contacts", ["engagement_id"], name: "index_engagement_contacts_on_engagement_id", using: :btree

  create_table "engagement_deals", force: :cascade do |t|
    t.integer  "deal_id"
    t.integer  "engagement_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "engagement_deals", ["deal_id"], name: "index_engagement_deals_on_deal_id", using: :btree
  add_index "engagement_deals", ["engagement_id"], name: "index_engagement_deals_on_engagement_id", using: :btree

  create_table "engagements", id: false, force: :cascade do |t|
    t.integer  "id",         null: false
    t.integer  "owner_id"
    t.string   "post_at"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "engagements", ["id"], name: "index_engagements_on_id", unique: true, using: :btree
  add_index "engagements", ["owner_id"], name: "index_engagements_on_owner_id", using: :btree

  create_table "master_contacts", force: :cascade do |t|
    t.string   "owner"
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "phone"
    t.string   "m_phone"
    t.string   "industry"
    t.string   "company"
    t.string   "job_title"
    t.string   "engagements"
    t.string   "deals"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "master_deals", force: :cascade do |t|
    t.string  "deal_stage"
    t.string  "deal_name"
    t.string  "close_date"
    t.string  "project_year"
    t.string  "project_start_date"
    t.string  "project_end_date"
    t.integer "rooms"
    t.integer "floors"
    t.string  "project_manager"
    t.string  "project_superintendent"
    t.string  "bid_type"
    t.float   "amount"
    t.float   "margin_bid"
    t.string  "job_code"
    t.string  "win_loss"
    t.string  "description"
    t.string  "closed_lost_reason"
    t.string  "closed_lost_won_percentage"
    t.float   "final_contract_amount"
    t.float   "margin_close"
  end

  create_table "owners", id: false, force: :cascade do |t|
    t.integer  "id",         null: false
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "owners", ["id"], name: "index_owners_on_id", unique: true, using: :btree

end
