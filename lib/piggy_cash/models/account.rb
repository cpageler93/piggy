module PiggyCash
  module Models
    class Account < ::ActiveRecord::Base
      has_many :booking_entries, -> { order 'booking_date, id' }

      def newest_booking_entry
        self.booking_entries.last
      end

      def oldest_booking_entry
        self.booking_entries.first
      end

      def validate_saldo

        # setup variables
        total_saldo = 0

        # enumerate booking entries
        self.booking_entries.each_with_index do |booking_entry, index|
          # init saldo
          if index == 0
            total_saldo = booking_entry.saldo - booking_entry.value
          end

          total_saldo += booking_entry.value
          saldo_is_valid = booking_entry.saldo == total_saldo

          unless saldo_is_valid
            puts "Saldo is not valid at #{booking_entry}".red
            return false
          end
        end

        return true
      end

    end
  end
end
