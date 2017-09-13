class VenuesController < ApplicationController

  http_basic_authenticate_with name: "admin", password: "12345", except: [:show, :venuesearch, :venuefilter]
  def index
    @venues = Venue.all
  end
 
  def show
    @venue = Venue.find(params[:id])
  end
 
  def new
    @venue = Venue.new
  end
 
  def edit
    @venue = Venue.find(params[:id])
  end
 
  def create
    @venue = Venue.new(venue_params)
 
    if @venue.save
      redirect_to new_venue_path(@venue)
    else
      render 'new'
    end
  end
 
  def update
    @venue = Venue.find(params[:id])
 
    if @venue.update(venue_params)
      redirect_to managelink_venue_path(@venue)
    else
      render 'edit'
    end
  end
 
  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
 
    redirect_to venues_path
  end

  def managelink
    @venue = Venue.find(params[:id]) 
  end
 
  def venuefilter
    @venues = Venue.all    
  end


  def  venuesearch
    @venues =  Venue.select('*').by_venue(params[:venue_s]).by_city(params[:city_s]).by_country(params[:country_s]).group(:id)


  end 
  private
    def venue_params
      params.require(:venue).permit(:vname, :address, :city, :country)
    end
end
