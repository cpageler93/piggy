module PiggyCash
  module Models
    class EvaluatedBookingEntry < ::ActiveRecord::Base
      belongs_to :booking_entry
      has_and_belongs_to_many :tags

      def generate_title_from_tags
        self.title = tags.collect{|tag|tag.name.titleize}.join(' ')
      end

      def fraction_value
        self.total_value * self.fraction
      end

      def split_with_fraction(fraction)

        raise "invalid fraction" if fraction >= self.fraction

        # decrease own fraction
        self.fraction -= fraction
        self.save

        # set up split with given fraction
        split_entry = self.dup
        split_entry.fraction = fraction
        split_entry.save

        return split_entry
      end

      def map
        {
          id: self.id,
          booking_date: self.booking_date,
          valuta: self.valuta,
          title: self.title,
          total_value: self.total_value,
          fraction: self.fraction,
          fraction_value: self.fraction_value,
          created_at: self.created_at,
          updated_at: self.updated_at
        }
      end
    end
  end
end