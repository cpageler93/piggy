require 'sinatra'

module PiggyCash
  module API
    class App < Sinatra::Base

      before do
        content_type 'application/json'

        if request.body.size > 0
          request.body.rewind
          @params = JSON.parse request.body.read
        end
      end

      not_found do
        {error: 'route not found'}.to_json
      end

      ###############
      #   Accounts
      ###############
      get '/accounts' do
        c = PiggyCash::API::Controllers::AccountsController.new
        c.index
      end

      get '/accounts/:id' do
        c = PiggyCash::API::Controllers::AccountsController.new
        c.show(params['id'].to_i)
      end

      post '/accounts' do
        c = PiggyCash::API::Controllers::AccountsController.new
        c.create(@params)
      end

      patch '/accounts/:id' do
        c = PiggyCash::API::Controllers::AccountsController.new
        c.update(params['id'].to_i, @params)
      end

      delete '/accounts/:id' do
        c = PiggyCash::API::Controllers::AccountsController.new
        c.delete(params['id'].to_i)
      end

    end
  end
end
