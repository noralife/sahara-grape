require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:   'sqlite3',
  database:  './sahara-oms.sqlite3'
)

class SaharaOmsSchema < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer  "customer_id", limit: 4
      t.integer  "product_id",  limit: 4
      t.string   "status",      limit: 255
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
    end
  end

  def self.down
    drop_table :orders
  end

end
