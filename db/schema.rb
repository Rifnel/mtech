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

ActiveRecord::Schema.define(version: 20160520092258) do

  create_table "articles", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "title",                        null: false
    t.string   "slug",                         null: false
    t.string   "thumb"
    t.text     "content",                      null: false
    t.datetime "published_at"
    t.integer  "category_id",                  null: false
    t.integer  "author_id",                    null: false
    t.boolean  "published",    default: false
  end

  add_index "articles", ["author_id"], name: "index_articles_on_author_id"
  add_index "articles", ["category_id"], name: "index_articles_on_category_id"

  create_table "categories", force: :cascade do |t|
    t.string "name",  null: false
    t.string "slug",  null: false
    t.string "icon"
    t.string "color"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.boolean  "is_valid",         default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id"
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "interactions", force: :cascade do |t|
    t.string  "role"
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "likes", ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "message"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at"
    t.boolean  "read"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "owner_id"
    t.integer  "category_id"
    t.boolean  "published",    default: false
    t.datetime "published_at"
    t.string   "name",         default: "",        null: false
    t.string   "slug",                             null: false
    t.string   "thumb"
    t.text     "content",      default: "",        null: false
    t.string   "state",        default: "Proposé"
    t.string   "location",     default: "Verdun"
    t.boolean  "labelized",    default: false
  end

  add_index "projects", ["category_id"], name: "index_projects_on_category_id"
  add_index "projects", ["owner_id"], name: "index_projects_on_owner_id"

  create_table "projects_categories", force: :cascade do |t|
    t.string "name"
    t.text   "description"
    t.string "icon"
  end

  create_table "projects_followers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "project_id"
  end

  add_index "projects_followers", ["project_id"], name: "index_projects_followers_on_project_id"
  add_index "projects_followers", ["user_id"], name: "index_projects_followers_on_user_id"

  create_table "surveys", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "title"
    t.text     "description"
    t.integer  "nb_responses"
    t.datetime "start_at"
    t.datetime "end_at"
  end

  create_table "surveys_fields", force: :cascade do |t|
    t.integer "survey_id"
    t.string  "input_type"
    t.boolean "is_required"
    t.string  "question"
    t.string  "options"
    t.string  "rules"
  end

  add_index "surveys_fields", ["survey_id"], name: "index_surveys_fields_on_survey_id"

  create_table "surveys_responses", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "survey_id"
    t.integer  "surveys_field_id"
    t.integer  "user_id"
    t.string   "response"
  end

  add_index "surveys_responses", ["survey_id"], name: "index_surveys_responses_on_survey_id"
  add_index "surveys_responses", ["surveys_field_id"], name: "index_surveys_responses_on_surveys_field_id"
  add_index "surveys_responses", ["user_id"], name: "index_surveys_responses_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "address"
    t.string   "city"
    t.integer  "cp"
    t.boolean  "is_admin",               default: false
    t.boolean  "is_banned",              default: false
    t.boolean  "can_comment",            default: false
    t.string   "username"
    t.string   "avatar"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "territory_attachment"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "country"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
