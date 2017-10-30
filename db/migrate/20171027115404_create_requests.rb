class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :reference
      t.text :results

      t.timestamps
    end
  end
end
