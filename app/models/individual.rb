class Individual < Performer
  has_many :bands, dependent: :destroy, inverse_of: :individual
  
  has_many :groups, :through => :bands
end
