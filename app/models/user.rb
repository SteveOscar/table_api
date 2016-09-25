class User < ApplicationRecord
  has_many :scores

  validates :device, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true
end
