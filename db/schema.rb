
ActiveRecord::Schema.define(version: 20160401000908) do

  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.text "root_url"
    t.text "identifier"
  end

  create_table "displays", force: :cascade do |t|
    t.text "width"
    t.text "height"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.date     "requested_at"
    t.integer  "responded_in"
    t.text     "event_name"
    t.text     "ip"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "url_id"
    t.integer  "referrer_id"
    t.integer  "request_type_id"
    t.integer  "user_id"
    t.integer  "display_id"
    t.integer  "client_id"
    t.text     "param"
  end

  create_table "referrers", force: :cascade do |t|
    t.text "referred_by"
  end

  create_table "request_types", force: :cascade do |t|
    t.text "verb"
  end

  create_table "urls", force: :cascade do |t|
    t.text "address"
  end

  create_table "users", force: :cascade do |t|
    t.text "browser"
    t.text "os"
  end

end
