module PiggyCash
  module Core
    module Selection
      class Account
        def self.select_account_from_table
          accounts = PiggyCash::Models::Account.all
          return accounts.first if accounts.count == 1

          rows = accounts.collect{|account| [
            account.id,
            account.name,
            account.iban
          ]}
          accounts_to_select = accounts.collect{|account| "#{account.name} (#{account.id})" }
          table = Terminal::Table.new :title => "Select Account",
                                      :headings => [
                                        'ID',
                                        'Name',
                                        'IBAN',
                                      ],
                                      :rows => rows
          puts table
          choosen_account_id = choose(*accounts_to_select)
          choosen_account_index = accounts_to_select.index(choosen_account_id)
          choosen_account = accounts[choosen_account_index]

          return choosen_account
        end
      end
    end
  end
end
