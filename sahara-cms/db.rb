require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:   'sqlite3',
  database:  './sahara-cms.sqlite3'
)

class SaharaSchema < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string   "name",       limit: 255
      t.string   "email",      limit: 255
      t.string   "password",   limit: 255
      t.string   "role",       limit: 255
      t.string   "token",      limit: 255
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end
  end

  def self.down
    drop_table :customers
  end

end
