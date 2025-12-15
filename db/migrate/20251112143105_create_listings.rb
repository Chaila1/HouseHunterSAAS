class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.string :lister
      t.string :address
      t.integer :beds
      t.integer :baths
      t.string :catergory
      t.integer :price

      t.timestamps
    end
  end
end
