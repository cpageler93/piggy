module PiggyCash
  module CLI
    module Tags
      module Reveal
        class Untagged < Base
          def execute(options = {})
            ensure_valid_connection_in_keychain_item!

            accounts = PiggyCash::Models::Account.all
            accounts.each do |account|
              untagged_booking_entries = PiggyCash::Core::Revealer::Untagged.untagged_booking_entries_for_account(account)
              PiggyCash::Core::Selection::BookingEntry.print_booking_entries_in_table(untagged_booking_entries, "Account #{account.name} (#{untagged_booking_entries.count})")
            end
          end
        end
      end
    end
  end
end