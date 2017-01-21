require 'sinatra'

module PiggyCash
  module API
    module Controllers
      class TagController < ApplicationController

        def index
          tags = PiggyCash::Models::Tag.all

          # return json
          tags_maps = []
          tags.each do |tag|
            tags_maps << tag.map
          end
          return tags_maps.to_json
        end

        def show(id)
          tag = PiggyCash::Models::Tag.find_by_id(id)
          return model_not_found unless tag
          return tag.map.to_json
        end

        def create(params)
          params = {
            name: params['name'],
          }
          tag = PiggyCash::Models::Tag.new
          tag.name = params[:name]
          tag.save

          return tag.map.to_json
        end

        def update(id, params)
          tag = PiggyCash::Models::Tag.find_by_id(id)
          return model_not_found unless tag

          params = {
            name: params['name']
          }
          params.delete_if { |key,value| !value }

          tag.update(params)
          return tag.to_json
        end

        def delete(id)
          tag = PiggyCash::Models::Tag.find_by_id(id)
          return model_not_found unless tag

          tag.destroy
          return {success: true}.to_json
        end

      end
    end
  end
end