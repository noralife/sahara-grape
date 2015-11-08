require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:   'sqlite3',
  database:  './sahara-pms.sqlite3'
)

class SaharaPmsSchema < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string   "name",       limit: 255
      t.text     "desc",       limit: 65535
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
    end
  end

  def self.down
    drop_table :products
  end

end
