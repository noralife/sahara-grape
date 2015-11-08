require 'active_record'

class Customer < ActiveRecord::Base
  has_many :order
  validates :name,     presence: true
  validates :email,    presence: true
  validates :password, presence: true
  validates :email,    uniqueness: true
end
