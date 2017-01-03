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

      end
    end
  end
end