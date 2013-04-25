class CreateHomelesses < ActiveRecord::Migration
  def change
    create_table :homelesses do |t|
      t.string :latitude
      t.string :longitude
      t.string :address
      t.string :district
      t.string :representative
      t.string :email

      t.timestamps
    end
  end
end
