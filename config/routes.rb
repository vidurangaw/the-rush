Rails.application.routes.draw do

  namespace :api do
    get 'rushings', to: 'rushings#index'
    get 'rushings/download', to: 'rushings#download'
  end

  root 'pages#home'
  get '/*path' => 'pages#home'
end
