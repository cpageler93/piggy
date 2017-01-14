module PiggyCash
  module CLI
    module Stats
      class Saldo < Base
        def execute(options = {})
          ensure_valid_connection_in_keychain_item!

          sql = <<-eos

          select distinct month(be.booking_date) as month, year(be.booking_date) as year
          from booking_entries be
          order by year desc, month desc

          eos

          saldos = []

          booking_entry_date_range_result = ActiveRecord::Base.connection.execute(sql)
          booking_entry_date_range_result.each do |row|
            saldo_value = saldo_for(row[1], row[0])
            saldos << {
              :year => row[1],
              :month => row[0],
              :saldo => saldo_value
            }
          end

          rows = saldos.collect{|saldo_row| [
            saldo_row[:year],
            saldo_row[:month],
            saldo_row[:saldo]
          ]}
          table = Terminal::Table.new :title => "Saldos",
                                      :headings => [
                                        'Year',
                                        'Month',
                                        'Saldo',
                                      ],
                                      :rows => rows
          puts table

        end

        def saldo_for(year, month)
          sql = <<-eos

          select be.*
          from booking_entries be
          where month(be.booking_date) = #{month}
          and year(be.booking_date) = #{year}

          eos

          booking_entries_in_range = PiggyCash::Models::BookingEntry.find_by_sql(sql)
          return booking_entries_in_range.last.saldo
        end
      end
    end
  end
end
