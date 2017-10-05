class Category < ApplicationRecord
  has_many :products

  has_many :memberships
  has_many :products, :through => :memberships
end
