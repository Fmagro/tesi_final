class Group < Performer
  has_many :bands, dependent: :destroy, inverse_of: :group
  
  has_many :individuals, :through => :bands
  #accepts_nested_attributes_for :ensembles
end
