class CreateBookingEntryTagRecognizers < ActiveRecord::Migration
  def change
    create_table :booking_entry_tag_recognizers do |t|
      t.references :booking_entry_query, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end