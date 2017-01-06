module PiggyCash
  module Models
    class BookingEntryQuery < ::ActiveRecord::Base
      belongs_to :account
      has_many :booking_entry_tag_recognizers

      def booking_entries
        prefix = "select * from booking_entries be where "
        account_query = "be.account_id = #{self.account.id}"

        all_queries = []
        all_queries << account_query
        all_queries << self.query if self.query.length > 0

        all_queries_string = all_queries.join(" and ")

        sql = "#{prefix}#{all_queries_string}"

        begin
          return BookingEntry.find_by_sql(sql)
        rescue Exception => e
          puts "Error: #{e.message}".red
          return nil
        end
      end
    end
  end
end