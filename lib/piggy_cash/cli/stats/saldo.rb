module PiggyCash
  module CLI
    module Stats
      class Saldo < Base
        def execute(options = {})
          ensure_valid_connection_in_keychain_item!

          account = PiggyCash::Models::Account.find(3)
          stats = PiggyCash::Core::Stats::Saldo.stats_per_month(account)

          rows = stats.collect{|stat_row| [
            stat_row[:date].strftime("%Y"),
            stat_row[:date].strftime("%m"),
            stat_row[:saldo]
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
      end
    end
  end
end
