# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2022_08_18_172736) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "destinations", force: :cascade do |t|
    t.string "name"
    t.integer "max_length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.json "data"
    t.integer "status", default: 0
    t.text "processing_errors"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "stripe_subscription_id", null: false
    t.string "fixed_price_id"
    t.string "usage_price_id"
    t.string "usage_subscription_item_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.bigint "you_tube_video_id", null: false
    t.text "content"
    t.bigint "destination_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "prompt_tokens"
    t.integer "completion_tokens"
    t.integer "total_tokens"
    t.json "data"
    t.string "stripe_usage_record_id"
    t.index ["destination_id"], name: "index_suggestions_on_destination_id"
    t.index ["you_tube_video_id"], name: "index_suggestions_on_you_tube_video_id"
  end

  create_table "training_samples", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tweet_id", null: false
    t.bigint "training_video_id", null: false
    t.index ["training_video_id"], name: "index_training_samples_on_training_video_id"
    t.index ["tweet_id"], name: "index_training_samples_on_tweet_id"
    t.index ["user_id"], name: "index_training_samples_on_user_id"
  end

  create_table "training_videos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "video_id"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_training_videos_on_user_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "username"
    t.string "text"
    t.string "twitter_id"
    t.datetime "tweeted_at"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "twitter_connections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "status"
    t.json "credentials"
    t.string "username"
    t.string "twitter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_twitter_connections_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "stripe_customer_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "waitlist_users", force: :cascade do |t|
    t.string "email", null: false
    t.string "you_tube_channel_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "you_tube_channels", force: :cascade do |t|
    t.string "you_tube_id", null: false
    t.bigint "user_id", null: false
    t.string "title"
    t.string "custom_url"
    t.integer "view_count"
    t.integer "subscriber_count"
    t.integer "video_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "banner_url"
    t.text "keywords", default: [], array: true
    t.bigint "you_tube_connection_id", null: false
    t.index ["user_id", "you_tube_id"], name: "index_you_tube_channels_on_user_id_and_you_tube_id", unique: true
    t.index ["user_id"], name: "index_you_tube_channels_on_user_id"
    t.index ["you_tube_connection_id"], name: "index_you_tube_channels_on_you_tube_connection_id"
    t.index ["you_tube_id"], name: "index_you_tube_channels_on_you_tube_id"
  end

  create_table "you_tube_connections", force: :cascade do |t|
    t.json "credentials"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "name"
    t.string "email"
    t.integer "status", default: 0, null: false
    t.index ["user_id"], name: "index_you_tube_connections_on_user_id"
  end

  create_table "you_tube_events", force: :cascade do |t|
    t.text "data"
    t.integer "status", default: 0
    t.string "processing_errors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "you_tube_videos", force: :cascade do |t|
    t.string "you_tube_id", null: false
    t.string "title"
    t.bigint "user_id", null: false
    t.bigint "you_tube_channel_id", null: false
    t.bigint "you_tube_connection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "fetched_at"
    t.text "tags", default: [], array: true
    t.text "description"
    t.json "data"
    t.text "captions"
    t.integer "fetch_status", default: 0, null: false
    t.text "custom_captions"
    t.text "fetch_errors"
    t.index ["user_id", "you_tube_id"], name: "index_you_tube_videos_on_user_id_and_you_tube_id", unique: true
    t.index ["user_id"], name: "index_you_tube_videos_on_user_id"
    t.index ["you_tube_channel_id"], name: "index_you_tube_videos_on_you_tube_channel_id"
    t.index ["you_tube_connection_id"], name: "index_you_tube_videos_on_you_tube_connection_id"
    t.index ["you_tube_id"], name: "index_you_tube_videos_on_you_tube_id"
  end

  add_foreign_key "subscriptions", "users"
  add_foreign_key "suggestions", "destinations"
  add_foreign_key "suggestions", "you_tube_videos"
  add_foreign_key "training_samples", "training_videos"
  add_foreign_key "training_samples", "tweets"
  add_foreign_key "training_samples", "users"
  add_foreign_key "training_videos", "users"
  add_foreign_key "tweets", "users"
  add_foreign_key "twitter_connections", "users"
  add_foreign_key "you_tube_channels", "users"
  add_foreign_key "you_tube_channels", "you_tube_connections"
  add_foreign_key "you_tube_connections", "users"
  add_foreign_key "you_tube_videos", "users"
  add_foreign_key "you_tube_videos", "you_tube_channels"
  add_foreign_key "you_tube_videos", "you_tube_connections"
end
