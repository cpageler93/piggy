module PiggyCash
  module Core
    module Recognizer
      class Tags
        def self.recognize_tags_for_all_accounts
          # enumerate accounts
          accounts = PiggyCash::Models::Account.all
          accounts.each do |account|
            recognize_tags_for_account(account)
          end
        end

        private

        def self.recognize_tags_for_account(account)
          account.booking_entry_queries.each do |booking_entry_query|
            tags_for_query = booking_entry_query.tags
            booking_entries = booking_entry_query.booking_entries
            booking_entries.each do |booking_entry|
              assign_tags_for_booking_entry(booking_entry, tags_for_query)
            end
          end
        end

        def self.assign_tags_for_booking_entry(booking_entry, tags)
          booking_entry.copy_to_evaluation_if_needed
          evaluated_booking_entry = booking_entry.evaluated_booking_entry
          if evaluated_booking_entry
            tags.each do |tag|
              includes = evaluated_booking_entry.tags.include?(tag)
              evaluated_booking_entry.tags << tag unless includes
            end
            evaluated_booking_entry.generate_title_from_tags
            evaluated_booking_entry.save
          end
        end

      end
    end
  end
end