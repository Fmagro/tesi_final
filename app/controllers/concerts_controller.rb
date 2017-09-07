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

    @performer = Performer.where(:id  => params[:artist_to_add])
      #@venue= @concert.venue
    @concert.performers << @performer  

    if @concert.save
      redirect_to managelink_concert_path(@concert)
      #redirect_to new_concert_path(@concert)
    else
      render 'new'
    end
  end
 
  def update
    @concert = Concert.find(params[:id])
 
    if @concert.update(concert_params)
      redirect_to managelink_concert_path(@concert)
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
      if  @concert.performers.by_id(params[:artist_to_add]).count ==0
        @concert.performers<< @performer        
      end 

    end
 
    if (params[:artist_del])
      if @concert.performers.length >1
        @performerd = Performer.where(:id  => params[:artist_to_delete]) 
     
        @concert.performers.delete(@performerd)
      else
#        errors.add("Cannot delete: there must be at least one associated performer to the concert")
        
      end

    end
    redirect_to managelink_concert_path(@concert)
  end 


  def managevenue
    @concert = Concert.find(params[:id])

    if (params[:venue_del])
     #@venued = Venue.where(:id  => params[:venue_to_delete])

      @venue = Venue.where(:id  => params[:venue_to_add]).first
      @concert.venue = @venue

      if @concert.update_attribute(:venue_id,params[:venue_to_add])
        redirect_to managelink_concert_path(@concert)
      else
        render 'managelink'
      end
    end
  end 
 
 
  def concertfilter
    @concerts = Concert.all    
  end


  def concertsearch
    @concerts =  Concert.select('*').before(params[:b_date]).after(params[:a_date]).joins(:venue).by_venue(params[:venue_s]).by_city(params[:city_s]).by_country(params[:country_s]).joins(:performers).by_performer(params[:artist_s]).group(:id) 

  end
 
  private
    def concert_params
      params.require(:concert).permit(:cdate, :venue_id,   
performances_attributes: [:id, :concert_id, :song_id, :position])
    end
end
