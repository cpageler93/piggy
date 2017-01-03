module PiggyCash
  module CLI
    module Serve
      class API < Base
        def execute(options = {})
          PiggyCash::API::App.run!
        end
      end
    end
  end
end