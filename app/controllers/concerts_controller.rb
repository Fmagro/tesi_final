class ConcertsController < ApplicationController
    http_basic_authenticate_with name:  "admin", password: "12345", except: [:show, :concertfilter, :concertsearch]

  def index
    @concerts = Concert.all
  end
 
  def show
    @concert = Concert.find(params[:id])
  end

  def new
    @concert = Concert.new
  end
 
  def edit
    @concert = Concert.find(params[:id])
  end
 
  def create
    @concert = Concert.new(concert_params)
    @venue = Venue.where(:id  => params[:venue_to_add]).first
      #@venue= @concert.venue
    @concert.venue = @venue  
    if @concert.save
      redirect_to @concert
    else
      render 'new'
    end
  end
 
  def update
    @concert = Concert.find(params[:id])
 
    if @concert.update(concert_params)
      redirect_to @concert
    else
      render 'edit'
    end
  end
 
  def destroy
    @concert = Concert.find(params[:id])
    @concert.destroy
 
    redirect_to concerts_path
  end
 
  def managelink
    @concert = Concert.find(params[:id])
  end


  def manageartist
    @concert = Concert.find(params[:id])
    if params[:artist_add]
      @performer = Performer.where(:id  => params[:artist_to_add])
      @concert.performers<< @performer 
    end
    if (params[:artist_del])
      @performerd = Performer.where(:id  => params[:artist_to_delete])
      @concert.performers.delete(@performerd)
    end
    redirect_to @concert
  end 


  def managevenue
    @concert = Concert.find(params[:id])

    if (params[:venue_del])
     #@venued = Venue.where(:id  => params[:venue_to_delete])

      @venue = Venue.where(:id  => params[:venue_to_add]).first
      @concert.venue = @venue
    end
    if @concert.update_attribute(:venue_id,params[:venue_to_add])
      redirect_to @concert
    else
      render 'show'
    end
  end 
 
 
  def concertfilter
    @concerts = Concert.all    
  end


  def concertsearch
@concerts =  Concert.select('*,concerts.id as concertid').before(params[:b_date]).after(params[:a_date]).group(:id)
    #@concerts =  Concert.select('*,concerts.id as concertid, concerts.name as concertname').before(params[:b_date]).after(params[:a_date])
    #@concerts=@concerts.joins(:venue).select('venues.name as venuename').by_venue(params[:venue_s]).by_city(params[:city_s]).by_country(params[:country_s])
    #@concerts=@concerts.joins(:performers).by_performer(params[:performer_s])
#    @concerts=@concerts.joins(:artists).select("artists.name as artistname").by_artist(params[:artist_s]).group(:id) 

  end
 
  private
    def concert_params
      params.require(:concert).permit(:cdate, :venue_id,   
performances_attributes: [:id, :concert_id, :song_id, :position])
    end
end
