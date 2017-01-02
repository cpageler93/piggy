module PiggyCash
  module Core
    module Importer
      class Base
        def self.import(rows, options = {})
          puts "Internal Error: ´import´ not implemented"
          exit 1
        end

        def self.account_from_iban(iban)
          account = PiggyCash::Models::Account.find_by_iban(iban)
          unless account
            create_new_account = agree("There is no account with IBAN from file ´#{iban}´ would you like to create a new one ?")
            if create_new_account
              account_name = ask("Account Name: ")

              account = PiggyCash::Models::Account.new
              account.name = account_name
              account.iban = iban
              account.save!
            else
              puts "Error: No Account"
              exit 1
            end
          end
          return account
        end
      end
    end
  end
end