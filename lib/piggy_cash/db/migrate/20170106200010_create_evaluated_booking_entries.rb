class CreateEvaluatedBookingEntries < ActiveRecord::Migration
  def change
    create_table :evaluated_booking_entries do |t|
      t.references :booking_entry, index: true, foreign_key: true

      t.datetime :booking_date
      t.datetime :valuta

      t.string :title

      t.decimal :total_value, precision: 10, scale: 2
      t.decimal :fraction, precision: 13, scale: 10

      t.timestamps null: false
    end
  end
end