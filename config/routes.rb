require "sidekiq/web"

Rails.application.routes.draw do
  post '/send_message', to: 'messages#send_message'

  # Interface web do Sidekiq (http://localhost:3000/sidekiq)
  mount Sidekiq::Web => '/sidekiq'
end
