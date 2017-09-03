class Performer < ApplicationRecord

  has_and_belongs_to_many :concerts, inverse_of:  :performers

  has_and_belongs_to_many :performances, inverse_of: :performers 

  validates :pname, presence: true, uniqueness: true,
                    length: { maximum: 50 }

  validate :xortype 

  scope :by_name, -> (name_s) { where("pname = ?", name_s) if name_s.present? }

  scope :by_type, -> (type_s) { where("type = ?", type_s) if type_s.present? }

  scope :by_id, -> (id_s) { where("id = ?", id_s) if id_s.present? }

  scope :by_song, -> (song_s) { where("title = ?", song_s) if song_s.present? }


  def perf(p_id)
    Performer.find(p_id)
  end

private

  def xortype
    if((type == 'Individual' || type == 'Group') && !(type == 'Individual' && type == 'Group'))
    true
    else errors.add(:type, " performer's type must be Individual or Group" )
    end
  end
end
