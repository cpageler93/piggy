module PiggyCash
  module Core
    module Revealer
      class Untagged
        def self.untagged_booking_entries_for_account(account)
          # first get all booking entries with tag/s
          sql = <<-eos

          select distinct be.id
          from booking_entries be
          join evaluated_booking_entries as ebe on ebe.booking_entry_id = be.id
          join evaluated_booking_entries_tags as ebet on ebet.evaluated_booking_entry_id = ebe.id

          eos

          booking_entry_ids_with_tags_result = ActiveRecord::Base.connection.execute(sql)
          booking_entry_ids_with_tags = []
          booking_entry_ids_with_tags_result.each do |row|
            booking_entry_ids_with_tags << row[0]
          end

          # puts "ids with tags #{booking_entry_ids_with_tags}"
          untagged_booking_entries = PiggyCash::Models::BookingEntry.all.where.not(id: booking_entry_ids_with_tags)
          return untagged_booking_entries
        end
      end
    end
  end
end