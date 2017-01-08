module PiggyCash
  module Core
    module Selection
      class BookingEntryQuery
        def self.select_booking_entry_queries_from_table(booking_entry_queries, title = nil)
          # create array for selection
          booking_entry_queries_to_select = booking_entry_queries.collect{|query| "#{query.name} (#{query.id})" }

          # create rows
          rows = []
          booking_entry_queries.each do |booking_entry_query|

            # get row options
            row_options = block_given? ? (yield booking_entry_query) : nil

            # make row
            row = [
              booking_entry_query.id,
              booking_entry_query.name,
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

          title ||= "Booking Entry Queries (#{rows.count})"

          table = Terminal::Table.new :title => title,
                                      :headings => [
                                        'ID',
                                        'Name'
                                      ],
                                      :rows => rows
          puts table

          choosen_booking_entry_query_id = choose(*booking_entry_queries_to_select)
          choosen_booking_entry_query_index = booking_entry_queries_to_select.index(choosen_booking_entry_query_id)
          choosen_booking_entry_query = booking_entry_queries[choosen_booking_entry_query_index]

          return choosen_booking_entry_query
        end
      end
    end
  end
end