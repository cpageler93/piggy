module PiggyCash
  module Core
    module Stats
      class Base

        def self.start_date_for_account(account)
          first_booking_entry = account.booking_entries.first
          return nil unless first_booking_entry

          date_of_first_booking_entry = first_booking_entry.booking_date
          first_day_of_month = Date.parse(date_of_first_booking_entry.strftime("%Y-%m-01"))

          return first_day_of_month
        end

        def self.enumerate_months_for_account(account)
          if block_given?
            iteration_date = start_date_for_account(account)
            while iteration_date <= Date.today
              yield iteration_date
              iteration_date = iteration_date + 1.month
            end
          else
            puts "no block given"
          end
        end

      end
    end
  end
end