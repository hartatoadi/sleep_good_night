Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :sleep_records, only: [:index, :create]
        member do
          post :follow
          delete :unfollow
          get :following_sleep_records
        end
      end
      post '/login', to: 'sessions#create'
    end
  end
end
