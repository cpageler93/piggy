module PiggyCash
  module Core
    module Selection
      class BookingEntry
        def self.print_booking_entries_in_table(booking_entries, title = nil)
          # create rows
          rows = []
          booking_entries.each do |booking_entry|

            # get row options
            row_options = block_given? ? (yield booking_entry) : nil

            # make row
            row = [
              booking_entry.booking_date.strftime("%d.%m.%Y").to_s,
              booking_entry.valuta.strftime("%d.%m.%Y").to_s,
              booking_entry.participant.to_s,
              booking_entry.booking_type.to_s,
              booking_entry.usage[0..30].to_s,
              booking_entry.value.to_s
            ]

            # highlight row if necessary
            if row_options && row_options[:highlight]
              color ||= row_options[:color]
              color ||= :green
              row.map!{|col|col.colorize(col, :foreground => color.to_s)}
            end

            # append row
            rows << row
          end

          title ||= "Booking Entries (#{rows.count})"

          table = Terminal::Table.new :title => title,
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