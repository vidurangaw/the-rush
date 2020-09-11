# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    get 'rushings', to: 'rushings#index'
    post 'rushings/download', to: 'rushings#download'
  end

  root 'pages#home'
end
