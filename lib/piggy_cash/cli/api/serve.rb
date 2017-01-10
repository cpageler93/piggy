module PiggyCash
  module CLI
    module API
      class Serve < Base
        def execute(options = {})
          ensure_valid_connection_in_keychain_item!

          PiggyCash::API::App.set :port, options[:port] if options[:port]
          PiggyCash::API::App.run!
        end

        private

        # ensures there is an keychain item for PiggyCash
        # exits if not
        def ensure_keychain_item!
          keychain_item = PiggyCash::Core::Keychain::piggy_cash_keychain_item
          unless keychain_item
            puts "DB Connection is required for this method, setup PiggyCash with ´setup´ command".red
          end
        end

        def ensure_valid_connection_in_keychain_item!
          ensure_keychain_item!

          valid = PiggyCash::Core::Keychain::has_valid_connection_in_keychain_item?
          unless valid
            puts "Invalid DB Connection was found in keychain, override settings with ´setup --force´ command".red
          end
        end

      end
    end
  end
end