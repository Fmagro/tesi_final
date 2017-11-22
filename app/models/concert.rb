class Concert < ApplicationRecord

  has_and_belongs_to_many :performers, inverse_of: :concerts 
  has_and_belongs_to_many :users, inverse_of: :concerts
  has_many :performances, inverse_of: :concert,      dependent: :destroy
  has_many :songs, :through => :performances
  accepts_nested_attributes_for :performances

  belongs_to :venue, inverse_of: 'concerts', foreign_key: 'venue_id'
  #accepts_nested_attributes_for :venue 
	
  validates :cdate, uniqueness: { scope: :venue_id, message:"Only one concert is held in the same venue every day" },presence: true

  #validates :performers , length: {minimum: 1}

  validate :songmin

  validate :performermin

  scope :by_venue, -> (venue_s) { where('vname = ?', venue_s) if venue_s.present? }

  scope :by_city, -> (city_s) { where('city = ?', city_s) if city_s.present? }

  scope :by_country, -> (country_s) { where('country = ?', country_s) if country_s.present? }

  scope :by_performer, -> (artist_s) { where('pname = ?', artist_s) if artist_s.present? }

  scope :after, -> (a_date) { where('cdate >= ?', Date.parse(a_date)) if a_date.present? }

  scope :before, -> (b_date) { where('cdate <= ?', Date.parse(b_date)) if b_date.present? }

  def conc(c_id)
    Concert.find(c_id)
  end

  private

    def songmin
      if self.performances.length < 1
        flash.now[:error] = 'The concert must have at least one song'
      end
    end

    def performermin
      if self.performers.length < 1
        flash.now[:error] = 'The concert must have at least one performer'
      end
    end

  end


