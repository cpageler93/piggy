module PiggyCash
  module Models
    class BookingEntryQuery < ::ActiveRecord::Base
      belongs_to :account
      has_many :booking_entry_tag_recognizers, dependent: destroy
      has_many :tags, through: :booking_entry_tag_recognizers

      def self.booking_entries_for_query(query, account)
        prefix = "select * from booking_entries be where "
        account_query = "be.account_id = #{account.id}"

        all_queries = []
        all_queries << account_query
        all_queries << query if query.length > 0

        all_queries_string = all_queries.join(" and ")

        sql = "#{prefix}#{all_queries_string}"

        begin
          return BookingEntry.find_by_sql(sql)
        rescue Exception => e
          puts "Error: #{e.message}".red
          return nil
        end
      end

      def booking_entries
        BookingEntryQuery.booking_entries_for_query(self.query, self.account)
      end
    end
  end
end