Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  

  namespace :api do
    namespace :v1 do
      resources :boards
      resources :board_invitations, only: :create
      resources :lists
      resources :tasks
      get "/invite/accept", to: "board_invitations#accept", as: :accept_invitation
      get "/invite/reject", to: "board_invitations#reject", as: :reject_invitation
    end
  end
end
