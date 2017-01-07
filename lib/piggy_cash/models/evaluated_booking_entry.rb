module PiggyCash
  module Models
    class EvaluatedBookingEntry < ::ActiveRecord::Base
      belongs_to :booking_entry
      has_and_belongs_to_many :tags

      def generate_title_from_tags
        self.title = tags.collect{|tag|tag.name.titleize}.join(' ')
      end
    end
  end
end