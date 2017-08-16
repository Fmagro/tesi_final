class BandsController < ApplicationController

  http_basic_authenticate_with name:  Tesi::Application.config.usrname, password: Tesi::Application.config.pwd, except: [:show]

  def index
    @bands = Band.all
  end
 
  def show
    @band = Band.find(params[:id])
  end
 
  def new
    @band = Band.new
    #@band = @performer.bands.build

  end
 
  def edit
    @band = Band.find(params[:id])

  end
 
  def create
    #@band = Band.new(band_params)
    #band.song =@song
    @group = Performer.find(params[:group_id])
    @band = @group.bands.create(band_params)

    if @band.save
      redirect_to performer_path(@group)
    else
 
     @performer = Performer.find(params[:group_id])
     render 'performers/show'
    end
  end

  def update
    @group = Performer.find(params[:performer_id])
    @band = @group.find(params[:id])
    if @band.update(band_params)
      redirect_to_edit_performer_path(@group)
    else 
      render 'edit' 
    end
  end
 
  def destroy
    @band = Band.find(params[:id])
    @band.destroy
 
    redirect_to performances_path
  end
 
  private
    def band_params
      params.require(:band).permit(:individual_id, :group_id, :joining,:leaving)
    end

end
