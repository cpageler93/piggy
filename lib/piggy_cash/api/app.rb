require 'sinatra'

module PiggyCash
  module API
    class App < Sinatra::Base

      before do
        content_type 'application/json'
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
        c.show(params[:id].to_i)
      end

    end
  end
end
