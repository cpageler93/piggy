module PiggyCash
  module Models
    class Account < ::ActiveRecord::Base
      has_many :booking_entries, -> { order 'booking_date, id' }, dependent: :destroy
      has_many :booking_entry_queries, dependent: :destroy

      def newest_booking_entry
        self.booking_entries.last
      end

      def oldest_booking_entry
        self.booking_entries.first
      end

      def newest_booking_entry_in_month(date)

        year = date.strftime("%Y").to_i
        month = date.strftime("%m").to_i

        first_day_of_month = Date.new(year, month, 1)
        last_day_of_month = Date.new(year, month, -1)

        self.booking_entries.where('booking_date >= ? and booking_date <= ?', first_day_of_month, last_day_of_month).last
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

      def map
        {
          id: self.id,
          name: self.name,
          iban: self.iban,
          created_at: self.created_at,
          updated_at: self.updated_at
        }
      end

    end
  end
end
