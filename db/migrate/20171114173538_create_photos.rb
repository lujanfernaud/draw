class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.references :request, foreign_key: true
      t.text :object

      t.timestamps
    end
  end
end
