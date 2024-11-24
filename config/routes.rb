Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        member do
          post :follow
          delete :unfollow
        end
      end
      resources :sleep_records, only: [ :create, :update, :index ]
      get "/following_sleep_records", to: "sleep_records#following_sleep_records"
      post "/login", to: "sessions#create"
    end
  end
end
