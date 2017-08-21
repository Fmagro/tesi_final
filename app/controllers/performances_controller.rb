class PerformancesController < ApplicationController
  http_basic_authenticate_with name:  "admin", password: "12345", except: [:show]

  def index
    @performances = Performance.all
  end
 
  def show
    @performance = Performance.find(params[:id])
  end
 
  def new
    @performance = Performance.new
    #@performance = @concert.performances.build
  end
 
  def edit
    @performance = Performance.find(params[:id])

  end
 
  def create
    #@performance = Performance.new(performance_params)
    #performance.song =@song
    @concert = Concert.find(params[:concert_id])
    @performance = @concert.performances.create(performance_params)
    @performance.position = @concert.performances.count+1

    if @performance.save
      redirect_to managelink_concert_path(@concert)
    else
      @concert = Concert.find(params[:concert_id])
      render 'concerts/managelink'
    end
  end
 
  def update
    #@performance = Performance.find(params[:id])
    @concert = Concert.find(params[:concert_id])
    @performance = @concert.performance.find(params[:id])
    
    if @performance.update(performance_params)
      redirect_to edit_concert_path(@concert)
    else
      render 'edit'
    end
  end
 
  def destroy
    @performance = Performance.find(params[:id])
    @performance.destroy
 
    redirect_to managelink_performances_path
  end
 
 
  def manageperformer
    @concert = Concert.find(params[:concert_id])
    @performance = @concert.performances.find(params[:id])
       
  end
  

  def addperformer
    @concert = Concert.find(params[:concert_id])
    @performance = @concert.performances.find(params[:id])
    
    if params[:artist_add]
      @performer = Performer.where(:id  => params[:artist_to_add])
      @performance.performers<< @performer 
    end
    if (params[:artist_del])
      @performerd = Performer.where(:id  => params[:artist_to_delete])
      @performance.performers.delete(@performerd)
    end
    redirect_to manageperformer_concert_performance_path(@concert,@performance) 
    
   
  end

  private
    def performance_params
      params.require(:performance).permit(:concert_id, :song_id,:position)
    end


end
