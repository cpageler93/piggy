module PiggyCash
  module CLI
    module Query
      module Assign
        class Tags < Base
          def execute(options = {})
            ensure_valid_connection_in_keychain_item!

            account = PiggyCash::Core::Selection::Account.select_account_from_table

            query = nil
            if options[:select]
              query = select_query_from_account(account)
            elsif options[:create]
              query = create_query_for_account(account)
            else
              query = create_or_select_query_for_account(account)
            end

            PiggyCash::Core::Assigner::Tag.assign_tags_for_query(query)

          end

          private

          def create_or_select_query_for_account(account)
            puts "Create new Query or select existing one?"
            choice = choose(:create, :select)

            if choice == :create
              return create_query_for_account(account)
            else
              return select_query_from_account(account)
            end
          end

          def create_query_for_account(account)
            puts "Untagged Booking Entries"
            untagged_booking_entries = PiggyCash::Core::Revealer::Untagged.untagged_booking_entries_for_account(account)
            PiggyCash::Core::Selection::BookingEntry.print_booking_entries_in_table(untagged_booking_entries)


            query_string = PiggyCash::Core::Assigner::Tag.ask_for_query do |query_string|
              # select booking entries with given query
              booking_entries = PiggyCash::Models::BookingEntryQuery.booking_entries_for_query(query_string, account)

              PiggyCash::Core::Assigner::Tag.print_booking_entries_with_highlight(untagged_booking_entries, booking_entries)

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
            end

            query = PiggyCash::Core::Assigner::Tag.save_query(query_string, account)

            return query
          end

          def select_query_from_account(account)
            query = PiggyCash::Core::Selection::BookingEntryQuery.select_booking_entry_queries_from_table(account.booking_entry_queries)
            return query
          end

        end
      end
    end
  end
end