class Gig < ApplicationRecord
  belongs_to :user
  has_one :address
  accepts_nested_attributes_from :address
end
