class PerformancesController < ApplicationController
  before_action :admin_user, except: [:show]

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

    #@performance.position = @concert.performances.count+1
    if @performance.save
      redirect_to managelink_concert_path(@concert)
    else
      @concert = Concert.find(params[:concert_id])
      render 'concerts/managelink'
    end
  end
 
  def update
    @concert = Concert.find(params[:concert_id])
    @performance = @concert.performances.find(params[:id])

    #if @performance.position != nil
      if @performance.update(performance_params)
        redirect_to edit_concert_path(@concert)
      end
    #end
    render 'concerts/edit'
  end
 
  def destroy
    @performance = Performance.find(params[:id])
    if @performance.concert.performances.length > 1
      @performance.destroy
    end
    redirect_to managelink_concert_path(@performance.concert)
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
      if  @performance.performers.by_id(params[:artist_to_add]).count ==0
        @performance.performers<< @performer 
      end
    end
    if (params[:artist_del])
      if @performance.performers.length >1
        @performerd = Performer.where(:id  => params[:artist_to_delete])
        @performance.performers.delete(@performerd)
      else
       # errors.add(:concert_id, "Cannot delete: there must be at least one associated performer to the performance")
      end
    end
    redirect_to manageperformer_concert_performance_path(@concert,@performance) 
    
   
  end

  private
    def performance_params
      params.require(:performance).permit(:concert_id, :song_id,:position)
    end


end
