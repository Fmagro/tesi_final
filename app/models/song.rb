class Song < ApplicationRecord
  has_many :performances, inverse_of: :song,     dependent: :destroy
  has_many :concerts, :through => :performances

  def self.all_genres; %w[pop rock metal classical jazz alternative hiphop blues country lyrical]; end
 
  validates :title, presence: true, uniqueness: true,
             length: {maximum: 35 }
  validates :genre, inclusion: { in:  Song.all_genres }

  scope :by_title, -> (title_s) { where("title = ?", title_s) if title_s.present? }
  scope :by_genre, -> (genre_s) { where("genre = ?", genre_s) if genre_s.present? }

end


