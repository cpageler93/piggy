module PiggyCash
  module Core
    module Stats
      class Saldo < Base

        def self.stats_per_month(account)
          stats = []
          enumerate_months_for_account(account) do |date|
            newest_entry = account.newest_booking_entry_in_month(date)
            stats << {
              date: date,
              saldo: newest_entry.saldo
            }
          end
          return stats
        end

      end
    end
  end
end