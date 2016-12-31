module PiggyCash
  module Core
    class DatabaseConnection

      def self.is_valid_connection?(settings = {})

        ActiveRecord::Base.connection_pool.disconnect! if ActiveRecord::Base.connected?
        ActiveRecord::Base.establish_connection(
          settings
        )
        valid = true

        begin
          ActiveRecord::Base.connection
        rescue Exception => e
          valid = false
        end

        return valid
      end

    end
  end
end
