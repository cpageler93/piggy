module PiggyCash
  module CLI
    module Commands
      module Setup
        def setup_commands
          command 'setup' do |c|
            c.syntax = 'piggycash setup'
            c.description = 'Setup: database, first account, ..'

            c.action do |args, options|
              options = {
              }

              cmd = PiggyCash::CLI::Setup.new
              cmd.execute(options)
            end
          end
        end
      end
    end
  end
end