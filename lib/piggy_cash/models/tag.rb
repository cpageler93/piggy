module PiggyCash
  module Models
    class Tag < ::ActiveRecord::Base
      has_many :booking_entry_tag_recognizers, dependent: :destroy
      has_and_belongs_to_many :evaluated_booking_entries
      before_destroy { evaluated_booking_entries.clear }

      def map
        {
          id: self.id,
          name: self.name,
          created_at: self.created_at,
          updated_at: self.updated_at
        }
      end
    end
  end
end