Rails.application.routes.draw do
    namespace :api, { format: 'json' } do
        resources :tasks
    end
    match '*path' => 'options_request#preflight', via: :options
end
