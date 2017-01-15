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

          command 'stats monthly' do |c|
            c.syntax = 'piggycash stats montly'
            c.description = 'Stats: prints stats for given month'

            c.option '--month INT', Integer, 'Month'
            c.option '--year INT', Integer, 'Year'

            c.action do |args, options|
              options = {
                month: options.month,
                year: options.year
              }

              cmd = PiggyCash::CLI::Stats::Monthly.new
              cmd.execute(options)
            end
          end
        end
      end
    end
  end
end