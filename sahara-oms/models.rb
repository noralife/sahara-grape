require 'active_record'

class Order < ActiveRecord::Base
  validates :customer_id, presence: true
  validates :product_id,  presence: true
  validates :customer_id, numericality: true
  validates :product_id, numericality: true
end
