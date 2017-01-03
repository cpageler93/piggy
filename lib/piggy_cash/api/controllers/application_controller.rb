require 'sinatra/base'

module PiggyCash
  module API
    module Controllers
      class ApplicationController
        def model_not_found
          return {error: 'model not found'}.to_json
        end
      end
    end
  end
end