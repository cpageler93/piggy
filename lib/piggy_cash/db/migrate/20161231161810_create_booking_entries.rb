class CreateBookingEntries < ActiveRecord::Migration
  def change
    create_table :booking_entries do |t|
      t.string :checksum
      t.references :account, index: true, foreign_key: true

      t.datetime :booking_date
      t.datetime :valuta

      t.string :participant
      t.string :booking_type
      t.string :usage
      t.decimal :value, precision: 10, scale: 2
      t.decimal :saldo, precision: 10, scale: 2

      t.timestamps null: false
    end

    add_index :booking_entries, :checksum, :unique => true
  end
end