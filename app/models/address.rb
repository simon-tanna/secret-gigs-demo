class Address < ApplicationRecord
  belongs_to :gig

  def full_address
    "#{self.street} #{self.suburb} #{self.postcode} #{self.state}"
  end
end
