module PiggyCash
  module Core
    module Assigner
      class Tag
        def self.ask_for_query
          query_string = "be."
          completions = [
            "be.id",
            "be.booking_date",
            "be.valuta",
            "be.participant",
            "be.booking_type",
            "be.usage",
            "be.value",
          ]
          loop do
            # ask for query
            query_string = ask("Query: ") { |q| q.completion = [query_string, completions].flatten; q.readline = true }

            yield query_string

            query_ok = agree("Save Query?") {|q| q.default = "yes"}
            break if query_ok
          end
        end

        def self.print_booking_entries_with_highlight(booking_entries, highlight_when_included)

          PiggyCash::Core::Selection::BookingEntry.print_booking_entries_in_table(booking_entries) do |booking_entry|
            is_included = highlight_when_included.include?(booking_entry)
            {
              highlight: is_included,
              color: :green
            }
          end
        end
      end
    end
  end
end