module PiggyCash
  module CLI
    module Commands
      module Stats
        def stats_commands
          command 'stats saldo' do |c|
            c.syntax = 'piggycash stats saldo'
            c.description = 'Stats: prints stats per month'

            c.action do |args, options|
              options = {
              }

              cmd = PiggyCash::CLI::Stats::Saldo.new
              cmd.execute(options)
            end
          end
        end
      end
    end
  end
end