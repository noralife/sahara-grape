require 'active_record'

unless ENV['SAHARA_ENV'] == 'production'
  ActiveRecord::Base.establish_connection(
    adapter:   'sqlite3',
    database:  './sahara-oms.sqlite3'
  )
else
  database = ENV['MYSQL_HOST'] || 'mysql'
  require 'mysql2'
  ActiveRecord::Base.establish_connection(
    adapter:   'mysql2',
    host: database,
    username: 'root',
    password: ENV['MYSQL_ROOT_PASSWORD'],
    database: 'sahara_oms'
  )
end

class SaharaOmsSchema < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer 'customer_id', limit: 4
      t.integer 'product_id',  limit: 4
      t.string 'status', limit: 255
      t.datetime 'created_at',              null: false
      t.datetime 'updated_at',              null: false
    end
  end

  def self.down
    drop_table :orders
  end
end
