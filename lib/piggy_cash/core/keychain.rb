module PiggyCash
  module Core
    class Keychain

      KEYCHAIN_SERVICE_NAME = 'piggycash'

      def self.piggy_cash_keychain_item
        ::Keychain.generic_passwords.where(:service => KEYCHAIN_SERVICE_NAME).all.first
      end

      def self.create_generic_password(options = {})
        options.merge!({
          :service => KEYCHAIN_SERVICE_NAME
        })
        ::Keychain.generic_passwords.create(options)
      end

      def self.has_valid_connection_in_keychain_item?
        keychain_item = piggy_cash_keychain_item
        return false unless keychain_item

        keychain_item_password = ""
        begin
          keychain_item_password = keychain_item.password
        rescue Exception => e
        end

        settings = {
          adapter:  'mysql2',
          host:     keychain_item.server,
          username: keychain_item.account,
          password: keychain_item_password,
          database: keychain_item.comment
        }

        return PiggyCash::Core::DatabaseConnection::is_valid_connection?(settings)
      end

    end
  end
end