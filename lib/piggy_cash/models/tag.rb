module PiggyCash
  module Models
    class Tag < ::ActiveRecord::Base
      has_many :booking_entry_tag_recognizers
      has_and_belongs_to_many :evaluated_booking_entries

      def map
        {
          id: self.id,
          name: self.name
        }
      end
    end
  end
end