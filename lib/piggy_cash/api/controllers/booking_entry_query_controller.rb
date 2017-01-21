require 'sinatra'

module PiggyCash
  module API
    module Controllers
      class BookingEntryQueryController < ApplicationController

        def index
          booking_entry_queries = PiggyCash::Models::BookingEntryQuery.all

          # return json
          booking_entry_queries_maps = []
          booking_entry_queries.each do |booking_entry_query|
            booking_entry_queries_maps << booking_entry_query.map
          end
          return booking_entry_queries_maps.to_json
        end

        def show(id)
          booking_entry_query = PiggyCash::Models::BookingEntryQuery.find_by_id(id)
          return model_not_found unless booking_entry_query
          return booking_entry_query.map.to_json
        end

        def create(params)
          params = {
            account_id: params['account_id'],
            name: params['name'],
            query: params['query']
          }

          account = PiggyCash::Models::Account.find_by_id(params[:account_id])
          return model_not_found unless account

          booking_entry_query = PiggyCash::Models::BookingEntryQuery.new
          booking_entry_query.account = account
          booking_entry_query.name = params[:name]
          booking_entry_query.query = params[:query]
          booking_entry_query.save

          return booking_entry_query.map.to_json
        end

        def update(id, params)
          booking_entry_query = PiggyCash::Models::BookingEntryQuery.find_by_id(id)
          return model_not_found unless booking_entry_query

          params = {
            name: params['name'],
            query: params['query']
          }
          params.delete_if { |key,value| !value }

          booking_entry_query.update(params)
          return booking_entry_query.to_json
        end

        def delete(id)
          booking_entry_query = PiggyCash::Models::BookingEntryQuery.find_by_id(id)
          return model_not_found unless booking_entry_query

          booking_entry_query.destroy
          return {success: true}.to_json
        end

        def recognize_tag(id, tag_id)
          booking_entry_query = PiggyCash::Models::BookingEntryQuery.find_by_id(id)
          return model_not_found unless booking_entry_query
          tag = PiggyCash::Models::Tag.find_by_id(tag_id)
          return model_not_found unless tag

          unless booking_entry_query.tags.include?(tag)
            booking_entry_query.tags << tag
            booking_entry_query.save
          end

          return {success: true}.to_json
        end

        def remove_recognized_tag(id, tag_id)
          booking_entry_query = PiggyCash::Models::BookingEntryQuery.find_by_id(id)
          return model_not_found unless booking_entry_query
          tag = PiggyCash::Models::Tag.find_by_id(tag_id)
          return model_not_found unless tag

          if booking_entry_query.tags.include?(tag)
            booking_entry_query.tags.delete(tag)
            booking_entry_query.save
          end

          return {success: true}.to_json
        end

      end
    end
  end
end