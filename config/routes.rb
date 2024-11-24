Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        member do
          post :follow
          delete :unfollow
        end
      end
      resources :sleep_records, only: [ :create, :update ] do
        member do
          get :following_sleep_records
        end
      end
      post "/login", to: "sessions#create"
    end
  end
end
