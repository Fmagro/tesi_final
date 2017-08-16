class Performance < ApplicationRecord
  belongs_to :concert, inverse_of: :performances
  belongs_to :song, inverse_of: :performances
  has_and_belongs_to_many :performers, inverse_of: :performances 
  validates_numericality_of :position, only_integer:true, message: 'can only be a whole number', allow_nil: false
end
