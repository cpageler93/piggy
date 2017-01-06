require 'digest/sha1'

module PiggyCash
  module Models
    class BookingEntry < ::ActiveRecord::Base
      belongs_to :account
      has_many :evaluated_booking_entries

      def update_checksum
        raw_checksum = "#{self.booking_date}#{self.valuta}#{self.participant}#{self.booking_type}#{self.usage}#{self.value}"
        self.checksum = Digest::SHA1.hexdigest raw_checksum
      end
    end
  end
end
