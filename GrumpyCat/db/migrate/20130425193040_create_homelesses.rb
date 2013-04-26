class CreateHomelesses < ActiveRecord::Migration
  def change
    create_table :homelesses do |t|
      t.float :latitude
      t.float :longitude
      t.integer :nearby
      t.string :address
      t.string :district
      t.string :representative
      t.string :email
      t.string :gender
      t.string :office
      t.string :twitter
      t.string :phone

      t.timestamps
    end
  end
end
