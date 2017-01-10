module PiggyCash
  module CLI
    module Commands
      module API
        def api_commands
          command 'api serve' do |c|
            c.syntax = 'piggycash api serve --port 12345'
            c.description = 'API: serves REST API at given port'

            c.option '--port INT', Integer, 'API Port'

            c.action do |arg, options|

              options = {
                port: options.port,
              }

              cmd = PiggyCash::CLI::API::Serve.new
              cmd.execute(options)
            end
          end
        end
      end
    end
  end
end