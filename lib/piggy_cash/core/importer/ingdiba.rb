module PiggyCash
  module Core
    module Importer
      class INGDiBa < Base
        def self.import(rows, options = {})

          # get iban and find account
          iban = rows[3][1]
          account = account_from_iban(iban)

          # setup validation variables
          total_saldo = 0
          checksums = account.booking_entries.collect{|booking_entry|booking_entry.checksum}

          # get booking entry rows
          rows = rows[8..rows.length]
          rows.reverse!

          # enumerate booking entry rows
          rows.each_with_index do |row, index|

            # get values from row
            booking_date  = row[0].strip! || row[0]
            valuta        = row[1].strip! || row[1]
            participant   = row[2].strip! || row[2]
            booking_type  = row[3].strip! || row[3]
            usage         = row[4].strip! || row[4]
            value         = row[5].strip! || row[5]
            saldo         = row[7].strip! || row[7]

            # prepare float values
            value = value.gsub('.', '').gsub(',', '.').to_f
            saldo = saldo.gsub('.', '').gsub(',', '.').to_f

            # initialize saldo
            if index == 0
              if account.newest_booking_entry
                # calculate total saldo from last booking entry
                total_saldo = account.newest_booking_entry.saldo - value
              else
                total_saldo = saldo
              end
            else
              total_saldo += value
            end

            # create booking entry
            booking_entry = PiggyCash::Models::BookingEntry.new
            booking_entry.account       = account
            booking_entry.booking_date  = booking_date
            booking_entry.valuta        = valuta
            booking_entry.participant   = participant
            booking_entry.booking_type  = booking_type
            booking_entry.usage         = usage
            booking_entry.value         = value
            booking_entry.saldo         = saldo
            booking_entry.update_checksum

            # validate checksum
            checksum = booking_entry.checksum
            if checksums.include?(checksum)
              puts "Error: checksum is not valid"
              exit 1
            end
            checksums << checksum

            # validate saldo
            saldo_is_valid = total_saldo.round(2).to_s == saldo.round(2).to_s
            unless saldo_is_valid
              puts "Error: saldo is not valid #{total_saldo.round(2)} vs #{saldo.round(2)}"
              # rollback transaction
              exit 1
            end

            booking_entry.save
          end
        end
      end
    end
  end
end