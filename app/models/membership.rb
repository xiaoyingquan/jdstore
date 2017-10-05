class Membership < ApplicationRecord

  belongs_to :category
  belongs_to :product
end
