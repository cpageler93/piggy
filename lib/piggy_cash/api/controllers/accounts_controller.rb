require 'sinatra'

module PiggyCash
  module API
    module Controllers
      class AccountsController < ApplicationController

        def index
          accounts = PiggyCash::Models::Account.all

          # return json
          accounts_maps = []
          accounts.each do |account|
            accounts_maps << account.map
          end
          return accounts_maps.to_json
        end

        def show(id)
          account = PiggyCash::Models::Account.find_by_id(id)
          return model_not_found unless account
          return account.map.to_json
        end

        def create(params)
          params = {
            name: params['name'],
            iban: params['iban']
          }
          account = PiggyCash::Models::Account.new
          account.name = params[:name]
          account.iban = params[:iban]
          account.save

          return account.map.to_json
        end

        def update(id, params)
          account = PiggyCash::Models::Account.find_by_id(id)
          return model_not_found unless account

          params = {
            name: params['name'],
            iban: params['iban']
          }
          params.delete_if { |key,value| !value }

          account.update(params)
          return account.to_json
        end

        def delete(id)
          account = PiggyCash::Models::Account.find_by_id(id)
          return model_not_found unless account

          account.destroy
          return {success: true}.to_json
        end

      end
    end
  end
end