require 'sinatra'

module PiggyCash
  module API
    module Controllers
      class BookingEntryController < ApplicationController

        def index
          evaluated_booking_entries = PiggyCash::Models::EvaluatedBookingEntry.all

          # return json
          evaluated_booking_entries_maps = []
          evaluated_booking_entries.each do |evaluated_booking_entry|
            evaluated_booking_entries_maps << evaluated_booking_entry.map
          end
          return evaluated_booking_entries_maps.to_json
        end

        def show(id)
          evaluated_booking_entry = PiggyCash::Models::EvaluatedBookingEntry.find_by_id(id)
          return model_not_found unless evaluated_booking_entry
          return evaluated_booking_entry.map.to_json
        end

        def split(id, fraction)
          evaluated_booking_entry = PiggyCash::Models::EvaluatedBookingEntry.find_by_id(id)
          return model_not_found unless evaluated_booking_entry

          new_evaluated_booking_entry = evaluated_booking_entry.split_with_fraction(fraction)
          return new_evaluated_booking_entry.map.to_json
        end

        def find_by_query(query_string, account_id)
          account = PiggyCash::Models::Account.find_by_id(account_id)
          booking_entries = PiggyCash::Models::BookingEntryQuery.booking_entries_for_query(query_string, account)
          evaluated_booking_entries = booking_entries.collect{|booking_entry|booking_entry.evaluated_booking_entries}.flatten

          # return json
          evaluated_booking_entries_maps = []
          evaluated_booking_entries.each do |evaluated_booking_entry|
            evaluated_booking_entries_maps << evaluated_booking_entry.map
          end
          return evaluated_booking_entries_maps.to_json
        end

        def add_tag(booking_entry_id, tag_id)
          # find models
          evaluated_booking_entry = PiggyCash::Models::EvaluatedBookingEntry.find_by_id(booking_entry_id)
          return model_not_found unless evaluated_booking_entry
          tag = PiggyCash::Models::Tag.find_by_id(tag_id)
          return model_not_found unless tag

          unless evaluated_booking_entry.tags.include?(tag)
            evaluated_booking_entry.tags << tag
            evaluated_booking_entry.save
          end

          return {success: true}.to_json
        end

        def remove_tag(booking_entry_id, tag_id)
          # find models
          evaluated_booking_entry = PiggyCash::Models::EvaluatedBookingEntry.find_by_id(booking_entry_id)
          return model_not_found unless evaluated_booking_entry
          tag = PiggyCash::Models::Tag.find_by_id(tag_id)
          return model_not_found unless tag

          if evaluated_booking_entry.tags.include?(tag)
            evaluated_booking_entry.tags.delete(tag)
            evaluated_booking_entry.save
          end

          return {success: true}.to_json
        end

      end
    end
  end
end
