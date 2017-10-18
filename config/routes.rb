Rails.application.routes.draw do


  get 'welcome/index'
  root 'welcome#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'admin/index'

  
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
    collection do
      get 'performerfilter'
      get 'performersearch'
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
    collection do
      get 'venuefilter'
      get 'venuesearch'
    end
  end 

  resources :users do
    member do
      patch 'addfavourite'
      patch 'delfavourite'
    end
  end
 
end
