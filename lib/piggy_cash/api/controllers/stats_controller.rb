require 'sinatra'

module PiggyCash
  module API
    module Controllers
      class StatsController < ApplicationController

        def saldo_per_month(account_id)
          account = PiggyCash::Models::Account.find(account_id)
          return model_not_found unless account

          stats = PiggyCash::Core::Stats::Saldo.stats_per_month(account)

          return stats.to_json
        end

      end
    end
  end
end