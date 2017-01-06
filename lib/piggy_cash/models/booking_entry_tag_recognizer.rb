module PiggyCash
  module Models
    class BookingEntryTagRecognizer < ::ActiveRecord::Base
      belongs_to :booking_entry_query
      belongs_to :tag
    end
  end
end