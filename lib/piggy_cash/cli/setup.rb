module PiggyCash
  module CLI
    class Setup < Base

      def execute(options)

        # remove_existing_keychain_item
        if PiggyCash::Core::Keychain::piggy_cash_keychain_item
          ensure_valid_connection_in_keychain_item!
        else
          setup_mysql_connection
        end

        prepare_database
        check_first_account

      end

      private

      # check if there is a piggycash keychain item
      def remove_existing_keychain_item
        keychain_item = PiggyCash::Core::Keychain::piggy_cash_keychain_item
        if keychain_item
          if $force
            keychain_item.delete
          else
            puts "Error: There is a corresponding Keychain Item for PiggyCash\nUse --force to override"
            return
          end
        end
      end

      def setup_mysql_connection
        puts "MySQL Setup:"
        settings = find_valid_connection

        keychain_options = {
          :server => settings[:host],
          :account => settings[:username],
          :password => settings[:password],
          :comment => settings[:database]
        }
        PiggyCash::Core::Keychain::create_generic_password(keychain_options)
      end

      def prepare_database
        migrations_path = File.join(File.dirname(__FILE__), '../db/migrate')
        ActiveRecord::Migration.verbose = true
        ActiveRecord::Migrator.migrate migrations_path, nil
      end

      def check_first_account
        first_account = PiggyCash::Models::Account.first
        return if first_account

        puts "Setup your first Banking Account!"
        account_name = ask "Account Name: "
        iban = ask "IBAN: "

        first_account = PiggyCash::Models::Account.new
        first_account.name = account_name
        first_account.iban = iban
        first_account.save
      end

      # returns settings
      def find_valid_connection

        settings = nil

        loop do

          default_host = "localhost"
          default_username = "root"
          default_password = ""
          default_database = "piggy_cash"

          host = ask "Host: (default: #{default_host})"
          host = nil if host.length == 0
          host ||= default_host

          username = ask "Username: (default: #{default_username})"
          username = nil if username.length == 0
          username ||= default_username

          password = ask("Password: (default: #{default_password})") { |q| q.echo = false }
          password = nil if password.length == 0
          password ||= default_password

          database = ask("Database: (default: #{default_database})")
          database = nil if database.length == 0
          database ||= default_database

          settings = {
            adapter:  'mysql2',
            host:     host,
            username: username,
            password: password,
            database: database
          }

          valid = PiggyCash::Core::DatabaseConnection::is_valid_connection?(settings)
          break if valid
        end

        return settings

      end

    end
  end
end