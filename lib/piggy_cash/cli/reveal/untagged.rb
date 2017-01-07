module PiggyCash
  module CLI
    module Reveal
      class Untagged < Base
        def execute(options = {})
          ensure_valid_connection_in_keychain_item!

          accounts = PiggyCash::Models::Account.all
          accounts.each do |account|
            untagged_booking_entries = PiggyCash::Core::Revealer::Untagged.untagged_booking_entries_for_account(account)

            rows = untagged_booking_entries.collect{|booking_entry| [
              booking_entry.booking_date.strftime("%d.%m.%Y"),
              booking_entry.valuta.strftime("%d.%m.%Y"),
              booking_entry.participant,
              booking_entry.booking_type,
              booking_entry.usage[0..30],
              booking_entry.value
            ]}
            table = Terminal::Table.new :title => "Account #{account.name} (#{rows.count})",
                                        :headings => [
                                          'Booking Date',
                                          'Valuta',
                                          'Participant',
                                          'Booking Type',
                                          'Usage',
                                          'Value'
                                        ],
                                        :rows => rows
            puts table
          end
        end
      end
    end
  end
end