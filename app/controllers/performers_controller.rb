class PerformersController < ApplicationController
    http_basic_authenticate_with name:  Tesi::Application.config.usrname, password: Tesi::Application.config.pwd, except: [:show]
  def index
    @performers = Performer.all
  end
 
  def show
    @performer = Performer.find(params[:id])
  end
 
  def new
    @performer = perf_type.new
  end
 
  def edit
    @performer = Performer.find(params[:id])
  end
 
  def create
    @performer = perf_type.new(perf_params)
    @performer.type = params[:type]
    if @performer.save
      redirect_to @performer
    else
      render 'new'
    end
  end
 
  def update
    @performer = Performer.find(params[:id])
 
    if @performer.update(perf_params)
      redirect_to @performer
    else
      render 'edit'
    end
  end
 
  def destroy
    @performer = Performer.find(params[:id])
    @performer.destroy
 
    redirect_to performers_path
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
      params.require(perf_req).permit(:pname, :bio, :type)
#params.require(params[:type].to_sym).permit(:pname, :bio)
    end
end
