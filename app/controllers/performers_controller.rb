class PerformersController < ApplicationController
    http_basic_authenticate_with name:  "admin", password: "12345", except: [:show]
  def index
    @performers = Performer.all
  end
 
  def show
    @performer = Performer.find(params[:id])
  end
 
  def new
    @performer = perf_type.new
    #@band = @performer.bands.build
  end
 
  def edit
    @performer = Performer.find(params[:id])
  end
 
  def create
    @performer = perf_type.new(perf_params)
    @performer.type = params[:type]
    if @performer.save
      redirect_to managelink_performer_path(@performer)
    else
      render 'new'
    end
  end
 
  def update
    @performer = Performer.find(params[:id])
 
    if @performer.update(perf_params)
      redirect_to managelink_performer_path(@performer)
    else
      render 'edit'
    end
  end
 
  def destroy
    @performer = Performer.find(params[:id])
    @performer.destroy
 
    redirect_to performers_path
  end

  def managelink
    @performer = Performer.find(params[:id])
  end
 
  private 
  
    def perf_types 
      ["Individual", "Group"]
    end

    def perf_type
      params[:type].constantize if params[:type].in? perf_types
    end 
 
    def perf_req
       params[:type].downcase.to_sym
    end

    def perf_params
      params.require(perf_req).permit(:pname, :bio, :type, bands_attributes: [:id, :performer_id, :joining, :leaving])
#params.require(params[:type].to_sym).permit(:pname, :bio)
    end
end
