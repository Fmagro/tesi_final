class Venue < ApplicationRecord
  has_many :concerts, inverse_of: 'venue'
 
  validates :vname, uniqueness: true, presence: true, 
                    length: { maximum: 25 }
  validates :address, presence: true, 
                    length: { maximum: 50 }
  validates :city, presence: true, 
                    length: { maximum: 25 }
  validates :country, presence: true, 
                    length: { maximum: 25 }

end
