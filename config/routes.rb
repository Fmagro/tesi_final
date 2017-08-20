Rails.application.routes.draw do
  get 'admin/index'

  get 'welcome/index'
  root 'welcome#index'
  
  resources :concerts do

    resources :performances do
      member do
        get 'manageperformer'
        patch 'addperformer'
      end
    end      
    member do
      get 'managelink'
      patch 'manageartist'
      patch 'managevenue'
    end
    collection do
      get 'concertsearch'
      get 'concertfilter'
    end
  end


  resources :songs do
    collection do
      get 'songfilter'
      get 'songsearch'
    end
    member do
      get 'managelink'
    end
  end

  resources :performers do
    member do
      get 'managelink'
    end
  end

  resources :individuals, :controller => "performers", :type => "Individual"
  resources :groups, :controller => "performers", :type => "Group" do
    resources :bands
  end

  resources :venues do
    member do
      get 'managelink'
    end
  end 
  
 
end
