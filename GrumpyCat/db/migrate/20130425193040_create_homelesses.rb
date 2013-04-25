class CreateHomelesses < ActiveRecord::Migration
  def change
    create_table :homelesses do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :district
      t.string :representative
      t.string :email

      t.timestamps
    end
  end
end
