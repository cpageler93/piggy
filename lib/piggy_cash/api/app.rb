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

      def self.account_routes
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
      account_routes

      def self.booking_entry_routes
        get '/booking_entries' do
          c = PiggyCash::API::Controllers::BookingEntryController.new
          c.index
        end

        get '/booking_entries/find_by_query' do
          query_string = params['query']
          account_id = params['account_id']

          c = PiggyCash::API::Controllers::BookingEntryController.new
          c.find_by_query(query_string, account_id)
        end

        get '/booking_entries/:id' do
          c = PiggyCash::API::Controllers::BookingEntryController.new
          c.show(params['id'].to_i)
        end

        post '/booking_entries/:id/split' do
          c = PiggyCash::API::Controllers::BookingEntryController.new
          c.split(params['id'].to_i, params['fraction'].to_f)
        end

        post '/booking_entries/:id/add_tag/:tag_id' do
          booking_entry_id = params['id']
          tag_id = params['tag_id']

          c = PiggyCash::API::Controllers::BookingEntryController.new
          c.add_tag(booking_entry_id, tag_id)
        end

        delete '/booking_entries/:id/remove_tag/:tag_id' do
          booking_entry_id = params['id']
          tag_id = params['tag_id']

          c = PiggyCash::API::Controllers::BookingEntryController.new
          c.remove_tag(booking_entry_id, tag_id)
        end
      end
      booking_entry_routes

      def self.booking_entry_query_routes

        get '/booking_entry_queries' do
          c = PiggyCash::API::Controllers::BookingEntryQueryController.new
          c.index
        end

        get '/booking_entry_queries/:id' do
          c = PiggyCash::API::Controllers::BookingEntryQueryController.new
          c.show(params['id'].to_i)
        end

        post '/booking_entry_queries' do
          c = PiggyCash::API::Controllers::BookingEntryQueryController.new
          c.create(@params)
        end

        patch '/booking_entry_queries/:id' do
          c = PiggyCash::API::Controllers::BookingEntryQueryController.new
          c.update(params['id'].to_i, @params)
        end

        delete '/booking_entry_queries/:id' do
          c = PiggyCash::API::Controllers::BookingEntryQueryController.new
          c.delete(params['id'].to_i)
        end

        post '/booking_entry_queries/:id/recognize_tag/:tag_id' do
          c = PiggyCash::API::Controllers::BookingEntryQueryController.new
          c.recognize_tag(params['id'].to_i, params['tag_id'].to_i)
        end

        delete '/booking_entry_queries/:id/remove_recognized_tag/:tag_id' do
          c = PiggyCash::API::Controllers::BookingEntryQueryController.new
          c.remove_recognized_tag(params['id'].to_i, params['tag_id'].to_i)
        end
      end
      booking_entry_query_routes
    end
  end
end
