require 'active_record'

unless ENV['SAHARA_ENV'] == 'production'
  ActiveRecord::Base.establish_connection(
    adapter:   'sqlite3',
    database:  './sahara-pms.sqlite3'
  )
else
  require 'mysql2'
  database = ENV['DB_PORT_3306_TCP_ADDR'] || 'mysql'
  ActiveRecord::Base.establish_connection(
    adapter:   'mysql2',
    host: database,
    username: 'root',
    password: ENV['MYSQL_ROOT_PASSWORD'],
    database: 'sahara_pms'
  )
end

class SaharaPmsSchema < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string 'name', limit: 255
      t.text 'desc', limit: 65_535
      t.datetime 'created_at',               null: false
      t.datetime 'updated_at',               null: false
    end
  end

  def self.down
    drop_table :products
  end
end
