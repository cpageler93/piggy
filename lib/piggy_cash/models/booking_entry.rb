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

      def copy_to_evaluation_if_needed
        copy_to_evaluation if evaluated_booking_entries.count == 0
      end

      def copy_to_evaluation
        evaluated_booking_entry = EvaluatedBookingEntry.new
        evaluated_booking_entry.booking_entry = self
        evaluated_booking_entry.booking_date = self.booking_date
        evaluated_booking_entry.valuta = self.valuta
        evaluated_booking_entry.title = self.usage
        evaluated_booking_entry.total_value = self.value
        evaluated_booking_entry.fraction = 1.0
        evaluated_booking_entry.save

        self.evaluated_booking_entries << evaluated_booking_entry
      end

      def evaluated_booking_entry
        return nil if evaluated_booking_entries.count != 1
        entry = evaluated_booking_entries.first
        return nil if entry.fraction != 1.0
        return entry
      end

      def has_evaluated_booking_entries_with_tags?
        self.evaluated_booking_entries.each do |evaluated_booking_entry|
          return true if evaluated_booking_entry.tags.count > 0
        end
        return false
      end

      def self.booking_entries_in_range(year, month)
        booking_entries_in_range = all
        booking_entries_in_range = booking_entries_in_range.where('month(booking_date) = ? and year(booking_date) = ?', month, year)
        booking_entries_in_range = booking_entries_in_range.order(booking_date: :desc, id: :desc)

        return booking_entries_in_range
      end

    end
  end
end
