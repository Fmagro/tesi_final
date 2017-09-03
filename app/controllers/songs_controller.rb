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
      redirect_to new_song_path(@song)
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
    @songs = Song.by_title(params[:title_s]).by_genre(params[:genre_s])
    @songs = @songs.joins(:performances).by_artist(params[:artist_s]).group(:id) 

    #@songs = @songs.joins(:performances).joins(:performances_performers).joins(:performers).by_artist(params[:artist_s]).group(:id)
    #@songs = @songs.joins(:performances).joins(:performers).by_artist(params[:artist_s]).group(:id)
   #@songs.find(:all, :joins => "JOIN performances ON performance_id = song.id JOIN performance_performers ON performance_performer.performance_id = performance.id JOIN performer ON performer.id = performance_performer.performer_id" :conditions => "performer.pname = 'i1'" :limit => 5)   
  end
 
  private
    def song_params
      params.require(:song).permit(:title, :genre, :ytid)
    end
end
