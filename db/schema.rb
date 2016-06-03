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

ActiveRecord::Schema.define(version: 20160603071527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_authors", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "article_authors", ["article_id"], name: "index_article_authors_on_article_id", using: :btree
  add_index "article_authors", ["author_id"], name: "index_article_authors_on_author_id", using: :btree

  create_table "article_translations", force: :cascade do |t|
    t.integer  "article_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "title"
    t.string   "slug"
  end

  add_index "article_translations", ["article_id"], name: "index_article_translations_on_article_id", using: :btree
  add_index "article_translations", ["locale"], name: "index_article_translations_on_locale", using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer  "issue_id"
    t.text     "ru_annotation"
    t.text     "en_annotation"
    t.integer  "page_from"
    t.integer  "page_to"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "file_url"
    t.text     "ru_keywords"
    t.text     "en_keywords"
    t.integer  "section_id"
  end

  add_index "articles", ["issue_id"], name: "index_articles_on_issue_id", using: :btree
  add_index "articles", ["section_id"], name: "index_articles_on_section_id", using: :btree

  create_table "authors", force: :cascade do |t|
    t.integer  "directory_id"
    t.string   "ru_surname"
    t.string   "ru_name"
    t.string   "ru_patronymic"
    t.string   "en_surname"
    t.string   "en_name"
    t.string   "en_patronymic"
    t.text     "post"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "claims", force: :cascade do |t|
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.string   "phone"
    t.string   "email"
    t.text     "address"
    t.text     "workplace"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "file_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "issues", force: :cascade do |t|
    t.integer  "year"
    t.integer  "number"
    t.integer  "through_number"
    t.integer  "part"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.text     "poster_url"
    t.string   "aasm_state"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "file_url"
    t.string   "slug"
  end

  add_index "issues", ["slug"], name: "index_issues_on_slug", unique: true, using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string   "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["user_id", "role", "context_id", "context_type"], name: "by_user_and_role_and_context", using: :btree

  create_table "section_translations", force: :cascade do |t|
    t.integer  "section_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  add_index "section_translations", ["locale"], name: "index_section_translations_on_locale", using: :btree
  add_index "section_translations", ["section_id"], name: "index_section_translations_on_section_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  add_foreign_key "article_authors", "articles"
  add_foreign_key "article_authors", "authors"
  add_foreign_key "articles", "issues"
  add_foreign_key "articles", "sections"
end
