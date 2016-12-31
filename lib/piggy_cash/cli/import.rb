module PiggyCash
  module CLI
    class Import < Base

      def execute(options)
        ensure_valid_connection_in_keychain_item!

        puts "options #{options}"
      end

    end
  end
end