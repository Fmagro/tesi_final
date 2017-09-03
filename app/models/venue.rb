class Venue < ApplicationRecord
  has_many :concerts, inverse_of: 'venue', dependent: :destroy
 
  validates :vname, uniqueness: true, presence: true, 
                    length: { maximum: 25 }
  validates :address, presence: true, 
                    length: { maximum: 50 }
  validates :city, presence: true, 
                    length: { maximum: 25 }
  validates :country, presence: true, 
                    length: { maximum: 25 }


  scope :by_venue, -> (venue_s) { where('vname = ?', venue_s) if venue_s.present? }

  scope :by_city, -> (city_s) { where('city = ?', city_s) if city_s.present? }

  scope :by_country, -> (country_s) { where('country = ?', country_s) if country_s.present? }

end
