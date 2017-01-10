module PiggyCash
  module CLI
    module Commands
      module Validate
        def validate_commands
          command 'validate saldo' do |c|
            c.syntax = 'piggycash validate saldo'
            c.description = 'Validate: validates saldos in booking entries'

            c.action do |arg, options|
              cmd = PiggyCash::CLI::Validate::Saldo.new
              cmd.execute(options)
            end
          end
        end
      end
    end
  end
end