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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111006191718) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "up_votes",    :default => 0
    t.integer  "down_votes",  :default => 0
  end

  add_index "answers", ["user_id", "question_id"], :name => "index_answers_on_user_id_and_question_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "event_attendees", :force => true do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  add_index "event_attendees", ["user_id", "event_id"], :name => "index_event_attendees_on_user_id_and_event_id"

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "street"
    t.string   "city"
    t.string   "postal_code"
    t.string   "website"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "attendees_count", :default => 0
    t.string   "slug"
    t.integer  "comments_count",  :default => 0
  end

  add_index "events", ["slug"], :name => "index_events_on_slug", :unique => true
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "guides", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "company"
    t.string   "url"
    t.string   "title"
    t.string   "city"
    t.string   "postal_code"
    t.text     "description"
    t.boolean  "freelance"
    t.boolean  "cdi"
    t.boolean  "cdd"
    t.boolean  "internship"
    t.boolean  "remote"
    t.boolean  "full_time"
    t.boolean  "part_time"
    t.integer  "views",       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street"
    t.string   "state"
    t.string   "logo_uid"
    t.string   "email"
    t.string   "token"
    t.string   "slug"
  end

  add_index "jobs", ["slug"], :name => "index_jobs_on_slug", :unique => true

  create_table "news", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count", :default => 0
  end

  add_index "news", ["user_id"], :name => "index_news_on_user_id"

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "up_votes",           :default => 0
    t.integer  "answers_count",      :default => 0
    t.integer  "down_votes",         :default => 0
    t.integer  "accepted_answer_id"
    t.integer  "views",              :default => 0
    t.string   "slug"
  end

  add_index "questions", ["accepted_answer_id"], :name => "index_questions_on_accepted_answer_id"
  add_index "questions", ["slug"], :name => "index_questions_on_slug", :unique => true
  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "github"
    t.string   "twitter"
    t.integer  "up_votes",                            :default => 0
    t.integer  "down_votes",                          :default => 0
    t.string   "role"
    t.string   "city"
    t.string   "street"
    t.string   "postal_code"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "slug"
    t.integer  "questions_count",                     :default => 0
    t.integer  "answers_count",                       :default => 0
    t.integer  "events_count",                        :default => 0
    t.string   "website"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

  create_table "workers", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "street"
    t.string   "postal_code"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

end
