class SongsController < ApplicationController
    http_basic_authenticate_with name:  "admin", password: "12345", except: [:show, :songfilter, :songsearch]
  def index
    @songs = Song.all
  end
 
  def show
    @song = Song.find(params[:id])
  end
 
  def new
    @song = Song.new
  end
 
  def edit
    @song = Song.find(params[:id])
  end
 
  def create
    @song = Song.new(song_params)
 
    if @song.save
      redirect_to managelink_song_path(@song)
    else
      render 'new'
    end
  end
 
  def update
    @song = Song.find(params[:id])
 
    if @song.update(song_params)
      redirect_to managelink_song_path(@song)
    else
      render 'edit'
    end
  end
 
  def destroy
    @song = Song.find(params[:id])
    @song.destroy
 
    redirect_to songs_path
  end

  def managelink
    @song = Song.find(params[:id])
  end

  def songfilter
    @songs = Song.all 
  end

  def songsearch
    @songs = Song.by_title(params[:title_s]).by_genre(params[:genre_s]).group(:id)


     #@songs = @songs.joins(:performances).joins(:performers).by_artist(params[:artist_s]).group(:id) 

#@concerts =  Concert.select('*,concerts.id as concertid, concerts.name as concertname').before(params[:b_date]).after(params[:a_date]).group(:id)
    #@concerts =  Concert.select('*,concerts.id as concertid, concerts.name as concertname').before(params[:b_date]).after(params[:a_date])
    #@concerts=@concerts.joins(:venue).select('venues.name as venuename').by_venue(params[:venue_s]).by_city(params[:city_s]).by_country(params[:country_s])
    #@concerts=@concerts.joins(:performers).by_performer(params[:performer_s])
#    @concerts=@concerts.joins(:artists).select("artists.name as artistname").by_artist(params[:artist_s]).group(:id)  
  end
 
  private
    def song_params
      params.require(:song).permit(:title, :genre, :ytid)
    end
end
