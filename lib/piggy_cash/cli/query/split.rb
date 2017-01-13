module PiggyCash
  module CLI
    module Query
      class Split < Base
        def execute(options = {})
          ensure_valid_connection_in_keychain_item!

          query_name = options[:query_name]
          queries_to_choose = []
          if query_name
            queries_with_name = PiggyCash::Models::BookingEntryQuery.where('name like ?', "%#{query_name}%")
            if queries_with_name.count == 0
              puts "Warning: there are no queries with name like ´#{query_name}´".yellow
            elsif queries_with_name.count == 1
              split_query(queries_with_name.first)
              return
            else
              queries_to_choose = queries_with_name
            end
          end

          if queries_to_choose.length == 0
            queries_to_choose = PiggyCash::Models::BookingEntryQuery.all
          end

          query = PiggyCash::Core::Selection::BookingEntryQuery.select_booking_entry_queries_from_table(queries_to_choose)
          split_query(query)

        end

        def split_query(query)
          account = query.account

          puts "Split Query: #{query.name}"
          puts "Query: #{query.query}"

          PiggyCash::Core::Selection::BookingEntry.print_booking_entries_in_table(query.booking_entries)

          query_string = PiggyCash::Core::Assigner::Tag.ask_for_query do |query_string|
            booking_entries = PiggyCash::Models::BookingEntryQuery.booking_entries_for_query(query_string, account)
            PiggyCash::Core::Assigner::Tag.print_booking_entries_with_highlight(query.booking_entries, booking_entries)
          end

        end
      end
    end
  end
end