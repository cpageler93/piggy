class CreateEvaluatedBookingEntriesTags < ActiveRecord::Migration
  def change
    create_table :evaluated_booking_entries_tags do |t|
      t.references :evaluated_booking_entry, index: {:name => "evaluated_booking_entry_index"}, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end