module PiggyCash
  module CLI
    module Validate
      class Saldo < Base
        def execute(options = {})
          ensure_valid_connection_in_keychain_item!

          # enumerate accounts
          accounts = PiggyCash::Models::Account.all
          accounts.each do |account|
            puts "Validate #{account.name}"
            valid_saldo = account.validate_saldo
            unless valid_saldo
              exit 1
            end
          end

          puts "Saldo is valid".green

        end
      end
    end
  end
end