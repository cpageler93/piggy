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

            assign_tags_for_query(query)

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

            return query
          end

          def select_query_from_account(account)
            query = PiggyCash::Core::Selection::BookingEntryQuery.select_booking_entry_queries_from_table(account.booking_entry_queries)
            return query
          end

          def assign_tags_for_query(query)

            # get all tags
            tags = PiggyCash::Models::Tag.all

            # ask to show all tags
            show_existing_tags = agree("Show existing tags?") {|q| q.default = "yes"}
            if show_existing_tags
              PiggyCash::Core::Selection::Tag.print_tags_in_table(tags) do |tag|
                {
                  highlight: query.tags.include?(tag),
                  color: :green
                }
              end
            end

            completions = []
            tags.each do |tag|
              completions << tag.name
            end

            puts "\n"
            puts "Hint: Exit adding tags by pressing ctrl+c".yellow
            puts "\n"

            loop do
              begin
                add_tag_with_name = ask("Add Tag: ") { |q| q.completion = completions; q.readline = true }

                add_tag = PiggyCash::Models::Tag.find_by_name(add_tag_with_name)
                unless add_tag
                  create_new_tag = agree("´#{add_tag_with_name}'´ is non of the existing tags, do you want to create it now?") {|q| q.default = "yes"}
                  add_tag = PiggyCash::Models::Tag.new
                  add_tag.name = add_tag_with_name
                  add_tag.save
                end

                if query.tags.include?(add_tag)
                  puts "The tag ´#{add_tag.name}´ was already added to the query ´#{query.name}´".red
                else
                  query.tags << add_tag
                  query.save
                end
              rescue SystemExit, Interrupt
                puts "\n"
                break
              ensure
              end
            end

            recognize = agree("Do you want to recognize tags for all booking entries now?") {|q| q.default = "yes"}
            if recognize
              PiggyCash::Core::Recognizer::Tags.recognize_tags_for_all_accounts
            end

            restart = agree("Restart?") {|q| q.default = "yes"}
            if restart
              self.execute
              return
            end

          end

        end
      end
    end
  end
end