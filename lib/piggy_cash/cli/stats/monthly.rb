module PiggyCash
  module CLI
    module Stats
      class Monthly < Base
        def execute(options = {})
          ensure_valid_connection_in_keychain_item!

          options[:month] ||= Date.today.strftime("%m").to_i
          options[:year] ||= Date.today.strftime("%Y").to_i

          booking_entries_in_range = PiggyCash::Models::BookingEntry.booking_entries_in_range(options[:year], options[:month])
          PiggyCash::Core::Selection::BookingEntry.print_booking_entries_in_table(booking_entries_in_range)

          saldos_per_tag = {}
          total_saldo = 0
          booking_entries_in_range.each do |booking_entry|
            booking_entry.evaluated_booking_entries.each do |evaluated_booking_entry|
              evaluated_booking_entry.tags.each do |tag|
                saldos_per_tag[tag.name] = 0 unless saldos_per_tag[tag.name]
                saldos_per_tag[tag.name] += evaluated_booking_entry.fraction_value
              end
            end

            if booking_entry.evaluated_booking_entries.count == 0
              empty_name = "Unbekannt"
              saldos_per_tag[empty_name] = 0 unless saldos_per_tag[empty_name]
              saldos_per_tag[empty_name] += booking_entry.value
            end

            total_saldo += booking_entry.value
          end


          rows = saldos_per_tag.collect{|tag, value| [
            tag,
            value
          ]}
          table = Terminal::Table.new :title => "Saldos per tag",
                                      :headings => [
                                        'Tag',
                                        'Value'
                                      ],
                                      :rows => rows
          puts table

          puts "Total saldo #{total_saldo}"

        end
      end
    end
  end
end