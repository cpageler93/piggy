module PiggyCash
  module Models
    class Account < ::ActiveRecord::Base
      has_many :booking_entries, -> { order 'booking_date' }

      def newest_booking_entry
        self.booking_entries.last
      end

      def oldest_booking_entry
        self.booking_entries.first
      end

    end
  end
end
