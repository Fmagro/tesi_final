class Group < Performer
  has_many :bands, dependent: :destroy, inverse_of: :group
  
  has_many :individuals, :through => :bands
  accepts_nested_attributes_for :bands

  validate :membermin

  private

    def membermin
      if self.bands.length < 1
        flash.now[:error] = 'The group must have at least one member'
      end
    end


end


