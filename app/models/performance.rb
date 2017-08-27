class Performance < ApplicationRecord
  belongs_to :concert, inverse_of: :performances
  belongs_to :song, inverse_of: :performances
  has_and_belongs_to_many :performers, inverse_of: :performances 
  validates_uniqueness_of :song_id, :scope => :concert_id
  before_create :pos_default

  #validates  :position, presence: true

  private
    def pos_default
      self.position = self.concert.performances.count + 1
    end
   
    
  end

   
