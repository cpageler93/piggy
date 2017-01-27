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
          return query_string
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

        def self.assign_tags_for_query(query)
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
                create_new_tag = agree("´#{add_tag_with_name}´ is non of the existing tags, do you want to create it now?") {|q| q.default = "yes"}
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
        end

        def self.save_query(query_string, account)
          query_name = ask("Query Name: ")

          # save query
          query = PiggyCash::Models::BookingEntryQuery.new
          query.name = query_name
          query.query = query_string
          query.account = account
          query.save

          return query
        end

      end
    end
  end
end