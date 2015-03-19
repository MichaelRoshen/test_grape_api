class CreateMusicStores < ActiveRecord::Migration
  def change
    create_table :music_stores do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :lon
      t.integer :stars

      t.timestamps
    end
  end
end
