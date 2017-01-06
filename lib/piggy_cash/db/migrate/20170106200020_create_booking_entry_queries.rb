class CreateBookingEntryQueries < ActiveRecord::Migration
  def change
    create_table :booking_entry_queries do |t|
      t.references :account, index: true, foreign_key: true

      t.string :name
      t.string :query

      t.timestamps null: false
    end
  end
end