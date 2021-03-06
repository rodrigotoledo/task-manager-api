require 'api_version_constraint'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :tasks
    end

    namespace :v2, path: '/', constraints: ApiVersionConstraint.new(version: 2) do
      resources :tasks
    end
  end
end
