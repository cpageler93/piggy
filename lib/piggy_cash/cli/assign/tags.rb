module PiggyCash
  module CLI
    module Assign
      class Tags < Base
        def execute(options = {})
          ensure_valid_connection_in_keychain_item!

          account = PiggyCash::Core::Selection::Account.select_account_from_table

          puts "Untagged Booking Entries"
          untagged_booking_entries = PiggyCash::Core::Revealer::Untagged.untagged_booking_entries_for_account(account)
          PiggyCash::Core::Selection::BookingEntry.print_booking_entries_in_table(untagged_booking_entries)

          query_string = "be."
          loop do
            # ask for query
            query_string = ask("Query: ") { |q| q.completion = [query_string]; q.readline = true }

            # select booking entries with given query
            booking_entries = PiggyCash::Models::BookingEntryQuery.booking_entries_for_query(query_string, account)

            # print booking entries
            PiggyCash::Core::Selection::BookingEntry.print_booking_entries_in_table(untagged_booking_entries) do |booking_entry|
              is_selected_with_query = booking_entries.include?(booking_entry)
              {
                highlight: is_selected_with_query,
                color: :green
              }
            end

            # check if booking entries are also tagged already
            tagged_booking_entries = booking_entries.select{|booking_entry|booking_entry.has_evaluated_booking_entries_with_tags?}
            if tagged_booking_entries.count > 0
              puts "\n\nWarning: With this Query, you select booking entries which are tagged already".yellow
              PiggyCash::Core::Selection::BookingEntry.print_booking_entries_in_table(tagged_booking_entries, "Already tagged (#{tagged_booking_entries.count})") do |booking_entry|
                {
                  highlight: true,
                  color: :yellow
                }
              end
            end

            query_ok = agree("Save Query?") {|q| q.default = "yes"}
            break if query_ok
          end

          query_name = ask("Query Name: ")

          # save query
          query = PiggyCash::Models::BookingEntryQuery.new
          query.name = query_name
          query.query = query_string
          query.account = account
          query.save

        end
      end
    end
  end
end